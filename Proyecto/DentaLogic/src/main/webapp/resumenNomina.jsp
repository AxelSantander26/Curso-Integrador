<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<% grupo7.dentalogic.model.Usuario usuario = (grupo7.dentalogic.model.Usuario) session.getAttribute("usuarioLogueado");
if (usuario == null) { response.sendRedirect("login"); return; } %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Resumen de Nómina</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            :root {
                --color-primary: #2c3e50;
                --color-secondary: #f5f5f5;
                --color-success: #e8f5e9;
                --color-error: #ffebee;
                --color-warning: #fff8e1;
                --color-info: #e3f2fd;
                --text-error: #d32f2f;
                --text-success: #2e7d32;
                --border-color: #e0e0e0;
                --spacing: 1rem;
                --spacing-sm: 0.75rem;
                --border-radius: 4px;
                --box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }
            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                margin: 0;
                padding: var(--spacing);
                color: var(--color-primary);
                background-color: #f9f9f9;
            }
            .content-wrapper {
                margin-left: 250px;
                padding: var(--spacing);
            }
            .header-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: var(--spacing);
            }
            h2, h4 {
                margin-top: 0;
                color: var(--color-primary);
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin: var(--spacing) 0;
                box-shadow: var(--box-shadow);
            }
            th, td {
                padding: var(--spacing-sm);
                text-align: center;
                border: 1px solid var(--border-color);
            }
            th {
                background-color: var(--color-secondary);
                font-weight: 600;
            }
            .btn {
                padding: var(--spacing-sm);
                cursor: pointer;
                border: none;
                border-radius: var(--border-radius);
                transition: background-color 0.2s;
            }
            .btn-primary {
                background-color: var(--color-primary);
                color: white;
            }
            .btn-primary:hover {
                background-color: #1a252f;
            }
            .btn-outline-primary {
                background-color: transparent;
                border: 1px solid var(--color-primary);
                color: var(--color-primary);
            }
            .btn-outline-primary:hover {
                background-color: var(--color-primary);
                color: white;
            }
            .negativo {
                color: var(--text-error);
                background-color: var(--color-error);
            }
            .destacado {
                background-color: var(--color-success);
                font-weight: bold;
            }
            .resumen-tablas {
                margin-top: calc(var(--spacing) * 2);
                width: 100%;
                max-width: 800px;
                margin-left: auto;
            }
            .resumen-tablas table {
                margin-bottom: var(--spacing);
            }
            caption {
                font-weight: bold;
                margin-bottom: var(--spacing-sm);
                text-align: left;
            }
            .employee-info {
                background-color: white;
                padding: var(--spacing);
                border-radius: var(--border-radius);
                margin-bottom: var(--spacing);
                box-shadow: var(--box-shadow);
            }
            .error-message {
                background-color: var(--color-error);
                color: var(--text-error);
                padding: var(--spacing-sm);
                border-radius: var(--border-radius);
                margin-bottom: var(--spacing);
            }
            .justificado {
                color: var(--text-success);
                font-weight: 500;
            }
            .no-justificado {
                color: var(--text-error);
            }
            .fin-de-semana {
                background-color: var(--color-secondary) !important;
            }
            .falta-injustificada {
                background-color: var(--color-error) !important;
            }
            .justificada {
                border-left: 4px solid #ba68c8 !important;
            }
            .tardanza {
                background-color: var(--color-warning) !important;
            }
            .employee-summary {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: var(--spacing);
                margin-bottom: var(--spacing);
            }
            .employee-summary-item {
                background-color: white;
                padding: var(--spacing-sm);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
            }
            .employee-summary-item h5 {
                color: var(--color-primary);
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }
            .employee-summary-item p {
                font-size: 1rem;
                font-weight: 500;
                margin-bottom: 0;
            }
            @media (max-width: 768px) {
                .content-wrapper {
                    margin-left: 0;
                    padding: var(--spacing-sm);
                }
                .employee-summary {
                    grid-template-columns: 1fr;
                }
                th, td {
                    padding: 0.5rem;
                    font-size: 0.85rem;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/components/routes/sidebar.jsp"/>
        <div class="content-wrapper">
            <div class="header-bar">
                <h2>Resumen de Nómina - ${mesActual} ${anioActual}</h2>
                <c:if test="${not empty detalle}">
                    <a href="resumen" class="btn btn-outline-primary"><i class="bi bi-arrow-left"></i> Volver al resumen</a>
                </c:if>
            </div>
            <c:if test="${not empty error}">
                <div class="error-message"><i class="bi bi-exclamation-triangle-fill"></i> ${error}</div>
            </c:if>
            <c:choose>
                <c:when test="${not empty detalle}">
                    <div class="employee-info">
                        <h4><i class="bi bi-person-badge"></i> Información del Empleado</h4>
                        <div class="employee-summary">
                            <div class="employee-summary-item">
                                <h5>Empleado</h5>
                                <p>${detalle.nombreEmpleado}</p>
                            </div>
                            <div class="employee-summary-item">
                                <h5>Especialidad</h5>
                                <p>${detalle.especialidad}</p>
                            </div>
                            <div class="employee-summary-item">
                                <h5>Días laborables</h5>
                                <p>${detalle.diasLaborablesMes}</p>
                            </div>
                            <div class="employee-summary-item">
                                <h5>Horario</h5>
                                <p>
                                    <fmt:formatDate value="${detalle.horaEntradaHorario}" pattern="HH:mm"/> - 
                                    <fmt:formatDate value="${detalle.horaSalidaHorario}" pattern="HH:mm"/>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center; margin: 20px 0;">
                        <a href="generar-boleta-pdf?empId=${detalle.empId}" class="btn-pdf">
                            <i class="bi bi-file-earmark-pdf"></i> Descargar Boleta de Pago
                        </a>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Entrada</th>
                                <th>Estado Ent.</th>
                                <th>Salida</th>
                                <th>Estado Sal.</th>
                                <th>Justificado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="i" begin="0" end="${fn:length(detalle.fechas) - 1}">
                                <tr class="${detalle.esFinSemana[i] ? 'fin-de-semana' : ''} 
                                    ${detalle.estadosEntrada[i] == 'FALTA' && !detalle.justificados[i] ? 'falta-injustificada' : ''} 
                                    ${detalle.estadosEntrada[i] == 'TARDANZA' ? 'tardanza' : ''} 
                                    ${detalle.justificados[i] ? 'justificada' : ''}">
                                    <td>${detalle.fechas[i]}</td>
                                    <td>${detalle.getHoraEntrada12h(i)}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${detalle.estadosEntrada[i] == 'FALTA'}">
                                                <span class="no-justificado">FALTA</span>
                                            </c:when>
                                            <c:when test="${detalle.estadosEntrada[i] == 'TARDANZA'}">
                                                <span class="no-justificado">TARDANZA</span>
                                            </c:when>
                                            <c:when test="${detalle.esFinSemana[i]}">FIN SEMANA</c:when>
                                            <c:otherwise>PUNTUAL</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${detalle.getHoraSalida12h(i)}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${detalle.estadosSalida[i] == 'ANTICIPADA'}">
                                                <span class="no-justificado">ANTICIPADA</span>
                                            </c:when>
                                            <c:when test="${detalle.estadosSalida[i] == 'NO_MARCÓ'}">
                                                <span class="no-justificado">NO MARCÓ</span>
                                            </c:when>
                                            <c:when test="${detalle.esFinSemana[i]}">-</c:when>
                                            <c:otherwise>NORMAL</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="${detalle.justificados[i] ? 'justificado' : 'no-justificado'}">
                                        ${detalle.justificados[i] ? 'Sí' : 'No'}
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="resumen-tablas">
                        <table>
                            <caption>Resumen de Asistencia</caption>
                            <thead>
                                <tr>
                                    <th>Horas Esperadas</th>
                                    <th>Horas Trabajadas</th>
                                    <th>Min. Tardanza</th>
                                    <th>Min. Anticipación</th>
                                    <th>Faltas</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>${detalle.horasEsperadas} h</td>
                                    <td>${detalle.horas} h</td>
                                    <td class="${detalle.tardanza > 0 ? 'negativo' : ''}">${detalle.tardanza} min</td>
                                    <td class="${detalle.anticipacion > 0 ? 'negativo' : ''}">${detalle.anticipacion} min</td>
                                    <td class="${detalle.faltas > 0 ? 'negativo' : ''}">${detalle.faltas}</td>
                                </tr>
                            </tbody>
                        </table>
                        <table>
                            <caption>Cálculo Salarial</caption>
                            <thead>
                                <tr>
                                    <th>Concepto</th>
                                    <th>Valor (S/)</th>
                                    <th>Fórmula</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Sueldo Base Esperado</td>
                                    <td>S/ <fmt:formatNumber value="${detalle.sueldoBaseEsperado}" pattern="#,##0.00"/></td>
                                    <td>sueldoHora × horasEsperadas<br/>(${detalle.sueldoHora} × ${detalle.horasEsperadas} h)</td>
                                </tr>
                                <tr>
                                    <td>Descuento por Tardanzas</td>
                                    <td class="negativo">S/ <fmt:formatNumber value="${detalle.descuentoTardanzas}" pattern="#,##0.00"/></td>
                                    <td>sueldoHora × (minTardanza ÷ 60)<br/>(${detalle.sueldoHora} × ${detalle.tardanza} min ÷ 60)</td>
                                </tr>
                                <tr>
                                    <td>Descuento por Anticipaciones</td>
                                    <td class="negativo">S/ <fmt:formatNumber value="${detalle.descuentoAnticipaciones}" pattern="#,##0.00"/></td>
                                    <td>sueldoHora × (minAnticipacion ÷ 60)<br/>(${detalle.sueldoHora} × ${detalle.anticipacion} min ÷ 60)</td>
                                </tr>
                                <tr>
                                    <td>Descuento por Faltas</td>
                                    <td class="negativo">S/ <fmt:formatNumber value="${detalle.descuentoFaltas}" pattern="#,##0.00"/></td>
                                    <td>sueldoHora × (faltas × horasPorDia)<br/>(${detalle.sueldoHora} × ${detalle.getHorasPorDia()} h × ${detalle.faltas})</td>
                                </tr>
                                <tr class="destacado">
                                    <td>Sueldo Final</td>
                                    <td>S/ <fmt:formatNumber value="${detalle.sueldoFinal}" pattern="#,##0.00"/></td>
                                    <td>sueldoBase - descuentos<br/>= ${detalle.sueldoBaseEsperado} - ${detalle.descuentoTardanzas} - ${detalle.descuentoAnticipaciones} - ${detalle.descuentoFaltas}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="d-flex justify-content-between mb-3">
                        <div>
                            <input type="text" id="searchInput" class="form-control" placeholder="Buscar por nombre..." style="width: 300px;">
                        </div>
                        <div>
                            <a href="generar-boletas-masivas" class="btn btn-success"><i class="bi bi-file-earmark-zip"></i> Generar Todas las Boletas</a>
                        </div>
                    </div>
                    <table id="employeesTable" class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Empleado</th>
                                <th>Especialidad</th>
                                <th>Horas Trabajadas</th>
                                <th>Sueldo Final</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="emp" items="${resumen}">
                                <tr>
                                    <td>${emp.empId}</td>
                                    <td class="employee-name">${emp.nombreEmpleado}</td>
                                    <td>${emp.especialidad}</td>
                                    <td>${emp.horas} h</td>
                                    <td>S/ <fmt:formatNumber value="${emp.sueldoFinal}" pattern="#,##0.00"/></td>
                                    <td>
                                        <a href="resumen?empId=${emp.empId}" class="btn btn-primary btn-sm"><i class="bi bi-eye"></i> Detalles</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <script>
                        document.getElementById('searchInput').addEventListener('input', function () {
                            const searchTerm = this.value.toLowerCase();
                            const rows = document.querySelectorAll('#employeesTable tbody tr');
                            rows.forEach(row => {
                                const nameCell = row.querySelector('.employee-name');
                                const name = nameCell.textContent.toLowerCase();
                                row.style.display = name.includes(searchTerm) ? '' : 'none';
                            });
                        });
                    </script>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>