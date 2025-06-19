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
</style>
<jsp:include page="/components/routes/sidebar.jsp" />
<div class="content-wrapper p-4">
<div class="container-fluid">

<!-- HEADER Y BOTÓN -->
<div class="d-flex justify-content-between align-items-center mb-4">
  <h3 class="mb-0"><i class="bi bi-person-vcard me-2"></i>Resumen denomina actual</h3>
</div>
