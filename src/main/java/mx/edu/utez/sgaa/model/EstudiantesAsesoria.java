package mx.edu.utez.sgaa.model;

public class EstudiantesAsesoria {
    private int idEstudiante;
    private int idAsesoria;
    private String tema;

    public EstudiantesAsesoria() {
    }

    public EstudiantesAsesoria(int idEstudiante, int idAsesoria, String tema) {
        this.tema = tema;
        this.idAsesoria = idAsesoria;
        this.idEstudiante = idEstudiante;
    }

    public EstudiantesAsesoria(int idEstudiante, int idAsesoria) {
        this.idEstudiante = idEstudiante;
        this.idAsesoria = idAsesoria;
    }

    public int getIdEstudiante() {
        return idEstudiante;
    }

    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }

    public int getIdAsesoria() {
        return idAsesoria;
    }

    public void setIdAsesoria(int idAsesoria) {
        this.idAsesoria = idAsesoria;
    }

    public String getTema() {
        return tema;
    }

    public void setTema(String tema) {
        this.tema = tema;
    }
}
