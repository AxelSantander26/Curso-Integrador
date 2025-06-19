package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.Marcacion;

import java.sql.*;
import java.time.LocalDate;

public class MarcacionDAO {

    public boolean yaMarcoEntrada(int empId, Date fecha) {
        String sql = "SELECT hora_entrada FROM asistencias WHERE emp_id = ? AND fecha = ?";
        try (Connection conn = ConexionBD.conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            stmt.setDate(2, fecha);
            ResultSet rs = stmt.executeQuery();
            return rs.next() && rs.getTime("hora_entrada") != null;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Marcacion obtenerMarcacionDeHoy(int empId, Date fecha) {
        String sql = "SELECT * FROM asistencias WHERE emp_id = ? AND fecha = ?";
        try (Connection conn = ConexionBD.conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            stmt.setDate(2, fecha);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Marcacion m = new Marcacion();
                m.setEmpId(empId);
                m.setFecha(fecha);
                m.setHoraEntrada(rs.getTime("hora_entrada"));
                m.setHoraSalida(rs.getTime("hora_salida"));
                m.setEstadoEntrada(rs.getString("estado_entrada"));
                m.setEstadoSalida(rs.getString("estado_salida"));
                m.setMinTardanza(rs.getInt("min_tardanza"));
                m.setMinAnticipacion(rs.getInt("min_anticipacion"));
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void registrarEntrada(Marcacion m) {
        String sql = "INSERT INTO asistencias (emp_id, fecha, hora_entrada, estado_entrada, min_tardanza) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, m.getEmpId());
            stmt.setDate(2, m.getFecha());
            stmt.setTime(3, m.getHoraEntrada());
            stmt.setString(4, m.getEstadoEntrada());
            stmt.setInt(5, m.getMinTardanza());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void registrarSalida(Marcacion m) {
        String sql = "UPDATE asistencias SET hora_salida = ?, estado_salida = ?, min_anticipacion = ? WHERE emp_id = ? AND fecha = ?";
        try (Connection conn = ConexionBD.conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTime(1, m.getHoraSalida());
            stmt.setString(2, m.getEstadoSalida());
            stmt.setInt(3, m.getMinAnticipacion());
            stmt.setInt(4, m.getEmpId());
            stmt.setDate(5, m.getFecha());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Time obtenerHoraEntradaEstablecida(int empId) {
        String sql = """
        SELECT h.hora_entrada
        FROM empleados e
        JOIN horarios h ON e.hor_id = h.hor_id
        WHERE e.emp_id = ?
    """;
        try (Connection conn = ConexionBD.conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getTime("hora_entrada");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Time obtenerHoraSalidaEstablecida(int empId) {
        String sql = """
        SELECT h.hora_salida
        FROM empleados e
        JOIN horarios h ON e.hor_id = h.hor_id
        WHERE e.emp_id = ?
    """;
        try (Connection conn = ConexionBD.conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getTime("hora_salida");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
