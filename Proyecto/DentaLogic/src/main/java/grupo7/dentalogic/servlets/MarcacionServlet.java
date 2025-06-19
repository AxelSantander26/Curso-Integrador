package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.MarcacionDAO;
import grupo7.dentalogic.model.Marcacion;
import grupo7.dentalogic.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/marcacion")
public class MarcacionServlet extends HttpServlet {
    private final MarcacionDAO dao = new MarcacionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioLogueado");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int empId = usuario.getIdEmpleado();
        Date fecha = Date.valueOf(LocalDate.now());
        Time ahora = Time.valueOf(LocalTime.now());

        Marcacion m = new Marcacion();
        m.setEmpId(empId);
        m.setFecha(fecha);

        Time horaEntradaEst = dao.obtenerHoraEntradaEstablecida(empId);
        Time horaSalidaEst = dao.obtenerHoraSalidaEstablecida(empId);

        boolean yaMarcoEntrada = dao.yaMarcoEntrada(empId, fecha);
        Marcacion marcada = dao.obtenerMarcacionDeHoy(empId, fecha);

        if (!yaMarcoEntrada) {
            if (horaEntradaEst != null) {
                long diferenciaMinutos = (ahora.getTime() - horaEntradaEst.getTime()) / 60000;

                if (diferenciaMinutos <= 10) {
                    m.setEstadoEntrada("PUNTUAL");
                    m.setMinTardanza(0);
                } else {
                    m.setEstadoEntrada("TARDANZA");
                    m.setMinTardanza((int) diferenciaMinutos);
                }
            }
            m.setHoraEntrada(ahora);
            dao.registrarEntrada(m);
            sesion.setAttribute("mensaje", "Entrada registrada");
        } else if (marcada != null && marcada.getHoraSalida() == null) {
            if (horaSalidaEst != null && ahora.before(horaSalidaEst)) {
                int minAnt = (int) ((horaSalidaEst.getTime() - ahora.getTime()) / 60000);
                m.setEstadoSalida("ANTICIPADA");
                m.setMinAnticipacion(minAnt);
            } else {
                m.setEstadoSalida("NORMAL");
                m.setMinAnticipacion(0);
            }
            m.setHoraSalida(ahora);
            dao.registrarSalida(m);
            sesion.setAttribute("mensaje", "Salida registrada");
        }

        response.sendRedirect("marcacion");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioLogueado");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int empId = usuario.getIdEmpleado();
        Date fecha = Date.valueOf(LocalDate.now());

        Time horaEntradaEst = dao.obtenerHoraEntradaEstablecida(empId);
        Time horaSalidaEst = dao.obtenerHoraSalidaEstablecida(empId);
        Marcacion marcada = dao.obtenerMarcacionDeHoy(empId, fecha);

        request.setAttribute("horaEntradaEstablecida", horaEntradaEst);
        request.setAttribute("horaSalidaEstablecida", horaSalidaEst);

        if (marcada != null) {
            request.setAttribute("horaMarcadaEntrada", marcada.getHoraEntrada());
            request.setAttribute("horaMarcadaSalida", marcada.getHoraSalida());
            request.setAttribute("estadoEntrada", marcada.getEstadoEntrada());
            request.setAttribute("estadoSalida", marcada.getEstadoSalida());
            request.setAttribute("yaMarcadaEntrada", marcada.getHoraEntrada() != null);
            request.setAttribute("yaMarcadaSalida", marcada.getHoraSalida() != null);
        } else {
            request.setAttribute("horaMarcadaEntrada", null);
            request.setAttribute("horaMarcadaSalida", null);
            request.setAttribute("estadoEntrada", null);
            request.setAttribute("estadoSalida", null);
            request.setAttribute("yaMarcadaEntrada", false);
            request.setAttribute("yaMarcadaSalida", false);
        }

        String mensaje = (String) sesion.getAttribute("mensaje");
        if (mensaje != null) {
            request.setAttribute("mensaje", mensaje);
            sesion.removeAttribute("mensaje");
        }

        request.getRequestDispatcher("dashboardOdon.jsp").forward(request, response);
    }
}
