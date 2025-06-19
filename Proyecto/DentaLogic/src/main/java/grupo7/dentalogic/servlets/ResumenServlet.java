package grupo7.dentalogic.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/resumen")
public class ResumenServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            request.setAttribute("usuario", session.getAttribute("usuarioLogueado"));
            request.getRequestDispatcher("/resumen.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
