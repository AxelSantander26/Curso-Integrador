package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.UsuarioDAO;
import grupo7.dentalogic.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        Usuario usuarioValidado = UsuarioDAO.validarUsuario(usuario, password);

        if (usuarioValidado != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioValidado);

            // Redirigir al controlador del dashboard
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
