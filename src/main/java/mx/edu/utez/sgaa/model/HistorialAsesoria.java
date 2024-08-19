package mx.edu.utez.sgaa.model;

public class HistorialAsesoria {
    private String nombreEstudiante;
    private String nombreDocente;
    private String nombreMateria;
    private java.sql.Date fecha;
    private java.sql.Time hora;

    // Constructor vacío
    public HistorialAsesoria() {}

    // Constructor con parámetros
    public HistorialAsesoria(String nombreEstudiante, String nombreDocente, String nombreMateria, java.sql.Date fecha, java.sql.Time hora) {
        this.nombreEstudiante = nombreEstudiante;
        this.nombreDocente = nombreDocente;
        this.nombreMateria = nombreMateria;
        this.fecha = fecha;
        this.hora = hora;
    }

    // Getters y Setters
    public String getNombreEstudiante() {
        return nombreEstudiante;
    }

    public void setNombreEstudiante(String nombreEstudiante) {
        this.nombreEstudiante = nombreEstudiante;
    }

    public String getNombreDocente() {
        return nombreDocente;
    }

    public void setNombreDocente(String nombreDocente) {
        this.nombreDocente = nombreDocente;
    }

    public String getNombreMateria() {
        return nombreMateria;
    }

    public void setNombreMateria(String nombreMateria) {
        this.nombreMateria = nombreMateria;
    }

    public java.sql.Date getFecha() {
        return fecha;
    }

    public void setFecha(java.sql.Date fecha) {
        this.fecha = fecha;
    }

    public java.sql.Time getHora() {
        return hora;
    }

    public void setHora(java.sql.Time hora) {
        this.hora = hora;
    }
}
