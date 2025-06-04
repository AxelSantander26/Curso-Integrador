<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Generar Asistencias</title>
</head>
<body>
    <h2>Generar Asistencias del Mes</h2>
    <form action="generar-asistencias" method="post">
        A�o: <input type="number" name="year" value="2025" required><br>
        Mes (1-12): <input type="number" name="month" value="6" required><br>
        <input type="submit" value="Generar">
    </form>
</body>
</html>
