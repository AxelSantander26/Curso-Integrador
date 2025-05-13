<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    :root {
        --sidebar-width: 85px;
        --sidebar-bg: #19414b;
        --card-bg: #1a4d40;
        --navbar-height: 60px;
    }

    .static-sidebar {
        width: var(--sidebar-width);
        background-color: var(--sidebar-bg);
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
    }

    .sidebar-modal {
        position: fixed;
        top: 0;
        left: -250px;
        width: 250px;
        background-color: var(--sidebar-bg);
        height: 100vh;
        z-index: 1100;
        transition: all 0.3s ease;
    }

    .sidebar-modal.show {
        left: 0;
    }

    .overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0,0,0,0.5);
        z-index: 1050;
        display: none;
    }

    .overlay.show {
        display: block;
    }

    .navbar {
        height: var(--navbar-height);
        background-color: white;
        position: fixed;
        top: 0;
        left: var(--sidebar-width);
        right: 0;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        z-index: 999;
    }

    .content-wrapper {
        margin-top: var(--navbar-height);
        margin-left: var(--sidebar-width);
        padding: 2rem;
    }

    .user-section {
        display: flex;
        align-items: center;
        margin-left: auto;
        padding-right: 1rem;
        cursor: pointer;
    }

    .user-info {
        text-align: right;
        margin-right: 1rem;
        display: flex;
        flex-direction: column;
        align-items: flex-end;
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
    }

    /* Estilos del Sidebar */
    .static-sidebar .d-flex a {
        color: white;
    }

    .sidebar-modal a {
        color: white;
    }
</style>

<!-- Sidebar -->
<div class="static-sidebar text-white">
    <div class="d-flex flex-column align-items-center pt-2">
        <button class="btn btn-link text-white mb-4" id="hamburgerBtn">
            <i class="bi bi-list fs-4"></i>
        </button>
        <a href="<c:url value='/dashboard.jsp' />"class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
            <i class="bi bi-speedometer2 fs-4"></i>
            <small>Inicio</small>
        </a>
        <a href="<c:url value='/empleados' />" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
            <i class="bi bi-person-vcard fs-4"></i>
            <small>Personal</small>
        </a>
        <a href="<c:url value='/planillas.jsp' />" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
            <i class="bi bi-file-earmark-spreadsheet fs-4"></i>
            <small>Planillas</small>
        </a>
        <a href="<c:url value='/asistencias.jsp' />" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
            <i class="bi bi-clipboard2-pulse fs-4"></i>
            <small>Asistencias</small>
        </a>

        <a href="<c:url value='/bonos.jsp' />" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
            <i class="bi bi-cash-coin fs-4"></i>
            <small>Bonos</small>
        </a>
        <a href="<c:url value='/periodos.jsp' />" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
            <i class="bi bi-calendar-check fs-4"></i>
            <small style="text-align: center;">Periodos Pago</small>
        </a>
        <a href="<c:url value='/pagos.jsp' />" class="d-flex flex-column align-items-center text-white text-decoration-none mb-3">
            <i class="bi bi-credit-card fs-4"></i>

            <small style="text-align: center;"> Pagos a Empleados</small>
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
            <i class="bi bi-person-vcard fs-4 me-3"></i> Personal
        </a>
        <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
            <i class="bi bi-file-earmark-spreadsheet fs-4 me-3"></i> Planillas
        </a>
        <a href="/asistencias.jsp" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
            <i class="bi bi-clipboard2-pulse fs-4 me-3"></i> Asistencias
        </a>
        <a href="#" class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
            <i class="bi bi-cash-coin fs-4 me-3"></i> Bonos
        </a>
        <a  class="d-flex align-items-center text-white text-decoration-none py-2 px-3 mb-2">
            <i class="bi bi-calendar-check fs-4 me-3"></i> Periodos de Pago
        </a>
    </div>
</div>


<!-- Overlay -->
<div class="overlay" id="overlay"></div>

<!-- Navbar -->
<nav class="navbar">
    <div class="container-fluid d-flex align-items-center">
        <!-- Logo -->
        <img src="assets/images/logo.png" alt="Logo" class="mb-4" style="width: 150px; margin-top: 0;">

        <!-- Usuario (Texto y Avatar) -->
        <div class="dropdown ms-auto d-flex align-items-center">
            <div class="user-section d-flex align-items-center" data-bs-toggle="dropdown" aria-expanded="false">
                <!-- Información del usuario -->
                <div class="user-info" style="margin-right: 10px;">
                    <!-- Estructura ajustada para mostrar el Hola y el Rol en la misma línea -->
                    <div style="display: flex; align-items: center; gap: 4px;">
                        <p class="saludo" style="color: gray; margin-bottom: 0;">Hola,</p>
                        <p class="user-name" style="margin-bottom: 0;">${usuario.nombre} ${usuario.apellido}</p>
                    </div>
                    <p class="user-role" style="font-size: 0.85rem; color: gray; margin-top: 2px;">${usuario.rol}</p>
                </div>

                <!-- Avatar de Usuario -->
                <img src="assets/images/usuario.png" alt="Logo" class="mb-4" style="width: 46px; margin-top: 5;">
                <i class="bi bi-chevron-down ms-1" style="font-size: 0.8rem;"></i>
            </div>
            <!-- Menú de Dropdown -->
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión</a></li>
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
