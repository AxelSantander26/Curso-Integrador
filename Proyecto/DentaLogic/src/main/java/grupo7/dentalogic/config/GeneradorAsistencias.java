package grupo7.dentalogic.config;

import java.sql.*;
import java.time.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Random;

public class GeneradorAsistencias {

    public static void main(String[] args) {
        try (Connection conn = ConexionBD.conectar()) {
            System.out.println("Conexión establecida.");

            int anio = 2025;
            int mes = 5; // Junio
            List<EmpleadoHorario> empleados = obtenerEmpleadosConHorario(conn);
            empleados.removeIf(e -> e.id == 2); // Excluir ID 2

            int tardanzasRestantes = 8;
            Random rand = new Random();

            for (EmpleadoHorario emp : empleados) {
                for (int dia = 1; dia <= 13; dia++) {
                    LocalDate fecha = LocalDate.of(anio, mes + 1, dia);
                    DayOfWeek diaSemana = fecha.getDayOfWeek();
                    if (diaSemana == DayOfWeek.SATURDAY || diaSemana == DayOfWeek.SUNDAY) continue;

                    boolean marcarTarde = rand.nextInt(100) < 10 && tardanzasRestantes > 0;
                    if (marcarTarde) tardanzasRestantes--;

                    boolean marcarAnticipada = rand.nextInt(100) < 10;

                    generarYGuardarRegistro(conn, fecha, emp, marcarTarde, marcarAnticipada);
                }
            }

            System.out.println("Generación e inserción de asistencias completada.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    static void generarYGuardarRegistro(Connection conn, LocalDate fecha, EmpleadoHorario emp, boolean conTardanza, boolean salidaAnticipada) throws SQLException {
        LocalTime horaEntradaEst = emp.horaEntrada;
        LocalTime horaSalidaEst = emp.horaSalida;

        LocalTime horaEntradaMarcada = conTardanza
                ? horaEntradaEst.plusMinutes(5 + new Random().nextInt(16))
                : horaEntradaEst.minusMinutes(new Random().nextInt(5));

        LocalTime horaSalidaMarcada = salidaAnticipada
                ? horaSalidaEst.minusMinutes(5 + new Random().nextInt(11))
                : horaSalidaEst;

        int minTardanza = Math.max(0, (int) Duration.between(horaEntradaEst, horaEntradaMarcada).toMinutes());
        int minAnticipacion = Math.max(0, (int) Duration.between(horaSalidaMarcada, horaSalidaEst).toMinutes());

        String estadoEntrada = (minTardanza > 0) ? "TARDANZA" : "PUNTUAL";
        String estadoSalida = (minAnticipacion > 0) ? "ANTICIPADA" : "NORMAL";

        System.out.printf("INSERTANDO | Fecha: %s | EmpID: %d | Entrada: %s (%s, %d min) | Salida: %s (%s, %d min)%n",
                fecha,
                emp.id,
                horaEntradaMarcada,
                estadoEntrada,
                minTardanza,
                horaSalidaMarcada,
                estadoSalida,
                minAnticipacion
        );

        String sql = """
            INSERT INTO asistencias
            (emp_id, fecha, hora_entrada, hora_salida, estado_entrada, estado_salida, min_tardanza, min_anticipacion)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, emp.id);
            stmt.setDate(2, Date.valueOf(fecha));
            stmt.setTime(3, Time.valueOf(horaEntradaMarcada));
            stmt.setTime(4, Time.valueOf(horaSalidaMarcada));
            stmt.setString(5, estadoEntrada);
            stmt.setString(6, estadoSalida);
            stmt.setInt(7, minTardanza);
            stmt.setInt(8, minAnticipacion);
            stmt.executeUpdate();
        }
    }

    static List<EmpleadoHorario> obtenerEmpleadosConHorario(Connection conn) throws SQLException {
        List<EmpleadoHorario> lista = new ArrayList<>();
        String sql = """
            SELECT e.emp_id, h.hora_entrada, h.hora_salida
            FROM empleados e
            JOIN horarios h ON e.hor_id = h.hor_id
        """;
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("emp_id");
                LocalTime entrada = rs.getTime("hora_entrada").toLocalTime();
                LocalTime salida = rs.getTime("hora_salida").toLocalTime();
                lista.add(new EmpleadoHorario(id, entrada, salida));
            }
        }
        return lista;
    }

    static class EmpleadoHorario {
        int id;
        LocalTime horaEntrada;
        LocalTime horaSalida;

        EmpleadoHorario(int id, LocalTime entrada, LocalTime salida) {
            this.id = id;
            this.horaEntrada = entrada;
            this.horaSalida = salida;
        }
    }
}
