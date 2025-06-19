package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.Asistencia;

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AsistenciaDAO {
    private static final Logger LOGGER = Logger.getLogger(AsistenciaDAO.class.getName());
    private final Connection conexion;

    public AsistenciaDAO() {
        this.conexion = ConexionBD.conectar();
    }

    public List<Asistencia> obtenerTodosLosEmpleados() {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT emp_id, emp_nombre, emp_apellido FROM empleados ORDER BY emp_id ASC";

        try (PreparedStatement ps = conexion.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Asistencia emp = new Asistencia();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setNombreCompletoEmpleado(rs.getString("emp_nombre") + " " + rs.getString("emp_apellido"));
                lista.add(emp);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al obtener empleados", e);
        }
        return lista;
    }

    public Map<Integer, Map<Integer, Asistencia>> obtenerAsistenciasPorMesYAnio(int year, int month) {
        Map<Integer, Map<Integer, Asistencia>> resultado = new TreeMap<>();
        int mesMySQL = month + 1;
        
        String sql = "WITH dias_mes AS ("
                + "    SELECT DATE(CONCAT(?, '-', ?, '-', day)) as fecha, day "
                + "    FROM ("
                + "        SELECT 1 as day UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION "
                + "        SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION "
                + "        SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION "
                + "        SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION "
                + "        SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION "
                + "        SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION SELECT 31"
                + "    ) days "
                + "    WHERE day <= DAY(LAST_DAY(CONCAT(?, '-', ?, '-01'))) "
                + ") "
                + "SELECT "
                + "    e.emp_id, e.emp_nombre, e.emp_apellido, "
                + "    dm.fecha, dm.day, "
                + "    a.asi_id, a.hora_entrada, a.hora_salida, a.estado_entrada, a.estado_salida, "
                + "    a.min_tardanza, a.min_anticipacion, "
                + "    CASE WHEN j.jus_id IS NOT NULL THEN TRUE ELSE FALSE END as justificado "
                + "FROM empleados e "
                + "CROSS JOIN dias_mes dm "
                + "LEFT JOIN asistencias a ON e.emp_id = a.emp_id AND dm.fecha = a.fecha "
                + "LEFT JOIN justificativos j ON e.emp_id = j.emp_id AND dm.fecha BETWEEN j.desde AND j.hasta "
                + "WHERE YEAR(dm.fecha) = ? AND MONTH(dm.fecha) = ? "
                + "ORDER BY e.emp_id, dm.day";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, mesMySQL);
            ps.setInt(3, year);
            ps.setInt(4, mesMySQL);
            ps.setInt(5, year);
            ps.setInt(6, mesMySQL);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int empId = rs.getInt("emp_id");
                    int dia = rs.getInt("day");
                    
                    Asistencia asistencia = new Asistencia();
                    asistencia.setEmpId(empId);
                    asistencia.setNombreCompletoEmpleado(
                        rs.getString("emp_nombre") + " " + rs.getString("emp_apellido"));
                    asistencia.setFecha(rs.getDate("fecha"));
                    
                    if (rs.getObject("asi_id") != null) {
                        asistencia.setAsiId(rs.getInt("asi_id"));
                        asistencia.setHoraEntrada(rs.getTime("hora_entrada"));
                        asistencia.setHoraSalida(rs.getTime("hora_salida"));
                        asistencia.setEstadoEntrada(rs.getString("estado_entrada"));
                        asistencia.setEstadoSalida(rs.getString("estado_salida"));
                        asistencia.setMinTardanza(rs.getInt("min_tardanza"));
                        asistencia.setMinAnticipacion(rs.getInt("min_anticipacion"));
                    }
                    
                    asistencia.setJustificado(rs.getBoolean("justificado"));
                    
                    resultado.computeIfAbsent(empId, k -> new TreeMap<>()).put(dia, asistencia);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error al obtener asistencias", e);
        }
        
        return resultado;
    }
}