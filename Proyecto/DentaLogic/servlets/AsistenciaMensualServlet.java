package grupo7.dentalogic.servlets;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.dao.AsistenciaDAO;
import grupo7.dentalogic.dao.EmpleadoDAO;
import grupo7.dentalogic.model.Empleado;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/asistencias-mensuales")
public class AsistenciaMensualServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mesParam = request.getParameter("mes");
        String anioParam = request.getParameter("anio");
        String mesAnioParam = request.getParameter("mesAnio");  // nuevo parámetro

        int mes = 1;
        int anio = 2025;

        try {
            if (mesAnioParam != null && mesAnioParam.matches("\\d{4}-\\d{2}")) {
                // Parseamos "YYYY-MM"
                anio = Integer.parseInt(mesAnioParam.substring(0, 4));
                mes = Integer.parseInt(mesAnioParam.substring(5, 7));
            } else if (mesParam != null && anioParam != null) {
                mes = Integer.parseInt(mesParam);
                anio = Integer.parseInt(anioParam);
            } else {
                throw new IllegalArgumentException("Faltan parámetros mes o año.");
            }

            if (mes < 1 || mes > 12) {
                throw new IllegalArgumentException("Mes fuera de rango (1-12).");
            }

            try (Connection conn = ConexionBD.conectar()) {
                EmpleadoDAO empDao = new EmpleadoDAO(conn);
                AsistenciaDAO asisDao = new AsistenciaDAO(conn);

                List<Empleado> empleados = empDao.obtenerTodos();
                Map<Integer, Map<Integer, String>> mapaAsistencias = asisDao.obtenerAsistenciasMensuales(mes, anio);

                Calendar calendar = Calendar.getInstance();
                calendar.set(anio, mes - 1, 1);
                int diasDelMes = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

                request.setAttribute("empleados", empleados);
                request.setAttribute("mapaAsistencias", mapaAsistencias);
                request.setAttribute("diasDelMes", diasDelMes);
                request.setAttribute("mes", mes);
                request.setAttribute("anio", anio);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Parámetros inválidos o error en el servidor: " + e.getMessage());

            // Valores por defecto para evitar NullPointerException en JSP
            request.setAttribute("empleados", new ArrayList<Empleado>());
            request.setAttribute("mapaAsistencias", new HashMap<Integer, Map<Integer,String>>());
            request.setAttribute("diasDelMes", 30);
            request.setAttribute("mes", mes);
            request.setAttribute("anio", anio);
        }

        request.getRequestDispatcher("asistencia_mensual.jsp").forward(request, response);
    }
}
