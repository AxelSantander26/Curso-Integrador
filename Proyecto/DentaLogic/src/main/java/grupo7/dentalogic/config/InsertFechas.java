package grupo7.dentalogic.config;

import java.sql.*;
import java.time.*;
import java.util.*;

public class InsertFechas {

    public static void main(String[] args) {
        Connection con = ConexionBD.conectar();

        if (con == null) {
            System.out.println("Error en la conexión.");
            return;
        }

        List<Integer> empIds = Arrays.asList(
                33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
                43, 44, 45, 46, 47, 48, 49, 50, 51, 52,
                53, 54, 55, 56, 57, 58, 59, 60, 61, 62,
                63, 64, 67
        );

        Map<Integer, Integer> totalTardanzas = new HashMap<>();
        Map<Integer, Integer> semanaTardanzas = new HashMap<>();

        LocalDate start = LocalDate.of(2025, 5, 1);
        LocalDate end = LocalDate.of(2025, 5, 31);

        try {
            String sql = "INSERT INTO asistencias (emp_id, fecha, hora_entrada, hora_salida, estado, observaciones) VALUES (?, ?, ?, ?, ?, NULL)";
            PreparedStatement ps = con.prepareStatement(sql);

            for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
                DayOfWeek dow = date.getDayOfWeek();
                if (dow == DayOfWeek.SATURDAY || dow == DayOfWeek.SUNDAY) {
                    continue;
                }

                // Reset semanal los lunes
                if (dow == DayOfWeek.MONDAY) {
                    semanaTardanzas.clear();
                }

                for (int empId : empIds) {
                    totalTardanzas.putIfAbsent(empId, 0);
                    semanaTardanzas.putIfAbsent(empId, 0);

                    String estado = "PUNTUAL";
                    LocalTime horaEntrada = LocalTime.of(15, 0);

                    // Todos puntuales los viernes
                    if (dow != DayOfWeek.FRIDAY
                            && semanaTardanzas.get(empId) < 3
                            && totalTardanzas.get(empId) < 5
                            && Math.random() < 0.2) { // 20% chance de tardanza

                        estado = "TARDANZA";
                        semanaTardanzas.put(empId, semanaTardanzas.get(empId) + 1);
                        totalTardanzas.put(empId, totalTardanzas.get(empId) + 1);
                        int minutosTarde = 11 + new Random().nextInt(10); // entre 11 y 20 min tarde
                        horaEntrada = horaEntrada.plusMinutes(minutosTarde);
                    } else {
                        // Puntual
                        int minutosAntes = new Random().nextInt(5); // hasta 4 minutos antes
                        horaEntrada = horaEntrada.minusMinutes(minutosAntes);
                    }

                    ps.setInt(1, empId);
                    ps.setDate(2, java.sql.Date.valueOf(date));
                    ps.setTime(3, Time.valueOf(horaEntrada));
                    ps.setTime(4, Time.valueOf(LocalTime.of(20, 0)));
                    ps.setString(5, estado);
                    ps.addBatch();
                }
            }

            ps.executeBatch();
            System.out.println("Asistencias insertadas correctamente para mayo 2025.");
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
