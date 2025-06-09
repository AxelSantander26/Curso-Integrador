
package grupo7.dentalogic.model;

public class DetallePago {
    private int detpId;
    private int empId;
    private int pagId = 1; // Por defecto
    private int perId;
    private int bonoId;
    private double detpMon;
    private double descuentoTotal;
    private double sueldoNeto;

    // Nuevos campos para mostrar
    private String empleadoNombre;
    private String periodoNombre;

    // Nuevos atributos agregados
    private double sueldoBase; // equivale a emp_sal
    private double bonoMonto;  // equivale a bono_can

    // Getters y Setters
    public int getDetpId() { return detpId; }
    public void setDetpId(int detpId) { this.detpId = detpId; }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public int getPagId() { return pagId; }
    public void setPagId(int pagId) { this.pagId = pagId; }

    public int getPerId() { return perId; }
    public void setPerId(int perId) { this.perId = perId; }

    public int getBonoId() { return bonoId; }
    public void setBonoId(int bonoId) { this.bonoId = bonoId; }

    public double getDetpMon() { return detpMon; }
    public void setDetpMon(double detpMon) { this.detpMon = detpMon; }

    public double getDescuentoTotal() { return descuentoTotal; }
    public void setDescuentoTotal(double descuentoTotal) { this.descuentoTotal = descuentoTotal; }

    public double getSueldoNeto() { return sueldoNeto; }
    public void setSueldoNeto(double sueldoNeto) { this.sueldoNeto = sueldoNeto; }

    public String getEmpleadoNombre() { return empleadoNombre; }
    public void setEmpleadoNombre(String empleadoNombre) { this.empleadoNombre = empleadoNombre; }

    public String getPeriodoNombre() { return periodoNombre; }
    public void setPeriodoNombre(String periodoNombre) { this.periodoNombre = periodoNombre; }

    public double getSueldoBase() { return sueldoBase; }
    public void setSueldoBase(double sueldoBase) { this.sueldoBase = sueldoBase; }

    public double getBonoMonto() { return bonoMonto; }
    public void setBonoMonto(double bonoMonto) { this.bonoMonto = bonoMonto; }
}
