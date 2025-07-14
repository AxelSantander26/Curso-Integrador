package grupo7.dentalogic.servlets;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.dao.DashboardDAO;
import grupo7.dentalogic.model.Dashboard;
import grupo7.dentalogic.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/dashboardAdmin")
public class DashboardAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
            response.sendRedirect("login");
            return;
        }

        try (Connection conn = ConexionBD.conectar()) {
            DashboardDAO dao = new DashboardDAO(conn);
            Dashboard dashboard = dao.obtenerDashboard();

            request.setAttribute("dashboard", dashboard);
            request.getRequestDispatcher("dashboardAdmin.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error obteniendo datos del dashboard", e);
        }
    }
}
