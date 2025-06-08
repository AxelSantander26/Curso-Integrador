package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.AsistenciaInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class AsistenciaDAO {
    private Connection conexion;

    public AsistenciaDAO() {
        this.conexion = ConexionBD.conectar();
    }

    // Obtener todos los empleados
public List<AsistenciaInfo> obtenerTodosLosEmpleados() {
    List<AsistenciaInfo> lista = new ArrayList<>();

    String sql = "SELECT emp_id, emp_nom, emp_ape FROM empleados";

    try (PreparedStatement ps = conexion.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            AsistenciaInfo emp = new AsistenciaInfo();
            emp.setEmpId(rs.getInt("emp_id"));
            emp.setNombre(rs.getString("emp_nom"));
            emp.setApellido(rs.getString("emp_ape"));
            lista.add(emp);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return lista;
}

// Obtener asistencias con justificación
public List<AsistenciaInfo> obtenerAsistenciasConJustificacion() {
    List<AsistenciaInfo> lista = new ArrayList<>();

    String sql = "SELECT a.emp_id, e.emp_nom, e.emp_ape, " +
            "a.fecha, a.hora_entrada, a.hora_salida, a.estado, " +
            "j.jus_id IS NOT NULL AS justificado, j.motivo AS observaciones " +
            "FROM asistencias a " +
            "INNER JOIN empleados e ON a.emp_id = e.emp_id " +
            "LEFT JOIN justificativos j ON a.asi_id = j.asi_id " +
            "ORDER BY a.fecha DESC";

    try (PreparedStatement ps = conexion.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

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

    } catch (Exception e) {
    }

    return lista;
}

}
