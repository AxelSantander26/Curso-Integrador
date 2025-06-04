<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <!-- NUEVO -->

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Módulo de Asistencias</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
         :root {
            --sidebar-bg: #19414b;
            --card-bg: #1a4d40;
        }
        body {
            background-color: #f8f9fa;
        }
        .main-content {
            margin-top: 40px; /* BAJAR MAIN */
        }
        .table td, .table th {
            color: #000;
        }
        .table {
            min-width: 900px; /* AGRANDAR ANCHO DE LA TABLA */
        }
        .tag {
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9em;
            color: white;
            cursor: help;
            display: inline-block;
            min-width: 120px;
            text-align: center;
        }
        .asistio { background-color: #2e7d32; }
        .falto { background-color: #c62828; }
        .tarde { background-color: #f9a825; color: #000; }
        .justificado { background-color: #1565c0; }
        .desconocido { background-color: #6c757d; }
        th.fecha-col, td.fecha-col {
    min-width: 130px;
    white-space: nowrap;
}

    </style>
</head>
<body>

<jsp:include page="components/sidebar-navbar.jsp"/>

<main class="main-content">
    <div class="container py-5">

        <div class="filter-section mb-4">
            <div class="row g-3">
                <div class="col-md-3">
                    <label for="filterName" class="form-label">Filtrar por Nombre</label>
                    <input type="text" class="form-control" id="filterName" placeholder="Buscar por nombre">
                </div>
                <div class="col-md-3">
                    <label for="filterDNI" class="form-label">Filtrar por DNI</label>
                    <input type="text" class="form-control" id="filterDNI" placeholder="Buscar por DNI">
                </div>
                <div class="col-md-3">
                    <label for="filterDate" class="form-label">Filtrar por Fecha</label>
                    <input type="date" class="form-control" id="filterDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button class="btn btn-primary w-100" id="filterBtn">Filtrar</button>
                </div>
            </div>
        </div>

        <div class="mb-4 d-flex justify-content-between align-items-center">
            <h4>Asistencias de Hoy</h4>
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#registerAttendanceModal">
                <i class="bi bi-plus-circle"></i> Registrar Asistencia
            </button>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-primary text-center">
                    <tr>
                                        <th class="fecha-col">Fecha</th> <!-- APLICADA AQUÍ -->

                        <th>Nombre y Apellido</th>
                        <th>ID Empleado</th>
                        <th>Hora Entrada</th>
                        <th>Hora Llegada</th>
                        <th>Hora Salida</th>
                        <th>Tipo de Asistencia</th>
                        <th>DNI</th>
                        <th>Observaciones</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="asis" items="${listaAsistencias}">
                        <tr data-id="${asis.empId}" data-tipo="${asis.tipoAsistencia}">
                            <td><fmt:formatDate value="${asis.fechaRegistroAsis}" pattern="yyyy-MM-dd" /></td>
                            <td>${asis.nombreCompleto}</td>
                            <td>${asis.empId}</td>
                            <td>09:00</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty asis.horaLlegada}">
                                        <fmt:formatDate value="${asis.horaLlegada}" pattern="HH:mm" />
                                    </c:when>
                                    <c:otherwise>---</c:otherwise>
                                </c:choose>
                            </td>
                            <td>17:00</td>
                            <td>
                               <c:choose>
        <c:when test="${fn:toLowerCase(asis.tipoAsistencia) == 'asistio'}">
            <span class="tag asistio" title="Empleado asistió puntualmente">ASISTIÓ</span>
        </c:when>
        <c:when test="${fn:toLowerCase(asis.tipoAsistencia) == 'tardanza'}">
            <span class="tag tarde" title="Empleado llegó tarde">LLEGÓ TARDE</span>
        </c:when>
        <c:when test="${fn:toLowerCase(asis.tipoAsistencia) == 'falta'}">
            <span class="tag falto" title="Empleado no se presentó">FALTÓ</span>
        </c:when>
        <c:when test="${fn:toLowerCase(asis.tipoAsistencia) == 'justificado'}">
            <span class="tag justificado" title="Justificación registrada">JUSTIFICADO</span>
        </c:when>
        <c:otherwise>
            <span class="tag desconocido" title="Tipo no reconocido">SIN DATOS</span>
        </c:otherwise>
    </c:choose>
                            </td>
                            <td>${asis.empDni}</td>
                            <td>
                                <input type="text" class="form-control form-control-sm" value="Sin observaciones" />
                            </td>
                            <td>
                                <button class="btn btn-info btn-sm edit-btn">Editar</button>
                                <button class="btn btn-warning btn-sm justify-btn">Justificar</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</main>

<div class="modal fade" id="registerAttendanceModal" tabindex="-1" aria-labelledby="registerAttendanceModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="registerAttendanceModalLabel">Registrar Asistencia</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <p class="text-muted">Formulario para registrar nueva asistencia.</p>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('filterBtn').addEventListener('click', function() {
        const nameFilter = document.getElementById('filterName').value.toLowerCase();
        const dniFilter = document.getElementById('filterDNI').value.toLowerCase();
        const dateFilter = document.getElementById('filterDate').value;

        document.querySelectorAll('tbody tr').forEach(row => {
            const name = row.cells[1].textContent.toLowerCase();
            const dni = row.cells[7].textContent.toLowerCase();
            const date = row.cells[0].textContent;

            const matches = name.includes(nameFilter) && dni.includes(dniFilter) && date === dateFilter;
            row.style.display = matches ? '' : 'none';
        });
    });
</script>

</body>
</html>
