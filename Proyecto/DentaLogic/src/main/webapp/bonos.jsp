<%@ page contentType="text/html;charset=windows-1252" language="java" %>
<%@ page import="grupo7.dentalogic.model.Bono" %>
<%@ page import="java.util.List" %>
<%
    Bono bonoEditar = (Bono) request.getAttribute("bonoEditar");
    List<Bono> bonos = (List<Bono>) request.getAttribute("bonos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Gestión de Bonos</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="components/sidebar-navbar.jsp"/>
<main class="main-content">
    <div class="container py-4">
        <h3 class="mb-4">Gestión de Bonos</h3>

        <!-- Botón de acción -->
        <div class="mb-3 d-flex justify-content-end">
            <button class="btn btn-success" onclick="mostrarFormulario()">
                <i class="bi bi-plus-circle"></i> Nuevo Bono
            </button>
        </div>

        <!-- Formulario bono -->
        <div id="form-nuevo-bono" class="card p-4 mb-4 <%= bonoEditar != null ? "" : "d-none" %>">
            <h5 class="mb-3"><%= bonoEditar != null ? "Editar Bono" : "Registrar Nuevo Bono" %></h5>
            <form class="row gy-3" action="bonos" method="post">
                <% if (bonoEditar != null) { %>
                    <input type="hidden" name="bonoId" value="<%= bonoEditar.getBonoId() %>">
                <% } %>
                <div class="col-md-6">
                    <label class="form-label">Nombre del Bono</label>
                    <input type="text" class="form-control" name="nombre" required
                           value="<%= bonoEditar != null ? bonoEditar.getBonoNom() : "" %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Monto</label>
                    <input type="number" step="0.01" min="0" class="form-control" name="cantidad" required
                           value="<%= bonoEditar != null ? bonoEditar.getBonoCan() : "" %>">
                </div>
                <div class="col-12">
                    <label class="form-label">Descripción</label>
                    <textarea class="form-control" rows="2" name="descripcion"><%= bonoEditar != null ? bonoEditar.getBonoDesc() : "" %></textarea>
                </div>
                <div class="col-12 d-flex justify-content-end gap-2">
                    <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">Cancelar</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save"></i> <%= bonoEditar != null ? "Actualizar" : "Guardar Bono" %>
                    </button>
                </div>
            </form>
        </div>

        <!-- Tabla de bonos -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th>Nombre</th>
                    <th>Monto</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <% if (bonos != null && !bonos.isEmpty()) {
                    for (Bono b : bonos) { %>
                        <tr>
                            <td><%= b.getBonoNom() %></td>
                            <td>S/. <%= String.format("%.2f", b.getBonoCan()) %></td>
                            <td><%= b.getBonoDesc() != null ? b.getBonoDesc() : "-" %></td>
                            <td>
                                <a href="bonos?action=edit&id=<%= b.getBonoId() %>" class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil"></i> Editar
                                </a>
                                <a href="bonos?action=delete&id=<%= b.getBonoId() %>" class="btn btn-sm btn-danger"
                                   onclick="return confirm('¿Deseas eliminar este bono?');">
                                    <i class="bi bi-trash"></i> Eliminar
                                </a>
                            </td>
                        </tr>
                    <% }
                } else { %>
                    <tr>
                        <td colspan="4" class="text-center">No hay bonos registrados.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<script>
    function mostrarFormulario() {
        document.getElementById("form-nuevo-bono").classList.remove("d-none");
        document.getElementById("form-nuevo-bono").scrollIntoView({behavior: "smooth"});
    }

    function ocultarFormulario() {
        document.getElementById("form-nuevo-bono").classList.add("d-none");
        window.location.href = "bonos"; // Reinicia sin bonoEditar
    }
</script>
</body>
</html>
