package mx.edu.utez.sgaa.model;

public class Administrador {
    private String matricula;
    private String contrasena;

    public Administrador(){
    }

    public Administrador(String matricula, String contrasena){
        this.matricula = matricula;
        this.contrasena = contrasena;
    }
    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {}
    public String getContrasena() {
        return contrasena;
    }
    public void setContrasena(String contrasena) {}
}
