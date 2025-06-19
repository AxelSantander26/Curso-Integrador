package grupo7.dentalogic.config;

import java.sql.*;
import java.time.*;

public class AsistenciasID2 {

    public static void main(String[] args) {
        try (Connection conn = ConexionBD.conectar()) {
            System.out.println("Conexión establecida.");

            insertarAsistenciasManualesParaID2(conn);

            System.out.println("Asistencias para emp_id=2 insertadas correctamente.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void insertarAsistenciasManualesParaID2(Connection conn) throws SQLException {
        int empId = 2;

        LocalTime entradaOficial = LocalTime.of(8, 0);
        LocalTime salidaOficial = LocalTime.of(16, 0);

        // Semana pasada: lunes 2 al viernes 6 de junio de 2025
        for (int dia = 2; dia <= 6; dia++) {
            LocalDate fecha = LocalDate.of(2025, 6, dia);
            insertarAsistencia(conn, empId, fecha, entradaOficial, salidaOficial,
                    "PUNTUAL", "NORMAL", 0, 0);
        }

        // Lunes 9 de junio: puntual
        LocalDate lunes = LocalDate.of(2025, 6, 9);
        insertarAsistencia(conn, empId, lunes, entradaOficial, salidaOficial,
                "PUNTUAL", "NORMAL", 0, 0);

        // Martes 10 de junio: llegó 13 min tarde, salió 10 min después (considerado NORMAL)
        LocalDate martes = LocalDate.of(2025, 6, 10);
        LocalTime entradaTarde = entradaOficial.plusMinutes(13);
        LocalTime salidaTarde = salidaOficial.plusMinutes(10);
        insertarAsistencia(conn, empId, martes, entradaTarde, salidaTarde,
                "TARDANZA", "NORMAL", 13, 0);
    }

    private static void insertarAsistencia(Connection conn, int empId, LocalDate fecha,
                                           LocalTime horaEntrada, LocalTime horaSalida,
                                           String estadoEntrada, String estadoSalida,
                                           int minTardanza, int minAnticipacion) throws SQLException {
        String sql = """
            INSERT INTO asistencias
            (emp_id, fecha, hora_entrada, hora_salida, estado_entrada, estado_salida, min_tardanza, min_anticipacion)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, empId);
            stmt.setDate(2, Date.valueOf(fecha));
            stmt.setTime(3, Time.valueOf(horaEntrada));
            stmt.setTime(4, Time.valueOf(horaSalida));
            stmt.setString(5, estadoEntrada);
            stmt.setString(6, estadoSalida);
            stmt.setInt(7, minTardanza);
            stmt.setInt(8, minAnticipacion);
            stmt.executeUpdate();

            System.out.printf("INSERTADO | Fecha: %s | Entrada: %s (%s, %d min) | Salida: %s (%s, %d min)%n",
                    fecha, horaEntrada, estadoEntrada, minTardanza, horaSalida, estadoSalida, minAnticipacion);
        }
    }
}
