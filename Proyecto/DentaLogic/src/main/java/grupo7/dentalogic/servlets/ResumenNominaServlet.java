package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.ResumenNominaDAO;
import grupo7.dentalogic.model.ResumenNomina;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.List;
import java.util.Locale;

@WebServlet("/resumen")
public class ResumenNominaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ResumenNominaDAO dao = new ResumenNominaDAO();
        LocalDate ahora = LocalDate.now();
        String mesActual = ahora.getMonth().getDisplayName(TextStyle.FULL, new Locale("es", "ES"));
        int anioActual = ahora.getYear();
        String empIdParam = request.getParameter("empId");
        
        try {
            if (empIdParam != null && !empIdParam.isEmpty()) {
                int empId = Integer.parseInt(empIdParam);
                ResumenNomina detalle = dao.obtenerDetalleEmpleado(empId);
                if (detalle.getSueldoHora() == null || detalle.getSueldoHora().compareTo(BigDecimal.ZERO) == 0) {
                    request.setAttribute("error", "El empleado no tiene tarifa por hora configurada");
                } else {
                    request.setAttribute("detalle", detalle);
                }
            } else {
                List<ResumenNomina> resumen = dao.obtenerResumenMesActual();
                request.setAttribute("resumen", resumen);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de empleado inválido");
        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar la solicitud: " + e.getMessage());
            e.printStackTrace();
        }
        
        request.setAttribute("mesActual", mesActual);
        request.setAttribute("anioActual", anioActual);
        request.getRequestDispatcher("/resumenNomina.jsp").forward(request, response);
    }
}