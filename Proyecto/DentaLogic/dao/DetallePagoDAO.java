package grupo7.dentalogic.dao;

import grupo7.dentalogic.model.DetallePago;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DetallePagoDAO {

    private final Connection connection;

    public DetallePagoDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean insertar(DetallePago dp) throws SQLException {
        String sql = "INSERT INTO detalle_pagos (emp_id, pag_id, per_id, bono_id, detp_mon, descuento_total, sueldo_neto) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, dp.getEmpId());
            stmt.setInt(2, dp.getPagId());
            stmt.setInt(3, dp.getPerId());
            stmt.setInt(4, dp.getBonoId());
            stmt.setDouble(5, dp.getDetpMon());
            stmt.setDouble(6, dp.getDescuentoTotal());
            stmt.setDouble(7, dp.getSueldoNeto());

            return stmt.executeUpdate() > 0;
        }
    }

    public List<DetallePago> listarTodos() throws SQLException {
        List<DetallePago> lista = new ArrayList<>();

        String sql = "SELECT dp.detp_id, dp.emp_id, dp.per_id, dp.bono_id, dp.detp_mon, dp.descuento_total, dp.sueldo_neto, " +
                     "e.emp_sal AS sueldo_base, " +
                     "b.bono_can AS bono_monto, " +
                     "CONCAT(e.emp_nom, ' ', e.emp_ape) AS empleado_nombre, " +
                     "p.per_nom AS periodo_nombre " +
                     "FROM detalle_pagos dp " +
                     "JOIN empleados e ON dp.emp_id = e.emp_id " +
                     "JOIN periodos_pago p ON dp.per_id = p.per_id " +
                     "LEFT JOIN bonos b ON dp.bono_id = b.bono_id";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                DetallePago dp = new DetallePago();
                dp.setDetpId(rs.getInt("detp_id"));
                dp.setEmpId(rs.getInt("emp_id"));
                dp.setPerId(rs.getInt("per_id"));
                dp.setBonoId(rs.getInt("bono_id"));
                dp.setDetpMon(rs.getDouble("detp_mon"));
                dp.setDescuentoTotal(rs.getDouble("descuento_total"));
                dp.setSueldoNeto(rs.getDouble("sueldo_neto"));

                dp.setEmpleadoNombre(rs.getString("empleado_nombre"));
                dp.setPeriodoNombre(rs.getString("periodo_nombre"));

                dp.setSueldoBase(rs.getDouble("sueldo_base"));
                dp.setBonoMonto(rs.getDouble("bono_monto"));

                lista.add(dp);
            }
        }

        return lista;
    }

    public double obtenerSueldoBase(int empId) throws SQLException {
        String sql = "SELECT emp_sal FROM empleados WHERE emp_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("emp_sal");
            }
        }
        return 0.0;
    }

    public double obtenerMontoBono(int bonoId) throws SQLException {
        String sql = "SELECT bono_can FROM bonos WHERE bono_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bonoId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("bono_can");
            }
        }
        return 0.0;
    }
}

