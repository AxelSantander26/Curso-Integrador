package grupo7.dentalogic.dao;

import grupo7.dentalogic.model.Empleado;
import java.sql.*;
import java.util.*;

public class EmpleadoDAO {
    public static List<Empleado> obtenerTodos(Connection conn) throws SQLException {
        List<Empleado> lista = new ArrayList<>();
        String sql = "SELECT e.emp_id, e.emp_nombre, e.emp_apellido, e.emp_dni, e.esp_id, es.esp_nombre, e.hor_id, CONCAT(h.hora_entrada, ' – ', h.hora_salida) AS horario FROM empleados e JOIN especialidades es ON e.esp_id = es.esp_id JOIN horarios h ON e.hor_id = h.hor_id ORDER BY e.emp_id ASC";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Empleado emp = new Empleado();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setEmpNombre(rs.getString("emp_nombre"));
                emp.setEmpApellido(rs.getString("emp_apellido"));
                emp.setEmpDni(rs.getString("emp_dni"));
                emp.setEspId(rs.getInt("esp_id"));
                emp.setEspecialidad(rs.getString("esp_nombre"));
                emp.setHorId(rs.getInt("hor_id"));
                emp.setHorario(rs.getString("horario"));
                lista.add(emp);
            }
        }
        return lista;
    }

    public static void insertar(Connection conn, Empleado emp) throws SQLException {
        String sql = "INSERT INTO empleados (emp_nombre, emp_apellido, emp_dni, esp_id, hor_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, emp.getEmpNombre());
            stmt.setString(2, emp.getEmpApellido());
            stmt.setString(3, emp.getEmpDni());
            stmt.setInt(4, emp.getEspId());
            stmt.setInt(5, emp.getHorId());
            stmt.executeUpdate();
        }
    }

    public static void actualizar(Connection conn, Empleado emp) throws SQLException {
        String sql = "UPDATE empleados SET emp_nombre=?, emp_apellido=?, emp_dni=?, esp_id=?, hor_id=? WHERE emp_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, emp.getEmpNombre());
            stmt.setString(2, emp.getEmpApellido());
            stmt.setString(3, emp.getEmpDni());
            stmt.setInt(4, emp.getEspId());
            stmt.setInt(5, emp.getHorId());
            stmt.setInt(6, emp.getEmpId());
            stmt.executeUpdate();
        }
    }

    public static void eliminar(Connection conn, int id) throws SQLException {
        String sql = "DELETE FROM empleados WHERE emp_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
