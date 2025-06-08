package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.UsuarioDAO;
import grupo7.dentalogic.model.Usuario;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cuando alguien va a /login, mostrar la vista login.jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        Usuario usuarioValidado = UsuarioDAO.validarUsuario(usuario, password);

        if (usuarioValidado != null) {
            // Almacenar el usuario en la sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioValidado);

            // Almacenar el idEmpleado en la sesión
            session.setAttribute("empId", usuarioValidado.getIdEmpleado());  // Guardamos el idEmpleado

            int rolId = usuarioValidado.getIdRol();
            String username = usuarioValidado.getUsuario();

            if (rolId == 1 && username.matches("^A\\d{8}$")) {
                // Redirigir al dashboard de administrador
                response.sendRedirect("dashboardAdmin");
            } else if (rolId == 3 && username.matches("^O\\d{8}$")) {
                // Redirigir al dashboard del odontólogo
                response.sendRedirect("dashboardOdon");
            } else {
                request.setAttribute("error", "Usuario no autorizado o formato de usuario incorrecto.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
