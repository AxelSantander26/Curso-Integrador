package grupo7.dentalogic.dao;

import grupo7.dentalogic.model.Dashboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class DashboardDAO {

    private Connection conn;

    public DashboardDAO(Connection conn) {
        this.conn = conn;
    }

    public Dashboard obtenerDashboard() throws SQLException {
        Dashboard dashboard = new Dashboard();

        dashboard.setTotalEmpleados(contar("SELECT COUNT(*) FROM empleados"));
        dashboard.setTotalAsistenciasMes(contar(
            "SELECT COUNT(*) FROM asistencias WHERE MONTH(fecha)=MONTH(CURDATE()) AND YEAR(fecha)=YEAR(CURDATE())"
        ));
        dashboard.setTotalTardanzasMes(contar(
            "SELECT COUNT(*) FROM asistencias WHERE estado_entrada='TARDANZA' AND MONTH(fecha)=MONTH(CURDATE()) AND YEAR(fecha)=YEAR(CURDATE())"
        ));
        dashboard.setTotalSalidasAnticipadasMes(contar(
            "SELECT COUNT(*) FROM asistencias WHERE estado_salida='ANTICIPADA' AND MONTH(fecha)=MONTH(CURDATE()) AND YEAR(fecha)=YEAR(CURDATE())"
        ));
        dashboard.setTotalJustificativosMes(contar(
            "SELECT COUNT(*) FROM justificativos WHERE MONTH(desde)=MONTH(CURDATE()) AND YEAR(desde)=YEAR(CURDATE())"
        ));
        dashboard.setEmpleadosPorEspecialidad(obtenerEmpleadosPorEspecialidad());

        return dashboard;
    }

    private int contar(String sql) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public Map<String, Integer> obtenerEmpleadosPorEspecialidad() throws SQLException {
        Map<String, Integer> data = new LinkedHashMap<>();
        String sql = "SELECT esp.esp_nombre, COUNT(*) AS cantidad " +
                     "FROM empleados e " +
                     "JOIN especialidades esp ON e.esp_id = esp.esp_id " +
                     "GROUP BY esp.esp_id";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("esp_nombre"), rs.getInt("cantidad"));
            }
        }
        return data;
    }
}
