package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.ResumenNomina;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Logger;
import java.util.logging.Level;

public class ResumenNominaDAO {

    private static final Logger LOGGER = Logger.getLogger(ResumenNominaDAO.class.getName());
    private final Connection conexion;

    public ResumenNominaDAO() {
        this.conexion = ConexionBD.conectar();
    }

    public List<ResumenNomina> obtenerResumenMesActual() {
        List<ResumenNomina> resumen = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        int anio = cal.get(Calendar.YEAR);
        int mes = cal.get(Calendar.MONTH) + 1;

        String empleadosSql = "SELECT e.emp_id FROM empleados e";

        try (PreparedStatement ps = conexion.prepareStatement(empleadosSql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int empId = rs.getInt("emp_id");

                // Usar mismo flujo del detalle
                ResumenNomina detalle = new ResumenNomina();
                obtenerInfoBasicaEmpleado(empId, detalle);
                List<Map<String, Object>> diasMes = obtenerDiasMes(cal, detalle);
                procesarAsistencias(empId, cal, detalle, diasMes);

                // Limpiar datos que no se mostrarán en el resumen general
                detalle.setFechas(new String[0]);
                detalle.setHorasEntrada(new Time[0]);
                detalle.setHorasSalida(new Time[0]);
                detalle.setEstadosEntrada(new String[0]);
                detalle.setEstadosSalida(new String[0]);
                detalle.setMinutosTardanza(new int[0]);
                detalle.setMinutosAnticipacion(new int[0]);
                detalle.setJustificados(new boolean[0]);
                detalle.setEsFinSemana(new boolean[0]);

                resumen.add(detalle);
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al obtener resumen de nómina", e);
        }

        return resumen;
    }

    public ResumenNomina obtenerDetalleEmpleado(int empId) {
        ResumenNomina detalle = new ResumenNomina();
        Calendar cal = Calendar.getInstance();
        obtenerInfoBasicaEmpleado(empId, detalle);
        List<Map<String, Object>> diasMes = obtenerDiasMes(cal, detalle);
        procesarAsistencias(empId, cal, detalle, diasMes);
        return detalle;
    }

    private void obtenerInfoBasicaEmpleado(int empId, ResumenNomina detalle) {
        String sql = "SELECT e.emp_id, CONCAT(e.emp_nombre, ' ', e.emp_apellido) as nombre, "
                + "esp.esp_nombre as especialidad, COALESCE(esp.tarifa_hora, 0) as sueldo_hora, "
                + "h.hora_entrada, h.hora_salida FROM empleados e "
                + "JOIN especialidades esp ON e.esp_id = esp.esp_id "
                + "JOIN horarios h ON e.hor_id = h.hor_id WHERE e.emp_id = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                detalle.setEmpId(empId);
                detalle.setNombreEmpleado(rs.getString("nombre"));
                detalle.setEspecialidad(rs.getString("especialidad"));
                detalle.setSueldoHora(rs.getBigDecimal("sueldo_hora"));
                detalle.setHoraEntradaHorario(rs.getTime("hora_entrada"));
                detalle.setHoraSalidaHorario(rs.getTime("hora_salida"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al obtener información del empleado", e);
        }
    }

    private List<Map<String, Object>> obtenerDiasMes(Calendar cal, ResumenNomina detalle) {
        List<Map<String, Object>> diasMes = new ArrayList<>();
        SimpleDateFormat sdfFecha = new SimpleDateFormat("dd/MM/yyyy");
        int anio = cal.get(Calendar.YEAR);
        int mes = cal.get(Calendar.MONTH) + 1;
        int diasLaborables = 0;
        String sql = "SELECT DATE(CONCAT(?, '-', ?, '-', dia)) as fecha, "
                + "DAYOFWEEK(DATE(CONCAT(?, '-', ?, '-', dia))) as dia_semana "
                + "FROM (SELECT 1 as dia UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION "
                + "SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION "
                + "SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION "
                + "SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION "
                + "SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION "
                + "SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION SELECT 31) dias "
                + "WHERE dia <= DAY(LAST_DAY(CONCAT(?, '-', ?, '-01'))) ORDER BY fecha";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            for (int i = 1; i <= 6; i++) {
                ps.setInt(i, i % 2 == 1 ? anio : mes);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    boolean esFinSemana = rs.getInt("dia_semana") == 1 || rs.getInt("dia_semana") == 7;
                    if (!esFinSemana) {
                        diasLaborables++;
                    }
                    Map<String, Object> dia = new HashMap<>();
                    dia.put("fecha", sdfFecha.format(rs.getDate("fecha")));
                    dia.put("es_fin_semana", esFinSemana);
                    diasMes.add(dia);
                }
                detalle.setDiasLaborablesMes(diasLaborables);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al obtener días del mes", e);
        }
        return diasMes;
    }

    private void procesarAsistencias(int empId, Calendar cal, ResumenNomina detalle, List<Map<String, Object>> diasMes) {
        Map<String, Map<String, Object>> asistenciasMap = obtenerAsistenciasEmpleado(empId, cal);
        inicializarArraysDetalle(detalle, diasMes.size());
        int totalTardanza = 0, totalAnticipacion = 0, totalFaltas = 0, totalHoras = 0;
        for (int i = 0; i < diasMes.size(); i++) {
            Map<String, Object> dia = diasMes.get(i);
            String fecha = (String) dia.get("fecha");
            boolean esFinSemana = (boolean) dia.get("es_fin_semana");
            detalle.getFechas()[i] = fecha;
            detalle.getEsFinSemana()[i] = esFinSemana;
            if (asistenciasMap.containsKey(fecha)) {
                procesarAsistenciaExistente(detalle, asistenciasMap.get(fecha), i, esFinSemana);
                if (!esFinSemana) {
                    totalHoras += calcularHorasTrabajadas(detalle, i);
                    if (!detalle.getJustificados()[i]) {
                        totalTardanza += detalle.getMinutosTardanza()[i];
                        totalAnticipacion += detalle.getMinutosAnticipacion()[i];
                        if ("FALTA".equals(detalle.getEstadosEntrada()[i])) {
                            totalFaltas++;
                        }
                    }
                }
            } else if (!esFinSemana) {
                marcarFalta(detalle, i);
                if (!detalle.getJustificados()[i]) {
                    totalFaltas++;
                }
            }
        }
        detalle.setHoras(totalHoras);
        detalle.setTardanza(totalTardanza);
        detalle.setAnticipacion(totalAnticipacion);
        detalle.setFaltas(totalFaltas);
        detalle.calcularTotales();
    }

    private Map<String, Map<String, Object>> obtenerAsistenciasEmpleado(int empId, Calendar cal) {
        Map<String, Map<String, Object>> asistenciasMap = new HashMap<>();
        SimpleDateFormat sdfFecha = new SimpleDateFormat("dd/MM/yyyy");
        String sql = "SELECT a.fecha, a.hora_entrada, a.hora_salida, a.estado_entrada, a.estado_salida, "
                + "a.min_tardanza, a.min_anticipacion, "
                + "CASE WHEN EXISTS (SELECT 1 FROM justificativos j WHERE j.emp_id = a.emp_id AND a.fecha BETWEEN j.desde AND j.hasta) "
                + "THEN TRUE ELSE FALSE END as justificado "
                + "FROM asistencias a "
                + "WHERE a.emp_id = ? AND YEAR(a.fecha) = ? AND MONTH(a.fecha) = ? ORDER BY a.fecha";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ps.setInt(2, cal.get(Calendar.YEAR));
            ps.setInt(3, cal.get(Calendar.MONTH) + 1);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> asistencia = new HashMap<>();
                String fecha = sdfFecha.format(rs.getDate("fecha"));
                asistencia.put("hora_entrada", rs.getTime("hora_entrada"));
                asistencia.put("hora_salida", rs.getTime("hora_salida"));
                asistencia.put("estado_entrada", rs.getString("estado_entrada"));
                asistencia.put("estado_salida", rs.getString("estado_salida"));
                asistencia.put("min_tardanza", rs.getInt("min_tardanza"));
                asistencia.put("min_anticipacion", rs.getInt("min_anticipacion"));
                asistencia.put("justificado", rs.getBoolean("justificado"));
                asistenciasMap.put(fecha, asistencia);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al obtener asistencias del empleado", e);
        }
        return asistenciasMap;
    }

