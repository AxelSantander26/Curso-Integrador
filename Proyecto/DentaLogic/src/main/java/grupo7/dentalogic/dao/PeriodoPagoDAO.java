package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.PeriodoPago;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PeriodoPagoDAO {
    private final Connection conexion;

    public PeriodoPagoDAO() {
        this.conexion = ConexionBD.conectar();
    }

    public List<PeriodoPago> obtenerTodos() {
        List<PeriodoPago> periodos = new ArrayList<>();
        String sql = "SELECT * FROM periodos_pago";

        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PeriodoPago p = new PeriodoPago(
                    rs.getInt("per_id"),
                    rs.getDate("per_ini"),
                    rs.getDate("per_fin"),
                    rs.getString("per_nom"),
                    rs.getString("per_desc")
                );
                periodos.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return periodos;
    }

    public PeriodoPago obtenerPorId(int id) {
        PeriodoPago periodo = null;
        String sql = "SELECT * FROM periodos_pago WHERE per_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    periodo = new PeriodoPago(
                        rs.getInt("per_id"),
                        rs.getDate("per_ini"),
                        rs.getDate("per_fin"),
                        rs.getString("per_nom"),
                        rs.getString("per_desc")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return periodo;
    }

    public boolean agregarPeriodo(PeriodoPago periodo) {
        String sql = "INSERT INTO periodos_pago (per_ini, per_fin, per_nom, per_desc) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setDate(1, new java.sql.Date(periodo.getPerIni().getTime()));
            ps.setDate(2, new java.sql.Date(periodo.getPerFin().getTime()));
            ps.setString(3, periodo.getPerNom());
            ps.setString(4, periodo.getPerDesc());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarPeriodo(PeriodoPago periodo) {
        String sql = "UPDATE periodos_pago SET per_ini = ?, per_fin = ?, per_nom = ?, per_desc = ? WHERE per_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setDate(1, new java.sql.Date(periodo.getPerIni().getTime()));
            ps.setDate(2, new java.sql.Date(periodo.getPerFin().getTime()));
            ps.setString(3, periodo.getPerNom());
            ps.setString(4, periodo.getPerDesc());
            ps.setInt(5, periodo.getPerId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarPeriodo(int id) {
        String sql = "DELETE FROM periodos_pago WHERE per_id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
