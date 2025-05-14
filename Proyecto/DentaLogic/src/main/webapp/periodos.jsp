<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="grupo7.dentalogic.model.PeriodoPago" %>
<%@ page import="java.util.List" %>
<%
    PeriodoPago per = (PeriodoPago) request.getAttribute("periodoEditar");
    List<PeriodoPago> periodos = (List<PeriodoPago>) request.getAttribute("periodos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Periodos</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="components/sidebar-navbar.jsp"/>

<main class="main-content">
    <div class="container py-4">
        <h3>Gestión de Periodos</h3>

        <div class="mb-3 text-end">
            <button class="btn btn-success" onclick="mostrarFormulario()">Nuevo Periodo</button>
        </div>

        <div id="form-periodo" class="card p-4 mb-4 <%= per != null ? "" : "d-none" %>">
            <form action="periodos" method="post">
                <% if (per != null) { %>
                    <input type="hidden" name="perId" value="<%= per.getPerId() %>">
                <% } %>
                <div class="mb-3">
                    <label>Nombre del Periodo</label>
                    <input type="text" class="form-control" name="nombre" required
                           value="<%= per != null ? per.getPerNom() : "" %>">
                </div>
                <div class="mb-3">
                    <label>Fecha Inicio</label>
                    <input type="date" class="form-control" name="inicio" required
                           value="<%= per != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(per.getPerIni()) : "" %>">
                </div>
                <div class="mb-3">
                    <label>Fecha Fin</label>
                    <input type="date" class="form-control" name="fin" required
                           value="<%= per != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(per.getPerFin()) : "" %>">
                </div>
                <div class="mb-3">
                    <label>Descripción</label>
                    <textarea class="form-control" name="descripcion"><%= per != null ? per.getPerDesc() : "" %></textarea>
                </div>
                <div class="text-end">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <button type="button" class="btn btn-secondary" onclick="window.location='periodos'">Cancelar</button>
                </div>
            </form>
        </div>

        <table class="table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Inicio</th>
                    <th>Fin</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% if (periodos != null && !periodos.isEmpty()) {
                    for (PeriodoPago p : periodos) { %>
                        <tr>
                            <td><%= p.getPerId() %></td>
                            <td><%= p.getPerNom() %></td>
                            <td><%= p.getPerIni() %></td>
                            <td><%= p.getPerFin() %></td>
                            <td><%= p.getPerDesc() %></td>
                            <td>
                                <a href="periodos?action=edit&id=<%= p.getPerId() %>" class="btn btn-warning btn-sm">Editar</a>
                                <a href="periodos?action=delete&id=<%= p.getPerId() %>" class="btn btn-danger btn-sm"
                                   onclick="return confirm('¿Eliminar este periodo?');">Eliminar</a>
                            </td>
                        </tr>
                <% } } else { %>
                    <tr><td colspan="6" class="text-center">No hay periodos registrados.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</main>

<script>
    function mostrarFormulario() {
        document.getElementById("form-periodo").classList.remove("d-none");
        document.getElementById("form-periodo").scrollIntoView({ behavior: "smooth" });
    }
</script>
</body>
</html>
