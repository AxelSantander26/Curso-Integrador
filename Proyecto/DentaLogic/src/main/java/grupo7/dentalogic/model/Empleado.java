package grupo7.dentalogic.model;

public class Empleado {
    private int empId;
    private String empNombre;
    private String empApellido;
    private String empDni;
    private int espId;
    private String especialidad; // nombre
    private int horId;
    private String horario; // texto combinado "08:00 – 14:00"

    // Getters y Setters

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public String getEmpNombre() { return empNombre; }
    public void setEmpNombre(String empNombre) { this.empNombre = empNombre; }

    public String getEmpApellido() { return empApellido; }
    public void setEmpApellido(String empApellido) { this.empApellido = empApellido; }

    public String getEmpDni() { return empDni; }
    public void setEmpDni(String empDni) { this.empDni = empDni; }

    public int getEspId() { return espId; }
    public void setEspId(int espId) { this.espId = espId; }

    public String getEspecialidad() { return especialidad; }
    public void setEspecialidad(String especialidad) { this.especialidad = especialidad; }

    public int getHorId() { return horId; }
    public void setHorId(int horId) { this.horId = horId; }

    public String getHorario() { return horario; }
    public void setHorario(String horario) { this.horario = horario; }
}
