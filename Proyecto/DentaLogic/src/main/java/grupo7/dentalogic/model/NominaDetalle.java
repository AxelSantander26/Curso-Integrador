 
package grupo7.dentalogic.model;
import java.math.BigDecimal;
import java.sql.Date;
public class NominaDetalle {

    private int detId;
    private int nomId;
    private int empId;
    private String nombreEmpleado;
    private int horasTrabajadas;
    private int minTardanza;
    private int minAnticipacion;
    private int faltas;
    private BigDecimal sueldoBruto;
    private BigDecimal descuentoTotal;
    private BigDecimal sueldoNeto;
    private BigDecimal tarifaHora;

    // Getters y Setters
    public int getDetId() {
        return detId;
    }

    public void setDetId(int detId) {
        this.detId = detId;
    }

    public int getNomId() {
        return nomId;
    }

    public void setNomId(int nomId) {
        this.nomId = nomId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getNombreEmpleado() {
        return nombreEmpleado;
    }

    public void setNombreEmpleado(String nombreEmpleado) {
        this.nombreEmpleado = nombreEmpleado;
    }

    public int getHorasTrabajadas() {
        return horasTrabajadas;
    }

    public void setHorasTrabajadas(int horasTrabajadas) {
        this.horasTrabajadas = horasTrabajadas;
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

    public int getFaltas() {
        return faltas;
    }

    public void setFaltas(int faltas) {
        this.faltas = faltas;
    }

    public BigDecimal getSueldoBruto() {
        return sueldoBruto;
    }

    public void setSueldoBruto(BigDecimal sueldoBruto) {
        this.sueldoBruto = sueldoBruto;
    }

    public BigDecimal getDescuentoTotal() {
        return descuentoTotal;
    }

    public void setDescuentoTotal(BigDecimal descuentoTotal) {
        this.descuentoTotal = descuentoTotal;
    }

    public BigDecimal getSueldoNeto() {
        return sueldoNeto;
    }

    public void setSueldoNeto(BigDecimal sueldoNeto) {
        this.sueldoNeto = sueldoNeto;
    }

    public BigDecimal getTarifaHora() {
        return tarifaHora;
    }

    public void setTarifaHora(BigDecimal tarifaHora) {
        this.tarifaHora = tarifaHora;
    }
}
