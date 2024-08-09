package mx.edu.utez.sgaa.model;

public class MateriasDocentes {
    private String nombreDocente;
    private String nombreMateria;

    public MateriasDocentes(String nombreDocente, String nombreMateria) {
        this.nombreDocente = nombreDocente;
        this.nombreMateria = nombreMateria;
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

