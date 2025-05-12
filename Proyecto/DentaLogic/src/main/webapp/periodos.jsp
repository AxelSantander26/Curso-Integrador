<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Gestión de Periodos de Pago</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body>
    <!-- Sidebar y Navbar -->
    <jsp:include page="components/sidebar-navbar.jsp"/>

    <main class="main-content">
        <div class="content-wrapper container py-4">
            <h3 class="mb-4">Gestión de Periodos de Pago</h3>

            <!-- Botón para mostrar formulario -->
            <div class="mb-3 d-flex justify-content-end">
                <button class="btn btn-success" onclick="mostrarFormulario()">
                    <i class="bi bi-calendar-plus"></i> Nuevo Periodo
                </button>
            </div>

            <!-- Formulario para nuevo periodo -->
            <div id="form-nuevo-periodo" class="card p-4 mb-4 d-none">
                <h5 class="mb-3">Registrar Nuevo Periodo</h5>
                <form class="row gy-3">
                    <div class="col-md-6">
                        <label class="form-label">Nombre del Periodo</label>
                        <input type="text" class="form-control" name="per_nom" placeholder="Ej. Mayo 2025" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha Inicio</label>
                        <input type="date" class="form-control" name="per_fech_ini" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha Fin</label>
                        <input type="date" class="form-control" name="per_fech_fin" required>
                    </div>
                    <div class="col-12 d-flex justify-content-end gap-2">
                        <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">Cancelar</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Guardar Periodo
                        </button>
                    </div>
                </form>
            </div>

            <!-- Tabla de periodos -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Periodo</th>
                            <th>Fecha Inicio</th>
                            <th>Fecha Fin</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Ejemplo de fila -->
                        <tr>
                            <td>Mayo 2025</td>
                            <td>2025-05-01</td>
                            <td>2025-05-31</td>
                            <td>
                                <button class="btn btn-sm btn-info"><i class="bi bi-eye"></i> Ver</button>
                            </td>
                        </tr>
                        <!-- Aquí irán más registros -->
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        function mostrarFormulario() {
            const form = document.getElementById("form-nuevo-periodo");
            form.classList.remove("d-none");
            form.scrollIntoView({ behavior: "smooth" });
        }
        function ocultarFormulario() {
            document.getElementById("form-nuevo-periodo").classList.add("d-none");
        }
    </script>
</body>
</html>