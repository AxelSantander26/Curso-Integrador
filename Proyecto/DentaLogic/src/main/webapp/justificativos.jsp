<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    grupo7.dentalogic.model.Usuario usuario = (grupo7.dentalogic.model.Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!-- Bootstrap JS -->
<script src="assets/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/components/routes/sidebar.jsp" />
<div class="content-wrapper p-4">
    <div class="container-fluid">
        <!-- TÍTULO Y FORMULARIO -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="mb-0"><i class="bi bi-clipboard2-check me-2"></i>Justificativos</h3>
        </div>

        <div class="card mb-4">
            <div class="card-header bg-primary text-white"><strong>Registrar Justificativo</strong></div>
            <div class="card-body">
                <form method="post" class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Empleado</label>
                        <select name="emp_id" class="form-select" required>
                            <option value="">-- Seleccione empleado --</option>
                            <c:forEach var="e" items="${empleados}">
                                <option value="${e[0]}">${e[1]}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Desde</label>
                        <input type="date" name="desde" class="form-control" required />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Hasta</label>
                        <input type="date" name="hasta" class="form-control" required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Motivo</label>
                        <textarea name="motivo" class="form-control" rows="2" required></textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Archivo (URL o vacío)</label>
                        <input type="text" name="archivo_url" class="form-control" placeholder="https://..." />
                    </div>
                    <div class="col-12 d-flex justify-content-end">
                        <button type="submit" class="btn btn-success"><i class="bi bi-send me-1"></i>Guardar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- LISTA -->
        <div class="card">
            <div class="card-header bg-dark text-white"><strong>Justificativos del mes ${mes}/${anio}</strong></div>
            <div class="card-body table-responsive">
                <table class="table table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Empleado</th>
                            <th>Desde</th>
                            <th>Hasta</th>
                            <th>Motivo</th>
                            <th>Archivo</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="j" items="${justificativos}">
                            <tr>
                                <td>${j.jusId}</td>
                                <td>${j.empleadoNombre}</td>
                                <td>${j.desde}</td>
                                <td>${j.hasta}</td>
                                <td>${j.motivo}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty j.archivoUrl}">
                                            <a href="${j.archivoUrl}" target="_blank">Ver</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Ninguno</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <form method="post" onsubmit="return confirm('¿Eliminar justificativo?')">
                                        <input type="hidden" name="jus_id" value="${j.jusId}" />
                                        <input type="hidden" name="_method" value="DELETE" />
                                        <button type="submit" class="btn btn-danger btn-sm"><i class="bi bi-trash-fill"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty justificativos}">
                            <tr><td colspan="7" class="text-center text-muted">No hay justificativos registrados.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
