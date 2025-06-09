package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.Justificativo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JustificativoDAO {
    private final Connection conexion;

    public JustificativoDAO() {
        this.conexion = ConexionBD.conectar();
    }

    // Insertar justificativo
    public boolean insertar(Justificativo justificativo) {
        String sql = "INSERT INTO justificativos (emp_id, desde, hasta, archivo_url, motivo) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, justificativo.getEmpId());
            ps.setDate(2, new java.sql.Date(justificativo.getDesde().getTime()));
            ps.setDate(3, new java.sql.Date(justificativo.getHasta().getTime()));
            ps.setString(4, justificativo.getArchivoUrl());
            ps.setString(5, justificativo.getMotivo());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        justificativo.setJusId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Obtener justificativos por empleado
    public List<Justificativo> obtenerPorEmpleado(int empId) {
        List<Justificativo> lista = new ArrayList<>();
        String sql = "SELECT * FROM justificativos WHERE emp_id = ? ORDER BY desde DESC";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Justificativo j = new Justificativo();
                    j.setJusId(rs.getInt("jus_id"));
                    j.setEmpId(rs.getInt("emp_id"));
                    j.setDesde(rs.getDate("desde"));
                    j.setHasta(rs.getDate("hasta"));
                    j.setArchivoUrl(rs.getString("archivo_url"));
                    j.setMotivo(rs.getString("motivo"));
                    lista.add(j);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Verificar si una fecha está justificada
    public boolean estaJustificado(int empId, Date fecha) {
        String sql = "SELECT COUNT(*) FROM justificativos WHERE emp_id = ? AND ? BETWEEN desde AND hasta";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ps.setDate(2, new java.sql.Date(fecha.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}