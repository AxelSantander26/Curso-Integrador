<%@ page import="grupo7.dentalogic.model.DashboardInfo" %>
<%
    DashboardInfo dashboardInfo = (DashboardInfo) request.getAttribute("dashboardInfo");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dashboard - DentaLogic</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body class="bg-light">
        <!-- Incluyendo el sidebar y navbar -->
        <jsp:include page="components/sidebar-navbar.jsp"/>

        <!-- Contenido principal -->
        <main class="main-content">
            <div class="content-wrapper">
                <!-- Panel Principal -->
                <div id="dashboard">
                    
                    <!-- Tarjetas con datos -->
                    <div class="row g-4 mb-4">
                        <!-- Empleados Registrados -->
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h5><i class="bi bi-person-vcard me-2"></i> Empleados</h5>
                                <p class="fs-4"><%= dashboardInfo.getTotalEmpleados() %></p>
                            </div>
                        </div>

                        <!-- Bonos Activos -->
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h5><i class="bi bi-cash-coin me-2"></i> Bonos</h5>
                                <p class="fs-4"><%= dashboardInfo.getTotalBonos() %></p>
                            </div>
                        </div>

                        <!-- Asistencias Registradas Hoy -->
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h5><i class="bi bi-calendar-check me-2"></i> Asistencias Hoy</h5>
                                <p class="fs-4"><%= dashboardInfo.getAsistenciasHoy() %></p>
                            </div>
                        </div>

                        <!-- Total a Pagar -->
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h5><i class="bi bi-cash-coin me-2"></i> Total a Pagar</h5>
                                <p class="fs-4">S/ <%= String.format("%.2f", dashboardInfo.getTotalPagar()) %></p>
                            </div>
                        </div>
                    </div>

                    <!-- Gráficos -->
                    <div class="row g-4 mb-4">
                        <!-- Gráfico de Asistencias por Semana -->
                        <div class="col-md-6">
                            <div class="card p-3">
                                <h5 class="mb-3"><i class="bi bi-bar-chart-line me-2"></i> Asistencias por Semana</h5>
                                <canvas id="attendanceChart"></canvas>
                            </div>
                        </div>

                        <!-- Gráfico de Total a Pagar por Periodo -->
                        <div class="col-md-6">
                            <div class="card p-3">
                                <h5 class="mb-3"><i class="bi bi-bar-chart-line me-2"></i> Total a Pagar por Periodo</h5>
                                <canvas id="paymentsChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Scripts de gráficos -->
        <script>
            // Gráfico de Asistencias por Semana (Ejemplo)
            const ctxAttendance = document.getElementById('attendanceChart').getContext('2d');
            new Chart(ctxAttendance, {
                type: 'line',
                data: {
                    labels: ['Semana 1', 'Semana 2', 'Semana 3', 'Semana 4'],
                    datasets: [{
                        label: 'Asistencias',
                        data: [40, 55, 50, 60],
                        fill: true
                    }]
                }
            });

            // Gráfico de Total a Pagar por Periodo (Ejemplo)
            const ctxPayments = document.getElementById('paymentsChart').getContext('2d');
            new Chart(ctxPayments, {
                type: 'bar',
                data: {
                    labels: ['Enero', 'Febrero', 'Marzo', 'Abril'],
                    datasets: [{
                        label: 'Total a Pagar',
                        data: [12000, 15000, 13000, 18000],
                        borderWidth: 1
                    }]
                }
            });
        </script>
    </body>
</html>
