<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modulo de Asistencias</title>
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

        /* Estilo de los tags de tipo de asistencia */
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

        .checkbox-container {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .checkbox-container input {
            width: auto;
            margin-right: 10px;
        }

        .justification-section {
            display: none;
            width: 100%;
            margin-top: 1rem;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .discount-section {
            background-color: #fff3cd;
            padding: 1rem;
            border-radius: 5px;
            margin-top: 1rem;
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
                    <div class="col-md-3">
                        <label for="filterName" class="form-label">Filtrar por Nombre</label>
                        <input type="text" class="form-control" id="filterName" placeholder="Buscar por nombre">
                    </div>
                    <div class="col-md-3">
                        <label for="filterDNI" class="form-label">Filtrar por DNI</label>
                        <input type="text" class="form-control" id="filterDNI" placeholder="Buscar por DNI">
                    </div>
                    <div class="col-md-2">
                        <label for="filterDate" class="form-label">Filtrar por Fecha</label>
                        <input type="date" class="form-control" id="filterDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button class="btn btn-primary" id="filterBtn">Filtrar</button>
                    </div>
                </div>
            </div>

            <!-- Tabla de Asistencias de Hoy -->
            <div id="periodos">
                <div class="row g-4 mb-4">
                    <div class="col-12">
                        <h4 class="mb-3">Asistencias de Hoy</h4>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Fecha</th>
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
                                <!-- Filas con datos estáticos directamente en la tabla -->
                                <tr data-id="1" data-tipo="asistio">
                                    <td>2025-05-10</td>
                                    <td>Juan Pérez</td>
                                    <td>1</td>
                                    <td>08:00</td>
                                    <td>07:55</td>
                                    <td>17:00</td>
                                    <td>
                                        <span class="tag asistio" title="Empleado asistió puntualmente">ASISTIÓ</span>
                                    </td>
                                    <td>12345678A</td>
                                    <td><input type="text" class="form-control form-control-sm" value="Sin observaciones"></td>
                                    <td>
                                        <button class="btn btn-info btn-sm edit-btn">Editar</button>
                                        <button class="btn btn-warning btn-sm justify-btn">Justificar</button>
                                    </td>
                                </tr>
                                <tr data-id="2" data-tipo="tarde">
                                    <td>2025-05-10</td>
                                    <td>Ana González</td>
                                    <td>2</td>
                                    <td>08:00</td>
                                    <td>08:15</td>
                                    <td>17:00</td>
                                    <td>
                                        <span class="tag tarde" title="Empleado llegó después de la hora de entrada">LLEGÓ TARDE</span>
                                    </td>
                                    <td>23456789B</td>
                                    <td><input type="text" class="form-control form-control-sm" value="Retraso por tráfico"></td>
                                    <td>
                                        <button class="btn btn-info btn-sm edit-btn">Editar</button>
                                        <button class="btn btn-warning btn-sm justify-btn">Justificar</button>
                                    </td>
                                </tr>
                                <tr data-id="3" data-tipo="falto">
                                    <td>2025-05-10</td>
                                    <td>Pedro García</td>
                                    <td>3</td>
                                    <td>08:00</td>
                                    <td>---</td>
                                    <td>17:00</td>
                                    <td>
                                        <span class="tag falto" title="Empleado no se presentó">FALTÓ</span>
                                    </td>
                                    <td>34567890C</td>
                                    <td><input type="text" class="form-control form-control-sm" value="Sin justificación"></td>
                                    <td>
                                        <button class="btn btn-info btn-sm edit-btn">Editar</button>
                                        <button class="btn btn-warning btn-sm justify-btn">Justificar</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Botones de acción -->
            <div class="d-flex justify-content-between mb-4">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#registerAttendanceModal">
                    <i class="bi bi-plus-circle"></i> Registrar Asistencia
                </button>
                <button class="btn btn-secondary">
                    <i class="bi bi-file-earmark-text"></i> Generar Reporte
                </button>
            </div>

        <!-- Sección de justificación y descuentos -->
<div class="card mb-4" id="justificationSection" style="display: none;">
    <div class="card-header bg-warning text-dark">
        <h5 class="mb-0">Justificar y Registrar Descuento</h5>
    </div>
    <div class="card-body">
        <form id="justificationForm">
            <div class="row">
                <div class="col-md-3">
                    <div class="mb-3">
                        <label for="justifyEmployeeId" class="form-label">ID del Empleado</label>
                        <input type="text" class="form-control" id="justifyEmployeeId" readonly>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="mb-3">
                        <label for="justifyEmployeeName" class="form-label">Nombre del Empleado</label>
                        <input type="text" class="form-control" id="justifyEmployeeName" readonly>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="mb-3">
                        <label for="justifyType" class="form-label">Tipo de Asistencia</label>
                        <select class="form-select" id="justifyType" disabled>
                            <option value="asistio">Asistió</option>
                            <option value="tarde">Llegó tarde</option>
                            <option value="falto">Faltó</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="mb-3">
                        <label for="arrivalTime" class="form-label">Hora de Llegada</label>
                        <input type="time" class="form-control" id="arrivalTime" disabled>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <div class="checkbox-container">
                            <input type="checkbox" id="isJustified" name="isJustified">
                            <label for="isJustified">Justificado</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="justifyDate" class="form-label">Fecha</label>
                        <input type="date" class="form-control" id="justifyDate">
                    </div>
                </div>
            </div>

            <div class="justification-section" id="justificationDetails">
                <div class="mb-3">
                    <label for="justificationText" class="form-label">Justificación</label>
                    <textarea class="form-control" id="justificationText" rows="3"></textarea>
                </div>
            </div>

            <div class="discount-section">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="discountAmount" class="form-label">Descuento Aplicado (S/.)</label>
                            <input type="number" class="form-control" id="discountAmount" step="0.01" min="0" readonly>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="baseSalary" class="form-label">Sueldo Base (S/.)</label>
                            <input type="number" class="form-control" id="baseSalary" value="1500" readonly>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-end mt-3">
                <button type="button" class="btn btn-secondary me-2" id="cancelJustification">Cancelar</button>
                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
            </div>
        </form>
    </div>
</div>
        </div>
    </main>

    <!-- Modal para Registrar Asistencia -->
    <div class="modal fade" id="registerAttendanceModal" tabindex="-1" aria-labelledby="registerAttendanceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="registerAttendanceModalLabel">Registrar Asistencia</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="attendanceForm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="attendanceDate" class="form-label">Fecha</label>
                                    <input type="date" class="form-control" id="attendanceDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="attendanceEmployee" class="form-label">Empleado</label>
                                    <select class="form-select" id="attendanceEmployee">
                                        <option value="">Seleccionar empleado</option>
                                        <option value="1">Juan Pérez</option>
                                        <option value="2">Ana González</option>
                                        <option value="3">Pedro García</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="attendanceEntryTime" class="form-label">Hora de Entrada</label>
                                    <input type="time" class="form-control" id="attendanceEntryTime" value="08:00">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="attendanceArrival" class="form-label">Hora de Llegada</label>
                                    <input type="time" class="form-control" id="attendanceArrival">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="attendanceDeparture" class="form-label">Hora de Salida</label>
                                    <input type="time" class="form-control" id="attendanceDeparture" value="17:00">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="attendanceType" class="form-label">Tipo de Asistencia</label>
                                    <select class="form-select" id="attendanceType">
                                        <option value="asistio">Asistió</option>
                                        <option value="tarde">Llegó tarde</option>
                                        <option value="falto">Faltó</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="attendanceDNI" class="form-label">DNI</label>
                                    <input type="text" class="form-control" id="attendanceDNI" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="attendanceObservations" class="form-label">Observaciones</label>
                            <textarea class="form-control" id="attendanceObservations" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="saveAttendanceBtn">Registrar</button>
                </div>
            </div>
        </div>
    </div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Variables globales
    const sueldoBase = 1500; // Sueldo base para cálculos de descuento
    const horaEntradaOficial = '08:00'; // Hora oficial de entrada
    
    // Configurar fecha actual en el formulario de justificación
    document.getElementById('justifyDate').value = new Date().toISOString().split('T')[0];
    
    // Manejar clic en botones de justificación
    document.querySelectorAll('.justify-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const id = row.getAttribute('data-id');
            const name = row.cells[1].textContent;
            const type = row.getAttribute('data-tipo');
            
            // Obtener hora de llegada de la tabla (columna 5 - índice 4)
            const arrivalTimeCell = row.cells[4]; // Cambiado de 5 a 4 para la columna correcta
            let arrivalTime = arrivalTimeCell.textContent.trim();
            
            // Manejar caso cuando no hay hora registrada ("---")
            if (arrivalTime === '---') {
                arrivalTime = '';
            }
            
            // Llenar formulario de justificación
            document.getElementById('justifyEmployeeId').value = id;
            document.getElementById('justifyEmployeeName').value = name;
            document.getElementById('justifyType').value = type;
            
            // Configurar campo de hora de llegada
            const arrivalTimeInput = document.getElementById('arrivalTime');
            if (type === 'falto') {
                arrivalTimeInput.disabled = true;
                arrivalTimeInput.value = '';
            } else {
                arrivalTimeInput.disabled = false;
                arrivalTimeInput.value = arrivalTime;
            }
            
            // Mostrar sección de justificación
            document.getElementById('justificationSection').style.display = 'block';
            
            // Calcular descuento inicial
            calculateDiscount();
            
            // Desplazarse a la sección de justificación
            document.getElementById('justificationSection').scrollIntoView({ behavior: 'smooth' });
        });
    });
    
    // Manejar cambio en checkbox de justificación
    document.getElementById('isJustified').addEventListener('change', function() {
        const justificationSection = document.getElementById('justificationDetails');
        if (this.checked) {
            justificationSection.style.display = 'block';
        } else {
            justificationSection.style.display = 'none';
        }
        calculateDiscount();
    });
    
    // Manejar cambio en la hora de llegada
    document.getElementById('arrivalTime').addEventListener('change', function() {
        calculateDiscount();
    });
    
    // Función para calcular descuento
    function calculateDiscount() {
        const type = document.getElementById('justifyType').value;
        const isJustified = document.getElementById('isJustified').checked;
        const arrivalTime = document.getElementById('arrivalTime').value;
        let discountPercentage = 0;
        
        // Calcular porcentaje según tipo y justificación
        if (type === 'falto') {
            discountPercentage = isJustified ? 30 : 50;
        } else if (type === 'tarde') {
            if (arrivalTime && isJustified) {
                // Calcular minutos de retardo para ajustar el descuento
                const [horaEntrada, minEntrada] = horaEntradaOficial.split(':').map(Number);
                const [horaLlegada, minLlegada] = arrivalTime.split(':').map(Number);
                
                const minutosRetardo = (horaLlegada * 60 + minLlegada) - (horaEntrada * 60 + minEntrada);
                
                if (minutosRetardo <= 15) {
                    discountPercentage = 5; // Descuento menor por retardo corto justificado
                } else {
                    discountPercentage = 10; // Descuento estándar para retardos justificados
                }
            } else if (arrivalTime) {
                // Tardanza no justificada
                discountPercentage = 25;
            }
        }
        
        // Calcular monto del descuento
        const discountAmount = (sueldoBase * discountPercentage) / 100;
        document.getElementById('discountAmount').value = discountAmount.toFixed(2);
    }
    
    // Manejar envío del formulario de justificación
    document.getElementById('justificationForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const employeeId = document.getElementById('justifyEmployeeId').value;
        const isJustified = document.getElementById('isJustified').checked;
        const justification = document.getElementById('justificationText').value;
        const discount = document.getElementById('discountAmount').value;
        const arrivalTime = document.getElementById('arrivalTime').value;
        const type = document.getElementById('justifyType').value;
        
        // Aquí iría la lógica para guardar en la base de datos
        console.log('Guardando justificación:', {
            employeeId,
            isJustified,
            justification,
            discount,
            arrivalTime,
            type
        });
        
        // Actualizar la fila correspondiente en la tabla
        const row = document.querySelector(`tr[data-id="${employeeId}"]`);
        if (row) {
            const typeCell = row.cells[6];
            const observationsInput = row.cells[8].querySelector('input');
            const arrivalTimeCell = row.cells[5];
            
            if (isJustified) {
                if (type === 'falto') {
                    typeCell.innerHTML = '<span class="tag justificado" title="Falta justificada">FALTA JUSTIFICADA</span>';
                } else if (type === 'tarde') {
                    typeCell.innerHTML = '<span class="tag justificado" title="Tardanza justificada">TARDANZA JUSTIFICADA</span>';
                }
                
                // Actualizar observaciones
                observationsInput.value = justification || observationsInput.value;
            }
            
            // Actualizar hora de llegada si existe y no es falta
            if (arrivalTime && type !== 'falto' && arrivalTimeCell) {
                arrivalTimeCell.textContent = arrivalTime;
                row.setAttribute('data-hora', arrivalTime);
            }
        }
        
        // Mostrar alerta y resetear formulario
        alert('Justificación registrada correctamente');
        this.reset();
        document.getElementById('justificationSection').style.display = 'none';
    });
    
    // Manejar cancelación de justificación
    document.getElementById('cancelJustification').addEventListener('click', function() {
        document.getElementById('justificationForm').reset();
        document.getElementById('justificationSection').style.display = 'none';
    });
    
    // Resto del código existente...
    document.getElementById('attendanceEmployee').addEventListener('change', function() {
        const employeeId = this.value;
        const dniMap = {
            '1': '12345678A',
            '2': '23456789B',
            '3': '34567890C'
        };
        document.getElementById('attendanceDNI').value = dniMap[employeeId] || '';
    });
    
    document.getElementById('saveAttendanceBtn').addEventListener('click', function() {
        alert('Asistencia registrada correctamente');
        document.getElementById('registerAttendanceModal').querySelector('.btn-close').click();
        document.getElementById('attendanceForm').reset();
    });
    
    document.getElementById('filterBtn').addEventListener('click', function() {
        const nameFilter = document.getElementById('filterName').value.toLowerCase();
        const dniFilter = document.getElementById('filterDNI').value.toLowerCase();
        const dateFilter = document.getElementById('filterDate').value;
        
        document.querySelectorAll('tbody tr').forEach(row => {
            const name = row.cells[1].textContent.toLowerCase();
            const dni = row.cells[7].textContent.toLowerCase();
            const date = row.cells[0].textContent;
            
            const nameMatch = name.includes(nameFilter);
            const dniMatch = dni.includes(dniFilter);
            const dateMatch = date === dateFilter;
            
            if (nameMatch && dniMatch && dateMatch) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
});

</script>
  
</body>
</html>