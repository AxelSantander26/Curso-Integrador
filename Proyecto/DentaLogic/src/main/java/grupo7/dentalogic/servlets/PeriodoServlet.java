package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.PeriodoPagoDAO;
import grupo7.dentalogic.model.PeriodoPago;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/periodos")
public class PeriodoServlet extends HttpServlet {

    private final PeriodoPagoDAO periodoDAO = new PeriodoPagoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                PeriodoPago periodoEditar = periodoDAO.obtenerPorId(id);
                request.setAttribute("periodoEditar", periodoEditar);
            }
            case "delete" -> {
                int deleteId = Integer.parseInt(request.getParameter("id"));
                periodoDAO.eliminarPeriodo(deleteId);
            }
        }

        List<PeriodoPago> periodos = periodoDAO.obtenerTodos();
        request.setAttribute("periodos", periodos);
        request.getRequestDispatcher("periodos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String perIdStr = request.getParameter("perId");
        String nombre = request.getParameter("nombre");
        String iniStr = request.getParameter("inicio");
        String finStr = request.getParameter("fin");
        String descripcion = request.getParameter("descripcion");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date ini = sdf.parse(iniStr);
            Date fin = sdf.parse(finStr);

            PeriodoPago periodo = new PeriodoPago();
            periodo.setPerIni(ini);
            periodo.setPerFin(fin);
            periodo.setPerNom(nombre);
            periodo.setPerDesc(descripcion);

            boolean resultado;
            if (perIdStr != null && !perIdStr.isEmpty()) {
                periodo.setPerId(Integer.parseInt(perIdStr));
                resultado = periodoDAO.actualizarPeriodo(periodo);
            } else {
                resultado = periodoDAO.agregarPeriodo(periodo);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("periodos");
    }
}
