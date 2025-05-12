<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modulo de Empleados</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        :root {
            --sidebar-bg: #19414b;
            --card-bg: #1a4d40;
        }

        .modal-header, .modal-footer {
            border: none;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .modal-body input, .modal-body select, .modal-body textarea {
            margin-bottom: 1rem;
        }

        .filter-section {
            margin-bottom: 1rem;
        }

        /* Aseguramos que las filas sean visibles */
        .table td, .table th {
            color: #000;
        }

        /* Estilo de los tags de rol */
        .tag {
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9em;
            color: white;
            display: inline-block;
            min-width: 100px;
            text-align: center;
        }
        .administrador { background-color: #2e7d32; }
        .odontologo { background-color: #1565c0; }
        .secretaria { background-color: #f9a825; color: #000; }

        /* Filtro de búsqueda */
        .filter-section input {
            margin-bottom: 1rem;
        }

        /* Modal en diseño horizontal */
        .modal-body {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .modal-body .mb-3 {
            width: 48%;
        }

        .modal-body .mb-3.full-width {
            width: 100%;
        }

        .employee-photo {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 1rem;
            border: 3px solid var(--card-bg);
        }

        .photo-upload {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 1rem;
        }

        .action-btns .btn {
            margin-right: 5px;
            margin-bottom: 5px;
        }
            /* Añade esto en tu sección de estilos */
    .modal-lg {
        max-width: 800px; /* Puedes ajustar este valor según necesites */
    }
    
    .form-control-lg, .form-select-lg {
        padding: 0.5rem 1rem;
        font-size: 1.1rem;
        height: calc(2.5rem + 2px);
    }
    
    .modal-body {
        padding: 1.5rem;
    }
    select:disabled {
    background-color: #e9ecef;
    cursor: not-allowed;
}

    </style>
</head>
<body class="bg-light">
    <!-- Incluyendo el sidebar y navbar -->
    <jsp:include page="components/sidebar-navbar.jsp"/>

    <!-- Contenido Principal -->
    <main class="main-content">
        <div class="content-wrapper">
            <!-- Filtros de búsqueda -->
            <div class="filter-section">
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <label for="filterName" class="form-label">Filtrar por Nombre</label>
                        <input type="text" class="form-control" id="filterName" placeholder="Buscar por nombre o apellido">
                    </div>
                    <div class="col-md-3">
                        <label for="filterDNI" class="form-label">Filtrar por DNI</label>
                        <input type="text" class="form-control" id="filterDNI" placeholder="Buscar por DNI">
                    </div>
                    <div class="col-md-3">
                        <label for="filterRole" class="form-label">Filtrar por Rol</label>
                        <select class="form-select" id="filterRole">
                            <option value="">Todos</option>
                            <option value="administrador">Administrador</option>
                            <option value="odontologo">Odontólogo</option>
                            <option value="secretaria">Secretaria</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button class="btn btn-primary" id="filterBtn">Filtrar</button>
                    </div>
                </div>
            </div>

            <!-- Tabla de Empleados -->
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4>Lista de Empleados</h4>
                        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#registerEmployeeModal">
                            <i class="bi bi-plus-circle"></i> Registrar Empleado
                        </button>
                    </div>
                    
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Foto</th>
                                <th>Nombre y Apellido</th>
                                <th>DNI</th>
                                <th>Email</th>
                                <th>Teléfono</th>
                                <th>Fecha Ingreso</th>
                                <th>Salario</th>
                                <th>Rol</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Ejemplo de filas con datos estáticos -->
                            <tr data-id="1" data-role="administrador">
                                <td>1</td>
                                <td><img src="https://randomuser.me/api/portraits/men/1.jpg" alt="Foto" class="user-avatar"></td>
                                <td>Juan Pérez García</td>
                                <td>12345678</td>
                                <td>juan.perez@clinica.com</td>
                                <td>987654321</td>
                                <td>2023-01-15</td>
                                <td>S/. 4500.00</td>
                                <td>
                                    <span class="tag administrador">ADMINISTRADOR</span>
                                </td>
                                <td class="action-btns">
                                    <button class="btn btn-info btn-sm view-btn" data-bs-toggle="modal" data-bs-target="#viewEmployeeModal">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-primary btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-danger btn-sm delete-btn">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr data-id="2" data-role="odontologo">
                                <td>2</td>
                                <td><img src="https://randomuser.me/api/portraits/women/2.jpg" alt="Foto" class="user-avatar"></td>
                                <td>María López Sánchez</td>
                                <td>23456789</td>
                                <td>maria.lopez@clinica.com</td>
                                <td>987123456</td>
                                <td>2022-11-10</td>
                                <td>S/. 5500.00</td>
                                <td>
                                    <span class="tag odontologo">ODONTÓLOGO</span>
                                </td>
                                <td class="action-btns">
                                    <button class="btn btn-info btn-sm view-btn" data-bs-toggle="modal" data-bs-target="#viewEmployeeModal">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-primary btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-danger btn-sm delete-btn">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr data-id="3" data-role="secretaria">
                                <td>3</td>
                                <td><img src="https://randomuser.me/api/portraits/women/3.jpg" alt="Foto" class="user-avatar"></td>
                                <td>Ana Gómez Flores</td>
                                <td>34567890</td>
                                <td>ana.gomez@clinica.com</td>
                                <td>987654123</td>
                                <td>2021-05-20</td>
                                <td>S/. 2800.00</td>
                                <td>
                                    <span class="tag secretaria">SECRETARIA</span>
                                </td>
                                <td class="action-btns">
                                    <button class="btn btn-info btn-sm view-btn" data-bs-toggle="modal" data-bs-target="#viewEmployeeModal">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-primary btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-danger btn-sm delete-btn">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Botones de acción -->
            <div class="d-flex justify-content-end mb-4">
                <button class="btn btn-secondary">
                    <i class="bi bi-file-earmark-text"></i> Generar Reporte
                </button>
            </div>
        </div>
    </main>

<!-- Modal para Registrar Empleado -->
<div class="modal fade" id="registerEmployeeModal" tabindex="-1" aria-labelledby="registerEmployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="registerEmployeeModalLabel">Registrar Nuevo Empleado</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="employeeForm" class="w-100 px-3">

          

              
                    <div class="photo-upload mb-4 text-center">
                        <img src="https://via.placeholder.com/150" alt="Foto del empleado" class="employee-photo mb-2" id="employeePhotoPreview">
                        <input type="file" id="employeePhoto" accept="image/*" class="form-control" style="width: auto; margin: 0 auto;">
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeDNI" class="form-label">DNI *</label>
                                <input type="text" class="form-control" id="employeeDNI" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeName" class="form-label">Nombres *</label>
                                <input type="text" class="form-control" id="employeeName" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeLastName" class="form-label">Apellidos *</label>
                                <input type="text" class="form-control" id="employeeLastName" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeBirthdate" class="form-label">Fecha de Nacimiento *</label>
                                <input type="date" class="form-control" id="employeeBirthdate" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeEmail" class="form-label">Correo Electrónico *</label>
                                <input type="email" class="form-control" id="employeeEmail" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeePhone" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" id="employeePhone">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeStartDate" class="form-label">Fecha de Ingreso *</label>
                                <input type="date" class="form-control" id="employeeStartDate" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeSalary" class="form-label">Salario (S/.) *</label>
                                <input type="number" step="0.01" class="form-control" id="employeeSalary" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeRole" class="form-label">Rol *</label>
                                <select class="form-select" id="employeeRole" required>
                                    <option value="">Seleccionar</option>
                                    <option value="administrador">Administrador</option>
                                    <option value="odontologo">Odontólogo</option>
                                    <option value="secretaria">Secretaria</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeSpecialty" class="form-label">Especialidad (solo odontólogos)</label>
                                <select class="form-select" id="employeeSpecialty" disabled>
                                    <option value="">Seleccionar</option>
                                    <option value="1">Ortodoncia</option>
                                    <option value="2">Endodoncia</option>
                                    <option value="3">Periodoncia</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeeUsername" class="form-label">Nombre de Usuario *</label>
                                <input type="text" class="form-control" id="employeeUsername" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="employeePassword" class="form-label">Contraseña *</label>
                                <input type="password" class="form-control" id="employeePassword" required>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="saveEmployeeBtn">Registrar</button>
            </div>
        </div>
    </div>
</div>

    <!-- Modal para Visualizar Empleado -->
    <div class="modal fade" id="viewEmployeeModal" tabindex="-1" aria-labelledby="viewEmployeeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title" id="viewEmployeeModalLabel">Detalles del Empleado</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <img src="https://randomuser.me/api/portraits/men/1.jpg" alt="Foto del empleado" class="employee-photo mb-3" id="viewEmployeePhoto">
                            <div>
                                <span class="tag administrador" id="viewEmployeeRole">ADMINISTRADOR</span>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <h4 id="viewEmployeeName">Juan Pérez García</h4>
                            <p class="text-muted" id="viewEmployeeSpecialty"></p>
                            
                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <h6>Información Personal</h6>
                                    <p><strong>DNI:</strong> <span id="viewEmployeeDNI">12345678</span></p>
                                    <p><strong>Fecha Nacimiento:</strong> <span id="viewEmployeeBirthdate">15/01/1985</span></p>
                                    <p><strong>Email:</strong> <span id="viewEmployeeEmail">juan.perez@clinica.com</span></p>
                                    <p><strong>Teléfono:</strong> <span id="viewEmployeePhone">987654321</span></p>
                                </div>
                                <div class="col-md-6">
                                    <h6>Información Laboral</h6>
                                    <p><strong>Fecha Ingreso:</strong> <span id="viewEmployeeStartDate">15/01/2023</span></p>
                                    <p><strong>Salario:</strong> S/.<span id="viewEmployeeSalary">4500.00</span></p>
                                    <p><strong>Usuario:</strong> <span id="viewEmployeeUsername">jperez</span></p>
                                    <p><strong>Estado:</strong> <span id="viewEmployeeStatus">Activo</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

  <!-- Modal para Registrar Empleado -->
<div class="modal fade" id="registerEmployeeModal" tabindex="-1" aria-labelledby="registerEmployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="registerEmployeeModalLabel">Registrar Nuevo Empleado</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="employeeForm">
                    <div class="photo-upload mb-4">
                        <img src="https://via.placeholder.com/120" alt="Foto del empleado" class="employee-photo" id="employeePhotoPreview">
                        <input type="file" id="employeePhoto" accept="image/*" class="form-control form-control-sm mt-2" style="width: auto;">
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="mb-3">
                                <label for="employeeDNI" class="form-label">DNI *</label>
                                <input type="text" class="form-control form-control-lg" id="employeeDNI" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeName" class="form-label">Nombres *</label>
                                <input type="text" class="form-control form-control-lg" id="employeeName" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeLastName" class="form-label">Apellidos *</label>
                                <input type="text" class="form-control form-control-lg" id="employeeLastName" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeBirthdate" class="form-label">Fecha de Nacimiento *</label>
                                <input type="date" class="form-control form-control-lg" id="employeeBirthdate" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeEmail" class="form-label">Correo Electrónico *</label>
                                <input type="email" class="form-control form-control-lg" id="employeeEmail" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeePhone" class="form-label">Teléfono</label>
                                <input type="tel" class="form-control form-control-lg" id="employeePhone">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeStartDate" class="form-label">Fecha de Ingreso *</label>
                                <input type="date" class="form-control form-control-lg" id="employeeStartDate" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeSalary" class="form-label">Salario (S/.) *</label>
                                <input type="number" step="0.01" class="form-control form-control-lg" id="employeeSalary" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeRole" class="form-label">Rol *</label>
                                <select class="form-select form-select-lg" id="employeeRole" required>
                                    <option value="">Seleccionar</option>
                                    <option value="administrador">Administrador</option>
                                    <option value="odontologo">Odontólogo</option>
                                    <option value="secretaria">Secretaria</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeSpecialty" class="form-label">Especialidad (solo odontólogos)</label>
                                <select class="form-select form-select-lg" id="employeeSpecialty" disabled>
                                    <option value="">Seleccionar</option>
                                    <option value="1">Ortodoncia</option>
                                    <option value="2">Endodoncia</option>
                                    <option value="3">Periodoncia</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeeUsername" class="form-label">Nombre de Usuario *</label>
                                <input type="text" class="form-control form-control-lg" id="employeeUsername" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="employeePassword" class="form-label">Contraseña *</label>
                                <input type="password" class="form-control form-control-lg" id="employeePassword" required>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="saveEmployeeBtn">Registrar</button>
            </div>
        </div>
    </div>
</div>
  
  <div class="modal fade" id="editEmployeeModal" tabindex="-1" aria-labelledby="editEmployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editEmployeeModalLabel">Editar Empleado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editEmployeeForm">
                    <input type="hidden" id="editEmployeeDNI">
                    <div class="mb-3">
                        <label for="editEmployeeName" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="editEmployeeName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmployeeEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmployeeEmail" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmployeePhone" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="editEmployeePhone" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmployeeStartDate" class="form-label">Fecha de Inicio</label>
                        <input type="date" class="form-control" id="editEmployeeStartDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmployeeSalary" class="form-label">Salario</label>
                        <input type="text" class="form-control" id="editEmployeeSalary" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmployeeRole" class="form-label">Rol</label>
                        <select class="form-select" id="editEmployeeRole" required>
                            <option value="odontologo">Odontólogo</option>
                            <option value="otroRol">Otro Rol</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="saveEditEmployeeBtn">Guardar Cambios</button>
            </div>
        </div>
    </div>
</div>

    <!-- Modal de Confirmación para Eliminar -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">Confirmar Eliminación</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>¿Está seguro que desea eliminar al empleado <strong id="employeeToDeleteName">Juan Pérez García</strong>?</p>
                    <p class="text-danger">Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Eliminar</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
    // Previsualización de foto al subir
    document.getElementById('employeePhoto').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                document.getElementById('employeePhotoPreview').src = event.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Habilitar/deshabilitar especialidad según rol seleccionado
    const roleSelect = document.getElementById('employeeRole');
    const specialtySelect = document.getElementById('employeeSpecialty');

    if (roleSelect && specialtySelect) {
        roleSelect.addEventListener('change', function () {
            const isOdontologo = this.value === 'odontologo';
            specialtySelect.disabled = !isOdontologo;
            if (!isOdontologo) specialtySelect.value = '';
        });
    }

    // Configurar fecha actual en el formulario de registro
    document.getElementById('employeeStartDate').value = new Date().toISOString().split('T')[0];

    // Manejar clic en botones de visualización
    document.querySelectorAll('.view-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const id = row.getAttribute('data-id');
            const dni = row.cells[0].textContent;
            const photo = row.cells[1].querySelector('img').src;
            const name = row.cells[2].textContent;
            const email = row.cells[3].textContent;
            const phone = row.cells[4].textContent;
            const startDate = row.cells[5].textContent;
            const salary = row.cells[6].textContent;
            const role = row.cells[7].querySelector('.tag').textContent.toLowerCase();

            // Llenar modal de visualización
            document.getElementById('viewEmployeePhoto').src = photo;
            document.getElementById('viewEmployeeName').textContent = name;
            document.getElementById('viewEmployeeDNI').textContent = dni;
            document.getElementById('viewEmployeeEmail').textContent = email;
            document.getElementById('viewEmployeePhone').textContent = phone;
            document.getElementById('viewEmployeeStartDate').textContent = startDate;
            document.getElementById('viewEmployeeSalary').textContent = salary;

            // Actualizar rol con la clase adecuada
            const roleElement = document.getElementById('viewEmployeeRole');
            roleElement.className = 'tag ' + role;
            roleElement.textContent = role.toUpperCase();
        });
    });

    // Manejar clic en botones de eliminación
    document.querySelectorAll('.delete-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const name = row.cells[2].textContent;

            // Configurar modal de confirmación
            document.getElementById('employeeToDeleteName').textContent = name;

            // Mostrar modal
            const confirmModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            confirmModal.show();

            // Manejar confirmación de eliminación
            document.getElementById('confirmDeleteBtn').onclick = function() {
                row.remove();
                confirmModal.hide();
                alert('Empleado eliminado correctamente');
            };
        });
    });

    // Manejar envío del formulario de registro
    document.getElementById('saveEmployeeBtn').addEventListener('click', function() {
        // Obtener los datos del formulario
        const employeeDNI = document.getElementById('employeeDNI').value;
        const employeeName = document.getElementById('employeeName').value + ' ' + document.getElementById('employeeLastName').value;
        const employeeEmail = document.getElementById('employeeEmail').value;
        const employeePhone = document.getElementById('employeePhone').value;
        const employeeStartDate = document.getElementById('employeeStartDate').value;
        const employeeSalary = document.getElementById('employeeSalary').value;
        const employeeRole = document.getElementById('employeeRole').value;
        const employeePhoto = document.getElementById('employeePhotoPreview').src || 'ruta/a/imagen/por/defecto.jpg';

        // Validar campos obligatorios
        if (!employeeDNI || !employeeName.trim() || !employeeEmail || !employeeRole) {
            alert('Por favor complete todos los campos obligatorios');
            return;
        }

        // Crear una nueva fila para la tabla
        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td>${employeeDNI}</td>
            <td><img src="${employeePhoto}" alt="Foto" class="user-avatar" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;"></td>
            <td>${employeeName}</td>
            <td>${employeeEmail}</td>
            <td>${employeePhone}</td>
            <td>${employeeStartDate}</td>
            <td>S/. ${employeeSalary}</td>
            <td><span class="tag ${employeeRole}">${employeeRole.toUpperCase()}</span></td>
            <td class="action-btns">
                <button class="btn btn-info btn-sm view-btn" data-bs-toggle="modal" data-bs-target="#viewEmployeeModal">
                    <i class="bi bi-eye"></i>
                </button>
                <button class="btn btn-primary btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#editEmployeeModal">
                    <i class="bi bi-pencil"></i>
                </button>
                <button class="btn btn-danger btn-sm delete-btn">
                    <i class="bi bi-trash"></i>
                </button>
            </td>
        `;

        // Agregar la nueva fila a la tabla
        document.querySelector('tbody').appendChild(newRow);

        // Asignar eventos a los nuevos botones
        newRow.querySelector('.view-btn').addEventListener('click', function() {
            const row = this.closest('tr');
            const dni = row.cells[0].textContent;
            const photo = row.cells[1].querySelector('img').src;
            const name = row.cells[2].textContent;
            const email = row.cells[3].textContent;
            const phone = row.cells[4].textContent;
            const startDate = row.cells[5].textContent;
            const salary = row.cells[6].textContent;
            const role = row.cells[7].querySelector('.tag').textContent.toLowerCase();

            // Llenar modal de visualización
            document.getElementById('viewEmployeePhoto').src = photo;
            document.getElementById('viewEmployeeName').textContent = name;
            document.getElementById('viewEmployeeDNI').textContent = dni;
            document.getElementById('viewEmployeeEmail').textContent = email;
            document.getElementById('viewEmployeePhone').textContent = phone;
            document.getElementById('viewEmployeeStartDate').textContent = startDate;
            document.getElementById('viewEmployeeSalary').textContent = salary;

            // Actualizar rol
            const roleElement = document.getElementById('viewEmployeeRole');
            roleElement.className = 'tag ' + role;
            roleElement.textContent = role.toUpperCase();
        });

        newRow.querySelector('.delete-btn').addEventListener('click', function() {
            const row = this.closest('tr');
            const name = row.cells[2].textContent;

            document.getElementById('employeeToDeleteName').textContent = name;
            const confirmModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            confirmModal.show();

            document.getElementById('confirmDeleteBtn').onclick = function() {
                row.remove();
                confirmModal.hide();
                alert('Empleado eliminado correctamente');
            };
        });

        // Cerrar el modal y resetear el formulario
        const modal = bootstrap.Modal.getInstance(document.getElementById('registerEmployeeModal'));
        modal.hide();
        document.getElementById('employeeForm').reset();
        document.getElementById('employeePhotoPreview').src = 'ruta/a/imagen/por/defecto.jpg';
        
        alert('Empleado registrado correctamente');
        // Manejar clic en botones de edición
document.querySelectorAll('.edit-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        const row = this.closest('tr');
        const dni = row.cells[0].textContent;
        const name = row.cells[2].textContent;
        const email = row.cells[3].textContent;
        const phone = row.cells[4].textContent;
        const startDate = row.cells[5].textContent;
        const salary = row.cells[6].textContent.replace('S/. ', ''); // Eliminar el símbolo de moneda
        const role = row.cells[7].querySelector('.tag').textContent.toLowerCase();

        // Llenar el formulario de edición
        document.getElementById('editEmployeeDNI').value = dni;
        document.getElementById('editEmployeeName').value = name;
        document.getElementById('editEmployeeEmail').value = email;
        document.getElementById('editEmployeePhone').value = phone;
        document.getElementById('editEmployeeStartDate').value = startDate;
        document.getElementById('editEmployeeSalary').value = salary;
        document.getElementById('editEmployeeRole').value = role;

        // Mostrar el modal de edición
        const editModal = new bootstrap.Modal(document.getElementById('editEmployeeModal'));
        editModal.show();

        // Manejar el clic en el botón de guardar cambios
        document.getElementById('saveEditEmployeeBtn').onclick = function() {
            // Obtener los datos del formulario de edición
            const updatedDNI = document.getElementById('editEmployeeDNI').value;
            const updatedName = document.getElementById('editEmployeeName').value;
            const updatedEmail = document.getElementById('editEmployeeEmail').value;
            const updatedPhone = document.getElementById('editEmployeePhone').value;
            const updatedStartDate = document.getElementById('editEmployeeStartDate').value;
            const updatedSalary = document.getElementById('editEmployeeSalary').value;
            const updatedRole = document.getElementById('editEmployeeRole').value;

            // Actualizar la fila de la tabla
            row.cells[0].textContent = updatedDNI;
            row.cells[2].textContent = updatedName;
            row.cells[3].textContent = updatedEmail;
            row.cells[4].textContent = updatedPhone;
            row.cells[5].textContent = updatedStartDate;
            row.cells[6].textContent = `S/. ${updatedSalary}`;
            row.cells[7].querySelector('.tag').textContent = updatedRole.toUpperCase();
            row.cells[7].querySelector('.tag').className = 'tag ' + updatedRole;

            // Cerrar el modal de edición
            editModal.hide();
            alert('Empleado actualizado correctamente');
        };
    });
});

    });
});
    </script>
</body>
</html>