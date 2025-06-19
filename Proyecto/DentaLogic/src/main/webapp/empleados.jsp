<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    grupo7.dentalogic.model.Usuario usuario = (grupo7.dentalogic.model.Usuario) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login");
        return;
    }
%>
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<script src="assets/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root {
--primary-color:#4361ee;
--primary-hover:#3a56d4;
--secondary-color:#3f37c9;
--dark-color:#1f2937;
--light-color:#f9fafb;
--success-color:#10b981;
--warning-color:#f59e0b;
--danger-color:#ef4444;
}
body {
font-family:'Inter',sans-serif;
}
h3 {
font-weight:600;
}
.card {
border:none;
border-radius:10px;
box-shadow:0 4px 6px rgba(0,0,0,0.05);
transition:transform 0.2s,box-shadow 0.2s;
}
.card:hover {
transform:translateY(-2px);
box-shadow:0 10px 15px rgba(0,0,0,0.1);
}
.card-header {
border-radius:10px 10px 0 0 !important;
}
.btn {
border-radius:8px;
padding:8px 16px;
font-weight:500;
transition:all 0.2s;
}
.btn-primary {
background-color:var(--primary-color);
border-color:var(--primary-color);
}
.btn-primary:hover {
background-color:var(--primary-hover);
border-color:var(--primary-hover);
}
.btn-sm {
padding:5px 10px;
border-radius:6px;
}
.table {
--bs-table-bg:transparent;
border-collapse:separate;
border-spacing:0;
}
.table thead th {
background-color:var(--light-color);
border-bottom:2px solid #e5e7eb;
position:sticky;
top:0;
}
.table tbody tr {
transition:background-color 0.2s;
}
.table tbody tr:hover {
background-color:rgba(67,97,238,0.05);
}
.table td,.table th {
padding:12px 15px;
vertical-align:middle;
}
.form-control,.form-select {
border-radius:8px;
padding:10px 15px;
border:1px solid #e5e7eb;
transition:border-color 0.2s,box-shadow 0.2s;
}
.form-control:focus,.form-select:focus {
border-color:var(--primary-color);
box-shadow:0 0 0 3px rgba(67,97,238,0.2);
}
.form-label {
font-weight:500;
margin-bottom:8px;
color:#4b5563;
}
#formAgregar, #formEditar {
transition:all 0.3s ease;
}
</style>

<jsp:include page="/components/routes/sidebar.jsp" />
<div class="content-wrapper p-4">
<div class="container-fluid">

<!-- HEADER Y BOTÓN -->
<div class="d-flex justify-content-between align-items-center mb-4">
  <h3 class="mb-0"><i class="bi bi-person-vcard me-2"></i>Gestión de Empleados</h3>
  <button class="btn btn-primary" onclick="mostrarFormularioAgregar()"><i class="bi bi-plus-circle me-1"></i>Agregar Empleado</button>
</div>

<!-- FORMULARIO AGREGAR -->
<div class="card mb-4" id="formAgregar" style="display: none;">
  <div class="card-header bg-primary text-white"><strong>Registrar Nuevo Empleado</strong></div>
  <div class="card-body">
    <form method="post" class="row g-3" id="agregarForm">
      <div class="col-md-3">
        <label class="form-label">DNI</label>
        <input type="text" name="emp_dni" class="form-control" placeholder="DNI" required />
      </div>
      <div class="col-md-3">
        <label class="form-label">Nombre</label>
        <input type="text" name="emp_nombre" class="form-control" placeholder="Nombre" required />
      </div>
      <div class="col-md-3">
        <label class="form-label">Apellido</label>
        <input type="text" name="emp_apellido" class="form-control" placeholder="Apellido" required />
      </div>
      <div class="col-md-4">
        <label class="form-label">Especialidad</label>
        <select name="esp_id" class="form-select" required>
          <option value="">-- Seleccione --</option>
          <c:forEach var="esp" items="${especialidades}">
            <option value="${esp[0]}">${esp[1]}</option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-4">
        <label class="form-label">Horario</label>
        <select name="hor_id" class="form-select" required>
          <option value="">-- Seleccione --</option>
          <c:forEach var="hor" items="${horarios}">
            <option value="${hor[0]}">${hor[1]}</option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-4 d-flex align-items-end gap-2">
        <button type="submit" class="btn btn-success w-100"><i class="bi bi-person-plus me-1"></i>Guardar</button>
        <button type="button" class="btn btn-secondary" onclick="cancelarForm()">Cancelar</button>
      </div>
    </form>
  </div>
