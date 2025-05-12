<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Gestión de Pagos</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    </head>
    <body>
        <!-- Sidebar y navbar -->
        <jsp:include page="components/sidebar-navbar.jsp"/>

        <!-- Contenido principal -->
        <main class="main-content">
            <div class="container py-4">

                <h3 class="mb-4">Gestión de Pagos</h3>

                <!-- Filtros -->
                <form class="row gy-2 gx-3 align-items-end mb-4">
                    <div class="col-md-4">
                        <label class="form-label">Empleado</label>
                        <select class="form-select" name="empleado">
                            <option selected>Seleccione...</option>
                            <option value="todos">Todos</option>
                            <option value="odontologos">Odontólogos</option>
                            <option value="admin">Administrativos</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha desde</label>
                        <input type="date" class="form-control" name="desde">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha hasta</label>
                        <input type="date" class="form-control" name="hasta">
                    </div>
                    <div class="col-md-2 d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-funnel-fill"></i> Filtrar
                        </button>
                    </div>
                </form>

                <!-- Botones de acción -->
                <div class="mb-3 d-flex justify-content-end gap-2">
                    <button class="btn btn-success" onclick="mostrarFormulario()">
                        <i class="bi bi-plus-circle"></i> Nuevo Pago
                    </button>
                    <button class="btn btn-outline-secondary">
                        <i class="bi bi-file-earmark-excel"></i> Generar Plantilla
                    </button>
                </div>

                <!-- Formulario nuevo pago (oculto al inicio) -->
                <div id="form-nuevo-pago" class="card p-4 mb-4 d-none">
                    <h5 class="mb-3">Registrar Nuevo Pago</h5>
                    <form class="row gy-3 gx-4">

                        <div class="col-md-4">
                            <label class="form-label">Empleado</label>
                            <select class="form-select" name="emp_id" required>
                                <option selected disabled>Seleccione...</option>
                                <!-- Datos dinámicos -->
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Periodo de Pago</label>
                            <select class="form-select" name="per_id" required>
                                <option selected disabled>Seleccione...</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Bono (opcional)</label>
                            <select class="form-select" name="bono_id">
                                <option selected value="">Ninguno</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Monto Total</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="detp_mon" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Descuento Total</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="descuento_total" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Sueldo Neto</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="sueldo_neto" required>
                        </div>

                        <div class="col-12 d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">
                                Cancelar
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> Guardar Pago
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Tabla de pagos -->
                <div class="table-responsive">
                    <table class="table table-bordered align-middle table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Empleado</th>
                                <th>Periodo</th>
                                <th>Pago Total</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Juan Pérez</td>
                                <td>Mayo 2025</td>
                                <td>S/. 1,520.00</td>
                                <td>
                                    <button class="btn btn-sm btn-info">
                                        <i class="bi bi-eye"></i> Ver
                                    </button>
                                </td>
                            </tr>
                            <!-- Más registros -->
                        </tbody>
                    </table>
                </div>

            </div>
        </main>

        <!-- JS para mostrar/ocultar el formulario -->
        <script>
            function mostrarFormulario() {
                const form = document.getElementById("form-nuevo-pago");
                form.classList.remove("d-none");
                form.scrollIntoView({ behavior: "smooth" });
            }

            function ocultarFormulario() {
                document.getElementById("form-nuevo-pago").classList.add("d-none");
            }
        </script>
    </body>
</html>