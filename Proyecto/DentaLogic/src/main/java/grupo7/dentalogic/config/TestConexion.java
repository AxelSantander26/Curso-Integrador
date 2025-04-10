package grupo7.dentalogic.config;

import java.sql.Connection;

public class TestConexion {
    public static void main(String[] args) {
        Connection con = ConexionBD.conectar();
        if (con != null) {
            System.out.println("Conexion exitosa a la base de datos");
        } else {
            System.out.println("Error en la Conexion");
        }
    }
}
