package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class UsuarioDAO {

    public static Usuario validarUsuario(String usuario, String password) {
        Usuario usuarioValidado = null;
        String query = "SELECT u.usr_id, u.usr_user, u.usr_pass, u.emp_id, u.rol_id, u.usr_act, "
                + "e.emp_nom, e.emp_ape, r.rol_nom AS rol "
                + "FROM usuarios u "
                + "JOIN empleados e ON u.emp_id = e.emp_id "
                + "JOIN roles r ON u.rol_id = r.rol_id "
                + "WHERE u.usr_user = ? AND u.usr_act = 1";

        try (Connection con = ConexionBD.conectar(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, usuario); // Cambié 'email' por 'usuario'
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("usr_pass");
                if (BCrypt.checkpw(password, storedPassword)) {
                    usuarioValidado = new Usuario(
                            rs.getInt("usr_id"),
                            rs.getInt("emp_id"),
                            rs.getString("usr_user"), // Cambié 'email' por 'usuario'
                            storedPassword,
                            rs.getInt("rol_id"),
                            rs.getBoolean("usr_act"),
                            rs.getString("emp_nom"),
                            rs.getString("emp_ape"),
                            rs.getString("rol")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuarioValidado;
    }
}