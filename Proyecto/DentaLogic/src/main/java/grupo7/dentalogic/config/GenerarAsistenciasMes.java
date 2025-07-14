package grupo7.dentalogic.config;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Scanner;
import java.util.Set;

public class GenerarAsistenciasMes {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingrese el mes (1-12): ");
        int mes = sc.nextInt();
        System.out.print("Ingrese el último día del mes hasta donde generar registros: ");
        int ultimoDia = sc.nextInt();

        Connection con = ConexionBD.conectar();
        if (con != null) {
            System.out.println("Conexión exitosa");

            try {
                // Calcular primer día laboral del mes
                LocalDate tmp = LocalDate.of(2025, mes, 1);
                while (tmp.getDayOfWeek().getValue() > 5) {
                    tmp = tmp.plusDays(1);
                }
                LocalDate inicio = tmp;

                // Generar lista de días laborales hasta el último día
                LocalDate fin = LocalDate.of(2025, mes, ultimoDia);
                List<LocalDate> diasLaborales = new ArrayList<>();
                for (LocalDate d = inicio; !d.isAfter(fin); d = d.plusDays(1)) {
                    if (d.getDayOfWeek().getValue() <= 5) {
                        diasLaborales.add(d);
                    }
                }

                // Borrar asistencias del mes completo
                String delete = "DELETE FROM asistencias WHERE fecha BETWEEN ? AND ?";
                PreparedStatement psDelete = con.prepareStatement(delete);
                psDelete.setDate(1, Date.valueOf(LocalDate.of(2025, mes, 1)));
                psDelete.setDate(2, Date.valueOf(LocalDate.of(2025, mes, 31)));
                int eliminadas = psDelete.executeUpdate();
                System.out.println("Se eliminaron " + eliminadas + " asistencias previas.");

                // Obtener IDs de empleados
                Statement st = con.createStatement();
                List<Integer> empleados = new ArrayList<>();
                ResultSet rs = st.executeQuery("SELECT emp_id FROM empleados");
                while (rs.next()) {
                    empleados.add(rs.getInt("emp_id"));
                }

                // Insertar asistencias puntuales
                String sqlInsert = "INSERT INTO asistencias (emp_id, fecha, hora_entrada, hora_salida, estado_entrada, estado_salida, min_tardanza, min_anticipacion) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement psInsert = con.prepareStatement(sqlInsert);
                int registros = 0;
                for (Integer empId : empleados) {
                    for (LocalDate fecha : diasLaborales) {
                        psInsert.setInt(1, empId);
                        psInsert.setDate(2, Date.valueOf(fecha));
                        psInsert.setTime(3, Time.valueOf("08:00:00"));
                        psInsert.setTime(4, Time.valueOf("16:00:00"));
                        psInsert.setString(5, "PUNTUAL");
                        psInsert.setString(6, "NORMAL");
                        psInsert.setInt(7, 0);
                        psInsert.setInt(8, 0);
                        psInsert.addBatch();
                        registros++;
                    }
                }
                psInsert.executeBatch();
                System.out.println("Asistencias puntuales insertadas: " + registros);

                Random rand = new Random();

                // Generar tardanzas
                Set<String> tardanzasSet = new HashSet<>();
                while (tardanzasSet.size() < 14 && !diasLaborales.isEmpty()) {
                    int empId = empleados.get(rand.nextInt(empleados.size()));
                    LocalDate dia = diasLaborales.get(rand.nextInt(diasLaborales.size()));
                    tardanzasSet.add(empId + "_" + dia.toString());
                }

                // Generar salidas anticipadas
                Set<String> anticipadasSet = new HashSet<>();
                while (anticipadasSet.size() < 14 && !diasLaborales.isEmpty()) {
                    int empId = empleados.get(rand.nextInt(empleados.size()));
                    LocalDate dia = diasLaborales.get(rand.nextInt(diasLaborales.size()));
                    if (tardanzasSet.contains(empId + "_" + dia.toString())) continue;
                    anticipadasSet.add(empId + "_" + dia.toString());
                }

                // Aplicar tardanzas
                for (String clave : tardanzasSet) {
                    String[] partes = clave.split("_");
                    int empId = Integer.parseInt(partes[0]);
                    String fecha = partes[1];
                    int minTarde = 5 + rand.nextInt(11);
                    String update = "UPDATE asistencias SET hora_entrada = ?, estado_entrada = 'TARDANZA', min_tardanza = ? WHERE emp_id = ? AND fecha = ?";
                    PreparedStatement ps = con.prepareStatement(update);
                    ps.setTime(1, Time.valueOf(String.format("08:%02d:00", minTarde)));
                    ps.setInt(2, minTarde);
                    ps.setInt(3, empId);
                    ps.setDate(4, Date.valueOf(fecha));
                    ps.executeUpdate();
                }

                // Aplicar salidas anticipadas
                for (String clave : anticipadasSet) {
                    String[] partes = clave.split("_");
                    int empId = Integer.parseInt(partes[0]);
                    String fecha = partes[1];
                    int minAnticipo = 5 + rand.nextInt(11);
                    String update = "UPDATE asistencias SET hora_salida = ?, estado_salida = 'ANTICIPADA', min_anticipacion = ? WHERE emp_id = ? AND fecha = ?";
                    PreparedStatement ps = con.prepareStatement(update);
                    ps.setTime(1, Time.valueOf("15:" + String.format("%02d", 60 - minAnticipo) + ":00"));
                    ps.setInt(2, minAnticipo);
                    ps.setInt(3, empId);
                    ps.setDate(4, Date.valueOf(fecha));
                    ps.executeUpdate();
                }

                // Generar faltas
                Set<Integer> empleadosConMovimientos = new HashSet<>();
                for (String clave : tardanzasSet) {
                    empleadosConMovimientos.add(Integer.valueOf(clave.split("_")[0]));
                }
                for (String clave : anticipadasSet) {
                    empleadosConMovimientos.add(Integer.valueOf(clave.split("_")[0]));
                }

                List<Integer> sinMovimientos = new ArrayList<>();
                for (Integer empId : empleados) {
                    if (!empleadosConMovimientos.contains(empId)) {
                        sinMovimientos.add(empId);
                    }
                }

                Collections.shuffle(sinMovimientos);
                List<Integer> empleadosFaltas = sinMovimientos.size() >= 2 ? sinMovimientos.subList(0, 2) : new ArrayList<>();

                for (Integer empId : empleadosFaltas) {
                    if (diasLaborales.size() < 3) continue;
                    int inicioFalta = rand.nextInt(diasLaborales.size() - 2);
                    int diasFalta = 2 + rand.nextInt(2);
                    List<LocalDate> diasFaltas = diasLaborales.subList(inicioFalta, Math.min(inicioFalta + diasFalta, diasLaborales.size()));
                    for (LocalDate dia : diasFaltas) {
                        String deleteFalta = "DELETE FROM asistencias WHERE emp_id = ? AND fecha = ?";
                        PreparedStatement ps = con.prepareStatement(deleteFalta);
                        ps.setInt(1, empId);
                        ps.setDate(2, Date.valueOf(dia));
                        ps.executeUpdate();
                        System.out.println("Falta generada → Empleado " + empId + " día " + dia);
                    }
                }

                System.out.println("Tardanzas creadas: " + tardanzasSet.size());
                System.out.println("Salidas anticipadas creadas: " + anticipadasSet.size());
                System.out.println("Empleados con faltas: " + empleadosFaltas);

            } catch (SQLException e) {
                System.out.println("Error: " + e.getMessage());
            }
        } else {
            System.out.println("Error de conexión a la base de datos.");
        }
    }
}
