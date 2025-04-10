
package grupo7.dentalogic.model;

public class Usuario {

    private int idUsuario;
    private int idEmpleado;
    private String email;
    private String password;
    private int idRol;
    private boolean activo;
    private String nombre;
    private String apellido;
    private String rol;

    public Usuario() {
    }

    public Usuario(int idUsuario, int idEmpleado, String email, String password, int idRol, boolean activo, String nombre, String apellido, String rol) {
        this.idUsuario = idUsuario;
        this.idEmpleado = idEmpleado;
        this.email = email;
        this.password = password;
        this.idRol = idRol;
        this.activo = activo;
        this.nombre = nombre;
        this.apellido = apellido;
        this.rol = rol;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getIdRol() {
        return idRol;
    }

    public void setIdRol(int idRol) {
        this.idRol = idRol;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
}
