<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
grupo7.dentalogic.model.Usuario usuario = (grupo7.dentalogic.model.Usuario) session.getAttribute("usuarioLogueado");
if (usuario == null) {
return;
}
request.setAttribute("usuario", usuario);
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="assets/js/bootstrap.bundle.min.js"></script>
<style>
    :root {
        --sidebar-width: 90px;
        --sidebar-bg: #1e293b;
        --sidebar-hover: #334155;
        --navbar-height: 70px;
        --transition-speed: 0.3s;
        --text-primary: #f8fafc;
        --text-secondary: #94a3b8;
        --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        --active-color: #3b82f6;
    }

    * {
        font-family: 'Inter', sans-serif;
        box-sizing: border-box;
    }

    .static-sidebar {
        width: var(--sidebar-width);
        background-color: var(--sidebar-bg);
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        transition: width var(--transition-speed) ease;
        box-shadow: var(--shadow-md);
    }

    .sidebar-modal {
        position: fixed;
        top: 0;
        left: -300px;
        width: 300px;
        background-color: var(--sidebar-bg);
        height: 100vh;
        z-index: 1100;
        transition: all var(--transition-speed) ease;
        box-shadow: 2px 0 15px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
    }

    .sidebar-modal.show {
        left: 0;
    }

    .sidebar-header {
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        padding-bottom: 1rem;
        margin-bottom: 1rem;
    }

    .sidebar-title {
        color: var(--text-primary);
        font-weight: 600;
        font-size: 1.1rem;
    }

    .overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0,0,0,0.5);
        z-index: 1050;
        opacity: 0;
        transition: opacity var(--transition-speed) ease;
        pointer-events: none;
    }

    .overlay.show {
        opacity: 1;
        pointer-events: all;
    }

    .navbar {
        height: var(--navbar-height);
        background-color: white;
        position: fixed;
        top: 0;
        left: var(--sidebar-width);
        right: 0;
        box-shadow: var(--shadow-md);
        z-index: 999;
        display: flex;
        align-items: center;
        padding: 0 2rem;
    }

    .content-wrapper {
        margin-top: var(--navbar-height);
        margin-left: var(--sidebar-width);
        padding: 2rem;
        transition: margin-left var(--transition-speed) ease;
    }

    .static-sidebar .d-flex {
        padding-top: 1rem;
    }

    .nav-item {
        width: 100%;
        margin-bottom: 0.5rem;
        transition: all 0.2s ease;
    }

    .nav-link {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        color: var(--text-secondary);
        text-decoration: none;
        padding: 0.75rem 0;
        border-radius: 0.5rem;
        margin: 0 0.5rem;
        transition: all 0.2s ease;
    }

    .nav-link:hover, .nav-link:focus {
        background-color: var(--sidebar-hover);
        color: var(--text-primary);
    }

    .nav-link.active {
        background-color: var(--sidebar-hover);
        color: var(--active-color);
    }

    .nav-link i {
        font-size: 1.25rem;
        margin-bottom: 0.25rem;
    }

    .nav-link small {
        font-size: 0.7rem;
        font-weight: 500;
    }

    .sidebar-modal .nav-item {
        padding: 0 1rem;
    }

    .sidebar-modal .nav-link {
        flex-direction: row;
        justify-content: flex-start;
        padding: 0.75rem 1rem;
    }

    .sidebar-modal .nav-link i {
        margin-bottom: 0;
        margin-right: 1rem;
        font-size: 1.1rem;
    }

    .sidebar-modal .nav-link span {
        font-size: 0.95rem;
        font-weight: 500;
    }

    .user-section {
        display: flex;
        align-items: center;
        margin-left: auto;
        cursor: pointer;
        padding: 0.5rem 0.75rem;
        border-radius: 0.5rem;
        transition: all 0.2s ease;
    }

    .user-section:hover {
        background-color: #f1f5f9;
    }

    .user-info {
        text-align: right;
        margin-right: 1rem;
    }

    .user-name {
        color: #1e293b;
        font-weight: 600;
        margin: 0;
        white-space: nowrap;
    }

    .user-role {
        font-size: 0.8rem;
        color: #64748b;
        margin: 0;
        font-weight: 500;
        white-space: nowrap;
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #e2e8f0;
    }

    .saludo {
        color: #64748b;
        font-size: 0.9rem;
        margin: 0;
        white-space: nowrap;
    }

    #hamburgerBtn {
        color: var(--text-secondary);
        background: none;
        border: none;
        padding: 0.75rem;
        margin-bottom: 1rem;
        border-radius: 0.5rem;
        transition: all 0.2s ease;
        cursor: pointer;
    }

    #hamburgerBtn:hover {
        background-color: var(--sidebar-hover);
        color: var(--text-primary);
    }

    #closeSidebarBtn {
        color: var(--text-primary);
        background: none;
        border: none;
        padding: 0.25rem;
        border-radius: 50%;
        transition: all 0.2s ease;
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }

    #closeSidebarBtn:hover {
        background-color: var(--sidebar-hover);
        transform: scale(1.1);
    }

    .dropdown-menu {
        border: none;
        box-shadow: var(--shadow-md);
        border-radius: 0.5rem;
        padding: 0.5rem 0;
        min-width: 200px;
    }

    .dropdown-item {
        padding: 0.5rem 1.5rem;
        font-size: 0.9rem;
        color: #334155;
        font-weight: 500;
        transition: all 0.1s ease;
        display: flex;
        align-items: center;
    }

    .dropdown-item:hover {
        background-color: #f1f5f9;
        color: #1e40af;
    }

    .dropdown-item i {
        margin-right: 0.75rem;
        color: #64748b;
        width: 20px;
        text-align: center;
    }

    .static-sidebar .dropdown-menu {
        position: absolute;
        left: 100%;
        top: 0;
        margin-top: -0.5rem;
        margin-left: 0.5rem;
        border: none;
        box-shadow: var(--shadow-md);
        background-color: var(--sidebar-bg);
    }

    .static-sidebar .dropdown-item {
        color: var(--text-secondary);
        padding: 0.75rem 1rem;
    }

    .static-sidebar .dropdown-item:hover {
        background-color: var(--sidebar-hover);
        color: var(--text-primary);
    }

    .static-sidebar .dropdown-toggle::after {
        display: none;
    }

    .sidebar-modal .dropdown-menu {
        position: static;
        background-color: var(--sidebar-hover);
        border: none;
        box-shadow: none;
        padding: 0;
        margin: 0;
        display: none;
    }

    .sidebar-modal .dropdown-menu.show {
        display: block;
    }

    .sidebar-modal .dropdown-item {
        padding: 0.75rem 1rem 0.75rem 2.5rem;
        color: var(--text-secondary);
    }

    .sidebar-modal .dropdown-item:hover,
    .sidebar-modal .dropdown-item.active {
        color: var(--text-primary);
        background-color: transparent;
    }

    .sidebar-modal .dropdown-item i {
        margin-right: 0.75rem;
        color: inherit;
    }

    .sidebar-modal .dropdown-toggle {
        position: relative;
    }

    .sidebar-modal .dropdown-toggle::after {
        content: "\f282";
        font-family: "bootstrap-icons";
        position: absolute;
        right: 1rem;
        top: 50%;
        transform: translateY(-50%);
        transition: transform 0.2s;
    }

    .sidebar-modal .dropdown-toggle[aria-expanded="true"]::after {
        transform: translateY(-50%) rotate(180deg);
    }

    @media (max-width: 768px) {
        .static-sidebar {
            width: 70px;
        }
        .navbar {
            left: 70px;
        }
        .content-wrapper {
            margin-left: 70px;
        }
        .nav-link small {
            font-size: 0.6rem;
        }
        .nav-link i {
            font-size: 1.1rem;
        }
        .static-sidebar .dropdown-menu {
            font-size: 0.8rem;
        }
    }
