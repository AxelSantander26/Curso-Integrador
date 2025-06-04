package grupo7.dentalogic.dao;

import grupo7.dentalogic.model.Asistencia;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;




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

    // Obtener todas las asistencias con JOIN empleados
    public List<Asistencia> listarAsistencias() {
        List<Asistencia> lista = new ArrayList<>();
        String sql = "SELECT " +
                     "  a.asis_id, e.emp_id, e.emp_dni, e.emp_nom, e.emp_ape, " +
                     "  CONCAT(e.emp_nom, ' ', e.emp_ape) AS nombre_completo, " +
                     "  a.hora_llegada, a.tipo_asistencia, a.fecha_registro_asis " +
                     "FROM asistencias a " +
                     "INNER JOIN empleados e ON a.emp_id = e.emp_id";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Asistencia a = new Asistencia();
                a.setAsisId(rs.getInt("asis_id"));
                a.setEmpId(rs.getInt("emp_id"));
                a.setEmpDni(rs.getString("emp_dni"));
                a.setEmpNom(rs.getString("emp_nom"));
                a.setEmpApe(rs.getString("emp_ape"));
                a.setNombreCompleto(rs.getString("nombre_completo"));
                a.setHoraLlegada(rs.getTime("hora_llegada"));
                a.setTipoAsistencia(rs.getString("tipo_asistencia"));
                a.setFechaRegistroAsis(rs.getTimestamp("fecha_registro_asis"));
                lista.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
