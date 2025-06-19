package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.UsuarioDAO;
import grupo7.dentalogic.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a la página de login si se accede por GET
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario user = dao.login(usuario, clave);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", user);

            if ("ADMIN".equalsIgnoreCase(user.getRol())) {
                response.sendRedirect("dashboardAdmin");
            } else {
                response.sendRedirect("marcacion");
            }

        } else {
            request.setAttribute("error", "Usuario o clave incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
