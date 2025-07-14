package grupo7.dentalogic.model;

import java.util.Map;

public class Dashboard {
    private int totalEmpleados;
    private int totalAsistenciasMes;
    private int totalTardanzasMes;
    private int totalSalidasAnticipadasMes;
    private int totalJustificativosMes;
    private Map<String, Integer> empleadosPorEspecialidad;

    public int getTotalEmpleados() {
        return totalEmpleados;
    }
    public void setTotalEmpleados(int totalEmpleados) {
        this.totalEmpleados = totalEmpleados;
    }

    public int getTotalAsistenciasMes() {
        return totalAsistenciasMes;
    }
    public void setTotalAsistenciasMes(int totalAsistenciasMes) {
        this.totalAsistenciasMes = totalAsistenciasMes;
    }

    public int getTotalTardanzasMes() {
        return totalTardanzasMes;
    }
    public void setTotalTardanzasMes(int totalTardanzasMes) {
        this.totalTardanzasMes = totalTardanzasMes;
    }

    public int getTotalSalidasAnticipadasMes() {
        return totalSalidasAnticipadasMes;
    }
    public void setTotalSalidasAnticipadasMes(int totalSalidasAnticipadasMes) {
        this.totalSalidasAnticipadasMes = totalSalidasAnticipadasMes;
    }

    public int getTotalJustificativosMes() {
        return totalJustificativosMes;
    }
    public void setTotalJustificativosMes(int totalJustificativosMes) {
        this.totalJustificativosMes = totalJustificativosMes;
    }

    public Map<String, Integer> getEmpleadosPorEspecialidad() {
        return empleadosPorEspecialidad;
    }
    public void setEmpleadosPorEspecialidad(Map<String, Integer> empleadosPorEspecialidad) {
        this.empleadosPorEspecialidad = empleadosPorEspecialidad;
    }
}
