<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDate" %>

<%
    grupo7.dentalogic.model.Usuario usuario = (grupo7.dentalogic.model.Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Calendario de Asistencias</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <!-- Bootstrap JS -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

        <style>
            :root {
                --present: #F0FDF4;
                --late: #FFFBEB;
                --early: #EFF6FF;
                --absent: #FEF2F2;
                --justified: #F8FAFC;
                --weekend: #F5F5F5;
                --text-primary: #1F2937;
                --text-secondary: #6B7280;
                --border: #E5E7EB;
                --success: #10B981;
                --warning: #F59E0B;
                --info: #3B82F6;
                --danger: #EF4444;
                --justify-color: #7C3AED;
                --header-bg: #F3F4F6;
            }

            body {
                font-family: 'Inter', sans-serif !important;
                background-color: white !important;
                margin: 0 !important;
                padding: 20px !important;
            }

            .header-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .attendance-title {
                color: #111827 !important;
                margin: 0 !important;
                font-weight: 600 !important;
                font-size: 1.5rem !important;
            }

            .filter-container {
                display: flex;
                gap: 15px;
                align-items: center;
                margin-bottom: 20px;
            }

            .form-select, .form-input {
                padding: 8px 12px;
                border: 1px solid var(--border);
                border-radius: 6px;
                font-family: 'Inter', sans-serif;
            }

            .btn {
                padding: 8px 16px;
                border-radius: 6px;
                cursor: pointer;
                font-family: 'Inter', sans-serif;
                border: 1px solid var(--border);
                background-color: white;
            }

            .btn:hover {
                background-color: var(--header-bg);
            }

            .search-input {
                padding: 8px 12px;
                border: 1px solid var(--border);
                border-radius: 6px;
                width: 250px;
            }

            .attendance-table-container {
                overflow-x: auto;
                width: 100%;
                position: relative;
                max-height: 80vh;
                background: white;
                border-radius: 12px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }

            .attendance-table {
                width: 100%;
                border-collapse: separate !important;
                border-spacing: 0 !important;
                min-width: 1000px;
                background: white;
                margin-bottom: 0 !important;
                border-radius: 12px !important;
                overflow: hidden;
            }

            .attendance-table th,
            .attendance-table td {
                padding: 12px 16px !important;
                text-align: center;
                vertical-align: top;
                background: white;
                position: relative;
            }

            .attendance-table th:not(.fixed-header) {
                border-bottom: 2px solid var(--border) !important;
                border-right: 1px solid var(--border) !important;
                background-color: var(--header-bg) !important;
                color: var(--text-secondary) !important;
                font-weight: 500 !important;
                font-size: 0.75rem !important;
                letter-spacing: 0.5px !important;
                text-transform: uppercase !important;
                position: sticky;
                top: 0;
                z-index: 20;
                height: 60px;
                vertical-align: middle !important;
            }

            .attendance-table th:not(.fixed-header):last-child {
                border-right: none !important;
            }

            .attendance-table td {
                border-bottom: 1px solid var(--border) !important;
                border-right: 1px solid var(--border) !important;
                padding: 0 !important;
            }

            .attendance-table td:last-child {
                border-right: none !important;
            }

            .attendance-table tr:last-child td {
                border-bottom: none !important;
            }

            .fixed-header {
                position: sticky !important;
                top: 0 !important;
                z-index: 40 !important;
                background-color: var(--header-bg) !important;
                font-weight: 500 !important;
                font-size: 0.75rem !important;
                letter-spacing: 0.5px !important;
                text-transform: uppercase !important;
                height: 60px !important;
                vertical-align: middle !important;
            }

            .id-header {
                left: 0 !important;
                z-index: 45 !important;
                width: 60px !important;
                min-width: 60px !important;
                max-width: 60px !important;
                border-right: 1px solid var(--border) !important;
                box-shadow: 2px 0 3px rgba(0,0,0,0.05) !important;
            }

            .name-header {
                left: 60px !important;
                z-index: 44 !important;
                border-right: 1px solid var(--border) !important;
                box-shadow: 2px 0 3px rgba(0,0,0,0.05) !important;
                min-width: 180px !important;
                text-align: left !important;
            }

            .id {
                position: sticky !important;
                left: 0 !important;
                background: white !important;
                z-index: 30 !important;
                width: 60px !important;
                min-width: 60px !important;
                max-width: 60px !important;
                text-align: center !important;
                white-space: nowrap !important;
                font-weight: 500 !important;
                color: var(--text-secondary) !important;
            }

            .employee-name {
                position: sticky !important;
                left: 60px !important;
                background: white !important;
                z-index: 25 !important;
                white-space: nowrap !important;
                font-weight: 500 !important;
                text-align: left !important;
                color: black !important;
                border-right: 1px solid var(--border) !important;
                box-shadow: 2px 0 3px rgba(0,0,0,0.05) !important;
                min-width: 180px !important;
                padding-right: 24px !important;
            }

            .attendance-table tr:hover td:not(.id):not(.employee-name) {
                background-color: #f9f9f9 !important;
            }

            .attendance-cell {
                display: flex !important;
                flex-direction: column !important;
                justify-content: flex-start !important;
                padding: 12px !important;
                border-radius: 6px !important;
                gap: 8px !important;
                min-height: 175px !important;
                width: 140px !important;
                box-sizing: border-box !important;
                transition: all 0.2s ease !important;
            }

            .present {
                background-color: var(--present) !important;
            }
            .late {
                background-color: var(--late) !important;
            }
            .early {
                background-color: var(--early) !important;
            }
            .absent {
                background-color: var(--absent) !important;
            }
            .justified {
                background-color: var(--justified) !important;
                border: 1px solid var(--justify-color) !important;
            }
            .weekend {
                background-color: var(--weekend) !important;
                color: var(--text-secondary) !important;
            }
            .future-day {
                background-color: white !important;
                border: 1px dashed var(--border) !important;
                color: var(--text-secondary) !important;
                min-height: 175px !important;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* ESTILOS PARA DÍA ACTUAL */
            .current-day {
                background-color: #f0f9ff !important;
            }

            .current-day-header {
                background-color: #e1f0ff !important;
                position: relative;
            }

            .current-day-header::after {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background-color: #3B82F6;
            }

            .current-day-marker {
                color: #3B82F6 !important;
                font-weight: 700 !important;
            }

            .time-header {
                display: flex !important;
                justify-content: space-between !important;
                font-weight: 500 !important;
                font-size: 0.75rem !important;
                color: var(--text-secondary) !important;
                margin-bottom: 4px !important;
            }

            .time-values {
                display: flex !important;
                justify-content: space-between !important;
                align-items: baseline !important;
                font-size: 0.95rem !important;
                font-weight: 600 !important;
                margin-bottom: 6px !important;
            }

            .status-text {
                font-weight: 500 !important;
            }

            .present .status-text {
                color: var(--success) !important;
            }
            .late .status-text {
                color: var(--warning) !important;
            }
            .early .status-text {
                color: var(--info) !important;
            }
            .justified .status-text {
                color: var(--justify-color) !important;
            }

            .minutes {
                color: var(--text-secondary) !important;
                font-size: 0.7rem !important;
                margin-left: 4px !important;
            }

            .justification-badge {
                background-color: #EDE9FE !important;
                color: var(--justify-color) !important;
                padding: 4px 8px !important;
                border-radius: 4px !important;
                font-size: 0.7rem !important;
                font-weight: 500 !important;
                margin: 6px 0 !important;
                text-align: center !important;
            }

            .day-header {
                font-weight: 600 !important;
                color: var(--text-secondary) !important;
                margin-bottom: 2px !important;
            }

            .day-number {
                font-size: 0.9rem !important;
                color: var(--text-secondary) !important;
            }

            .absent-label {
                font-weight: 600 !important;
                color: var(--danger) !important;
                margin-bottom: 4px !important;
                text-align: center !important;
            }

            .justification-reason {
                font-size: 0.75rem !important;
                color: var(--text-secondary) !important;
                text-align: center !important;
            }

            .weekend-label {
                font-weight: 600 !important;
                color: #6B7280 !important;
                margin-bottom: 4px !important;
                text-align: center !important;
            }

            .employee-name-inner {
                padding-left: 12px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/components/routes/sidebar.jsp" />

        <div class="content-wrapper p-1">
            <div class="container-fluid">
                <div class="header-container">
                    <h2 class="attendance-title">Control de Asistencias - ${mes + 1}/${anio}</h2>

                    <form method="get" action="asistencia" id="formAsistencia" class="filter-container">
                        <select name="mes" id="mesSelect" onchange="enviarFormulario()" class="form-select">
                            <c:forEach var="i" begin="0" end="11">
                                <option value="${i}" ${i == mes ? "selected" : ""}>${i + 1}</option>
                            </c:forEach>
                        </select>

                        <input type="number" name="anio" id="anioInput" value="${anio}" min="2000" max="2100" onchange="enviarFormulario()" class="form-input" />

                        <button type="button" onclick="irAHoy()" class="btn">Hoy</button>

                        <input type="text" id="filtroInput" placeholder="Buscar empleado..." onkeyup="filtrarEmpleados()" class="search-input" />
                    </form>
                </div>

                <div class="attendance-table-container">
                    <table class="attendance-table" id="tablaAsistencias">
                        <thead>
                            <tr>
                                <th class="fixed-header id-header">ID</th>
                                <th class="fixed-header name-header">Empleado</th>
                                    <c:forEach var="dia" begin="1" end="${totalDiasMes}">
                                        <c:set var="fechaDia" value="${LocalDate.of(anio, mes + 1, dia)}" />
                                    <th class="${fechaDia.equals(hoy) ? 'current-day-header' : ''}">
                                        <div class="day-header">
                                            <c:choose>
                                                <c:when test="${fechaDia.dayOfWeek.value == 1}">Lun</c:when>
                                                <c:when test="${fechaDia.dayOfWeek.value == 2}">Mar</c:when>
                                                <c:when test="${fechaDia.dayOfWeek.value == 3}">Mié</c:when>
                                                <c:when test="${fechaDia.dayOfWeek.value == 4}">Jue</c:when>
                                                <c:when test="${fechaDia.dayOfWeek.value == 5}">Vie</c:when>
                                                <c:when test="${fechaDia.dayOfWeek.value == 6}">Sáb</c:when>
                                                <c:otherwise>Dom</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="day-number ${fechaDia.equals(hoy) ? 'current-day-marker' : ''}">${dia}</div>
                                    </th>
                                </c:forEach>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="empleado" items="${empleados}">
                                <tr>
                                    <td class="id">${empleado.empId}</td>
                                    <td class="employee-name">
                                        <div class="employee-name-inner">${empleado.nombreCompletoEmpleado}</div>
                                    </td>
                                    <c:forEach var="dia" begin="1" end="${totalDiasMes}">
                                        <c:set var="fechaDia" value="${LocalDate.of(anio, mes + 1, dia)}" />
                                        <c:set var="asistencia" value="${asistenciaMap[empleado.empId][dia]}" />

                                        <td class="${fechaDia.equals(hoy) ? 'current-day' : ''}">
                                            <c:choose>
                                                <c:when test="${fechaDia.isAfter(hoy)}">
                                                    <!-- Día futuro -->
                                                    <div class="attendance-cell future-day">
                                                        <div class="day-number">${dia}</div>
                                                    </div>
                                                </c:when>

                                                <c:when test="${fechaDia.dayOfWeek.value == 6 || fechaDia.dayOfWeek.value == 7}">
                                                    <!-- Fin de semana (sábado o domingo) -->
                                                    <div class="attendance-cell weekend">
                                                        <div class="weekend-label">
                                                            <c:choose>
                                                                <c:when test="${fechaDia.dayOfWeek.value == 6}">SÁBADO</c:when>
                                                                <c:otherwise>DOMINGO</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="justification-reason">Día no laborable</div>
                                                    </div>
                                                </c:when>

                                                <c:when test="${asistencia == null || asistencia.asiId == 0}">
                                                    <!-- Ausencia -->
                                                    <c:choose>
                                                        <c:when test="${asistencia != null && asistencia.justificado}">
                                                            <!-- Ausencia justificada sin asistencia -->
                                                            <div class="attendance-cell justified">
                                                                <div class="justification-badge">JUSTIFICADO</div>
                                                                <div class="justification-reason">Ausencia con justificativo</div>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Ausente sin justificativo -->
                                                            <div class="attendance-cell absent">
                                                                <div class="absent-label">AUSENTE</div>
                                                                <div class="justification-reason">No registró asistencia</div>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>

                                                <c:otherwise>
                                                    <!-- Día con asistencia registrada -->
                                                    <div class="attendance-cell 
                                                        ${asistencia.justificado ? 'justified' : 
                                                          asistencia.estadoEntrada == 'TARDANZA' ? 'late' :
                                                          asistencia.estadoSalida == 'ANTICIPADA' ? 'early' :
                                                          'present'}">

                                                        <div class="time-header">
                                                            <span>Entrada</span>
                                                            <span class="status-text">
                                                                <c:choose>
                                                                    <c:when test="${asistencia.estadoEntrada == 'TARDANZA'}">Tardanza</c:when>
                                                                    <c:otherwise>Puntual</c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </div>
                                                        <div class="time-values">
                                                            <span>${asistencia.horaEntrada12h}</span>
                                                            <c:if test="${asistencia.minTardanza > 0}">
                                                                <span class="minutes">(+${asistencia.minTardanza} min)</span>
                                                            </c:if>
                                                        </div>

                                                        <div class="time-header">
                                                            <span>Salida</span>
                                                            <span class="status-text">
                                                                <c:choose>
                                                                    <c:when test="${asistencia.estadoSalida == 'ANTICIPADA'}">Anticipada</c:when>
                                                                    <c:otherwise>Normal</c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </div>
                                                        <div class="time-values">
                                                            <span>${asistencia.horaSalida12h}</span>
                                                            <c:if test="${asistencia.minAnticipacion > 0}">
                                                                <span class="minutes">(-${asistencia.minAnticipacion} min)</span>
                                                            </c:if>
                                                        </div>

                                                        <c:if test="${asistencia.justificado}">
                                                            <div class="justification-badge">JUSTIFICADO</div>
                                                        </c:if>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            function filtrarEmpleados() {
                const filtro = document.getElementById("filtroInput").value.toLowerCase();
                const filas = document.querySelectorAll("#tablaAsistencias tbody tr");

                filas.forEach(fila => {
                    const nombre = fila.querySelector("td:nth-child(2)").textContent.toLowerCase();
                    fila.style.display = nombre.includes(filtro) ? "" : "none";
                });
            }

            function enviarFormulario() {
                document.getElementById("formAsistencia").submit();
            }

            function irAHoy() {
                const hoy = new Date();
                const mesActual = hoy.getMonth(); // 0-11
                const anioActual = hoy.getFullYear();

                document.getElementById("mesSelect").value = mesActual;
                document.getElementById("anioInput").value = anioActual;
                enviarFormulario();
            }

            // Función para desplazar al día actual
            function scrollToCurrentDay() {
                const hoy = new Date();
                const mesPagina = ${mes};
                const anioPagina = ${anio};

                if (mesPagina === hoy.getMonth() && anioPagina === hoy.getFullYear()) {
                    const diaActual = hoy.getDate();
                    const tablaContainer = document.querySelector('.attendance-table-container');
                    const celdasDia = document.querySelectorAll('th:not(.fixed-header)');

                    let columnaDiaActual = null;
                    celdasDia.forEach((th, index) => {
                        const diaHeader = th.querySelector('.day-number');
                        if (diaHeader && parseInt(diaHeader.textContent) === diaActual) {
                            columnaDiaActual = th;
                        }
                    });

                    if (columnaDiaActual) {
                        const scrollPos = columnaDiaActual.offsetLeft + columnaDiaActual.offsetWidth / 2 - tablaContainer.offsetWidth / 2;
                        tablaContainer.scrollTo({
                            left: scrollPos,
                            behavior: 'smooth'
                        });
                    }
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                scrollToCurrentDay();
                setTimeout(scrollToCurrentDay, 500);
            });
        </script>
    </body>
</html>