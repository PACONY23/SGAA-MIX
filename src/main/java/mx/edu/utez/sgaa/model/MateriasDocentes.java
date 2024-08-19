package mx.edu.utez.sgaa.model;

public class MateriasDocentes {
    private int idMateria;
    private String nombreDocente;
    private String nombreMateria;

    public MateriasDocentes(int idMateria, String nombreDocente, String nombreMateria) {
        this.idMateria = idMateria;
        this.nombreDocente = nombreDocente;
        this.nombreMateria = nombreMateria;
    }

    public int getIdMateria() {
        return idMateria;
    }

    public void setIdMateria(int idMateria) {
        this.idMateria = idMateria;
    }

    public String getNombreDocente() {
        return nombreDocente;
    }

    public String getNombreMateria() {
        return nombreMateria;
    }

    @Override
    public String toString() {
        return "Docente: " + nombreDocente + ", Materia: " + nombreMateria;
    }

    public void setNombreDocente(String nombreDocente) {
        this.nombreDocente = nombreDocente;
    }

    public void setNombreMateria(String nombreMateria) {
        this.nombreMateria = nombreMateria;
    }

    public MateriasDocentes() {
    }
}

