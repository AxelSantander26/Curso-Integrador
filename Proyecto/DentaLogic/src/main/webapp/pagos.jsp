<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="windows-1252">
    <title>Gestión de Pagos</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        /* Estilo para el scroll de la tabla */
        .table-scroll {
            max-height: 400px; /* Ajusta el valor según lo que desees */
            overflow-y: auto; /* Activa el scroll vertical */
        }
    </style>
</head>
<body>
<jsp:include page="components/sidebar-navbar.jsp"/>

<main class="main-content">
    <div class="container py-4">
        <h3 class="mb-4">Gestión de Pagos</h3>

        <!-- Filtros -->
        <form class="row gy-2 gx-3 align-items-end mb-4" method="get" action="pagos">
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

        <!-- Botones -->
        <div class="mb-3 d-flex justify-content-end gap-2">
            <button class="btn btn-success" type="button" onclick="mostrarFormulario()">
                <i class="bi bi-plus-circle"></i> Nuevo Pago
            </button>
            <button class="btn btn-outline-secondary" type="button">
                <i class="bi bi-file-earmark-excel"></i> Generar Plantilla
            </button>
        </div>

        <!-- Formulario nuevo pago -->
        <div id="form-nuevo-pago" class="card p-4 mb-4 d-none">
            <h5 class="mb-3">Registrar Nuevo Pago</h5>
            <form class="row gy-3 gx-4" action="pagos" method="post">

                <!-- Empleado -->
                <div class="col-md-4">
                    <label class="form-label">Empleado</label>
                    <select class="form-select" name="emp_id" id="empSelect" required>
                        <option selected disabled>Seleccione...</option>
                        <c:forEach var="emp" items="${empleadosEspecializados}">
                            <option value="${emp.empId}" data-sueldo="${emp.empSal}">
                                ${emp.empNom} ${emp.empApe} (${emp.especialidad})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Periodo -->
                <div class="col-md-4">
                    <label class="form-label">Periodo de Pago</label>
                    <select class="form-select" name="per_id" required>
                        <option selected disabled>Seleccione...</option>
                        <c:forEach var="per" items="${periodos}">
                            <option value="${per.perId}">${per.perNom}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Bono (opcional)</label>
                    <select class="form-select" name="bono_id" id="bonoSelect">
                        <option selected value="">Ninguno</option>
                        <c:forEach var="bono" items="${bonos}">
                            <option value="${bono.bonoId}" data-monto="${bono.bonoCan}">${bono.bonoNom}</option>
                        </c:forEach>
                    </select>
                    <!-- Campo oculto para el monto del bono -->
                    <input type="hidden" name="bono_can" id="bonoCan" value="0">
                </div>

                <!-- Monto Total (sueldo base + bono) -->
                <div class="col-md-4">
                    <label class="form-label">Monto Total</label>
                    <input id="montoTotal" type="number" step="0.01" min="0" class="form-control" name="detp_mon" required >
                </div>

                <!-- Descuento Total -->
                <div class="col-md-4">
                    <label class="form-label">Descuento Total</label>
                    <input id="descuentoTotal" type="number" step="0.01" min="0" class="form-control" name="descuento_total" value="0" required>
                </div>

                <!-- Sueldo Neto -->
                <div class="col-md-4">
                    <label class="form-label">Sueldo Neto</label>
                    <input id="sueldoNeto" type="number" step="0.01" min="0" class="form-control" name="sueldo_neto" required >
                </div>

                <!-- Botones -->
                <div class="col-12 d-flex justify-content-end gap-2">
                    <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">Cancelar</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save"></i> Guardar Pago
                    </button>
                </div>
            </form>
        </div>

        <!-- Tabla de pagos con scroll -->
        <div class="table-responsive table-scroll">
            <c:choose>
                <c:when test="${empty pagos}">
                    <div class="alert alert-warning text-center">
                        <i class="bi bi-exclamation-circle"></i> No se encontraron pagos registrados.
                    </div>
                </c:when>
                <c:otherwise>
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
                            <c:forEach var="pago" items="${pagos}">
                                <tr>
                                    <td>${pago.empleadoNombre}</td>
                                    <td>${pago.periodoNombre}</td>
                                    <td><strong>S/. ${pago.sueldoNeto}</strong></td>
                                    <td>
                                        <button class="btn btn-sm btn-info">
                                            <i class="bi bi-eye"></i> Ver
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const empSelect = document.getElementById('empSelect');
    const bonoSelect = document.getElementById('bonoSelect');
    const montoInput = document.getElementById('montoTotal');
    const descuentoInput = document.getElementById('descuentoTotal');
    const sueldoNetoInput = document.getElementById('sueldoNeto');
    const bonoCanInput = document.getElementById('bonoCan');

    let sueldoBase = 0;
    let bonoMonto = 0;

    // Función para recalcular el sueldo neto
    function recalcularSueldoNeto() {
        const descuento = parseFloat(descuentoInput.value) || 0;
        // Sueldo Neto: Sueldo Base + Bono - Descuento
        const sueldoNeto = (sueldoBase + bonoMonto) - descuento;
        sueldoNetoInput.value = sueldoNeto.toFixed(2);
    }

    // Al cambiar el empleado, actualizamos el sueldo base
    empSelect.addEventListener('change', function () {
        const selectedOption = this.options[this.selectedIndex];
        sueldoBase = parseFloat(selectedOption.getAttribute('data-sueldo')) || 0;
        // Monto Total solo toma el Sueldo Base
        montoInput.value = sueldoBase.toFixed(2);
        recalcularSueldoNeto();
    });

    // Al cambiar el bono, actualizamos el monto total y sueldo neto
    bonoSelect.addEventListener('change', function () {
        const bonoId = this.value;
        if (!bonoId) {
            bonoMonto = 0;  // Si no se selecciona bono, el monto es 0
        } else {
            const selectedOption = this.options[this.selectedIndex];
            const bonoMontoData = selectedOption.getAttribute('data-monto');
            if (bonoMontoData) {
                bonoMonto = parseFloat(bonoMontoData);
            }
        }
        bonoCanInput.value = bonoMonto.toFixed(2);
        recalcularSueldoNeto();
    });

    // Al cambiar el descuento, recalculamos el sueldo neto
    descuentoInput.addEventListener('input', function () {
        recalcularSueldoNeto();
    });
});



// Funciones para mostrar/ocultar formulario
function mostrarFormulario() {
    document.getElementById('form-nuevo-pago').classList.remove('d-none');
}

function ocultarFormulario() {
    document.getElementById('form-nuevo-pago').classList.add('d-none');
}

</script>

</body>
</html>
