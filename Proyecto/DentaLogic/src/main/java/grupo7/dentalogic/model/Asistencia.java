package grupo7.dentalogic.model;

import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class Asistencia {
    private int asiId;
    private int empId;
    private String nombreCompletoEmpleado;
    private Date fecha;
    private Time horaEntrada;
    private Time horaSalida;
    private String estadoEntrada;
    private String estadoSalida;
    private int minTardanza;
    private int minAnticipacion;
    private boolean justificado;
    private String horaEntrada12h;
    private String horaSalida12h;
    
    // Constructor
    public Asistencia() {
    }
    
    // Método para convertir formato de hora
    private String convertirHora12h(Time hora) {
        if (hora == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("h:mm a", Locale.getDefault());
        return sdf.format(hora);
    }
    
    // Getters y setters
    public int getAsiId() {
        return asiId;
    }

    public void setAsiId(int asiId) {
        this.asiId = asiId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getNombreCompletoEmpleado() {
        return nombreCompletoEmpleado;
    }

    public void setNombreCompletoEmpleado(String nombreCompletoEmpleado) {
        this.nombreCompletoEmpleado = nombreCompletoEmpleado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Time getHoraEntrada() {
        return horaEntrada;
    }

    public void setHoraEntrada(Time horaEntrada) {
        this.horaEntrada = horaEntrada;
        this.horaEntrada12h = convertirHora12h(horaEntrada);
    }

    public Time getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(Time horaSalida) {
        this.horaSalida = horaSalida;
        this.horaSalida12h = convertirHora12h(horaSalida);
    }

    public String getEstadoEntrada() {
        return estadoEntrada;
    }

    public void setEstadoEntrada(String estadoEntrada) {
        this.estadoEntrada = estadoEntrada;
    }

    public String getEstadoSalida() {
        return estadoSalida;
    }

    public void setEstadoSalida(String estadoSalida) {
        this.estadoSalida = estadoSalida;
    }

    public int getMinTardanza() {
        return minTardanza;
    }

    public void setMinTardanza(int minTardanza) {
        this.minTardanza = minTardanza;
    }

    public int getMinAnticipacion() {
        return minAnticipacion;
    }

    public void setMinAnticipacion(int minAnticipacion) {
        this.minAnticipacion = minAnticipacion;
    }

    public boolean isJustificado() {
        return justificado;
    }

    public void setJustificado(boolean justificado) {
        this.justificado = justificado;
    }

    public String getHoraEntrada12h() {
        return horaEntrada12h;
    }

    public String getHoraSalida12h() {
        return horaSalida12h;
    }
}