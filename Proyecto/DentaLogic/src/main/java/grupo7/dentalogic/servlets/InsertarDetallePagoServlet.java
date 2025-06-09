package grupo7.dentalogic.servlets;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.dao.DetallePagoDAO;
import grupo7.dentalogic.model.DetallePago;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/insertarDetallePago")
public class InsertarDetallePagoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int empId = Integer.parseInt(request.getParameter("emp_id"));
            int perId = Integer.parseInt(request.getParameter("per_id"));

            String bonoParam = request.getParameter("bono_id");
            int bonoId = (bonoParam != null && !bonoParam.isEmpty()) ? Integer.parseInt(bonoParam) : 0;

            double detpMon = Double.parseDouble(request.getParameter("detp_mon"));
            double descuentoTotal = Double.parseDouble(request.getParameter("descuento_total"));
            double sueldoNeto = Double.parseDouble(request.getParameter("sueldo_neto"));

            DetallePago dp = new DetallePago();
            dp.setEmpId(empId);
            dp.setPerId(perId);
            dp.setBonoId(bonoId);
            dp.setDetpMon(detpMon);
            dp.setDescuentoTotal(descuentoTotal);
            dp.setSueldoNeto(sueldoNeto);

            try (Connection conn = ConexionBD.conectar()) {
                DetallePagoDAO dao = new DetallePagoDAO(conn);
                boolean exito = dao.insertar(dp);

                if (exito) {
                    response.sendRedirect("pagos.jsp");

                } else {
                    response.sendRedirect("error.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