    private void inicializarArraysDetalle(ResumenNomina detalle, int size) {
        detalle.setFechas(new String[size]);
        detalle.setHorasEntrada(new Time[size]);
        detalle.setHorasSalida(new Time[size]);
        detalle.setEstadosEntrada(new String[size]);
        detalle.setEstadosSalida(new String[size]);
        detalle.setMinutosTardanza(new int[size]);
        detalle.setMinutosAnticipacion(new int[size]);
        detalle.setJustificados(new boolean[size]);
        detalle.setEsFinSemana(new boolean[size]);
    }

    private void procesarAsistenciaExistente(ResumenNomina detalle, Map<String, Object> asistencia, int index, boolean esFinSemana) {
        detalle.getHorasEntrada()[index] = (Time) asistencia.get("hora_entrada");
        detalle.getHorasSalida()[index] = (Time) asistencia.get("hora_salida");
        detalle.getEstadosEntrada()[index] = (String) asistencia.get("estado_entrada");
        detalle.getEstadosSalida()[index] = (String) asistencia.get("estado_salida");
        detalle.getMinutosTardanza()[index] = (int) asistencia.get("min_tardanza");
        detalle.getMinutosAnticipacion()[index] = (int) asistencia.get("min_anticipacion");
        detalle.getJustificados()[index] = (boolean) asistencia.get("justificado");
    }

    private int calcularHorasTrabajadas(ResumenNomina detalle, int index) {
        if (detalle.getHorasEntrada()[index] != null && detalle.getHorasSalida()[index] != null) {
            long diff = detalle.getHorasSalida()[index].getTime() - detalle.getHorasEntrada()[index].getTime();
            return (int) (diff / (60 * 60 * 1000));
        }
        return 0;
    }

    private void marcarFalta(ResumenNomina detalle, int index) {
        detalle.getEstadosEntrada()[index] = "FALTA";
        detalle.getEstadosSalida()[index] = "NO_MARCÓ";

        // Verificar si la falta está justificada
        String fecha = detalle.getFechas()[index];
        boolean justificado = verificarJustificacion(detalle.getEmpId(), fecha);
        detalle.getJustificados()[index] = justificado;
    }

    private boolean verificarJustificacion(int empId, String fecha) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        try {
            java.util.Date fechaDate = sdf.parse(fecha);
            java.sql.Date sqlDate = new java.sql.Date(fechaDate.getTime());

            String sql = "SELECT 1 FROM justificativos WHERE emp_id = ? AND ? BETWEEN desde AND hasta";
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setInt(1, empId);
                ps.setDate(2, sqlDate);
                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error al verificar justificación", e);
            return false;
        }
    }

}
