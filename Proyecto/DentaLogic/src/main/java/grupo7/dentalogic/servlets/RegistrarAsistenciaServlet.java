
package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.AsistenciaDAO;
import grupo7.dentalogic.model.Asistencia;
import grupo7.dentalogic.config.ConexionBD;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalTime;

@WebServlet("/registrar-asistencia")
public class RegistrarAsistenciaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetros
        int empId = Integer.parseInt(request.getParameter("emp_id"));
        Time horaLlegada = Time.valueOf(LocalTime.now());
        
        try (Connection conn = ConexionBD.conectar()) {
            AsistenciaDAO asistenciaDAO = new AsistenciaDAO(conn);
            
            // Crear objeto Asistencia
            Asistencia asistencia = new Asistencia();
            asistencia.setEmpId(empId);
            asistencia.setHoraLlegada(horaLlegada);
            asistencia.setTipoAsistencia("Consulta General"); // Valor por defecto
            
            // Insertar en la base de datos
            boolean exito = asistenciaDAO.insertarAsistencia(asistencia);
            
            // Respuesta JSON
            response.setContentType("application/json");
            response.getWriter().write("{\"status\": \"" + (exito ? "ok" : "fail") + "\"}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al registrar la asistencia.");
        }
    }
}