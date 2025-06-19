package grupo7.dentalogic.dao;

import grupo7.dentalogic.model.Justificativo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JustificativoDAO {

    public static void insertar(Connection conn, Justificativo j) throws SQLException {
        String sql = "INSERT INTO justificativos (emp_id, desde, hasta, archivo_url, motivo) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, j.getEmpId());
            stmt.setDate(2, j.getDesde());
            stmt.setDate(3, j.getHasta());
            if (j.getArchivoUrl() == null || j.getArchivoUrl().isBlank()) {
                stmt.setNull(4, Types.VARCHAR);
            } else {
                stmt.setString(4, j.getArchivoUrl());
            }
            stmt.setString(5, j.getMotivo());
            stmt.executeUpdate();
        }
    }

    public static List<Justificativo> listarPorMes(Connection conn, int mes, int anio) throws SQLException {
        List<Justificativo> lista = new ArrayList<>();
        String sql = """
            SELECT j.jus_id, j.emp_id, e.emp_nombre, e.emp_apellido,
                   j.desde, j.hasta, j.motivo, j.archivo_url
            FROM justificativos j
            JOIN empleados e ON j.emp_id = e.emp_id
            WHERE (MONTH(j.desde) = ? OR MONTH(j.hasta) = ?)
              AND (YEAR(j.desde) = ? OR YEAR(j.hasta) = ?)
            ORDER BY j.desde DESC
        """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, mes);
            stmt.setInt(2, mes);
            stmt.setInt(3, anio);
            stmt.setInt(4, anio);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Justificativo j = new Justificativo();
                j.setJusId(rs.getInt("jus_id"));
                j.setEmpId(rs.getInt("emp_id"));
                j.setEmpleadoNombre(rs.getString("emp_nombre") + " " + rs.getString("emp_apellido"));
                j.setDesde(rs.getDate("desde"));
                j.setHasta(rs.getDate("hasta"));
                j.setMotivo(rs.getString("motivo"));
                j.setArchivoUrl(rs.getString("archivo_url"));
                lista.add(j);
            }
        }
        return lista;
    }

    public static void eliminar(Connection conn, int jusId) throws SQLException {
        String sql = "DELETE FROM justificativos WHERE jus_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, jusId);
            stmt.executeUpdate();
        }
    }
}
