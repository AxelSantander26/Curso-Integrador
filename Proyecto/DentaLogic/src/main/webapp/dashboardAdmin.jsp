<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    grupo7.dentalogic.model.Usuario usuario = (grupo7.dentalogic.model.Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="assets/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<jsp:include page="/components/routes/sidebar.jsp" />

<div class="content-wrapper">
    <div class="container-fluid">

        <!-- Tarjetas de resumen -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="card p-3">
                    <h5><i class="bi bi-person-vcard me-2"></i> Empleados</h5>
                    <p class="fs-4">25</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <h5><i class="bi bi-cash-coin me-2"></i> Bonos</h5>
                    <p class="fs-4">10</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <h5><i class="bi bi-calendar-check me-2"></i> Asistencias Hoy</h5>
                    <p class="fs-4">18</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <h5><i class="bi bi-wallet2 me-2"></i> Total a Pagar</h5>
                    <p class="fs-4">S/ 12,500.75</p>
                </div>
            </div>
        </div>

        <!-- Gráficos -->
        <div class="row g-4 mb-4">
            <div class="col-md-6">
                <div class="card p-3">
                    <h5 class="mb-3"><i class="bi bi-bar-chart-line me-2"></i> Asistencias por Semana</h5>
                    <canvas id="attendanceChart"></canvas>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card p-3">
                    <h5 class="mb-3"><i class="bi bi-bar-chart-line me-2"></i> Total a Pagar por Periodo</h5>
                    <canvas id="paymentsChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts de gráficos -->
<script>
    const ctxAttendance = document.getElementById('attendanceChart').getContext('2d');
    new Chart(ctxAttendance, {
        type: 'line',
        data: {
            labels: ['Semana 1', 'Semana 2', 'Semana 3', 'Semana 4'],
            datasets: [{
                label: 'Asistencias',
                data: [40, 55, 50, 60],
                backgroundColor: 'rgba(0,123,255,0.2)',
                borderColor: 'rgba(0,123,255,1)',
                borderWidth: 2
            }]
        }
    });

    const ctxPayments = document.getElementById('paymentsChart').getContext('2d');
    new Chart(ctxPayments, {
        type: 'bar',
        data: {
            labels: ['Enero', 'Febrero', 'Marzo', 'Abril'],
            datasets: [{
                label: 'Total a Pagar',
                data: [12000, 15000, 13000, 18000],
                backgroundColor: 'rgba(40,167,69,0.5)',
                borderColor: 'rgba(40,167,69,1)',
                borderWidth: 1
            }]
        }
    });
</script>
