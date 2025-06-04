<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String asisId = request.getParameter("asis_id");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Registro de Asistencia</title>
</head>
<body>
    <h2>Registro de Asistencia</h2>
    <p id="horaActual"></p>

    <form action="RegistrarAsistenciaServlet" method="post" id="formAsistencia">
        <input type="hidden" name="asis_id" value="<%= asisId %>">
        <label>ID Empleado:</label>
        <input type="number" name="emp_id" required>
        <input type="hidden" name="hora_llegada" id="hora_llegada">
        <input type="submit" value="Registrar Asistencia">
    </form>

    <script>
        function actualizarHora() {
            const ahora = new Date();
            const horaTexto = ahora.toLocaleTimeString('es-PE');
            document.getElementById("horaActual").textContent = "Hora actual: " + horaTexto;
            document.getElementById("hora_llegada").value = ahora.toTimeString().split(' ')[0]; // formato HH:mm:ss
        }
        setInterval(actualizarHora, 1000);
        actualizarHora();
    </script>
</body>
</html>
