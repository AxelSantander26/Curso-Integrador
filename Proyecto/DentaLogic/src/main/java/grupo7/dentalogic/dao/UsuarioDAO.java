package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class UsuarioDAO {

    public static Usuario validarUsuario(String email, String password) {
        Usuario usuario = null;
        String query = "SELECT u.id_usuario, u.email, u.password, u.id_empleado, u.id_rol, u.activo, "
                + "e.nombre, e.apellido, r.nombre AS rol "
                + "FROM usuarios u "
                + "JOIN empleados e ON u.id_empleado = e.id_empleado "
                + "JOIN roles r ON u.id_rol = r.id_rol "
                + "WHERE u.email = ? AND u.activo = 1";

        try (Connection con = ConexionBD.conectar(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, storedPassword)) {
                    usuario = new Usuario(
                            rs.getInt("id_usuario"),
                            rs.getInt("id_empleado"),
                            rs.getString("email"),
                            storedPassword,
                            rs.getInt("id_rol"),
                            rs.getBoolean("activo"),
                            rs.getString("nombre"),
                            rs.getString("apellido"),
                            rs.getString("rol")
                    );
                }
            }
        } catch (SQLException e) {
        }

        return usuario;
    }
}
