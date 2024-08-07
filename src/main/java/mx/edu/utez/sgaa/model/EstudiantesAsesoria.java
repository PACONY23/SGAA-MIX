package mx.edu.utez.sgaa.model;

public class EstudiantesAsesoria {
    private int idEstudiante;
    private int idAsesoria;

    public EstudiantesAsesoria() {
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
}
