<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    grupo7.dentalogic.model.Usuario usuario = (grupo7.dentalogic.model.Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard | DentalLogic</title>

        <!-- Favicon -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="assets/css/dashboard.css">

        <!-- Font Awesome para íconos adicionales -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="/components/routes/sidebar.jsp" />

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid py-4">
                <!-- Tarjetas de Métricas -->
                <div class="row g-4 mb-4">
                    <!-- Tarjeta de Empleados -->
                    <div class="col-md-6 col-lg-4 col-xl-3">
                        <div class="metric-card card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="metric-icon bg-primary">
                                        <i class="bi bi-people-fill"></i>
                                    </div>
                                    <div class="text-end">
                                        <h6 class="metric-title">Empleados</h6>
                                        <h3 class="metric-value">${dashboard.totalEmpleados}</h3>
                                    </div>
                                </div>
                                <div class="metric-footer mt-2">
                                    <small class="text-muted">Total registrados</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tarjeta de Asistencias -->
                    <div class="col-md-6 col-lg-4 col-xl-3">
                        <div class="metric-card card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="metric-icon bg-success">
                                        <i class="bi bi-calendar-check"></i>
                                    </div>
                                    <div class="text-end">
                                        <h6 class="metric-title">Asistencias</h6>
                                        <h3 class="metric-value">${dashboard.totalAsistenciasMes}</h3>
                                    </div>
                                </div>
                                <div class="metric-footer mt-2">
                                    <small class="text-muted">Este mes</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tarjeta de Tardanzas -->
                    <div class="col-md-6 col-lg-4 col-xl-3">
                        <div class="metric-card card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="metric-icon bg-warning">
                                        <i class="bi bi-clock-history"></i>
                                    </div>
                                    <div class="text-end">
                                        <h6 class="metric-title">Tardanzas</h6>
                                        <h3 class="metric-value">${dashboard.totalTardanzasMes}</h3>
                                    </div>
                                </div>
                                <div class="metric-footer mt-2">
                                    <small class="text-muted">Este mes</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tarjeta de Justificativos -->
                    <div class="col-md-6 col-lg-4 col-xl-3">
                        <div class="metric-card card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="metric-icon bg-info">
                                        <i class="bi bi-file-earmark-text"></i>
                                    </div>
                                    <div class="text-end">
                                        <h6 class="metric-title">Justificativos</h6>
                                        <h3 class="metric-value">${dashboard.totalJustificativosMes}</h3>
                                    </div>
                                </div>
                                <div class="metric-footer mt-2">
                                    <small class="text-muted">Este mes</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Gráficos y Datos Adicionales -->
                <div class="row g-1">
                    <!-- Gráfico de Especialidades -->
                    <div class="col-lg-8">
                        <div class="card chart-card h-85">
                            <div class="card-header">
                                <h5 class="card-title">
                                    <i class="bi bi-pie-chart-fill me-2"></i>Distribución de Empleados por Especialidad
                                </h5>
                            </div>
                            <div class="card-body">
                                <canvas id="especialidadesChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Últimos Registros -->
                    <div class="col-lg-4">
                        <div class="card h-100">
                            <div class="card-header">
                                <h5 class="card-title">
                                    <i class="bi bi-clock-history me-2"></i>Actividad Reciente
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="list-group list-group-flush">
                                    <div class="list-group-item">
                                        <div class="d-flex w-100 justify-content-between">
                                            <small class="text-muted">Hoy, 10:45 AM</small>
                                        </div>
                                        <p class="mb-1">Nuevo registro de asistencia</p>
                                    </div>
                                    <div class="list-group-item">
                                        <div class="d-flex w-100 justify-content-between">
                                            <small class="text-muted">Ayer, 4:30 PM</small>
                                        </div>
                                        <p class="mb-1">Justificativo aprobado</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </main>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="assets/js/bootstrap.bundle.min.js"></script>

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Custom JS -->
    <script src="assets/js/dashboard.js"></script>

    <!-- Script para el gráfico -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const ctx = document.getElementById('especialidadesChart').getContext('2d');
            const labels = [
        <c:forEach items="${dashboard.empleadosPorEspecialidad}" var="entry">
                '${entry.key}',
        </c:forEach>
            ];
            const data = [
        <c:forEach items="${dashboard.empleadosPorEspecialidad}" var="entry">
            ${entry.value},
        </c:forEach>
            ];

            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                            data: data,
                            backgroundColor: [
                                '#4e73df',
                                '#1cc88a',
                                '#36b9cc',
                                '#f6c23e',
                                '#e74a3b',
                                '#858796'
                            ],
                            hoverBackgroundColor: [
                                '#2e59d9',
                                '#17a673',
                                '#2c9faf',
                                '#dda20a',
                                '#be2617',
                                '#6c757d'
                            ],
                            hoverBorderColor: "rgba(234, 236, 244, 1)",
                        }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'right',
                            labels: {
                                usePointStyle: true,
                                padding: 20
                            }
                        },
                        tooltip: {
                            backgroundColor: "rgb(255,255,255)",
                            bodyColor: "#858796",
                            borderColor: '#dddfeb',
                            borderWidth: 1,
                            padding: 15,
                            displayColors: true,
                            caretPadding: 10,
                            callbacks: {
                                label: function (context) {
                                    const label = context.label || '';
                                    const value = context.raw || 0;
                                    const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                    const percentage = Math.round((value / total) * 100);
                                    return `${label}: ${value} (${percentage}%)`;
                                }
                            }
                        }
                    },
                    cutout: '70%'
                }
            });
        });
    </script>
</body>
</html>
