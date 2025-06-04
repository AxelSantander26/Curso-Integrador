
package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.AsistenciaDAO;
import grupo7.dentalogic.model.Asistencia;
import grupo7.dentalogic.config.ConexionBD;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/asistencias")
public class ListarAsistenciasServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = ConexionBD.conectar()) {
            AsistenciaDAO dao = new AsistenciaDAO(conn);
            List<Asistencia> lista = dao.listarAsistencias();
            request.setAttribute("listaAsistencias", lista);
            request.getRequestDispatcher("asistencias.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al cargar la lista de asistencias.");
        }
    }
}