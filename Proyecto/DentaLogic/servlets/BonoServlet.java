package grupo7.dentalogic.servlets;

import grupo7.dentalogic.dao.BonoDAO;
import grupo7.dentalogic.model.Bono;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/bonos")
public class BonoServlet extends HttpServlet {

    private final BonoDAO bonoDAO = new BonoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Bono bonoEditar = bonoDAO.obtenerPorId(id);
                request.setAttribute("bonoEditar", bonoEditar);
            }
            case "delete" -> {
                int deleteId = Integer.parseInt(request.getParameter("id"));
                bonoDAO.eliminarBono(deleteId);
            }
        }

        List<Bono> bonos = bonoDAO.obtenerTodos();
        request.setAttribute("bonos", bonos);
        request.getRequestDispatcher("bonos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bonoIdStr = request.getParameter("bonoId");
        String nombre = request.getParameter("nombre");
        String cantidadStr = request.getParameter("cantidad");
        String descripcion = request.getParameter("descripcion");

        Bono bono = new Bono();
        bono.setBonoNom(nombre);
        bono.setBonoCan(Double.parseDouble(cantidadStr));
        bono.setBonoDesc(descripcion);

        boolean resultado;
        if (bonoIdStr != null && !bonoIdStr.isEmpty()) {
            bono.setBonoId(Integer.parseInt(bonoIdStr));
            resultado = bonoDAO.actualizarBono(bono);
        } else {
            resultado = bonoDAO.agregarBono(bono);
        }

        response.sendRedirect("bonos");
    }
}
