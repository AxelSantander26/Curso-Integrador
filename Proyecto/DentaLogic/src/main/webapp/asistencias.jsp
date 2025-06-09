<%@ page import="java.util.*, java.text.SimpleDateFormat, grupo7.dentalogic.model.AsistenciaInfo" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Asistencias Mensuales</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
    <style>
        /* Tus estilos actuales */
        .calendar-container {
            overflow-x: auto;
            margin-top: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 10px;
        }
        .calendar-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2c3e50;
        }
        .calendar-nav {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .calendar-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }
        .calendar-table th, .calendar-table td {
            padding: 10px 8px;
            text-align: center;
            border: 1px solid #e9ecef;
            vertical-align: middle;
        }
        .calendar-table th {
            background-color: #f8f9fa;
            font-weight: 500;
            border-bottom: 2px solid #dee2e6;
        }
        .employee-id-header {
            position: sticky;
            left: 0;
            z-index: 6;
            background-color: #f8f9fa;
            min-width: 60px;
        }
        .employee-name-header {
            position: sticky;
            left: 60px;
            z-index: 6;
            background-color: #f8f9fa;
            min-width: 200px;
            text-align: left;
            padding-left: 15px;
        }
        .employee-id {
            position: sticky;
            left: 0;
            z-index: 4;
            background-color: white;
            font-weight: 500;
        }
        .employee-name {
            position: sticky;
            left: 60px;
            z-index: 4;
            background-color: white;
            text-align: left;
            padding-left: 15px;
            font-weight: 500;
            white-space: nowrap;
        }
        .day-header {
            position: sticky;
            top: 0;
            z-index: 5;
            background-color: #f8f9fa;
            min-width: 40px;
        }
        .weekend {
            background-color: #f8f9fa;
        }
        .today {
            background-color: #e3f2fd;
        }
        .attendance-present {
            color: #2e7d32;
            font-weight: 500;
        }
        .attendance-absent {
            color: #c62828;
        }
        .attendance-late {
            color: #f9a825;
        }
        .attendance-justified {
            font-style: italic;
        }
        .day-number {
            font-size: 0.9rem;
        }
        .day-name {
            font-size: 0.75rem;
            color: #6c757d;
            text-transform: uppercase;
        }
        button, select {
            cursor: pointer;
        }
    </style>
