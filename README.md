# Sistema de Control de Asistencias y Nómina - DENTALOGIC

**Docente:** Prof. Carlos Alberto Effio Gonzales

## Equipo de Desarrollo

- **Santander Alcarraz Axel Jesús** - U21322494  
- **Ochoa Alarcón Gerson David** - U22231012  
- **Cocha Parrilla Lucas David** - U22208231

## Estado del Proyecto

- ✅ Capítulo 1: Análisis de la Empresa  
- ✅ Capítulo 2: Análisis de Situación  
- ✅ Capítulo 3: Alternativas de Solución (Completo)  
- ✅ Capítulo 4: Planificación (Completo)  
- ✅ Capítulo 5: Desarrollo de Solución (Completo)  
- ✅ Capítulo 6: Construcción (Completo)  

## Lean Canvas del Proyecto

- [Ver Lean Canvas en Canva](https://www.canva.com/design/DAGisvtjgEY/LeIdnjk1L7KT4MdQGmhwtQ/edit?utm_content=DAGisvtjgEY&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

---

## Descripción

**DENTALOGIC** es un sistema interno diseñado para gestionar la **asistencia del personal** y automatizar la **generación de nóminas** en una clínica dental. Permite llevar un control detallado de entradas, salidas, tardanzas, ausencias y justificativos, optimizando así la administración del recurso humano.

El sistema cuenta con dos tipos de usuario:

- **Empleado (Dentista)**: marca su asistencia de entrada y salida.
- **Administrador**: accede a todos los módulos de gestión y reportes.

## Problemática

La clínica presenta diversos problemas en la gestión del personal:

- Impuntualidad frecuente de los trabajadores.
- Ausencias sin registro ni seguimiento.
- Cálculo manual de descuentos en pagos.
- Falta de evidencia para justificar inasistencias.
- No existe un sistema centralizado de control.

## Objetivos

- Registrar las **entradas y salidas** del personal en tiempo real.
- Identificar y calcular automáticamente **tardanzas** y **salidas anticipadas**.
- Permitir la carga y validación de **justificativos** de ausencias.
- Generar la **nómina mensual** aplicando **descuentos** por faltas o impuntualidades.
- Brindar al administrador una **vista general por empleado y por mes**.
- Facilitar la exportación de información y la generación masiva de boletas de pago.

## Módulos del Sistema

1. **Dashboard Administrativo (Resumen general)**  
   - Muestra datos generales y resúmenes de asistencias, justificativos y nómina.

2. **Módulo de Administración de Empleados**  
   - Permite registrar y gestionar información de los empleados.

3. **Módulo de Asistencia del Personal**  
   - Visualiza las asistencias de todos los empleados mes a mes.
   - Incluye detalles como:
     - Hora de llegada.
     - Hora de salida.
     - Salidas anticipadas.
     - Tardanzas.
     - Faltas.
     - Estado de justificación de cada incidencia.

4. **Módulo de Justificaciones**  
   - Permite crear justificativos por rangos de fechas.
   - Asocia automáticamente los justificativos con los registros de asistencia.

5. **Módulo de Nómina Automatizada**  
   - Muestra una lista de empleados con:
     - Horas trabajadas en el mes.
     - Sueldo final proyectado.
   - Opción **Ver Detalles** para cada empleado, mostrando:
     - Todas las asistencias del mes.
     - Hora de llegada y estado de justificación.
     - Resumen de minutos de descuento por tardanza, salida anticipada o faltas.
     - Cálculo final del sueldo considerando los descuentos.
   - Permite:
     - Generar la boleta de pago individual del mes.
     - Generar las boletas de todos los empleados en un archivo `.zip`.

6. **Exportación e Historial de Pagos**  
   - Permite descargar reportes de nómina y mantener un historial de boletas generadas.

---

> Proyecto desarrollado con fines académicos. Universidad Tecnológica del Perú – 2025.
