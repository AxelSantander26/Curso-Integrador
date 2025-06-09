package grupo7.dentalogic.model;

public class DashboardInfo {
    private int totalEmpleados;
    private int totalBonos;
    private int asistenciasHoy;
    private double totalPagar;

    public DashboardInfo() {}

    public int getTotalEmpleados() {
        return totalEmpleados;
    }

    public void setTotalEmpleados(int totalEmpleados) {
        this.totalEmpleados = totalEmpleados;
    }

    public int getTotalBonos() {
        return totalBonos;
    }

    public void setTotalBonos(int totalBonos) {
        this.totalBonos = totalBonos;
    }

    public int getAsistenciasHoy() {
        return asistenciasHoy;
    }

    public void setAsistenciasHoy(int asistenciasHoy) {
        this.asistenciasHoy = asistenciasHoy;
    }

    public double getTotalPagar() {
        return totalPagar;
    }

    public void setTotalPagar(double totalPagar) {
        this.totalPagar = totalPagar;
    }
}
