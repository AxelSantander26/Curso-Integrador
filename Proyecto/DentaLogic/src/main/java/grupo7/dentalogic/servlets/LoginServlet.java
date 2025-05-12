package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.UsuarioDAO;
import grupo7.dentalogic.model.Usuario;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



    @WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        // Validar el usuario en la base de datos
        Usuario usuarioValidado = UsuarioDAO.validarUsuario(usuario, password);

        if (usuarioValidado != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioValidado);

            int rolId = usuarioValidado.getIdRol(); // Asegúrate de tener este getter en el modelo Usuario
            String username = usuarioValidado.getUsuario(); // Asume que esto devuelve el usuario (usr_user)

            // Redirección por rol y patrón de nombre de usuario
            if (rolId == 1 && username.matches("^A\\d{8}$")) {
                response.sendRedirect("dashboard.jsp");
            } else if (rolId == 3 && username.matches("^O\\d{8}$")) {
                response.sendRedirect("dashboardOdon.jsp");
            } else {
                // Si no cumple con el patrón o el rol, redirigir a un error o login con mensaje
                request.setAttribute("error", "Usuario no autorizado o formato de usuario incorrecto.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}