</head>
<body>
<jsp:include page="components/sidebar-navbar.jsp" />
<main class="main-content">
    <div class="content-wrapper">
        <%
            int year = (int) request.getAttribute("year");
            int month = (int) request.getAttribute("month");
            int diasEnMes = (int) request.getAttribute("diasEnMes");
            
            Calendar hoyCal = Calendar.getInstance();
            int hoyDia = hoyCal.get(Calendar.DAY_OF_MONTH);
            int hoyMes = hoyCal.get(Calendar.MONTH);
            int hoyYear = hoyCal.get(Calendar.YEAR);

            List<AsistenciaInfo> empleados = (List<AsistenciaInfo>) request.getAttribute("empleados");
            Map<Integer, Map<Integer, AsistenciaInfo>> asistenciasPorEmpleado = 
                (Map<Integer, Map<Integer, AsistenciaInfo>>) request.getAttribute("asistenciasPorEmpleado");

            String[] nombresDias = {"Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"};
            String[] nombresMeses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", 
                                   "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
        %>

        <div class="calendar-header">
            <h4 class="calendar-title">Asistencias Mensuales</h4>

            <form id="filtroForm" action="asistencias" method="get" class="calendar-nav">
                <label for="selectMes">Mes:</label>
                <select id="selectMes" name="month" required>
                    <% for (int m = 0; m < 12; m++) { %>
                        <option value="<%= m %>" <%= (m == month) ? "selected" : "" %>><%= nombresMeses[m] %></option>
                    <% } %>
                </select>

                <label for="selectYear">Año:</label>
                <select id="selectYear" name="year" required>
                    <%
                        int yearInicio = hoyYear - 5;
                        int yearFin = hoyYear + 5;
                        for (int y = yearInicio; y <= yearFin; y++) {
                    %>
                        <option value="<%= y %>" <%= (y == year) ? "selected" : "" %>><%= y %></option>
                    <% } %>
                </select>

                <button type="button" class="btn btn-secondary btn-sm" id="btnHoy">Hoy</button>
            </form>
        </div>
        
        <input type="text" id="filtroNombre" placeholder="Buscar por nombre o apellido" class="form-control form-control-sm" style="max-width: 250px;" />
        
        <div class="calendar-container">
            <table class="calendar-table">
                <thead>
                    <tr>
                        <th class="employee-id-header">ID</th>
                        <th class="employee-name-header">Empleado</th>
                        <% 
                            Calendar cal = Calendar.getInstance();
                            cal.set(year, month, 1);
                            for (int d = 1; d <= diasEnMes; d++) {
                                cal.set(Calendar.DAY_OF_MONTH, d);
                                int diaSemana = cal.get(Calendar.DAY_OF_WEEK);
                                boolean esHoy = (d == hoyDia && month == hoyMes && year == hoyYear);
                                String clase = "day-header";
                                if (diaSemana == Calendar.SATURDAY || diaSemana == Calendar.SUNDAY) clase += " weekend";
                                if (esHoy) clase += " today";
                        %>
                        <th class="<%= clase %>">
                            <div class="day-number"><%= d %></div>
                            <div class="day-name"><%= nombresDias[diaSemana - 1] %></div>
                        </th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                    <% if (empleados != null && !empleados.isEmpty()) {
                        for (AsistenciaInfo emp : empleados) {
                            int empId = emp.getEmpId();
                            String nombreCompleto = emp.getNombreCompleto();
                            Map<Integer, AsistenciaInfo> asistenciasEmp = asistenciasPorEmpleado.get(empId);
                    %>
                    <tr>
                        <td class="employee-id"><%= empId %></td>
                        <td class="employee-name"><%= nombreCompleto %></td>
                        <% 
                            for (int d = 1; d <= diasEnMes; d++) {
                                cal.set(Calendar.DAY_OF_MONTH, d);
                                int diaSemana = cal.get(Calendar.DAY_OF_WEEK);
                                boolean esHoy = (d == hoyDia && month == hoyMes && year == hoyYear);
                                String clase = "";
                                if (diaSemana == Calendar.SATURDAY || diaSemana == Calendar.SUNDAY) clase += "weekend ";
                                if (esHoy) clase += "today";

                                String contenido = "-";
                                String estadoClass = "";
                                String tooltip = "";
                                
                                if (asistenciasEmp != null && asistenciasEmp.containsKey(d)) {
                                    AsistenciaInfo asi = asistenciasEmp.get(d);
                                    contenido = asi.getEstado();
                                    
                                    // Establecer clases según el estado
                                    if (asi.getEstado() != null) {
                                        switch (asi.getEstado()) {
                                            case "PUNTUAL": 
                                                estadoClass = "attendance-present";
                                                contenido = "PUNTUAL";
                                                break;
                                            case "TARDANZA": 
                                                estadoClass = "attendance-late";
                                                contenido = "TARDANZA";
                                                break;
                                            case "FALTA": 
                                                estadoClass = "attendance-absent";
                                                contenido = "FALTA";
                                                break;
                                        }
                                    }
                                    
                                    // Si está justificado
                                    if (asi.isJustificado()) {
                                        estadoClass += " attendance-justified";
                                        tooltip = "Justificado: " + asi.getObservaciones();
                                    } else if (asi.getObservaciones() != null && !asi.getObservaciones().isEmpty()) {
                                        tooltip = asi.getObservaciones();
                                    }
                                    
                                    // Agregar tooltip si hay información adicional
                                    if (!tooltip.isEmpty()) {
                                        contenido = "<span title='" + tooltip + "'>" + contenido + "</span>";
                                    }
                                }
                        %>
                        <td class="<%= clase %>"><span class="<%= estadoClass %>"><%= contenido %></span></td>
                        <% } %>
                    </tr>
                    <% }
                    } else { %>
                    <tr><td colspan="<%= diasEnMes + 2 %>">No hay datos para mostrar</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<script>
    document.getElementById('selectMes').onchange = function () {
        document.getElementById('filtroForm').submit();
    };
    document.getElementById('selectYear').onchange = function () {
        document.getElementById('filtroForm').submit();
    };
    document.getElementById('btnHoy').onclick = function () {
        var hoy = new Date();
        var mes = hoy.getMonth();
        var anio = hoy.getFullYear();
        window.location.href = 'asistencias?month=' + mes + '&year=' + anio;
    };
    document.getElementById('filtroNombre').oninput = function () {
        var filtro = this.value.toLowerCase();
        var filas = document.querySelectorAll('.calendar-table tbody tr');
        for (var i = 0; i < filas.length; i++) {
            var celdaNombre = filas[i].querySelector('.employee-name');
            if (celdaNombre) {
                var nombreTexto = celdaNombre.textContent.toLowerCase();
                filas[i].style.display = nombreTexto.includes(filtro) ? '' : 'none';
            }
        }
    };
</script>

</body>
</html>