package mx.edu.utez.sgaa.model;

public class Docente {
    private int id;
    private String nombres;
    private String apellidos;
    private String matricula;
    private String contrasena;
    private String correoElectronico;
    private boolean estatus; // Asegúrate de agregar este campo
    private boolean admission;
    private String rol;

    public Docente() {
    }

    public Docente(String nombres, String apellidos, String matricula, String contrasena, String correoElectronico, boolean estatus, boolean admission, String rol) {
        this.id = id;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.matricula = matricula;
        this.contrasena = contrasena;
        this.correoElectronico = correoElectronico;
        this.estatus = estatus;
        this.admission = admission;
        this.rol = rol;
    }

    // Agrega getters y setters para 'estatus'


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean getEstatus() {
        return estatus;
    }

    public boolean isEstatus() {
        return estatus;
    }

    public void setEstatus(boolean estatus) {
        this.estatus = estatus;
    }

    // Otros getters y setters...

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    public boolean isAdmission() {
        return admission;
    }

    public void setAdmission(boolean admission) {
        this.admission = admission;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {}

}
