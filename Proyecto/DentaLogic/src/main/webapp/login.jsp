<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Iniciar Sesión</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="vh-100">
    <div class="container-fluid vh-100">
        <div class="row vh-100">
            <div class="col-md-6 d-none d-md-flex align-items-center justify-content-center" style="background-color: #eff6ff;">
                <img src="assets/images/bglogin.webp" class="img-fluid" alt="corparade memphis dental">
            </div>

            <div class="col-md-6 d-flex align-items-center justify-content-center">
                <div class="p-4" style="width: 25rem;">
                    <img src="assets/images/logo.png" alt="Logo" class="mb-3" style="width: 190px;">
                    <h4 class="fw-bold">Sistema de Gestión de Planillas y Personal</h4>
                    <p class="text-muted">Acceso al sistema para la administración de planillas, control de asistencias, generación de reportes y gestión de personal.</p>
                    <p class="fw-semibold">Por favor ingresa tus credenciales para continuar.</p>

                    <div id="error-message" class="alert alert-danger d-none">
                        <strong>Error:</strong> Usuario o contraseña incorrectos.
                    </div>

                    <form id="loginForm" action="login" method="post">
                        <div class="input-group mb-3">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Usuario" required>
                                <label for="usuario">Usuario</label>
                            </div>
                            <span class="input-group-text"><i class="bi-person"></i></span>
                        </div>

                        <div class="input-group mb-3">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required>
                                <label for="password">Contraseña</label>
                            </div>
                            <span class="input-group-text" onclick="togglePassword()">
                                <i class="bi-eye" id="toggleIcon"></i>
                            </span>
                        </div>

                        <button type="submit" class="btn w-100 py-2" style="background-color: #19414b; color: white; border: none;">
                            Ingresar
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            let passwordField = document.getElementById("password");
            let toggleIcon = document.getElementById("toggleIcon");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.classList.remove("bi-eye");
                toggleIcon.classList.add("bi-eye-slash");
            } else {
                passwordField.type = "password";
                toggleIcon.classList.remove("bi-eye-slash");
                toggleIcon.classList.add("bi-eye");
            }
        }

        window.onload = function () {
            const urlParams = new URLSearchParams(window.location.search);
            const errorMessage = urlParams.get("error");

            if (errorMessage) {
                const errorDiv = document.getElementById("error-message");
                errorDiv.innerText = errorMessage;
                errorDiv.classList.remove("d-none");
            }
        };
    </script>
</body>
</html>
