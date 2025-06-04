<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clínica Dental CABES</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
         :root {
                --sidebar-bg: #19414b;
                --accent-color: #1e8e67;
                --card-bg: #ffffff;
                --header-height: 60px;
            }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e0f7fa, #ffffff);
            margin: 0;
        }

       
            header {
                height: var(--header-height);
                background-color: var(--sidebar-bg);
                color: white;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 30px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            }

            header h1 {
                font-size: 20px;
                margin: 0;
            }

        .container {
            margin-top: 40px;
            display: flex;
            justify-content: center;
        }

        .card {
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 500px;
            background-color: #fff;
        }

        .info-table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
        }

        .info-table th {
            text-align: left;
            padding: 8px;
            background-color: #e0f2f1;
            width: 30%;
        }

        .info-table td {
            padding: 8px;
        }

        button {
            padding: 12px 24px;
            background-color: #00796b;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #004d40;
        }

        .timestamp {
            margin-top: 10px;
            color: #004d40;
        }

        
            .modal {
                display: none;
                position: fixed;
                z-index: 999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
                justify-content: center;
                align-items: center;
            }

            .modal-content {
                background-color: white;
                padding: 30px 40px;
                border-radius: 15px;
                text-align: center;
                max-width: 400px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            }

            .modal-content h3 {
                color: #19414b;
            }

            .modal-content p {
                margin-top: 10px;
                color: #333;
            }

            .modal-content button {
                background-color: #19414b;
            }
    </style>
</head>
<body>
  <header>
    <h1>Clínica Dental CABES</h1>

    <div class="dropdown d-flex align-items-center" style="gap: 12px;">
        <div class="text-end">
            <p class="mb-0">Hola, <strong>${usuario.nombre} ${usuario.apellido}</strong></p>
            <p class="user-role mb-0" style="font-size: 0.85rem;">${usuario.rol}</p>
        </div>

        <button class="btn btn-link text-white p-0 dropdown-toggle" type="button" id="userDropdown"
                data-bs-toggle="dropdown" aria-expanded="false" style="line-height: 1;">
            <i class="bi bi-chevron-down" style="font-size: 1rem;"></i>
        </button>

        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
            <li>
                <a class="dropdown-item" href="logout">
                    <i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión
                </a>
            </li>
        </ul>
    </div>
</header>

<!-- ✅ CORREGIDO: usar idEmpleado -->
<input type="hidden" id="empId" value="${usuario.idEmpleado}">

<div class="container">
    <div class="card">
        <h2>Bienvenido, Dr. ${usuario.nombre} ${usuario.apellido}</h2>
        <p>Registre su asistencia antes de comenzar la atención a los pacientes.</p>

        <table class="info-table">
            <tr>
                <th>Servicio</th>
                <td>Consulta General</td>
            </tr>
            <tr>
                <th>Turno</th>
                <td>10:30 a 12:00</td>
            </tr>
            <tr>
                <th>Fecha</th>
                <td id="fechaActual"></td>
            </tr>
        </table>

        <button onclick="registrarAsistencia()">Registrar asistencia</button>
        <div class="timestamp" id="horaActual"></div>
    </div>
</div>

<!-- Modal -->
<div class="modal" id="modal">
    <div class="modal-content">
        <h3>✔ Asistencia registrada</h3>
        <p id="horaRegistro"></p>
        <button onclick="cerrarModal()">Aceptar</button>
    </div>
</div>

<!-- ✅ Script completo -->
<script>
    function actualizarHora() {
        const ahora = new Date();
        const horaTexto = ahora.toLocaleTimeString('es-PE');
        const fechaTexto = ahora.toLocaleDateString('es-PE');
        document.getElementById("horaActual").textContent = "Hora actual: " + horaTexto;
        document.getElementById("fechaActual").textContent = fechaTexto;
    }

    setInterval(actualizarHora, 1000);
    actualizarHora();

    function registrarAsistencia() {
        const empId = document.getElementById("empId").value;

        fetch("registrar-asistencia", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "emp_id=" + empId
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "ok") {
                const hora = new Date().toLocaleTimeString('es-PE');
                document.getElementById("horaRegistro").textContent = "Hora registrada: " + hora;
                document.getElementById("modal").style.display = "flex";
            } else {
                alert("Error al registrar asistencia.");
            }
        });
    }

    function cerrarModal() {
        document.getElementById("modal").style.display = "none";
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
