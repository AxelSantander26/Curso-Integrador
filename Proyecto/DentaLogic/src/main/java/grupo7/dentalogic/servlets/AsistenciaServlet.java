package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.AsistenciaDAO;
import grupo7.dentalogic.model.Asistencia;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;

@WebServlet("/asistencia")
public class AsistenciaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int mes = obtenerParametroInt(request, "mes", LocalDate.now().getMonthValue() - 1);
        int anio = obtenerParametroInt(request, "anio", LocalDate.now().getYear());
        
        AsistenciaDAO dao = new AsistenciaDAO();
        
        List<Asistencia> empleados = dao.obtenerTodosLosEmpleados();
        Map<Integer, Map<Integer, Asistencia>> asistenciaMap = dao.obtenerAsistenciasPorMesYAnio(anio, mes);
        
        int totalDiasMes = YearMonth.of(anio, mes + 1).lengthOfMonth();
        
        // Preparamos datos para la vista
        request.setAttribute("empleados", empleados);
        request.setAttribute("asistenciaMap", asistenciaMap);
        request.setAttribute("totalDiasMes", totalDiasMes);
        request.setAttribute("mes", mes);
        request.setAttribute("anio", anio);
        request.setAttribute("hoy", LocalDate.now());
        
        request.getRequestDispatcher("/asistencia.jsp").forward(request, response);
    }
    
    private int obtenerParametroInt(HttpServletRequest request, String paramName, int defaultValue) {
        try {
            return Integer.parseInt(request.getParameter(paramName));
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}