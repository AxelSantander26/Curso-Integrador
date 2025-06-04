package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.EmpleadoDAO;
import grupo7.dentalogic.model.Empleado;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.util.List;



import grupo7.dentalogic.dao.EmpleadoDAO;
import grupo7.dentalogic.model.Empleado;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/pagos")
public class PagoServlet extends HttpServlet {

    private final EmpleadoDAO empleadoDAO = new EmpleadoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener solo empleados con especialidad (odontólogos)
        List<Empleado> empleadosConEspecialidad = empleadoDAO.obtenerSoloConEspecialidad();
        request.setAttribute("empleadosEspecializados", empleadosConEspecialidad);

        // Cargar vista
        request.getRequestDispatcher("pagos.jsp").forward(request, response);
    }
}
