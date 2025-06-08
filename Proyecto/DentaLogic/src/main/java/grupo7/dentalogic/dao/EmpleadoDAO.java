package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.Empleado;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO {

    private Connection conexion;

    public EmpleadoDAO() {
        this.conexion = ConexionBD.conectar(); // Usar conexi?n directa
    }

// ? LISTAR todos los empleados
    public List<Empleado> obtenerTodos() {
        List<Empleado> empleados = new ArrayList<>();
        String sql = "SELECT e.emp_id, e.emp_dni, e.emp_nom, e.emp_ape, e.emp_email, e.emp_tel, e.emp_fec, e.emp_sal, e.esp_id, es.esp_nom "
                + "FROM empleados e LEFT JOIN especialidades es ON e.esp_id = es.esp_id";

        try (PreparedStatement ps = conexion.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Empleado emp = new Empleado();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setEmpDni(rs.getString("emp_dni"));
                emp.setEmpNom(rs.getString("emp_nom"));
                emp.setEmpApe(rs.getString("emp_ape"));
                emp.setEmpEmail(rs.getString("emp_email"));
                emp.setEmpTel(rs.getString("emp_tel"));
                emp.setEmpFec(rs.getDate("emp_fec"));
                emp.setEmpSal(rs.getDouble("emp_sal"));
                emp.setEspId(rs.getInt("esp_id"));
                emp.setEspecialidad(rs.getString("esp_nom") != null ? rs.getString("esp_nom") : "Sin especialidad");

                empleados.add(emp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return empleados;
    }

// ? INSERTAR nuevo empleado
    public boolean agregarEmpleado(Empleado emp) {
        String sql = "INSERT INTO empleados (emp_dni, emp_nom, emp_ape, emp_email, emp_tel, emp_fec, emp_sal, esp_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, emp.getEmpDni());
            ps.setString(2, emp.getEmpNom());
            ps.setString(3, emp.getEmpApe());
            ps.setString(4, emp.getEmpEmail());
            ps.setString(5, emp.getEmpTel());
            ps.setDate(6, emp.getEmpFec());
            ps.setDouble(7, emp.getEmpSal());
            ps.setInt(8, emp.getEspId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// ?? ACTUALIZAR empleado existente
    public boolean actualizarEmpleado(Empleado emp) {
        String sql = "UPDATE empleados SET emp_dni = ?, emp_nom = ?, emp_ape = ?, emp_email = ?, emp_tel = ?, emp_fec = ?, emp_sal = ?, esp_id = ? WHERE emp_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, emp.getEmpDni());
            ps.setString(2, emp.getEmpNom());
            ps.setString(3, emp.getEmpApe());
            ps.setString(4, emp.getEmpEmail());
            ps.setString(5, emp.getEmpTel());
            ps.setDate(6, emp.getEmpFec());
            ps.setDouble(7, emp.getEmpSal());
            ps.setInt(8, emp.getEspId());
            ps.setInt(9, emp.getEmpId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// ?? ELIMINAR empleado por ID
    public boolean eliminarEmpleado(int empId) {
        String sql = "DELETE FROM empleados WHERE emp_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// ? OBTENER empleado por ID (?til para editar)
    public Empleado obtenerPorId(int empId) {
        String sql = "SELECT e.*, es.esp_nom FROM empleados e LEFT JOIN especialidades es ON e.esp_id = es.esp_id WHERE emp_id = ?";
        Empleado emp = null;

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    emp = new Empleado();
                    emp.setEmpId(rs.getInt("emp_id"));
                    emp.setEmpDni(rs.getString("emp_dni"));
                    emp.setEmpNom(rs.getString("emp_nom"));
                    emp.setEmpApe(rs.getString("emp_ape"));
                    emp.setEmpEmail(rs.getString("emp_email"));
                    emp.setEmpTel(rs.getString("emp_tel"));
                    emp.setEmpFec(rs.getDate("emp_fec"));
                    emp.setEmpSal(rs.getDouble("emp_sal"));
                    emp.setEspId(rs.getInt("esp_id"));
                    emp.setEspecialidad(rs.getString("esp_nom"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return emp;
    }

}