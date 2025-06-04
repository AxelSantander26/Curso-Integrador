<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Listado de Asistencias</title>
</head>
<body>
    <h1>Listado de Asistencias</h1>

    <c:if test="${param.success == 'true'}">
        <p style="color: green;">Días hábiles generados exitosamente.</p>
    </c:if>
    <c:if test="${param.error == 'true'}">
        <p style="color: red;">Error al generar los días hábiles.</p>
    </c:if>

    <!-- Aquí podrías mostrar una tabla con asistencias o un botón para volver -->
</body>
</html>
