package grupo7.dentalogic.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/cerrar-sesion")
public class CerrarSesionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalida la sesión actual
        HttpSession session = request.getSession(false); // false para evitar crear una nueva
        if (session != null) {
            session.invalidate();
        }

        // Redirige al login
        response.sendRedirect("login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Para permitir cerrar sesión desde una petición POST también
        doGet(request, response);
    }
}
