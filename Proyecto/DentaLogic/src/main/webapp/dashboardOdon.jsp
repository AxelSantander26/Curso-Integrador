<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Control de Asistencia</title>
    <style>
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            line-height: 1.5;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #212529;
        }
        .container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        h1 {
            font-weight: 500;
            margin-bottom: 1.5rem;
            text-align: center;
            color: #343a40;
        }
        .clock-container {
            text-align: center;
            margin: 1.5rem 0;
        }
        .current-time {
            font-size: 1.4rem;
            font-weight: 400;
            color: #495057;
            letter-spacing: 1px;
        }
        .time-section {
            margin-bottom: 1.8rem;
        }
        .time-section h2 {
            font-size: 1.1rem;
            font-weight: 500;
            color: #495057;
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
        }
        .time-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.8rem;
        }
        .time-label {
            font-weight: 500;
            color: #6c757d;
        }
        .time-value {
            font-weight: 400;
            color: #212529;
        }
        .attendance-status {
            padding: 1rem;
            border-radius: 6px;
            margin: 2rem 0;
            text-align: center;
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
        }
        .btn {
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 1.5rem auto;
            padding: 0.75rem;
            background-color: #343a40;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn:hover {
            background-color: #495057;
        }
        .btn:disabled {
            background-color: #e9ecef;
            color: #adb5bd;
            cursor: not-allowed;
        }
        .message {
            padding: 0.75rem;
            border-radius: 6px;
            margin: 1rem 0;
            text-align: center;
            font-size: 0.9rem;
        }
        .success {
            background-color: #e6f7ee;
            color: #28a745;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #fae8e8;
            color: #dc3545;
            border: 1px solid #f5c6cb;
        }
        .warning {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }
        .status-badge {
            padding: 0.3rem 0.6rem;
            border-radius: 1rem;
            font-size: 0.9rem;
            display: inline-block;
            margin-left: 0.5rem;
        }
        .status-success {
            background-color: #e6f7ee;
            color: #28a745;
        }
        .status-warning {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-danger {
            background-color: #fae8e8;
            color: #dc3545;
        }
        .nav {
            display: flex;
            justify-content: flex-end;
            padding: 1rem;
        }
        .nav-link {
            color: #495057;
            text-decoration: none;
            font-size: 0.9rem;
        }
        .nav-link:hover {
            text-decoration: underline;
        }
        .spinner-border {
            vertical-align: text-top;
            width: 1rem;
            height: 1rem;
            border-width: 0.15em;
        }
    </style>
</head>
<body>
    <nav class="nav">
        <a href="logout" class="nav-link">Cerrar sesión</a>
    </nav>

    <div class="container">
        <h1>Bienvenido, ${usuario.nombre} ${usuario.apellido}</h1>
        
        <div class="clock-container">
            <div class="current-time" id="currentTime"></div>
        </div>
        
        <%!
            public String formatTo12Hour(String time24) {
                if (time24 == null || time24.isEmpty() || time24.equals("null")) return "--:--";
                try {
                    String[] parts = time24.split(":");
                    int hour = Integer.parseInt(parts[0]);
                    int minute = parts.length > 1 ? Integer.parseInt(parts[1]) : 0;
                    String period = (hour >= 12) ? "PM" : "AM";
                    if (hour == 0) hour = 12;
                    else if (hour > 12) hour -= 12;
                    return String.format("%d:%02d %s", hour, minute, period);
                } catch (Exception e) {
                    return time24;
                }
            }
        %>
        
        <div class="time-section">
            <h2>Horario programado</h2>
            <div class="time-info">
                <span class="time-label">Hora de entrada:</span>
                <span class="time-value"><%= formatTo12Hour(request.getAttribute("horaEntradaEstablecida") != null ? request.getAttribute("horaEntradaEstablecida").toString() : "") %></span>
            </div>
        </div>
        
        <div class="time-section">
            <h2>Registro de hoy</h2>
            <div class="time-info">
                <span class="time-label">Hora marcada:</span>
                <span class="time-value">
                    <c:choose>
                        <c:when test="${yaMarcada}">
                            <%= formatTo12Hour(request.getAttribute("horaMarcada") != null ? request.getAttribute("horaMarcada").toString() : "") %>
                        </c:when>
                        <c:otherwise>
                            Pendiente
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
        
        <c:if test="${yaMarcada}">
            <div class="attendance-status">
                <strong>Estado:</strong> 
                <c:choose>
                    <c:when test="${estadoAsistencia == 'Puntual'}">
                        <span class="status-badge status-success">✓ Puntual</span>
                    </c:when>
                    <c:when test="${estadoAsistencia == 'Tardanza'}">
                        <span class="status-badge status-warning">⌛ Tardanza</span>
                    </c:when>
                    <c:when test="${estadoAsistencia == 'Ausente'}">
                        <span class="status-badge status-danger">✗ Ausente</span>
                    </c:when>
                    <c:otherwise>
                        ${estadoAsistencia}
                    </c:otherwise>
                </c:choose>
                <br>Asistencia registrada
            </div>
        </c:if>
        
        <c:if test="${tiempoRestante != null && tiempoRestante < 15 && tiempoRestante > 0 && !yaMarcada}">
            <div class="message warning">
                ⚠ Atención: Tienes menos de ${tiempoRestante} minutos para marcar a tiempo
            </div>
        </c:if>
        
        <c:if test="${not yaMarcada}">
            <form method="post" action="dashboardOdon" id="asistenciaForm">
                <button type="submit" class="btn" id="submitBtn">
                    Registrar mi asistencia
                </button>
            </form>
        </c:if>
        
        <c:if test="${not empty mensaje}">
            <div class="message ${mensaje.contains('éxito') ? 'success' : 'error'}">
                ${mensaje}
            </div>
        </c:if>
    </div>

    <script>
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
        
        document.getElementById('asistenciaForm')?.addEventListener('submit', function(e) {
            const btn = document.getElementById('submitBtn');
            if(btn) {
                btn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Procesando...';
                btn.disabled = true;
            }
        });
        
        window.addEventListener('load', updateClock);
    </script>
</body>
</html>