package grupo7.dentalogic.dao;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.model.DashboardInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDAO {
    private Connection conexion;

    public DashboardDAO() {
        conexion = ConexionBD.conectar();
    }

    public DashboardInfo obtenerDashboardInfo() {
        DashboardInfo info = new DashboardInfo();

        try {
            // Total de empleados
            PreparedStatement ps1 = conexion.prepareStatement("SELECT COUNT(*) FROM empleados");
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                info.setTotalEmpleados(rs1.getInt(1));
            }

            // Total de bonos
            PreparedStatement ps2 = conexion.prepareStatement("SELECT COUNT(*) FROM bonos");
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                info.setTotalBonos(rs2.getInt(1));
            }

            // Asistencias de hoy (por fecha actual)
            PreparedStatement ps3 = conexion.prepareStatement(
                "SELECT COUNT(*) FROM detalle_asistencias WHERE asis_id IN (SELECT asis_id FROM asistencias WHERE asis_fec = CURDATE())"
            );
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                info.setAsistenciasHoy(rs3.getInt(1));
            }

            // Total a pagar (ficticio o por ahora suma netos)
            PreparedStatement ps4 = conexion.prepareStatement(
                "SELECT SUM(sueldo_neto) FROM detalle_pagos"
            );
            ResultSet rs4 = ps4.executeQuery();
            if (rs4.next()) {
                info.setTotalPagar(rs4.getDouble(1));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return info;
    }
}
