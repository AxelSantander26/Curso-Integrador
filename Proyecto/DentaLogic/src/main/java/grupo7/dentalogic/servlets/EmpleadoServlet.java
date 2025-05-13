package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.EmpleadoDAO;
import grupo7.dentalogic.model.Empleado;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/empleados")
public class EmpleadoServlet extends HttpServlet {

    private final EmpleadoDAO empleadoDAO = new EmpleadoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Empleado empEditar = empleadoDAO.obtenerPorId(editId);
                request.setAttribute("empleadoEditar", empEditar);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                empleadoDAO.eliminarEmpleado(deleteId);
                break;

            // default: solo lista
        }

        // Siempre carga la lista de empleados y especialidades
        List<Empleado> empleados = empleadoDAO.obtenerTodos();

        request.setAttribute("empleados", empleados);

        request.getRequestDispatcher("empleados.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Leer parámetros del formulario
        String empIdStr = request.getParameter("empId");
        String dni = request.getParameter("dni");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String tel = request.getParameter("tel");
        String fecha = request.getParameter("fecha");
        String salarioStr = request.getParameter("salario");
        String espIdStr = request.getParameter("espId");

        Empleado emp = new Empleado();
        emp.setEmpDni(dni);
        emp.setEmpNom(nombre);
        emp.setEmpApe(apellido);
        emp.setEmpEmail(email);
        emp.setEmpTel(tel);
        emp.setEmpFec(Date.valueOf(fecha));
        emp.setEmpSal(Double.parseDouble(salarioStr));
        emp.setEspId(Integer.parseInt(espIdStr));

        boolean resultado;
        if (empIdStr != null && !empIdStr.isEmpty()) {
            emp.setEmpId(Integer.parseInt(empIdStr));
            resultado = empleadoDAO.actualizarEmpleado(emp);
        } else {
            resultado = empleadoDAO.agregarEmpleado(emp);
        }

        // Siempre redirige a GET después de guardar
        response.sendRedirect("empleados");
    }
}
