package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

public class UsuarioDAO {

    public Usuario login(String username, String password) {
        Usuario usuario = null;

        String sql = """
            SELECT u.usr_id, u.emp_id, u.usr_usuario, u.usr_clave, u.rol_id,
                   e.emp_nombre, e.emp_apellido, r.rol_nombre
            FROM usuarios u
            JOIN empleados e ON u.emp_id = e.emp_id
            JOIN roles r ON u.rol_id = r.rol_id
            WHERE u.usr_usuario = ?
        """;

        try (Connection conn = ConexionBD.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashedPassword = rs.getString("usr_clave");
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        usuario = new Usuario();
                        usuario.setIdUsuario(rs.getInt("usr_id"));
                        usuario.setIdEmpleado(rs.getInt("emp_id"));
                        usuario.setUsuario(rs.getString("usr_usuario"));
                        usuario.setPassword(null); // No exponer el hash
                        usuario.setIdRol(rs.getInt("rol_id"));
                        usuario.setNombre(rs.getString("emp_nombre"));
                        usuario.setApellido(rs.getString("emp_apellido"));
                        usuario.setRol(rs.getString("rol_nombre"));
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
    }
}
