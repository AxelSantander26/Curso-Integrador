package grupo7.dentalogic.config;

import java.sql.*;

public class TestConexion {
    public static void main(String[] args) {
        // Probar conexión
        Connection con = ConexionBD.conectar();
        if (con != null) {
            System.out.println("Conexión exitosa a la base de datos");

            // Consulta SQL
            String query = "SELECT emp_id, emp_nombre, emp_apellido FROM empleados";

            try (Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {

                while (rs.next()) {
                    int empId = rs.getInt("emp_id");
                    String nombre = rs.getString("emp_nombre");
                    String apellido = rs.getString("emp_apellido");

                    System.out.println("ID Empleado: " + empId);
                    System.out.println("Nombre: " + nombre);
                    System.out.println("Apellido: " + apellido);
                    System.out.println("---------------------");
                }

            } catch (SQLException e) {
                System.out.println("Error al ejecutar la consulta: " + e.getMessage());
            }

        } else {
            System.out.println("Error en la conexión");
        }
    }
}
