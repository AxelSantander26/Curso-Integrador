package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.DashboardDAO;
import grupo7.dentalogic.model.DashboardInfo;
import grupo7.dentalogic.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/", "/dashboard"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // No crear sesión nueva
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            // Si no hay sesión, redirigir al login
            response.sendRedirect("login");
            return;
        }

        // Si hay sesión, mostrar el dashboard
        DashboardDAO dao = new DashboardDAO();
        DashboardInfo info = dao.obtenerDashboardInfo();

        request.setAttribute("dashboardInfo", info);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
