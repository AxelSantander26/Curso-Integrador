package grupo7.dentalogic.model;

import java.sql.Date;
import java.sql.Time;

public class Marcacion {
    private int empId;
    private Date fecha;
    private Time horaEntrada;
    private Time horaSalida;
    private String estadoEntrada;
    private String estadoSalida;
    private int minTardanza;
    private int minAnticipacion;

    // Getters y Setters
    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public Time getHoraEntrada() { return horaEntrada; }
    public void setHoraEntrada(Time horaEntrada) { this.horaEntrada = horaEntrada; }

    public Time getHoraSalida() { return horaSalida; }
    public void setHoraSalida(Time horaSalida) { this.horaSalida = horaSalida; }

    public String getEstadoEntrada() { return estadoEntrada; }
    public void setEstadoEntrada(String estadoEntrada) { this.estadoEntrada = estadoEntrada; }

    public String getEstadoSalida() { return estadoSalida; }
    public void setEstadoSalida(String estadoSalida) { this.estadoSalida = estadoSalida; }

    public int getMinTardanza() { return minTardanza; }
    public void setMinTardanza(int minTardanza) { this.minTardanza = minTardanza; }

    public int getMinAnticipacion() { return minAnticipacion; }
    public void setMinAnticipacion(int minAnticipacion) { this.minAnticipacion = minAnticipacion; }
}
