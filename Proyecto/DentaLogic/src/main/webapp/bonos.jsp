<%@page contentType="text/html" pageEncoding="windows-1252"%>
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

            <!-- Formulario nuevo bono -->
            <div id="form-nuevo-bono" class="card p-4 mb-4 d-none">
                <h5 class="mb-3">Registrar Nuevo Bono</h5>
                <form class="row gy-3">
                    <div class="col-md-6">
                        <label class="form-label">Nombre del Bono</label>
                        <input type="text" class="form-control" name="bon_nom" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Monto</label>
                        <input type="number" step="0.01" min="0" class="form-control" name="bon_monto" required>
                    </div>
                    <div class="col-12 d-flex justify-content-end gap-2">
                        <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">Cancelar</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Guardar Bono
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
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Productividad</td>
                            <td>S/. 250.00</td>
                            <td>
                                <button class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil"></i> Editar
                                </button>
                            </td>
                        </tr>
                        <!-- Más registros -->
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        function mostrarFormulario() {
            const form = document.getElementById("form-nuevo-bono");
            form.classList.remove("d-none");
            form.scrollIntoView({ behavior: "smooth" });
        }

        function ocultarFormulario() {
            document.getElementById("form-nuevo-bono").classList.add("d-none");
        }
    </script>
</body>
</html>