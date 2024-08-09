package mx.edu.utez.sgaa.model;

public class MateriasDocentes {
    private int idMateria;
    private String nombreDocente;
    private String nombreMateria;

    public MateriasDocentes(String nombreDocente, String nombreMateria) {
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
}

