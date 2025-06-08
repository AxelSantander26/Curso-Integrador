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

        if (yearParam != null && monthParam != null) {
            try {
                int year = Integer.parseInt(yearParam);
                int month = Integer.parseInt(monthParam);
                // Validar mes entre 0 y 11
                if (month >= 0 && month <= 11) {
                    cal.set(Calendar.YEAR, year);
                    cal.set(Calendar.MONTH, month);
                    cal.set(Calendar.DAY_OF_MONTH, 1);
                }
            } catch (NumberFormatException e) {
                // Si hay error, usar fecha actual
                cal = Calendar.getInstance();
            }
        }

        // Año y mes calculados
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);

        // Traer todos los empleados
        List<AsistenciaInfo> empleados = asistenciaDAO.obtenerTodosLosEmpleados();

        // Traer asistencias para ese mes y año (necesitamos filtrar)
        // Para mejorar, habría que agregar un método DAO que filtre por mes y año, pero mientras:
        List<AsistenciaInfo> asistenciasTodos = asistenciaDAO.obtenerAsistenciasConJustificacion();

        // Filtrar asistencias para solo las del mes y año solicitado
        List<AsistenciaInfo> asistencias = new ArrayList<>();
        for (AsistenciaInfo asi : asistenciasTodos) {
            Calendar c = Calendar.getInstance();
            c.setTime(asi.getFecha());
            int asiYear = c.get(Calendar.YEAR);
            int asiMonth = c.get(Calendar.MONTH);
            if (asiYear == year && asiMonth == month) {
                asistencias.add(asi);
            }
        }

        // Pasar atributos a la JSP
        request.setAttribute("empleados", empleados);
        request.setAttribute("asistencias", asistencias);
        request.setAttribute("year", year);
        request.setAttribute("month", month);

        request.getRequestDispatcher("asistencias.jsp").forward(request, response);
    }
}
