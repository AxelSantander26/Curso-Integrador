package grupo7.dentalogic.model;

import java.util.Date;

public class PeriodoPago {
    private int perId;
    private Date perIni;
    private Date perFin;
    private String perNom;
    private String perDesc;

    public PeriodoPago() {}

    public PeriodoPago(int perId, Date perIni, Date perFin, String perNom, String perDesc) {
        this.perId = perId;
        this.perIni = perIni;
        this.perFin = perFin;
        this.perNom = perNom;
        this.perDesc = perDesc;
    }

    public int getPerId() {
        return perId;
    }

    public void setPerId(int perId) {
        this.perId = perId;
    }

    public Date getPerIni() {
        return perIni;
    }

    public void setPerIni(Date perIni) {
        this.perIni = perIni;
    }

    public Date getPerFin() {
        return perFin;
    }

    public void setPerFin(Date perFin) {
        this.perFin = perFin;
    }

    public String getPerNom() {
        return perNom;
    }

    public void setPerNom(String perNom) {
        this.perNom = perNom;
    }

    public String getPerDesc() {
        return perDesc;
    }

    public void setPerDesc(String perDesc) {
        this.perDesc = perDesc;
    }
}
