package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.ResumenNominaDAO;
import grupo7.dentalogic.model.ResumenNomina;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@WebServlet("/generar-boletas-masivas")
public class GenerarBoletasMasivasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ResumenNominaDAO dao = new ResumenNominaDAO();
        List<ResumenNomina> empleados = dao.obtenerResumenMesActual();

        if (empleados.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "No hay empleados registrados");
            return;
        }

        // Configuración del ZIP
        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=boletas_nomina.zip");

        try (ZipOutputStream zipOut = new ZipOutputStream(response.getOutputStream())) {
            for (ResumenNomina empleado : empleados) {
                // Generar PDF para cada empleado
                byte[] pdfBytes = generarPdfEmpleado(empleado);

                // Nombre del archivo: boleta_[nombre_empleado].pdf
                String filename = "boleta_" + empleado.getNombreEmpleado().replace(" ", "_") + ".pdf";
                ZipEntry entry = new ZipEntry(filename);
                zipOut.putNextEntry(entry);
                zipOut.write(pdfBytes);
                zipOut.closeEntry();
            }
        } catch (Exception e) {
            throw new ServletException("Error al generar boletas masivas: " + e.getMessage(), e);
        }
    }

    private byte[] generarPdfEmpleado(ResumenNomina empleado) throws IOException {
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        PdfRendererBuilder builder = new PdfRendererBuilder();
        builder.withHtmlContent(generarHtmlBoleta(empleado), "/");
        builder.toStream(os);
        builder.run();
        return os.toByteArray();
    }

    private String generarHtmlBoleta(ResumenNomina detalle) {
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm", Locale.getDefault());

        return "<!DOCTYPE html><html lang=\"es\"><head><meta charset=\"UTF-8\" />"
                + "<title>Boleta de Pago</title><style>"
                + "body {font-family: sans-serif; font-size: 14px;}"
                + ".boleta-container {width: 530px; margin: 40px auto; background: #fff; "
                + "border: 1px solid #ccc; padding: 30px; box-shadow: 0 0 15px rgba(0,0,0,0.1);}"
                + ".boleta-title {font-size: 24px; font-weight: 700; color: #333; "
                + "border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 30px; "
                + "text-transform: uppercase; letter-spacing: 1px; text-align: center;}"
                + ".section-title {font-size: 16px; font-weight: 600; color: #333; "
                + "border-bottom: 1px solid #ccc; margin-bottom: 15px; padding-bottom: 5px;}"
                + ".two-columns {width: 100%; overflow: hidden; margin-bottom: 20px;}"
                + ".column {float: left; width: 48%; margin-right: 4%;}"
                + ".column:last-child {margin-right: 0;}"
                + ".box-fixed {min-height: 210px; border: 1px solid #ccc; background-color: #fff; "
                + "padding: 15px; border-radius: 2px; margin-bottom: 20px; "
                + "display: flex; flex-direction: column; height: 100%; position: relative;}"
                + ".box-content {flex-grow: 1;}"
                + ".box-footer {position: absolute; bottom: 15px; left: 15px; right: 15px;}"
                + ".box-calc {border: 1px solid #ccc; background-color: #fff; padding: 15px; "
                + "border-radius: 2px; margin-bottom: 20px;}"
                + ".summary-line {display: flex; justify-content: space-between; margin-bottom: 8px;}"
                + ".summary-line.total {border-top: 1px solid #ccc; padding-top: 8px; "
                + "font-weight: 600; margin-top: 8px;}"
                + ".calculo-final {font-size: 15px; color: #333; margin-top: 10px;}"
                + ".calculo-final span {margin-right: 5px;}"
                + ".sueldo-neto {background-color: #333; color: #fff; text-align: center; "
                + "font-size: 18px; font-weight: 700; padding: 12px; margin-top: 20px;}"
                + ".clearfix::after {content: \"\"; display: table; clear: both;}"
                + ".fw-bold {font-weight: bold;}"
                + ".employee-line {display: flex; justify-content: space-between; width: 100%; margin-bottom: 10px;}"
                + "</style></head><body>"
                + "<div class=\"boleta-container\">"
                + "<div class=\"boleta-title\">BOLETA DE PAGO</div>"
                + "<div class=\"mb-4\">"
                + "<div class=\"section-title\">Datos del Empleado</div>"
                + "<div class=\"employee-line\">"
                + "<div style=\"flex-grow: 1;\"><strong>Empleado:</strong> " + detalle.getNombreEmpleado() + "</div>"
                + "<div><strong>Especialidad:</strong> " + detalle.getEspecialidad() + "</div>"
                + "<div style=\"text-align: right;\"><strong>Horario:</strong> "
                + timeFormat.format(detalle.getHoraEntradaHorario()) + " - "
                + timeFormat.format(detalle.getHoraSalidaHorario()) + "</div>"
                + "</div>"
                + "<div class=\"summary-line\">"
                + "</div></div>"
                + "<div class=\"two-columns clearfix\">"
                + "<div class=\"column\">"
                + "<div class=\"box-fixed\">"
                + "<div class=\"box-content\"><div class=\"section-title\">Ingresos</div>"
                + "<div class=\"summary-line\">"
                + "<span>Sueldo Base:</span>"
                + "<span>S/ " + String.format("%,.2f", detalle.getSueldoBaseEsperado()) + "</span>"
                + "</div></div>"
                + "<div class=\"box-footer\"><div class=\"summary-line total\">"
                + "<span>Subtotal Ingresos:</span>"
                + "<span>S/ " + String.format("%,.2f", detalle.getSueldoBaseEsperado()) + "</span>"
                + "</div></div></div></div>"
                + "<div class=\"column\">"
                + "<div class=\"box-fixed\">"
                + "<div class=\"box-content\"><div class=\"section-title\">Descuentos</div>"
                + "<div class=\"summary-line\">"
                + "<span>Tardanzas:</span>"
                + "<span>- S/ " + String.format("%,.2f", detalle.getDescuentoTardanzas()) + "</span>"
                + "</div>"
                + "<div class=\"summary-line\">"
                + "<span>Anticipaciones:</span>"
                + "<span>- S/ " + String.format("%,.2f", detalle.getDescuentoAnticipaciones()) + "</span>"
                + "</div>"
                + "<div class=\"summary-line\">"
                + "<span>Faltas:</span>"
                + "<span>- S/ " + String.format("%,.2f", detalle.getDescuentoFaltas()) + "</span>"
                + "</div></div>"
                + "<div class=\"box-footer\"><div class=\"summary-line total\">"
                + "<span>Desc. Totales:</span>"
                + "<span>- S/ " + String.format("%,.2f",
                        detalle.getDescuentoTardanzas()
                                .add(detalle.getDescuentoAnticipaciones())
                                .add(detalle.getDescuentoFaltas())) + "</span>"
                + "</div></div></div></div></div>"
                + "<div class=\"box-calc\">"
                + "<div class=\"section-title\">Cálculo de Sueldo Final</div>"
                + "<div class=\"calculo-final\">"
                + "<span>S/ " + String.format("%,.2f", detalle.getSueldoBaseEsperado()) + "</span>"
                + "<span>-</span>"
                + "<span>S/ " + String.format("%,.2f",
                        detalle.getDescuentoTardanzas()
                                .add(detalle.getDescuentoAnticipaciones())
                                .add(detalle.getDescuentoFaltas())) + "</span>"
                + "<span>=</span>"
                + "<span class=\"fw-bold\" style=\"color: green;\">"
                + "S/ " + String.format("%,.2f", detalle.getSueldoFinal()) + "</span>"
                + "</div></div>"
                + "<div class=\"sueldo-neto\">"
                + "SUELDO NETO: S/ " + String.format("%,.2f", detalle.getSueldoFinal())
                + "</div></div></body></html>";
    }
}
