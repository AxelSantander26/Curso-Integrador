package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.MarcacionDAO;
import grupo7.dentalogic.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Time;
import java.sql.Date;

@WebServlet("/dashboardOdon")
public class MarcacionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login");
            return;
        }

        int empId = usuario.getIdEmpleado();
        Time horaActual = new Time(System.currentTimeMillis());

        MarcacionDAO dao = new MarcacionDAO();

        boolean yaMarcada = dao.isAsistenciaMarcada(empId);
        Time horaEntradaEstablecida = dao.obtenerHoraEntradaEstablecida(empId);
        Time horaMarcada = null;
        String estado = "";

        if (yaMarcada) {
            horaMarcada = dao.obtenerHoraMarcada(empId);
            estado = dao.obtenerEstado(empId);
        }

        request.setAttribute("horaActual", horaActual);
        request.setAttribute("horaEntradaEstablecida", horaEntradaEstablecida);
        request.setAttribute("yaMarcada", yaMarcada);
        request.setAttribute("horaMarcada", horaMarcada);
        request.setAttribute("estadoAsistencia", estado);

        request.getRequestDispatcher("dashboardOdon.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login");
            return;
        }

        int empId = usuario.getIdEmpleado();
        Time horaActual = new Time(System.currentTimeMillis());
        Date fechaActual = new Date(System.currentTimeMillis());

        MarcacionDAO dao = new MarcacionDAO();

        if (!dao.isAsistenciaMarcada(empId)) {
            Time horaEntrada = dao.obtenerHoraEntradaEstablecida(empId);
            if (horaEntrada != null) {
                String estado = dao.calcularEstado(horaEntrada, horaActual);
                dao.registrarAsistencia(empId, horaActual, estado);
            }
        }

        response.sendRedirect("dashboardOdon");
    }
}
