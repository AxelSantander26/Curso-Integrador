package grupo7.dentalogic.model;

import java.sql.Date;

public class Empleado {

    private int empId;
    private String empDni;
    private String empNom;
    private String empApe;
    private String empEmail;
    private String empTel;
    private Date empFec;
    private double empSal;
    private String especialidad;
    private Integer espId;

    public Empleado() {
    }

    public Empleado(int empId, String empDni, String empNom, String empApe, String empEmail, String empTel, Date empFec, double empSal, String especialidad, Integer espId) {
        this.empId = empId;
        this.empDni = empDni;
        this.empNom = empNom;
        this.empApe = empApe;
        this.empEmail = empEmail;
        this.empTel = empTel;
        this.empFec = empFec;
        this.empSal = empSal;
        this.especialidad = especialidad;
        this.espId = espId;
    }

    // Getters y Setters
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

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
    }

    public String getEmpTel() {
        return empTel;
    }

    public void setEmpTel(String empTel) {
        this.empTel = empTel;
    }

    public Date getEmpFec() {
        return empFec;
    }

    public void setEmpFec(Date empFec) {
        this.empFec = empFec;
    }

    public double getEmpSal() {
        return empSal;
    }

    public void setEmpSal(double empSal) {
        this.empSal = empSal;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public Integer getEspId() {
        return espId;
    }

    public void setEspId(Integer espId) {
        this.espId = espId;
    }

}