</style>
<!-- Sidebar Estático -->
<div class="static-sidebar text-white">
    <div class="d-flex flex-column align-items-center">
        <button class="btn" id="hamburgerBtn" aria-label="Abrir menú">
            <i class="bi bi-list fs-4"></i>
        </button>

        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/dashboardAdmin" class="nav-link ${pageContext.request.requestURI.endsWith('/dashboardAdmin.jsp') ? 'active' : ''}">
                <i class="bi bi-house"></i>
                <small>Inicio</small>
            </a>
        </div>

        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/empleados" class="nav-link ${pageContext.request.requestURI.endsWith('/empleados.jsp') ? 'active' : ''}">
                <i class="bi bi-people"></i>
                <small>Empleados</small>
            </a>
        </div>

        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/asistencia" class="nav-link ${pageContext.request.requestURI.endsWith('/asistencia.jsp') ? 'active' : ''}">
                <i class="bi bi-calendar-check"></i>
                <small>Asistencia</small>
            </a>
        </div>

        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/justificativos" class="nav-link ${pageContext.request.requestURI.endsWith('/justificativos.jsp') ? 'active' : ''}">
                <i class="bi bi-file-earmark-text"></i>
                <small>Justificativos</small>
            </a>
        </div>

        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/resumen" class="nav-link ${pageContext.request.requestURI.endsWith('/resumen.jsp') ? 'active' : ''}">
                <i class="bi bi-cash-stack"></i>
                <small>Nómina</small>
            </a>
        </div>
    </div>
</div>


