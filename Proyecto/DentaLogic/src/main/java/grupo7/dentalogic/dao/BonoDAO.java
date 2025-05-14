package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.Bono;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BonoDAO {

    private final Connection conexion;

    public BonoDAO() {
        this.conexion = ConexionBD.conectar();
    }

    public List<Bono> obtenerTodos() {
        List<Bono> bonos = new ArrayList<>();
        String sql = "SELECT * FROM bonos";

        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Bono bono = new Bono(
                        rs.getInt("bono_id"),
                        rs.getString("bono_nom"),
                        rs.getDouble("bono_can"),
                        rs.getString("bono_desc")
                );
                bonos.add(bono);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bonos;
    }

    public Bono obtenerPorId(int id) {
        Bono bono = null;
        String sql = "SELECT * FROM bonos WHERE bono_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bono = new Bono(
                            rs.getInt("bono_id"),
                            rs.getString("bono_nom"),
                            rs.getDouble("bono_can"),
                            rs.getString("bono_desc")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bono;
    }

    public boolean agregarBono(Bono bono) {
        String sql = "INSERT INTO bonos (bono_nom, bono_can, bono_desc) VALUES (?, ?, ?)";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, bono.getBonoNom());
            ps.setDouble(2, bono.getBonoCan());
            ps.setString(3, bono.getBonoDesc());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarBono(Bono bono) {
        String sql = "UPDATE bonos SET bono_nom = ?, bono_can = ?, bono_desc = ? WHERE bono_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, bono.getBonoNom());
            ps.setDouble(2, bono.getBonoCan());
            ps.setString(3, bono.getBonoDesc());
            ps.setInt(4, bono.getBonoId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarBono(int id) {
        String sql = "DELETE FROM bonos WHERE bono_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
