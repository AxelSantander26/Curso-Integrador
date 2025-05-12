package grupo7.dentalogic.config;

import java.sql.*;

public class TestConexion {
    public static void main(String[] args) {
        // Probar conexión
        Connection con = ConexionBD.conectar();
        if (con != null) {
            System.out.println("Conexión exitosa a la base de datos");

            // Realizar una consulta SELECT
            String query = "SELECT * FROM empleados";  // Aquí va tu consulta SQL
            try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
                // Iterar sobre los resultados
                while (rs.next()) {
                    // Puedes cambiar esto según los campos de la tabla empleados
                    System.out.println("ID Empleado: " + rs.getInt("emp_id"));
                    System.out.println("Nombre: " + rs.getString("emp_nom"));
                    System.out.println("Apellido: " + rs.getString("emp_ape"));
                    System.out.println("Email: " + rs.getString("emp_email"));
                    // Agrega más columnas según lo necesites
                }
            } catch (SQLException e) {
                System.out.println("Error al ejecutar la consulta: " + e.getMessage());
            }

        } else {
            System.out.println("Error en la conexión");
        }
    }
}