<!-- Modal Sidebar Expandido -->
<div class="sidebar-modal text-white" id="sidebarModal">
    <div class="d-flex flex-column p-3">
        <div class="d-flex justify-content-between align-items-center sidebar-header">
            <h5 class="sidebar-title mb-0">Menú principal</h5>
            <button class="btn" id="closeSidebarBtn" aria-label="Cerrar menú">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>

        <div class="nav-item">
            <a href="dashboardAdmin" class="nav-link ${pageContext.request.requestURI.endsWith('/dashboardAdmin.jsp') ? 'active' : ''}">
                <i class="bi bi-house"></i>
                <span>Inicio</span>
            </a>
        </div>

        <div class="nav-item">
            <a href="empleados" class="nav-link ${pageContext.request.requestURI.endsWith('/empleados.jsp') ? 'active' : ''}">
                <i class="bi bi-people"></i>
                <span>Empleados</span>
            </a>
        </div>

        <div class="nav-item">
            <a href="asistencia" class="nav-link ${pageContext.request.requestURI.endsWith('/asistencia.jsp') ? 'active' : ''}">
                <i class="bi bi-calendar-check"></i>
                <span>Asistencia</span>
            </a>
        </div>

        <div class="nav-item">
            <a href="justificativos" class="nav-link ${pageContext.request.requestURI.endsWith('/justificativos.jsp') ? 'active' : ''}">
                <i class="bi bi-file-earmark-text"></i>
                <span>Justificativos</span>
            </a>
        </div>

        <div class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-expanded="false">
                <i class="bi bi-cash-stack"></i>
                <span>Nómina</span>
            </a>
            <ul class="dropdown-menu">
                <a href="resumen" class="dropdown-item ${pageContext.request.requestURI.endsWith('/resumen') ? 'active' : ''}">
                    <i class="bi bi-file-text"></i> Resumen actual
                </a>
                <a href="historial" class="dropdown-item ${pageContext.request.requestURI.endsWith('/historial') ? 'active' : ''}">
                    <i class="bi bi-clock-history"></i> Historial
                </a>

            </ul>
        </div>
    </div>
</div>

<!-- Overlay -->
<div class="overlay" id="overlay"></div>
<!-- Navbar -->
<nav class="navbar">
    <div class="container-fluid d-flex align-items-center">
        <img src="assets/images/logo.png" alt="Logo" style="height: 40px;">

        <div class="dropdown ms-auto">
            <a href="#" class="d-flex align-items-center user-section dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <div class="user-info me-2">
                    <div style="display: flex; align-items: center; gap: 4px;">
                        <p class="saludo mb-0">Hola,</p>
                        <p class="user-name mb-0">${usuario.nombre} ${usuario.apellido}</p>
                    </div>
                    <p class="user-role mb-0">${usuario.rol}</p>
                </div>
                <img src="assets/images/usuario.png" alt="Avatar" class="user-avatar">
                <i class="bi bi-chevron-down ms-1" style="font-size: 0.8rem; color: #64748b;"></i>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                <li><a class="dropdown-item" href="cerrar-sesion"><i class="bi bi-box-arrow-right"></i> Cerrar sesión</a></li>
            </ul>
        </div>
    </div>
</nav>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        const hamburgerBtn = document.getElementById('hamburgerBtn');
        const closeSidebarBtn = document.getElementById('closeSidebarBtn');
        const sidebarModal = document.getElementById('sidebarModal');
        const overlay = document.getElementById('overlay');
        const navLinks = document.querySelectorAll('.nav-link');

        // Inicializar dropdowns de Bootstrap manualmente
        var dropdownElements = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
        dropdownElements.forEach(function (dropdownToggleEl) {
            var dropdownMenuEl = dropdownToggleEl.nextElementSibling;
            dropdownToggleEl.addEventListener('click', function (e) {
                e.preventDefault();
                if (dropdownToggleEl.classList.contains('show')) {
                    dropdownMenuEl.classList.remove('show');
                    dropdownToggleEl.classList.remove('show');
                    dropdownToggleEl.setAttribute('aria-expanded', 'false');
                } else {
                    dropdownMenuEl.classList.add('show');
                    dropdownToggleEl.classList.add('show');
                    dropdownToggleEl.setAttribute('aria-expanded', 'true');
                }
            });
        });

        // Manejo de clics en nav-links
        navLinks.forEach(link => {
            link.addEventListener('click', function (e) {
                // Evitar cerrar el modal si el clic fue en dropdown-toggle o dentro de un dropdown
                if (this.classList.contains('dropdown-toggle') || this.closest('.dropdown')) {
                    return;
                }

                // Activar visualmente el link
                navLinks.forEach(l => l.classList.remove('active'));
                this.classList.add('active');

                // Cerrar el modal si está abierto
                if (sidebarModal.classList.contains('show')) {
                    closeModal();
                }
            });
        });

        hamburgerBtn.addEventListener('click', openModal);
        closeSidebarBtn.addEventListener('click', closeModal);
        overlay.addEventListener('click', closeModal);

        function openModal() {
            sidebarModal.classList.add('show');
            overlay.classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            sidebarModal.classList.remove('show');
            overlay.classList.remove('show');
            document.body.style.overflow = '';
        }

        // Cerrar con tecla Escape
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape' && sidebarModal.classList.contains('show')) {
                closeModal();
            }
        });

        // Cerrar dropdowns al hacer clic fuera
        document.addEventListener('click', function (e) {
            if (!e.target.closest('.dropdown')) {
                var openDropdowns = document.querySelectorAll('.dropdown-menu.show');
                openDropdowns.forEach(function (dropdown) {
                    dropdown.classList.remove('show');
                    dropdown.previousElementSibling.classList.remove('show');
                    dropdown.previousElementSibling.setAttribute('aria-expanded', 'false');
                });
            }
        });
    });
</script>
