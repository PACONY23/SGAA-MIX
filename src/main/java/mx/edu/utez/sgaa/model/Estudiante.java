package mx.edu.utez.sgaa.model;

public class Estudiante {
    private String nombre;
    private String apellido;
    private String contrasena;
    private String matricula;
    private String grupo;
    private int cuatrimestre;
    private String correoElectronico;
    private boolean estatus;

    public Estudiante() {
    }

    public Estudiante(String nombre, String apellido, String contrasena, String matricula, String grupo, int cuatrimestre, String correoElectronico, boolean estatus) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.contrasena = contrasena;
        this.matricula = matricula;
        this.grupo = grupo;
        this.cuatrimestre = cuatrimestre;
        this.correoElectronico = correoElectronico;
        this.estatus = estatus;
    }

    // Getters y setters para todos los campos, incluyendo estatus

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

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getGrupo() {
        return grupo;
    }

    public void setGrupo(String grupo) {
        this.grupo = grupo;
    }

    public int getCuatrimestre() {
        return cuatrimestre;
    }

    public void setCuatrimestre(int cuatrimestre) {
        this.cuatrimestre = cuatrimestre;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    public boolean getEstatus() {
        return estatus;
    }

    public void setEstatus(boolean estatus) {
        this.estatus = estatus;
    }
}
