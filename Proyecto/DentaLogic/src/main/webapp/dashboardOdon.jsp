<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalTime, java.time.format.DateTimeFormatter" %>

<%! 
    public String formatTo12Hour(String hora) {
        try {
            LocalTime time = LocalTime.parse(hora);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a");
            return time.format(formatter);
        } catch (Exception e) {
            return "-";
        }
    }
%>

<html>
    <head>
        <title>Control de Asistencia</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary: #343a40;
                --success: #28a745;
                --warning: #ffc107;
                --danger: #dc3545;
                --info: #17a2b8;
                --light: #f8f9fa;
                --dark: #343a40;
                --gray: #6c757d;
                --white: #ffffff;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: #f8f9fa;
                color: #212529;
                line-height: 1.6;
                padding: 0;
                margin: 0;
                min-height: 100vh;
            }

            .nav {
                display: flex;
                justify-content: flex-end;
                padding: 1rem;
                background: transparent;
            }

            .nav-link {
                color: #495057;
                text-decoration: none;
                font-size: 0.9rem;
                transition: color 0.3s;
            }

            .nav-link:hover {
                color: var(--primary);
                text-decoration: underline;
            }

            .nav-link i {
                margin-right: 6px;
            }

            .dashboard {
                width: 100%;
                max-width: 800px;
                padding: 2rem;
                margin: 0 auto;
            }

            .card {
                background: var(--white);
                border-radius: 8px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
                padding: 2rem;
                margin-bottom: 1.5rem;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .card-title {
                font-size: 1.5rem;
                font-weight: 500;
                color: var(--dark);
            }

            .real-time-clock {
                font-size: 1.2rem;
                font-weight: 400;
                color: #495057;
                letter-spacing: 1px;
                display: inline-flex;
                align-items: center;
            }

            .real-time-clock i {
                margin-right: 8px;
                font-size: 1rem;
            }

            .tabs {
                display: flex;
                border-bottom: 1px solid #e9ecef;
                margin-bottom: 1.5rem;
            }

            .tab {
                padding: 0.75rem 1.5rem;
                cursor: pointer;
                font-weight: 500;
                color: var(--gray);
                position: relative;
                transition: all 0.3s;
            }

            .tab.active {
                color: var(--primary);
            }

            .tab.active:after {
                content: '';
                position: absolute;
                bottom: -1px;
                left: 0;
                width: 100%;
                height: 2px;
                background: var(--primary);
            }

            .tab-content {
                display: none;
            }

            .tab-content.active {
                display: block;
                animation: fadeIn 0.3s;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .status-section {
                padding: 1.25rem;
                background: var(--light);
                border-radius: 6px;
                margin-bottom: 1.5rem;
                border: 1px solid #e9ecef;
            }

            .status-title {
                font-size: 1.1rem;
                font-weight: 500;
                margin-bottom: 0.75rem;
                color: var(--dark);
                display: flex;
                align-items: center;
            }

            .status-title i {
                margin-right: 10px;
                font-size: 1rem;
            }

            .status-detail {
                display: flex;
                justify-content: space-between;
                margin-bottom: 0.8rem;
            }

            .status-label {
                font-weight: 500;
                color: var(--gray);
            }

            .status-value {
                font-weight: 400;
                color: #212529;
            }

            .status-badge {
                font-weight: 600;
                padding: 0.3rem 0.6rem;
                border-radius: 1rem;
                font-size: 0.9rem;
                display: inline-flex;
                align-items: center;
                margin-top: 0.5rem;
            }

            .status-badge i {
                margin-right: 6px;
            }

            .status-success {
                background-color: #e6f7ee;
                color: var(--success);
            }
            .status-warning {
                background-color: #fff3cd;
                color: var(--warning);
            }
            .status-info {
                background-color: rgba(23, 162, 184, 0.1);
                color: var(--info);
            }
            .status-muted {
                background-color: rgba(108, 117, 125, 0.1);
                color: var(--gray);
            }

            .btn {
                display: inline-block;
                padding: 0.75rem;
                border: none;
                border-radius: 6px;
                font-weight: 500;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s ease;
                text-align: center;
                text-decoration: none;
            }

            .btn-primary {
                background-color: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background-color: #495057;
                transform: translateY(-2px);
            }

            .btn-block {
                display: block;
                width: 100%;
                max-width: 300px;
                margin: 1.5rem auto;
            }

            .message {
                padding: 0.75rem;
                border-radius: 6px;
                margin: 1rem 0;
                text-align: center;
                font-size: 0.9rem;
            }

            .message-success {
                background-color: #e6f7ee;
                color: var(--success);
                border: 1px solid #c3e6cb;
            }

            .message-info {
                background-color: rgba(23, 162, 184, 0.1);
                color: var(--info);
                border: 1px solid rgba(23, 162, 184, 0.2);
            }

            @media (max-width: 768px) {
                .dashboard {
                    padding: 1rem;
                }

                .card {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <nav class="nav">
            <a href="cerrar-sesion" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Cerrar sesión
            </a>
        </nav>

        <div class="dashboard">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title">Control de Asistencia</h1>
                    <div class="real-time-clock">
                        <i class="fas fa-clock"></i>
                        <span id="currentTime"></span>
                    </div>
                </div>

                <!-- Pestañas -->
                <div class="tabs">
                    <div class="tab ${not yaMarcadaEntrada ? 'active' : ''}" id="tabEntrada">
                        <i class="fas fa-sign-in-alt"></i> Entrada
                    </div>
                    <div class="tab ${yaMarcadaEntrada ? 'active' : ''}" id="tabSalida">
                        <i class="fas fa-sign-out-alt"></i> Salida
                    </div>
                </div>

                <!-- Contenido de pestañas -->
                <div class="tab-content ${not yaMarcadaEntrada ? 'active' : ''}" id="contentEntrada">
                    <div class="status-section">
                        <h3 class="status-title"><i class="fas fa-clock"></i> Información de Entrada</h3>

                        <div class="status-detail">
                            <span class="status-label">Hora Establecida:</span>
                            <span class="status-value">
                                <%= formatTo12Hour(request.getAttribute("horaEntradaEstablecida") != null ? request.getAttribute("horaEntradaEstablecida").toString() : "") %>
                            </span>
                        </div>

                        <c:choose>
                            <c:when test="${yaMarcadaEntrada}">
                                <div class="status-detail">
                                    <span class="status-label">Hora Marcada:</span>
                                    <span class="status-value">
                                        <%= formatTo12Hour(request.getAttribute("horaMarcadaEntrada") != null ? request.getAttribute("horaMarcadaEntrada").toString() : "") %>
                                    </span>
                                </div>
                                <c:choose>
                                    <c:when test="${estadoEntrada == 'PUNTUAL'}">
                                        <span class="status-badge status-success"><i class="fas fa-check"></i> Puntual</span>
                                    </c:when>
                                    <c:when test="${estadoEntrada == 'TARDANZA'}">
                                        <span class="status-badge status-warning"><i class="fas fa-exclamation"></i> Tardanza</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-muted"><i class="fas fa-minus"></i> -</span>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-muted"><i class="far fa-clock"></i> No marcada aún</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Botón de entrada -->
                    <c:if test="${not yaMarcadaEntrada}">
                        <form action="marcacion" method="post">
                            <button type="submit" class="btn btn-primary btn-block">
                                <i class="fas fa-fingerprint"></i> Marcar Entrada
                            </button>
                        </form>
                    </c:if>
                </div>

                <div class="tab-content ${yaMarcadaEntrada ? 'active' : ''}" id="contentSalida">
                    <div class="status-section">
                        <h3 class="status-title"><i class="fas fa-clock"></i> Información de Salida</h3>

                        <div class="status-detail">
                            <span class="status-label">Hora Establecida:</span>
                            <span class="status-value">
                                <%= formatTo12Hour(request.getAttribute("horaSalidaEstablecida") != null ? request.getAttribute("horaSalidaEstablecida").toString() : "") %>
                            </span>

                        </div>

                        <c:choose>
                            <c:when test="${yaMarcadaSalida}">
                                <div class="status-detail">
                                    <span class="status-label">Hora Marcada:</span>
                                    <span class="status-value">
                                        <%= formatTo12Hour(request.getAttribute("horaMarcadaSalida") != null ? request.getAttribute("horaMarcadaSalida").toString() : "") %>
                                    </span>
                                </div>
                                <c:choose>
                                    <c:when test="${estadoSalida == 'NORMAL'}">
                                        <span class="status-badge status-success"><i class="fas fa-check"></i> Normal</span>
                                    </c:when>
                                    <c:when test="${estadoSalida == 'ANTICIPADA'}">
                                        <span class="status-badge status-info"><i class="fas fa-arrow-left"></i> Anticipada</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-muted"><i class="fas fa-minus"></i> -</span>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-muted"><i class="far fa-clock"></i> No marcada aún</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Botón de salida -->
                    <c:if test="${yaMarcadaEntrada and not yaMarcadaSalida}">
                        <form action="marcacion" method="post">
                            <button type="submit" class="btn btn-primary btn-block">
                                <i class="fas fa-fingerprint"></i> Marcar Salida
                            </button>
                        </form>
                    </c:if>
                </div>

                <!-- Mensaje -->
                <c:if test="${not empty mensaje}">
                    <div class="message ${mensajeTipo == 'success' ? 'message-success' : 'message-info'}">
                        <i class="fas ${mensajeTipo == 'success' ? 'fa-check-circle' : 'fa-info-circle'}"></i>
                        ${mensaje}
                    </div>
                </c:if>

                <!-- Mensaje cuando ya está todo marcado -->
                <c:if test="${yaMarcadaEntrada and yaMarcadaSalida}">
                    <div class="status-badge status-muted" style="margin-top: 1.5rem;">
                        <i class="fas fa-check-circle"></i> Ya completaste tu marcación hoy
                    </div>
                </c:if>
            </div>
        </div>

        <script>
            // Reloj en tiempo real (funcional)
            function updateClock() {
                const options = {
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: true
                };
                document.getElementById('currentTime').textContent =
                        new Date().toLocaleTimeString('es-ES', options);
                setTimeout(updateClock, 1000);
            }

            // Control de pestañas
            document.addEventListener('DOMContentLoaded', function () {
                updateClock();

                const tabEntrada = document.getElementById('tabEntrada');
                const tabSalida = document.getElementById('tabSalida');
                const contentEntrada = document.getElementById('contentEntrada');
                const contentSalida = document.getElementById('contentSalida');

                tabEntrada.addEventListener('click', function () {
                    tabEntrada.classList.add('active');
                    tabSalida.classList.remove('active');
                    contentEntrada.classList.add('active');
                    contentSalida.classList.remove('active');
                });

                tabSalida.addEventListener('click', function () {
                    tabSalida.classList.add('active');
                    tabEntrada.classList.remove('active');
                    contentSalida.classList.add('active');
                    contentEntrada.classList.remove('active');
                });

                // Mostrar la pestaña adecuada según el estado
            <c:if test="${yaMarcadaEntrada}">
                tabEntrada.classList.remove('active');
                tabSalida.classList.add('active');
                contentEntrada.classList.remove('active');
                contentSalida.classList.add('active');
            </c:if>
            });
        </script>
    </body>
</html>