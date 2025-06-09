package grupo7.dentalogic.config;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class TestEmpIds {
    public static void main(String[] args) {
        Connection con = ConexionBD.conectar();

        if (con != null) {
            System.out.println("Conexión exitosa a la base de datos.");
            String query = "SELECT emp_id FROM empleados ORDER BY emp_id";

            try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
                System.out.println("IDs de empleados registrados:");
                while (rs.next()) {
                    int id = rs.getInt("emp_id");
                    System.out.println("ID: " + id);
                }
            } catch (SQLException e) {
                System.out.println("Error al ejecutar la consulta: " + e.getMessage());
            }
        } else {
            System.out.println("Error al conectar con la base de datos.");
        }
    }
}
