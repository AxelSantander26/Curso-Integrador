<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dashboard - DentaLogic</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <!-- Bootstrap JS -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <!-- Dashboard CSS -->
        <link rel="stylesheet" href="assets/css/pages/dashboard.desing.css">
    </head>
    <body class="bg-light">
        <!-- Sidebar estático -->
        <div class="static-sidebar text-white">
            <div class="d-flex flex-column align-items-center pt-2">
                <button class="btn btn-link text-white mb-4" id="hamburgerBtn">
                    <i class="bi bi-list fs-4"></i>
                </button>
                <a href="#" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
                    <i class="bi bi-speedometer2 fs-4"></i>
                    <small>Inicio</small>
                </a>
                <a href="#" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
                    <i class="bi bi-calendar-plus fs-4"></i>
                    <small>Citas</small>
                </a>
                <a href="#" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
                    <i class="bi bi-person-vcard fs-4"></i>
                    <small>Pacientes</small>
                </a>
                <a href="#" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
                    <i class="bi bi-people fs-4"></i>
                    <small>Personal</small>
                </a>
                <a href="#" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
                    <i class="bi bi-clipboard2-pulse fs-4"></i>
                    <small>Tratamientos</small>
                </a>
                <a href="#" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
                    <i class="bi bi-cash-coin fs-4"></i>
                    <small>Planillas</small>
                </a>
                <a href="#" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
                    <i class="bi bi-box-arrow-right fs-4"></i>
                    <small>Salir</small>
                </a>
            </div>
        </div>

        <!-- Modal para sidebar expandido -->
        <div class="sidebar-modal text-white" id="sidebarModal">
            <div class="p-3">
                <button class="btn btn-link text-white p-0 mb-4 d-flex align-items-center" id="closeSidebarBtn">
                    <i class="bi bi-arrow-left fs-4 me-3"></i>
                    <span class="fw-bold">REGRESAR</span>
                </button>
                <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
                    <i class="bi bi-speedometer2 fs-4 me-3"></i> Inicio
                </a>
                <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
                    <i class="bi bi-calendar-plus fs-4 me-3"></i> Gestión de Citas
                </a>
                <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
                    <i class="bi bi-person-vcard fs-4 me-3"></i> Registro de Pacientes
                </a>
                <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
                    <i class="bi bi-people fs-4 me-3"></i> Personal Clínico
                </a>
                <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
                    <i class="bi bi-clipboard2-pulse fs-4 me-3"></i> Tratamientos
                </a>
                <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
                    <i class="bi bi-cash-coin fs-4 me-3"></i> Planillas y Pagos
                </a>
                <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
                    <i class="bi bi-graph-up fs-4 me-3"></i> Reportes
                </a>
                <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
                    <i class="bi bi-box-arrow-right fs-4 me-3"></i> Cerrar Sesión
                </a>
            </div>
        </div>

        <!-- Overlay -->
        <div class="overlay" id="overlay"></div>

        <!-- Contenido principal -->
        <main class="main-content">
            <!-- Navbar -->
            <nav class="navbar">
                <div class="container-fluid">
                    <img src="assets/images/logo.png" alt="Logo" class="mb-1" style="width: 150px;">
                    <div class="dropdown">
                        <div class="user-section" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="user-info">
                                <div style="display: flex; gap: 4px;">
                                    <p class="saludo">Hola,</p>
                                    <p class="user-name">${usuario.nombre} ${usuario.apellido}</p>
                                </div>
                                <p class="user-role">${usuario.rol}</p> 
                            </div>
                            <img src="assets/images/usuario.png" class="user-avatar" alt="Avatar">
                            <i class="bi bi-chevron-down ms-1" style="font-size: 0.8rem;"></i>
                        </div>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Contenido -->
            <div class="content-wrapper">
                <!-- Dashboard Principal -->
                <div id="dashboard">
                    <h2 class="fw-bold text-dark mb-4"><i class="bi bi-speedometer2 me-2"></i> Panel Principal</h2>

                    <div class="row g-4 mb-4">
                        <div class="col-md-3 ">
                            <div class="card text-white p-3 module-card" style="background-color: var(--card-bg);">
                                <h5><i class="bi bi-calendar-check me-2"></i> Citas Hoy</h5>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white p-3 module-card" style="background-color: var(--card-bg);">
                                <h5><i class="bi bi-people me-2"></i> Pacientes</h5>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white p-3 module-card" style="background-color: var(--card-bg);">
                                <h5><i class="bi bi-cash-coin me-2"></i> Ingresos</h5>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white p-3 module-card" style="background-color: var(--card-bg);">
                                <h5><i class="bi bi-clipboard2-pulse me-2"></i> Tratamientos</h5>
                            </div>
                        </div>
                    </div>

                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const hamburgerBtn = document.getElementById('hamburgerBtn');
                            const closeSidebarBtn = document.getElementById('closeSidebarBtn');
                            const sidebarModal = document.getElementById('sidebarModal');
                            const overlay = document.getElementById('overlay');

                            // Abrir modal sidebar
                            hamburgerBtn.addEventListener('click', function () {
                                sidebarModal.classList.add('show');
                                overlay.classList.add('show');
                                document.body.style.overflow = 'hidden';
                            });

                            // Cerrar modal sidebar
                            function closeModal() {
                                sidebarModal.classList.remove('show');
                                overlay.classList.remove('show');
                                document.body.style.overflow = '';
                            }

                            closeSidebarBtn.addEventListener('click', closeModal);
                            overlay.addEventListener('click', closeModal);
                        });
                    </script>
                    </body>
                    </html>