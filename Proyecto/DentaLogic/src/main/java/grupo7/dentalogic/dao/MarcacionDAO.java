package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import java.sql.*;
import java.time.LocalTime;

public class MarcacionDAO {

    public Connection conexion;

    public MarcacionDAO() {
        this.conexion = ConexionBD.conectar();
    }

    public boolean isAsistenciaMarcada(int empId) {
        String sql = "SELECT COUNT(*) FROM asistencias WHERE emp_id = ? AND fecha = CURDATE()";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Time obtenerHoraEntradaEstablecida(int empId) {
        Time horaEntrada = null;
        String sql = "SELECT hora_entrada FROM horarios WHERE hor_id = (SELECT hor_id FROM empleados WHERE emp_id = ?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    horaEntrada = rs.getTime("hora_entrada");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return horaEntrada;
    }

    // ? Lógica corregida con LocalTime
    public String calcularEstado(Time horaEntrada, Time horaActual) {
        if (horaEntrada == null || horaActual == null) {
            return "DESCONOCIDO";
        }

        LocalTime entrada = horaEntrada.toLocalTime();
        LocalTime actual = horaActual.toLocalTime();
        LocalTime limitePuntual = entrada.plusMinutes(10);

        return actual.isBefore(limitePuntual) || actual.equals(limitePuntual)
                ? "PUNTUAL"
                : "TARDANZA";
    }

    public Time obtenerHoraMarcada(int empId) {
        String sql = "SELECT hora_entrada FROM asistencias WHERE emp_id = ? AND fecha = CURDATE()";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getTime("hora_entrada");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String obtenerEstado(int empId) {
        String sql = "SELECT estado FROM asistencias WHERE emp_id = ? AND fecha = CURDATE()";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("estado");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public void registrarAsistencia(int empId, Time horaActual, String estado) {
        String sql = "INSERT INTO asistencias (emp_id, fecha, hora_entrada, estado) VALUES (?, CURDATE(), ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ps.setTime(2, horaActual);
            ps.setString(3, estado);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
