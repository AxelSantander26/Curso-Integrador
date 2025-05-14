package grupo7.dentalogic.model;

public class Bono {

    private int bonoId;
    private String bonoNom;
    private double bonoCan;
    private String bonoDesc;

    public Bono() {}

    public Bono(int bonoId, String bonoNom, double bonoCan, String bonoDesc) {
        this.bonoId = bonoId;
        this.bonoNom = bonoNom;
        this.bonoCan = bonoCan;
        this.bonoDesc = bonoDesc;
    }

    public int getBonoId() {
        return bonoId;
    }

    public void setBonoId(int bonoId) {
        this.bonoId = bonoId;
    }

    public String getBonoNom() {
        return bonoNom;
    }

    public void setBonoNom(String bonoNom) {
        this.bonoNom = bonoNom;
    }

    public double getBonoCan() {
        return bonoCan;
    }

    public void setBonoCan(double bonoCan) {
        this.bonoCan = bonoCan;
    }

    public String getBonoDesc() {
        return bonoDesc;
    }

    public void setBonoDesc(String bonoDesc) {
        this.bonoDesc = bonoDesc;
    }
}
