package grupo7.dentalogic.servlets;

import grupo7.dentalogic.config.ConexionBD;
import grupo7.dentalogic.dao.BonoDAO;
import grupo7.dentalogic.dao.DetallePagoDAO;
import grupo7.dentalogic.dao.EmpleadoDAO;
import grupo7.dentalogic.dao.PeriodoPagoDAO;
import grupo7.dentalogic.model.Bono;
import grupo7.dentalogic.model.DetallePago;
import grupo7.dentalogic.model.Empleado;
import grupo7.dentalogic.model.PeriodoPago;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/pagos")
public class PagoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("sueldo".equals(action)) {
            obtenerSueldoEmpleado(request, response);
        } else if ("bono".equals(action)) {
            obtenerMontoBono(request, response);
        } else {
            mostrarVistaPagos(request, response);
        }
    }

      @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int empId = Integer.parseInt(request.getParameter("emp_id"));
            int perId = Integer.parseInt(request.getParameter("per_id"));

            String bonoParam = request.getParameter("bono_id");
            int bonoId = (bonoParam != null && !bonoParam.isEmpty()) ? Integer.parseInt(bonoParam) : 0;

            double descuentoTotal = Double.parseDouble(request.getParameter("descuento_total"));

            try (Connection conn = ConexionBD.conectar()) {
                DetallePagoDAO detallePagoDAO = new DetallePagoDAO(conn);
                BonoDAO bonoDAO = new BonoDAO(); // usa su propia conexión interna

                // Obtener el sueldo base
                double sueldoBase = detallePagoDAO.obtenerSueldoBase(empId);
                
                // Si se seleccionó un bono, obtener su monto
                double bonoCan = (bonoId > 0) ? bonoDAO.obtenerMontoBono(bonoId) : 0;

                // Monto Total solo toma el sueldo base (sin incluir el bono)
                double montoTotal = sueldoBase;  // Solo Sueldo Base, no sumar el bono aquí

                // Calcular el Sueldo Neto (Sueldo Base + Bono - Descuento Total)
                double sueldoNeto = sueldoBase + bonoCan - descuentoTotal;

                // Crear el objeto DetallePago
                DetallePago dp = new DetallePago();
                dp.setEmpId(empId);
                dp.setPerId(perId);
                dp.setBonoId(bonoId);  // Guardamos el bono id
                dp.setDetpMon(montoTotal);  // Guardamos solo el Sueldo Base en el "Monto Total"
                dp.setDescuentoTotal(descuentoTotal);
                dp.setSueldoNeto(sueldoNeto);  // Guardamos el Sueldo Neto (Sueldo Base + Bono - Descuento)

                // Guardar el pago
                boolean exito = detallePagoDAO.insertar(dp);

                if (exito) {
                    response.sendRedirect("pagos");
                } else {
                    response.sendRedirect("error.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void mostrarVistaPagos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = ConexionBD.conectar()) {
            EmpleadoDAO empleadoDAO = new EmpleadoDAO(conn);
            DetallePagoDAO detallePagoDAO = new DetallePagoDAO(conn);
            BonoDAO bonoDAO = new BonoDAO(); // usa su propia conexión
            PeriodoPagoDAO periodoDAO = new PeriodoPagoDAO(); // también su propia conexión

            List<Empleado> empleadosConEspecialidad = empleadoDAO.obtenerSoloConEspecialidad();
            List<Bono> bonos = bonoDAO.obtenerTodos();
            List<PeriodoPago> periodos = periodoDAO.obtenerTodos();
            List<DetallePago> pagos = detallePagoDAO.listarTodos();

            request.setAttribute("empleadosEspecializados", empleadosConEspecialidad);
            request.setAttribute("bonos", bonos);
            request.setAttribute("periodos", periodos);
            request.setAttribute("pagos", pagos);

            request.getRequestDispatcher("pagos.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void obtenerSueldoEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String empIdStr = request.getParameter("emp_id");

        try (Connection conn = ConexionBD.conectar()) {
            int empId = Integer.parseInt(empIdStr);
            DetallePagoDAO dao = new DetallePagoDAO(conn);
            double sueldoBase = dao.obtenerSueldoBase(empId);

            response.setContentType("application/json");
            response.getWriter().write("{\"sueldoBase\": " + sueldoBase + "}");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error obteniendo sueldo base");
        }
    }

private void obtenerMontoBono(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
    String bonoIdStr = request.getParameter("bono_id");

    try {
        // Verificar si bono_id es válido
        if (bonoIdStr == null || bonoIdStr.isEmpty() || !bonoIdStr.matches("\\d+")) {
            response.sendError(400, "El bono_id proporcionado no es válido.");
            return;
        }

        int bonoId = Integer.parseInt(bonoIdStr);

        // Llamar al DAO para obtener el monto del bono
        BonoDAO bonoDAO = new BonoDAO();
        double bonoCan = bonoDAO.obtenerMontoBono(bonoId);

        // Enviar el monto como respuesta JSON
        response.setContentType("application/json");
        response.getWriter().write("{\"monto\": " + bonoCan + "}");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(500, "Error inesperado.");
    }
}

}
