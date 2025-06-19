<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1e293b;
            --primary-hover: #334155;
            --accent-color: #3b82f6;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
        }

        * {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            height: 100vh;
            overflow: hidden;
        }

        .login-container {
            display: flex;
            height: 100vh;
        }

        .login-left {
            flex: 1;
            background: url('assets/images/bglogin.webp') center/cover no-repeat;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-left::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(30, 41, 59, 0.7);
        }

        .login-left-content {
            position: relative;
            z-index: 1;
            color: white;
            padding: 2rem;
            max-width: 500px;
        }

        .login-left img {
            max-width: 200px;
            margin-bottom: 2rem;
        }

        .login-left h2 {
            font-weight: 700;
            margin-bottom: 1rem;
            font-size: 2rem;
        }

        .login-left p {
            color: var(--text-secondary);
            margin-bottom: 2rem;
            font-size: 1.1rem;
            line-height: 1.6;
        }

        .login-right {
            flex: 1;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .login-form-container {
            width: 100%;
            max-width: 400px;
        }

        .login-right img {
            max-width: 180px;
            margin-bottom: 1.5rem;
        }

        .login-right h3 {
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--primary-color);
            font-size: 1.5rem;
        }

        .login-right p {
            color: #64748b;
            margin-bottom: 2rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #475569;
        }

        .form-control {
            width: 100%;
            border: 1px solid #e2e8f0;
            padding: 0.75rem 1rem;
            height: calc(3rem + 2px);
            border-radius: 0.5rem;
            font-size: 1rem;
        }

        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25);
        }

        .input-group {
            display: flex;
            align-items: center;
        }

        .input-group .form-control {
            border-right: none;
            border-radius: 0.5rem 0 0 0.5rem;
        }

        .input-group .input-group-text {
            background-color: white;
            border: 1px solid #e2e8f0;
            border-left: none;
            border-radius: 0 0.5rem 0.5rem 0;
            height: calc(3rem + 2px);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            padding: 0 1rem;
            font-size: 1.2rem;
            color: #64748b;
        }

        .btn-login {
            background-color: var(--primary-color);
            color: white;
            padding: 0.75rem;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            width: 100%;
            font-size: 1rem;
            margin-top: 1rem;
        }

        .btn-login:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .mb-3 {
            margin-bottom: 1.2rem;
        }

        .mb-4 {
            margin-bottom: 1.5rem;
        }

        .error-message {
            background-color: #fee2e2;
            color: #b91c1c;
            padding: 0.75rem;
            border-radius: 0.5rem;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 0.5rem;
        }

        .error-message i {
            margin-right: 0.5rem;
        }

        .error-message button {
            background: none;
            border: none;
            color: #b91c1c;
            font-size: 1.2rem;
            cursor: pointer;
        }

        @media (max-width: 992px) {
            .login-left {
                display: none;
            }

            .login-container {
                flex-direction: column;
                overflow-y: auto;
            }

            .login-right {
                height: auto;
                min-height: 100vh;
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-left">
        <div class="login-left-content">
            <img src="assets/images/logo-white.png" alt="Logo Dental">
            <h2>Sistema de Gestión Dental</h2>
            <p>Acceso al sistema para la administración de pacientes, citas, historiales clínicos y reportes financieros.</p>
            <div style="display: flex; align-items: center; gap: 1rem; margin-top: 2rem;">
                <div style="width: 40px; height: 3px; background: var(--accent-color);"></div>
                <small>Plataforma segura y confiable</small>
            </div>
        </div>
    </div>

    <div class="login-right">
        <div class="login-form-container">
            <img src="assets/images/logo.png" alt="Logo">
            <h3>Iniciar Sesión</h3>
            <p>Ingresa tus credenciales para acceder al sistema</p>

            <form method="post" action="login">
                <!-- Usuario -->
                <div class="mb-3">
                    <label for="usuario" class="form-label">Usuario</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="usuario" name="usuario" required>
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                    </div>
                </div>

                <!-- Contraseña -->
                <div class="mb-3">
                    <label for="password" class="form-label">Contraseña</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="clave" required>
                        <span class="input-group-text" onclick="togglePassword()" style="user-select: none;">
                            <i class="bi bi-eye" id="toggleIcon"></i>
                        </span>
                    </div>
                </div>

                <!-- Botón -->
                <button type="submit" class="btn-login">
                    <i class="bi bi-box-arrow-in-right me-2"></i> Ingresar
                </button>

                <!-- Mensaje de error (solo si hay error válido) -->
                <c:if test="${fn:length(fn:trim(error)) > 0}">
                    <div class="error-message" id="errorBox">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <span>${error}</span>
                        <button onclick="closeError(event)"><i class="bi bi-x-lg"></i></button>
                    </div>
                </c:if>
            </form>
        </div>
    </div>
</div>

<script>
    function togglePassword() {
        const field = document.getElementById("password");
        const icon = document.getElementById("toggleIcon");
        if (field.type === "password") {
            field.type = "text";
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        } else {
            field.type = "password";
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        }
    }

    function closeError(event) {
        event.preventDefault();
        const box = document.getElementById("errorBox");
        if (box) box.style.display = "none";
    }

    window.addEventListener("DOMContentLoaded", () => {
        const box = document.getElementById("errorBox");
        if (box) {
            setTimeout(() => {
                box.style.display = "none";
            }, 5000);
        }
    });
</script>
</body>
</html>
