package grupo7.dentalogic.config;

import java.sql.*;

public class CorregirUsuariosPorDNI {

    public static void main(String[] args) {
        try (Connection conn = ConexionBD.conectar()) {
            String select = "SELECT usr_id, emp_id, usr_user FROM usuarios WHERE rol_id = 3";
            PreparedStatement ps = conn.prepareStatement(select);
            ResultSet rs = ps.executeQuery();

            int corregidos = 0;

            while (rs.next()) {
                int usrId = rs.getInt("usr_id");
                int empId = rs.getInt("emp_id");
                String usuarioActual = rs.getString("usr_user");

                // Verificar si ya cumple formato O00000000
                if (usuarioActual.matches("^O\\d{8}$")) {
                    continue;
                }

                // Obtener el DNI del empleado
                String dni = obtenerDniEmpleado(conn, empId);
                if (dni == null || !dni.matches("\\d{8}")) {
                    System.out.println("? DNI inválido para emp_id " + empId + ": " + dni);
                    continue;
                }

                String nuevoUsuario = "O" + dni;

                // Verificar si ya existe ese nombre de usuario
                if (existeUsuario(conn, nuevoUsuario)) {
                    System.out.println("? Usuario ya existe: " + nuevoUsuario + " ? se omite");
                    continue;
                }

                // Actualizar usuario
                PreparedStatement update = conn.prepareStatement(
                    "UPDATE usuarios SET usr_user = ? WHERE usr_id = ?"
                );
                update.setString(1, nuevoUsuario);
                update.setInt(2, usrId);
                update.executeUpdate();
                update.close();

                corregidos++;
                System.out.println("? Usuario corregido: " + usuarioActual + " ? " + nuevoUsuario);
            }

            rs.close();
            ps.close();

            System.out.println("? Total corregidos: " + corregidos);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static String obtenerDniEmpleado(Connection conn, int empId) {
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT emp_dni FROM empleados WHERE emp_id = ?");
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("emp_dni");
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static boolean existeUsuario(Connection conn, String nuevoUsuario) {
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM usuarios WHERE usr_user = ?");
            ps.setString(1, nuevoUsuario);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
