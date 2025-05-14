<%@ page import="java.util.*, grupo7.dentalogic.model.Empleado" %>
<%@ page contentType="text/html;charset=windows-1252" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Gestión de Empleados</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            .sticky-header thead th {
                position: sticky;
                top: 0;
                background: #f8f9fa;
                z-index: 1;
            }
        </style>
    </head>
    <body>

        <jsp:include page="components/sidebar-navbar.jsp"/>

        <main class="main-content">
            <div class="content-wrapper container py-4">
                <%
                    Empleado emp = (Empleado) request.getAttribute("empleadoEditar");
                    boolean mostrarForm = emp != null || "add".equals(request.getParameter("action"));

                    String[][] camposTexto = {
                        {"DNI", "dni", emp != null ? emp.getEmpDni() : ""},
                        {"Nombre", "nombre", emp != null ? emp.getEmpNom() : ""},
                        {"Apellido", "apellido", emp != null ? emp.getEmpApe() : ""},
                        {"Email", "email", emp != null ? emp.getEmpEmail() : ""},
                        {"Teléfono", "tel", emp != null && emp.getEmpTel() != null ? emp.getEmpTel() : ""}
                    };

                    String fechaIngreso = "";
                    if (emp != null && emp.getEmpFec() != null) {
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                        fechaIngreso = sdf.format(emp.getEmpFec());
                    }

                    String salario = emp != null ? String.valueOf(emp.getEmpSal()) : "";
                    String espId = emp != null ? String.valueOf(emp.getEspId()) : "";
                %>

                <!-- Formulario -->
                <div id="form-empleado" class="card p-4 mb-4 <%= mostrarForm ? "" : "d-none"%>">
                    <h5 class="mb-3"><%= emp != null ? "Editar Empleado" : "Nuevo Empleado"%></h5>
                    <form class="row gy-3" method="post" action="empleados">
                        <% if (emp != null) {%>
                        <input type="hidden" name="empId" value="<%= emp.getEmpId()%>"/>
                        <% } %>

                        <% for (int i = 0; i < camposTexto.length; i++) {%>
                        <div class="col-md-<%= (i < 3) ? "4" : "6"%>">
                            <label class="form-label"><%= camposTexto[i][0]%></label>
                            <input type="<%= camposTexto[i][0].equals("Email") ? "email" : "text"%>"
                                   class="form-control"
                                   name="<%= camposTexto[i][1]%>"
                                   value="<%= camposTexto[i][2]%>" required>
                        </div>
                        <% }%>

                        <div class="col-md-4">
                            <label class="form-label">Fecha Ingreso</label>
                            <input type="date" class="form-control" name="fecha" value="<%= fechaIngreso%>" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Salario</label>
                            <input type="number" step="0.01" class="form-control" name="salario" value="<%= salario%>" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Especialidad ID</label>
                            <input type="number" class="form-control" name="espId" value="<%= espId%>" required>
                        </div>

                        <div class="col-12 d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">Cancelar</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> Guardar
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Filtros -->
                <h5>Filtrado por información</h5>
                <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">
                    <!-- Filtros -->
                    <div class="d-flex" style="gap: 0.5rem; max-width: 600px;">
                        <input id="filtroDni" type="text" class="form-control form-control-sm" placeholder="DNI" style="width: 50%;">
                        <input id="filtroApellido" type="text" class="form-control form-control-sm" placeholder="Apellido" style="width: 50%;">
                    </div>

                    <!-- Botón -->
                    <button class="btn btn-success mt-2 mt-md-0" style="margin-right: -8rem;" onclick="mostrarFormulario()">
                        <i class="bi bi-person-plus"></i> Nuevo Empleado
                    </button>
                </div>

                <!-- Tabla empleados -->
                <div class="table-responsive" style="max-height: 400px; overflow-y: auto; margin-right: -8rem;">
                    <table class="table table-bordered table-hover align-middle sticky-header">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th><th>DNI</th><th>Nombre</th><th>Apellido</th><th>Email</th>
                                <th>Teléfono</th><th>Ingreso</th><th>Salario</th><th>Especialidad</th><th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Empleado> empleados = (List<Empleado>) request.getAttribute("empleados");
                                if (empleados != null && !empleados.isEmpty()) {
                                    for (Empleado e : empleados) {
                            %>
                            <tr>
                                <td><%= e.getEmpId()%></td>
                                <td><%= e.getEmpDni()%></td>
                                <td><%= e.getEmpNom()%></td>
                                <td><%= e.getEmpApe()%></td>
                                <td><%= e.getEmpEmail()%></td>
                                <td><%= e.getEmpTel() != null ? e.getEmpTel() : "N/A"%></td>
                                <td><%= e.getEmpFec()%></td>
                                <td><%= e.getEmpSal()%></td>
                                <td><%= e.getEspecialidad()%></td>
                                <td class="text-center">
                                    <a href="empleados?action=edit&id=<%= e.getEmpId()%>" class="btn btn-sm btn-warning">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="empleados?action=delete&id=<%= e.getEmpId()%>" class="btn btn-sm btn-danger"
                                       onclick="return confirmarEliminacion(this);">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr><td colspan="10" class="text-center">No hay empleados registrados.</td></tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <script>
            function mostrarFormulario() {
                const form = document.getElementById("form-empleado");
                form.classList.remove("d-none");
                const inputs = form.querySelectorAll("input:not([type='hidden'])");
                inputs.forEach(input => input.value = "");
                form.scrollIntoView({behavior: "smooth"});

                if (window.history.replaceState) {
                    window.history.replaceState(null, null, location.pathname);
                }
            }

            function ocultarFormulario() {
                const form = document.getElementById("form-empleado");
                form.classList.add("d-none");
                const inputs = form.querySelectorAll("input:not([type='hidden'])");
                inputs.forEach(input => input.value = "");
                window.scrollTo({top: 0, behavior: "smooth"});

                if (window.history.replaceState) {
                    window.history.replaceState(null, null, location.pathname);
                }
            }

            function confirmarEliminacion(link) {
                return confirm('¿Eliminar este empleado?');
            }

            // Filtro en tiempo real por DNI y Apellido
            document.addEventListener("DOMContentLoaded", () => {
                const filtroDni = document.getElementById("filtroDni");
                const filtroApellido = document.getElementById("filtroApellido");

                if (filtroDni && filtroApellido) {
                    filtroDni.addEventListener("input", filtrarTabla);
                    filtroApellido.addEventListener("input", filtrarTabla);
                }
            });

            function filtrarTabla() {
                const dniFiltro = document.getElementById("filtroDni").value.trim().toLowerCase();
                const apellidoFiltro = document.getElementById("filtroApellido").value.trim().toLowerCase();
                const filas = document.querySelectorAll("table tbody tr");

                filas.forEach(fila => {
                    const celdas = fila.querySelectorAll("td");
                    if (celdas.length >= 4) {
                        const dni = celdas[1].textContent.trim().toLowerCase();
                        const apellido = celdas[3].textContent.trim().toLowerCase();

                        const coincideDni = dni.includes(dniFiltro);
                        const coincideApellido = apellido.includes(apellidoFiltro);

                        fila.style.display = (coincideDni && coincideApellido) ? "" : "none";
                    }
                });
            }
        </script>
    </body>
</html>