</div>

<!-- FORMULARIO EDITAR -->
<c:if test="${empleado != null}">
  <div class="card mb-4" id="formEditar">
    <div class="card-header bg-primary text-white"><strong>Editar Empleado</strong></div>
    <div class="card-body">
      <form method="post" class="row g-3" id="editarForm">
        <input type="hidden" name="emp_id" value="${empleado.empId}" />
        <div class="col-md-3">
          <label class="form-label">DNI</label>
          <input type="text" name="emp_dni" value="${empleado.empDni}" class="form-control" required />
        </div>
        <div class="col-md-3">
          <label class="form-label">Nombre</label>
          <input type="text" name="emp_nombre" value="${empleado.empNombre}" class="form-control" required />
        </div>
        <div class="col-md-3">
          <label class="form-label">Apellido</label>
          <input type="text" name="emp_apellido" value="${empleado.empApellido}" class="form-control" required />
        </div>
        <div class="col-md-4">
          <label class="form-label">Especialidad</label>
          <select name="esp_id" class="form-select" required>
            <option value="">-- Seleccione --</option>
            <c:forEach var="esp" items="${especialidades}">
              <option value="${esp[0]}" ${empleado.espId == esp[0] ? 'selected' : ''}>${esp[1]}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-md-4">
          <label class="form-label">Horario</label>
          <select name="hor_id" class="form-select" required>
            <option value="">-- Seleccione --</option>
            <c:forEach var="hor" items="${horarios}">
              <option value="${hor[0]}" ${empleado.horId == hor[0] ? 'selected' : ''}>${hor[1]}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-md-4 d-flex align-items-end gap-2">
          <button type="submit" class="btn btn-success w-100"><i class="bi bi-pencil-square me-1"></i>Actualizar</button>
          <button type="button" class="btn btn-secondary" onclick="cancelarForm()">Cancelar</button>
        </div>
      </form>
    </div>
  </div>
</c:if>

<!-- TABLA -->
<div class="card">
  <div class="card-header bg-dark text-white"><strong><i class="bi bi-people-fill me-2"></i>Lista de Empleados</strong></div>
  <div class="card-body table-responsive">
    <table class="table table-bordered table-hover align-middle">
      <thead class="table-light">
        <tr>
          <th>ID</th>
          <th>DNI</th>
          <th>Nombre</th>
          <th>Apellido</th>
          <th>Especialidad</th>
          <th>Horario</th>
          <th class="text-center">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="emp" items="${empleados}">
          <tr>
            <td>${emp.empId}</td>
            <td>${emp.empDni}</td>
            <td>${emp.empNombre}</td>
            <td>${emp.empApellido}</td>
            <td>${emp.especialidad}</td>
            <td>${emp.horario}</td>
            <td class="text-center">
              <div class="d-flex justify-content-center gap-2">
                <form method="get">
                  <input type="hidden" name="edit_id" value="${emp.empId}" />
                  <button type="submit" class="btn btn-warning btn-sm"><i class="bi bi-pencil-fill"></i></button>
                </form>
                <form method="post" onsubmit="return confirm('¿Eliminar empleado?')">
                  <input type="hidden" name="emp_id" value="${emp.empId}" />
                  <input type="hidden" name="_method" value="DELETE" />
                  <button type="submit" class="btn btn-danger btn-sm"><i class="bi bi-trash-fill"></i></button>
                </form>
              </div>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty empleados}">
          <tr>
            <td colspan="7" class="text-center text-muted">No hay empleados registrados.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>

</div>
</div>

<!-- SCRIPTS -->
<script>
function mostrarFormularioAgregar() {
  document.getElementById('formEditar')?.remove();
  document.getElementById('agregarForm').reset();
  document.getElementById('formAgregar').style.display = 'block';
}

function cancelarForm() {
  document.getElementById('agregarForm')?.reset();
  document.getElementById('editarForm')?.reset();
  document.getElementById('formAgregar').style.display = 'none';
  document.getElementById('formEditar')?.remove();
  history.replaceState(null, '', window.location.pathname);
}
</script>
