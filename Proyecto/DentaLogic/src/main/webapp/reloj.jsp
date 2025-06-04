<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Prueba de Reloj en JSP</title>
</head>
<body>
    <h2 id="hora"></h2>

    <script>
        function actualizarHora() {
            const ahora = new Date();
            document.getElementById("hora").textContent = ahora.toLocaleTimeString('es-PE');
        }

        setInterval(actualizarHora, 1000);
        actualizarHora();
    </script>
</body>
</html>
