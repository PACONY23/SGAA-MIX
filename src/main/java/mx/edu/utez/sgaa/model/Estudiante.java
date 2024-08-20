package mx.edu.utez.sgaa.model;

public class Estudiante {
    private int id;
    private String nombre;
    private String apellido;
    private String contrasena;
    private String matricula;
    private String grupo;
    private String cuatrimestre;
    private String correoElectronico;
    private boolean estatus;
    private String rol;

    public Estudiante() {
    }

    public Estudiante(int id,String nombre, String apellido, String contrasena, String matricula, String grupo, String cuatrimestre, String correoElectronico, boolean estatus, String rol) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.contrasena = contrasena;
        this.matricula = matricula;
        this.grupo = grupo;
        this.cuatrimestre = cuatrimestre;
        this.correoElectronico = correoElectronico;
        this.estatus = estatus;
        this.rol = rol;
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

    public String getCuatrimestre() {
        return cuatrimestre;
    }

    public void setCuatrimestre(String cuatrimestre) {
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

    public String getRol() {
        return rol;
    }
    public void setRol(String rol) {}

    public int getId() {
        return id;
    }
    public void setId(int id) {
    }
}
