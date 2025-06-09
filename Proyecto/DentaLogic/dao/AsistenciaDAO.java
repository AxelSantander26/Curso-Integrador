package grupo7.dentalogic.dao;

import grupo7.dentalogic.model.Asistencia;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;




public class AsistenciaDAO {
    private Connection conn;

    public AsistenciaDAO(Connection conn) {
        this.conn = conn;
    }

    // Insertar nueva asistencia con tipo_asistencia automático
    public boolean insertarAsistencia(Asistencia asistencia) {
        String tipoAsistencia = calcularTipoAsistencia(asistencia.getHoraLlegada());
        String sql = "INSERT INTO asistencias (emp_id, hora_llegada, tipo_asistencia) VALUES (?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, asistencia.getEmpId());
            stmt.setTime(2, asistencia.getHoraLlegada());
            stmt.setString(3, tipoAsistencia);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lógica para determinar tipo de asistencia automáticamente
    private String calcularTipoAsistencia(Time horaLlegada) {
        Time horaPresente = Time.valueOf("09:00:00");
        Time horaLimiteTardanza = Time.valueOf("17:00:00");

        if (horaLlegada.compareTo(horaPresente) <= 0) {
            return "Asistio";
        } else if (horaLlegada.compareTo(horaLimiteTardanza) <= 0) {
            return "Tardanza";
        } else {
            return "Falta";
        }
    }

public Map<Integer, Map<Integer, String>> obtenerAsistenciasMensuales(int mes, int anio) {
    Map<Integer, Map<Integer, String>> asistenciasMensuales = new HashMap<>();
    String sql = "SELECT e.emp_id, DAY(a.fecha_registro_asis) AS dia, a.tipo_asistencia " +
                 "FROM empleados e " +
                 "LEFT JOIN asistencias a ON e.emp_id = a.emp_id AND MONTH(a.fecha_registro_asis) = ? AND YEAR(a.fecha_registro_asis) = ? " +
                 "ORDER BY e.emp_id, dia";

    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, mes);
        stmt.setInt(2, anio);

        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int empId = rs.getInt("emp_id");
                int dia = rs.getInt("dia");
                String tipo = rs.getString("tipo_asistencia");

                if (dia == 0) continue; // Si no hay día, ignorar

                String simbolo = "-";
                if (tipo != null) {
                    switch (tipo) {
                        case "Asistio": simbolo = "A"; break;
                        case "Tardanza": simbolo = "T"; break;
                        case "Falta": simbolo = "F"; break;
                    }
                }

                asistenciasMensuales
                    .computeIfAbsent(empId, k -> new HashMap<>())
                    .put(dia, simbolo);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return asistenciasMensuales;
}


}


