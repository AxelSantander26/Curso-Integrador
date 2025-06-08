package grupo7.dentalogic.model;

import java.sql.Date;
import java.sql.Time;

public class MarcacionModel {
    private int empId;  // ID del empleado
    private Date fecha;  // Fecha de la marcación
    private Time horaEntradaMarcada;  // Hora de entrada del empleado
    private String estado;  // Estado de la asistencia ("PUNTUAL", "TARDANZA", "FALTA")
    
    // Constructor
    public MarcacionModel(int empId, Date fecha, Time horaEntradaMarcada, String estado) {
        this.empId = empId;
        this.fecha = fecha;
        this.horaEntradaMarcada = horaEntradaMarcada;
        this.estado = estado;
    }

    // Getters y setters
    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Time getHoraEntradaMarcada() {
        return horaEntradaMarcada;
    }

    public void setHoraEntradaMarcada(Time horaEntradaMarcada) {
        this.horaEntradaMarcada = horaEntradaMarcada;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
