package grupo7.dentalogic.model;

import java.sql.Time;
import java.sql.Timestamp;



import java.sql.Time;
import java.sql.Timestamp;

public class Asistencia {
    private int asisId;
    private int empId;
    private String empDni;
    private String empNom;
    private String empApe;
    private String nombreCompleto;
    private Time horaLlegada;
    private String tipoAsistencia;
    private Timestamp fechaRegistroAsis;

    public int getAsisId() {
        return asisId;
    }

    public void setAsisId(int asisId) {
        this.asisId = asisId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getEmpDni() {
        return empDni;
    }

    public void setEmpDni(String empDni) {
        this.empDni = empDni;
    }

    public String getEmpNom() {
        return empNom;
    }

    public void setEmpNom(String empNom) {
        this.empNom = empNom;
    }

    public String getEmpApe() {
        return empApe;
    }

    public void setEmpApe(String empApe) {
        this.empApe = empApe;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public Time getHoraLlegada() {
        return horaLlegada;
    }

    public void setHoraLlegada(Time horaLlegada) {
        this.horaLlegada = horaLlegada;
    }

    public String getTipoAsistencia() {
        return tipoAsistencia;
    }

    public void setTipoAsistencia(String tipoAsistencia) {
        this.tipoAsistencia = tipoAsistencia;
    }

    public Timestamp getFechaRegistroAsis() {
        return fechaRegistroAsis;
    }

    public void setFechaRegistroAsis(Timestamp fechaRegistroAsis) {
        this.fechaRegistroAsis = fechaRegistroAsis;
    }
}
