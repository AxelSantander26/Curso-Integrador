package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.EmpleadoDAO;
import grupo7.dentalogic.model.Empleado;
import grupo7.dentalogic.config.ConexionBD;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/empleados")
public class EmpleadoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Empleado> empleados = new ArrayList<>();
        List<String[]> especialidades = new ArrayList<>();
        List<String[]> horarios = new ArrayList<>();
        Empleado empleadoEditar = null;
        try (Connection conn = ConexionBD.conectar()) {
            empleados = EmpleadoDAO.obtenerTodos(conn);
            ResultSet rsEsp = conn.prepareStatement("SELECT esp_id, esp_nombre FROM especialidades").executeQuery();
            while (rsEsp.next()) especialidades.add(new String[]{rsEsp.getString("esp_id"), rsEsp.getString("esp_nombre")});
            ResultSet rsHor = conn.prepareStatement("SELECT hor_id, CONCAT(hora_entrada, ' – ', hora_salida) AS horario FROM horarios").executeQuery();
            while (rsHor.next()) horarios.add(new String[]{rsHor.getString("hor_id"), rsHor.getString("horario")});
            String editId = request.getParameter("edit_id");
            if (editId != null) {
                int id = Integer.parseInt(editId);
                for (Empleado e : empleados) if (e.getEmpId() == id) { empleadoEditar = e; break; }
            }
        } catch (SQLException e) {
            throw new ServletException("Error al obtener datos", e);
        }
        request.setAttribute("empleados", empleados);
        request.setAttribute("especialidades", especialidades);
        request.setAttribute("horarios", horarios);
        request.setAttribute("empleado", empleadoEditar);
        request.getRequestDispatcher("/empleados.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("_method");
        if ("DELETE".equalsIgnoreCase(method)) { doDelete(request, response); return; }
        int empId = 0;
        String empIdParam = request.getParameter("emp_id");
        if (empIdParam != null && !empIdParam.isEmpty()) empId = Integer.parseInt(empIdParam);
        Empleado emp = new Empleado();
        emp.setEmpNombre(request.getParameter("emp_nombre"));
        emp.setEmpApellido(request.getParameter("emp_apellido"));
        emp.setEmpDni(request.getParameter("emp_dni"));
        emp.setEspId(Integer.parseInt(request.getParameter("esp_id")));
        emp.setHorId(Integer.parseInt(request.getParameter("hor_id")));
        try (Connection conn = ConexionBD.conectar()) {
            if (empId == 0) EmpleadoDAO.insertar(conn, emp);
            else { emp.setEmpId(empId); EmpleadoDAO.actualizar(conn, emp); }
        } catch (SQLException e) {
            throw new ServletException("Error al guardar empleado", e);
        }
        response.sendRedirect("empleados");
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int empId = Integer.parseInt(request.getParameter("emp_id"));
        try (Connection conn = ConexionBD.conectar()) {
            EmpleadoDAO.eliminar(conn, empId);
        } catch (SQLException e) {
            throw new ServletException("Error al eliminar empleado", e);
        }
        response.sendRedirect("empleados");
    }
}
