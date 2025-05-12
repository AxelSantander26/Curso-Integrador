<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>CABES - Registro de Asistencia</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            :root {
                --sidebar-bg: #19414b;
                --accent-color: #1e8e67;
                --card-bg: #ffffff;
                --header-height: 60px;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #f1f4f3;
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
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: calc(100vh - var(--header-height));
                padding: 30px;
            }

            .card {
                background-color: var(--card-bg);
                padding: 50px;
                /* border-radius: 20px; */
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                max-width: 900px;
                width: 100%;
                text-align: center;
            }

            .card h2 {
                margin-bottom: 5px;
                color: #19414b;
                font-size: 26px;
            }

            .card p {
                color: #444;
                font-size: 16px;
            }

            .info-table {
                margin: 30px auto;
                border-collapse: collapse;
                width: 100%;
                border-radius: 12px;
                overflow: hidden;
                background-color: #f9fbfb;
                box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
            }

            .info-table th, .info-table td {
                padding: 16px 24px;
                text-align: left;
                font-size: 15px;
            }

            .info-table th {
                background-color: #e1e5e4;
                color: #19414b;
                font-weight: 600;
            }

            .info-table td {
                color: #333;
            }

            button {
                margin-top: 25px;
                padding: 14px 30px;
                background-color: var(--accent-color);
                border: none;
                color: white;
                font-size: 16px;
                cursor: pointer;
                border-radius: 10px;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #176d54;
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

            .timestamp {
                margin-top: 12px;
                color: #888;
                font-size: 14px;
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

                <!-- Botón del dropdown -->
                <button class="btn btn-link text-white p-0 dropdown-toggle" type="button" id="userDropdown"
                        data-bs-toggle="dropdown" aria-expanded="false" style="line-height: 1;">
                    <i class="bi bi-chevron-down" style="font-size: 1rem;"></i>
                </button>

                <!-- Menú -->
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                    <li>
                        <a class="dropdown-item" href="logout">
                            <i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión
                        </a>
                    </li>
                </ul>
            </div>
        </header>


        <div class="container">
            <div class="card">
                <h2>Bienvenido, Dr. Ulises diedo</h2>
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

        <div class="modal" id="modal">
            <div class="modal-content">
                <h3>✔️ Asistencia registrada</h3>
                <p id="horaRegistro"></p>
                <button onclick="cerrarModal()">Aceptar</button>
            </div>
        </div>

        <script>
            function registrarAsistencia() {
                const ahora = new Date();
                const hora = ahora.toLocaleTimeString('es-PE');
                const fecha = ahora.toLocaleDateString('es-PE');

                document.getElementById("horaActual").textContent = `Hora registrada: ${hora}`;
                document.getElementById("horaRegistro").textContent = `Tu llegada (${fecha} - ${hora}) ha sido registrada exitosamente.`;
                document.getElementById("modal").style.display = "flex";
            }

            function cerrarModal() {
                document.getElementById("modal").style.display = "none";
            }

            // Cargar fecha automáticamente
            window.onload = () => {
                const hoy = new Date();
                document.getElementById("fechaActual").textContent = hoy.toLocaleDateString('es-PE');
            };
        </script>
    </body>
</html>
