package mx.edu.utez.sgaa.model;

public class Calificacion {
    private long id_asesoria;
    private long id_materia;
    private long id_docente;
    private long id_estudiante;
    private int calificacionEstudiante;
    private int calificacionDocente;

    public Calificacion(long id_asesoria, long id_materia, long id_docente, long id_estudiante, int calificacionEstudiante) {
        this.id_asesoria = id_asesoria;
        this.id_materia = id_materia;
        this.id_docente = id_docente;
        this.id_estudiante = id_estudiante;
        this.calificacionEstudiante = calificacionEstudiante;
    }


    public long getId_asesoria() {
        return id_asesoria;
    }

    public void setId_asesoria(long id_asesoria) {
        this.id_asesoria = id_asesoria;
    }

    public long getId_materia() {
        return id_materia;
    }

    public void setId_materia(long id_materia) {
        this.id_materia = id_materia;
    }

    public long getId_docente() {
        return id_docente;
    }

    public void setId_docente(long id_docente) {
        this.id_docente = id_docente;
    }

    public long getId_estudiante() {
        return id_estudiante;
    }

    public void setId_estudiante(long id_estudiante) {
        this.id_estudiante = id_estudiante;
    }

    public int getCalificacionEstudiante() {
        return calificacionEstudiante;
    }

    public void setCalificacionEstudiante(int calificacionEstudiante) {
        this.calificacionEstudiante = calificacionEstudiante;
    }

    public int getCalificacionDocente() {
        return calificacionDocente;
    }

    public void setCalificacionDocente(int calificacionDocente) {
        this.calificacionDocente = calificacionDocente;
    }
}
