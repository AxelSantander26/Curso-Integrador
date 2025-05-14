package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.DashboardDAO;
import grupo7.dentalogic.model.DashboardInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
        } else {
            // Cargar datos del dashboard
            DashboardDAO dao = new DashboardDAO();
            DashboardInfo info = dao.obtenerDashboardInfo();

            request.setAttribute("dashboardInfo", info);
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}
