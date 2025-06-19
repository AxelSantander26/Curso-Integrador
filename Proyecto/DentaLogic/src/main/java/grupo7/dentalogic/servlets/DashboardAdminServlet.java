package grupo7.dentalogic.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/dashboardAdmin")
public class DashboardAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Aquí puedes agregar validaciones si el usuario está logueado y es ADMIN
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            // Si hay sesión activa, va al JSP del dashboard
            request.getRequestDispatcher("dashboardAdmin.jsp").forward(request, response);
        } else {
            // Si no hay sesión, redirige al login
            response.sendRedirect("/login");
        }
    }
}
