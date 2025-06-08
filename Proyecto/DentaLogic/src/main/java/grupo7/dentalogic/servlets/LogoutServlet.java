package grupo7.dentalogic.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // No crea sesión nueva si no existe

        if (session != null) {
            session.invalidate(); // Cierra sesión si existe
        }

        response.sendRedirect("login"); // Redirige al login (servlet /login)
    }
}
