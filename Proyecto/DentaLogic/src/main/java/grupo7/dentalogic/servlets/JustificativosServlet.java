package grupo7.dentalogic.servlets;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.dao.JustificativoDAO;
import grupo7.dentalogic.model.Justificativo;
import grupo7.dentalogic.model.Usuario;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/justificativos")
public class JustificativosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
            response.sendRedirect("login");
            return;
        }

        int mes, anio;
        String paramMes = request.getParameter("mes");
        String paramAnio = request.getParameter("anio");

        if (paramMes != null && paramAnio != null) {
            mes = Integer.parseInt(paramMes);
            anio = Integer.parseInt(paramAnio);
        } else {
            Calendar cal = Calendar.getInstance();
            mes = cal.get(Calendar.MONTH) + 1;
            anio = cal.get(Calendar.YEAR);
        }

        try (Connection conn = ConexionBD.conectar()) {
            List<Justificativo> lista = JustificativoDAO.listarPorMes(conn, mes, anio);
            request.setAttribute("justificativos", lista);

            // Enviar lista de empleados
            ResultSet rs = conn.prepareStatement("SELECT emp_id, emp_nombre, emp_apellido FROM empleados ORDER BY emp_nombre").executeQuery();
            List<String[]> empleados = new ArrayList<>();
            while (rs.next()) {
                empleados.add(new String[]{
                    rs.getString("emp_id"),
                    rs.getString("emp_nombre") + " " + rs.getString("emp_apellido")
                });
            }
            request.setAttribute("empleados", empleados);
            request.setAttribute("mes", mes);
            request.setAttribute("anio", anio);

        } catch (SQLException e) {
            throw new ServletException("Error al obtener justificativos", e);
        }

        request.getRequestDispatcher("justificativos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String method = request.getParameter("_method");
        if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response);
            return;
        }

        int empId = Integer.parseInt(request.getParameter("emp_id"));
        java.sql.Date desde = java.sql.Date.valueOf(request.getParameter("desde"));
        java.sql.Date hasta = java.sql.Date.valueOf(request.getParameter("hasta"));
        String motivo = request.getParameter("motivo");
        String archivo = request.getParameter("archivo_url");

        Justificativo j = new Justificativo();
        j.setEmpId(empId);
        j.setDesde(desde);
        j.setHasta(hasta);
        j.setMotivo(motivo);
        j.setArchivoUrl((archivo == null || archivo.isBlank()) ? null : archivo);

        try (Connection conn = ConexionBD.conectar()) {
            JustificativoDAO.insertar(conn, j);
        } catch (SQLException e) {
            throw new ServletException("Error al registrar justificativo", e);
        }

        response.sendRedirect("justificativos");
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int jusId = Integer.parseInt(request.getParameter("jus_id"));
        try (Connection conn = ConexionBD.conectar()) {
            JustificativoDAO.eliminar(conn, jusId);
        } catch (SQLException e) {
            throw new ServletException("Error al eliminar justificativo", e);
        }
        response.sendRedirect("justificativos");
    }
}
