package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.AsistenciaDAO;
import grupo7.dentalogic.model.AsistenciaInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/asistencias")
public class AsistenciaServlet extends HttpServlet {
    private final AsistenciaDAO asistenciaDAO = new AsistenciaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetros year y month de la URL (opcional)
        String yearParam = request.getParameter("year");
        String monthParam = request.getParameter("month");

        Calendar cal = Calendar.getInstance();
        int year, month;

        if (yearParam != null && monthParam != null) {
            try {
                year = Integer.parseInt(yearParam);
                month = Integer.parseInt(monthParam);
                // Validar mes entre 0 y 11
                if (month >= 0 && month <= 11) {
                    cal.set(Calendar.YEAR, year);
                    cal.set(Calendar.MONTH, month);
                } else {
                    // Si el mes no es válido, usar fecha actual
                    cal = Calendar.getInstance();
                }
            } catch (NumberFormatException e) {
                // Si hay error, usar fecha actual
                cal = Calendar.getInstance();
            }
        } else {
            // Si no hay parámetros, usar fecha actual
            cal = Calendar.getInstance();
        }

        year = cal.get(Calendar.YEAR);
        month = cal.get(Calendar.MONTH);

        // Obtener datos
        List<AsistenciaInfo> empleados = asistenciaDAO.obtenerTodosLosEmpleados();
        List<AsistenciaInfo> asistencias = asistenciaDAO.obtenerAsistenciasPorMesYAnio(year, month);

        // Preparar datos para la vista
        Map<Integer, Map<Integer, AsistenciaInfo>> asistenciasPorEmpleado = new HashMap<>();
        for (AsistenciaInfo asi : asistencias) {
            Calendar tempCal = Calendar.getInstance();
            tempCal.setTime(asi.getFecha());
            int day = tempCal.get(Calendar.DAY_OF_MONTH);
            int empId = asi.getEmpId();

            if (!asistenciasPorEmpleado.containsKey(empId)) {
                asistenciasPorEmpleado.put(empId, new HashMap<>());
            }
            asistenciasPorEmpleado.get(empId).put(day, asi);
        }

        // Pasar atributos a la JSP
        request.setAttribute("empleados", empleados);
        request.setAttribute("asistenciasPorEmpleado", asistenciasPorEmpleado);
        request.setAttribute("year", year);
        request.setAttribute("month", month);
        request.setAttribute("diasEnMes", cal.getActualMaximum(Calendar.DAY_OF_MONTH));

        request.getRequestDispatcher("asistencias.jsp").forward(request, response);
    }
}