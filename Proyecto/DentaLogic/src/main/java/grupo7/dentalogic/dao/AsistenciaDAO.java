package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.AsistenciaInfo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaDAO {

    private Connection conexion;

    public AsistenciaDAO() {
        this.conexion = ConexionBD.conectar();
    }

    // Obtener todos los empleados
    public List<AsistenciaInfo> obtenerTodosLosEmpleados() {
        List<AsistenciaInfo> lista = new ArrayList<>();
        String sql = "SELECT emp_id, emp_nom, emp_ape FROM empleados ORDER BY emp_id ASC";

        try (PreparedStatement ps = conexion.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AsistenciaInfo emp = new AsistenciaInfo();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setNombre(rs.getString("emp_nom"));
                emp.setApellido(rs.getString("emp_ape"));
                lista.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Obtener asistencias por mes y año
    public List<AsistenciaInfo> obtenerAsistenciasPorMesYAnio(int year, int month) {
        List<AsistenciaInfo> lista = new ArrayList<>();
        String sql = "SELECT a.emp_id, e.emp_nom, e.emp_ape, "
                + "a.fecha, a.hora_entrada, a.hora_salida, a.estado, "
                + "a.observaciones, IFNULL(j.jus_id, 0) > 0 as justificado "
                + "FROM asistencias a "
                + "INNER JOIN empleados e ON a.emp_id = e.emp_id "
                + "LEFT JOIN justificativos j ON a.emp_id = j.emp_id AND a.fecha BETWEEN j.desde AND j.hasta "
                + "WHERE YEAR(a.fecha) = ? AND MONTH(a.fecha) = ? "
                + "ORDER BY a.fecha, e.emp_ape, e.emp_nom";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month + 1); // MySQL usa meses 1-12

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AsistenciaInfo info = new AsistenciaInfo();
                    info.setEmpId(rs.getInt("emp_id"));
                    info.setNombre(rs.getString("emp_nom"));
                    info.setApellido(rs.getString("emp_ape"));
                    info.setFecha(rs.getDate("fecha"));
                    info.setHoraEntrada(rs.getTime("hora_entrada"));
                    info.setHoraSalida(rs.getTime("hora_salida"));
                    info.setEstado(rs.getString("estado"));
                    info.setJustificado(rs.getBoolean("justificado"));
                    info.setObservaciones(rs.getString("observaciones"));
                    lista.add(info);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
