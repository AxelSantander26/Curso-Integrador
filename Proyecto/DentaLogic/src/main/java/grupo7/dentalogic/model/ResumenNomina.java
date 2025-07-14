package grupo7.dentalogic.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class ResumenNomina {
    private int empId;
    private String nombreEmpleado;
    private String especialidad;
    private int horas;
    private int tardanza;
    private int anticipacion;
    private int faltas;
    private BigDecimal sueldoHora = BigDecimal.ZERO;
    private Time horaEntradaHorario;
    private Time horaSalidaHorario;
    private int diasLaborablesMes;
    private String[] fechas;
    private Time[] horasEntrada;
    private Time[] horasSalida;
    private String[] estadosEntrada;
    private String[] estadosSalida;
    private int[] minutosTardanza;
    private int[] minutosAnticipacion;
    private boolean[] justificados;
    private boolean[] esFinSemana;
    private BigDecimal sueldoBaseEsperado;
    private BigDecimal descuentoTardanzas;
    private BigDecimal descuentoAnticipaciones;
    private BigDecimal descuentoFaltas;
    private BigDecimal sueldoFinal;
    private int horasEsperadas;

    public String getHoraEntrada12h(int index) {
        if (horasEntrada == null || index < 0 || index >= horasEntrada.length || horasEntrada[index] == null) 
            return "-";
        return new SimpleDateFormat("hh:mm a", Locale.getDefault()).format(horasEntrada[index]);
    }

    public String getHoraSalida12h(int index) {
        if (horasSalida == null || index < 0 || index >= horasSalida.length || horasSalida[index] == null) 
            return "-";
        return new SimpleDateFormat("hh:mm a", Locale.getDefault()).format(horasSalida[index]);
    }

    public int getHorasPorDia() {
        if (horaEntradaHorario == null || horaSalidaHorario == null) return 8;
        long diffMs = horaSalidaHorario.getTime() - horaEntradaHorario.getTime();
        if (diffMs < 0) diffMs += 24 * 60 * 60 * 1000;
        return (int) (diffMs / (1000 * 60 * 60));
    }

    public void calcularTotales() {
        this.horasEsperadas = this.diasLaborablesMes * this.getHorasPorDia();
        this.sueldoBaseEsperado = sueldoHora.multiply(new BigDecimal(horasEsperadas));
        
        int tardanzaReal = 0;
        int anticipacionReal = 0;
        int faltasReales = 0;
        
        if (fechas != null && estadosEntrada != null && justificados != null && 
            esFinSemana != null && minutosTardanza != null && minutosAnticipacion != null) {
            for (int i = 0; i < fechas.length; i++) {
                if (!esFinSemana[i] && !justificados[i]) {
                    tardanzaReal += minutosTardanza[i];
                    anticipacionReal += minutosAnticipacion[i];
                    if ("FALTA".equals(estadosEntrada[i])) {
                        faltasReales++;
                    }
                }
            }
        } else {
            tardanzaReal = tardanza;
            anticipacionReal = anticipacion;
            faltasReales = faltas;
        }
        
        BigDecimal minutosPorHora = new BigDecimal(60);
        this.descuentoTardanzas = sueldoHora.multiply(new BigDecimal(tardanzaReal).divide(minutosPorHora, 2, RoundingMode.HALF_UP));
        this.descuentoAnticipaciones = sueldoHora.multiply(new BigDecimal(anticipacionReal).divide(minutosPorHora, 2, RoundingMode.HALF_UP));
        this.descuentoFaltas = sueldoHora.multiply(new BigDecimal(faltasReales * this.getHorasPorDia()));
        this.sueldoFinal = sueldoBaseEsperado.subtract(descuentoTardanzas).subtract(descuentoAnticipaciones).subtract(descuentoFaltas);
    }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }
    public String getNombreEmpleado() { return nombreEmpleado; }
    public void setNombreEmpleado(String nombreEmpleado) { this.nombreEmpleado = nombreEmpleado; }
    public String getEspecialidad() { return especialidad; }
    public void setEspecialidad(String especialidad) { this.especialidad = especialidad; }
    public int getHoras() { return horas; }
    public void setHoras(int horas) { this.horas = horas; }
    public int getTardanza() { return tardanza; }
    public void setTardanza(int tardanza) { this.tardanza = tardanza; }
    public int getAnticipacion() { return anticipacion; }
    public void setAnticipacion(int anticipacion) { this.anticipacion = anticipacion; }
    public int getFaltas() { return faltas; }
    public void setFaltas(int faltas) { this.faltas = faltas; }
    public BigDecimal getSueldoHora() { return sueldoHora; }
    public void setSueldoHora(BigDecimal sueldoHora) { this.sueldoHora = sueldoHora; }
    public Time getHoraEntradaHorario() { return horaEntradaHorario; }
    public void setHoraEntradaHorario(Time horaEntradaHorario) { this.horaEntradaHorario = horaEntradaHorario; }
    public Time getHoraSalidaHorario() { return horaSalidaHorario; }
    public void setHoraSalidaHorario(Time horaSalidaHorario) { this.horaSalidaHorario = horaSalidaHorario; }
    public int getDiasLaborablesMes() { return diasLaborablesMes; }
    public void setDiasLaborablesMes(int diasLaborablesMes) { this.diasLaborablesMes = diasLaborablesMes; }
    public String[] getFechas() { return fechas; }
    public void setFechas(String[] fechas) { this.fechas = fechas; }
    public Time[] getHorasEntrada() { return horasEntrada; }
    public void setHorasEntrada(Time[] horasEntrada) { this.horasEntrada = horasEntrada; }
    public Time[] getHorasSalida() { return horasSalida; }
    public void setHorasSalida(Time[] horasSalida) { this.horasSalida = horasSalida; }
    public String[] getEstadosEntrada() { return estadosEntrada; }
    public void setEstadosEntrada(String[] estadosEntrada) { this.estadosEntrada = estadosEntrada; }
    public String[] getEstadosSalida() { return estadosSalida; }
    public void setEstadosSalida(String[] estadosSalida) { this.estadosSalida = estadosSalida; }
    public int[] getMinutosTardanza() { return minutosTardanza; }
    public void setMinutosTardanza(int[] minutosTardanza) { this.minutosTardanza = minutosTardanza; }
    public int[] getMinutosAnticipacion() { return minutosAnticipacion; }
    public void setMinutosAnticipacion(int[] minutosAnticipacion) { this.minutosAnticipacion = minutosAnticipacion; }
    public boolean[] getJustificados() { return justificados; }
    public void setJustificados(boolean[] justificados) { this.justificados = justificados; }
    public boolean[] getEsFinSemana() { return esFinSemana; }
    public void setEsFinSemana(boolean[] esFinSemana) { this.esFinSemana = esFinSemana; }
    public BigDecimal getSueldoBaseEsperado() { return sueldoBaseEsperado; }
    public void setSueldoBaseEsperado(BigDecimal sueldoBaseEsperado) { this.sueldoBaseEsperado = sueldoBaseEsperado; }
    public BigDecimal getDescuentoTardanzas() { return descuentoTardanzas; }
    public void setDescuentoTardanzas(BigDecimal descuentoTardanzas) { this.descuentoTardanzas = descuentoTardanzas; }
    public BigDecimal getDescuentoAnticipaciones() { return descuentoAnticipaciones; }
    public void setDescuentoAnticipaciones(BigDecimal descuentoAnticipaciones) { this.descuentoAnticipaciones = descuentoAnticipaciones; }
    public BigDecimal getDescuentoFaltas() { return descuentoFaltas; }
    public void setDescuentoFaltas(BigDecimal descuentoFaltas) { this.descuentoFaltas = descuentoFaltas; }
    public BigDecimal getSueldoFinal() { return sueldoFinal; }
    public void setSueldoFinal(BigDecimal sueldoFinal) { this.sueldoFinal = sueldoFinal; }
    public int getHorasEsperadas() { return horasEsperadas; }
    public void setHorasEsperadas(int horasEsperadas) { this.horasEsperadas = horasEsperadas; }
}