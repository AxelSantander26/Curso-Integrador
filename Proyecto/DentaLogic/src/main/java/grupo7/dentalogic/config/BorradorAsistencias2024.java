package grupo7.dentalogic.config;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class BorradorAsistencias2024 {

    public static void main(String[] args) {
        try (Connection conn = ConexionBD.conectar()) {
            System.out.println("Conexión establecida.");

            String sql = """
                DELETE FROM asistencias
                WHERE YEAR(fecha) = 2024
            """;

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                int filasEliminadas = stmt.executeUpdate();
                System.out.println("Asistencias eliminadas: " + filasEliminadas);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
