package mx.edu.utez.sgaa.model;

import java.sql.Date;
import java.sql.Time;

public class HistorialAsesoria {
    private long id_asesoria;
    private long id_estudiante;
    private long id_docente;
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

    public HistorialAsesoria(long id_asesoria, String nombreEstudiante, String nombreDocente, String nombreMateria, Date fecha, Time hora) {
        this.id_asesoria = id_asesoria;
        this.nombreEstudiante = nombreEstudiante;
        this.nombreDocente = nombreDocente;
        this.nombreMateria = nombreMateria;
        this.fecha = fecha;
        this.hora = hora;
    }

    public HistorialAsesoria(long id_asesoria, long id_estudiante, String nombreEstudiante, String nombreDocente, String nombreMateria, Date fecha, Time hora) {
        this.id_asesoria = id_asesoria;
        this.id_estudiante = id_estudiante;
        this.nombreEstudiante = nombreEstudiante;
        this.nombreDocente = nombreDocente;
        this.nombreMateria = nombreMateria;
        this.fecha = fecha;
        this.hora = hora;
    }

    public HistorialAsesoria(long id_asesoria, long id_estudiante, long id_docente, String nombreEstudiante, String nombreDocente, String nombreMateria, Date fecha, Time hora) {
        this.id_asesoria = id_asesoria;
        this.id_estudiante = id_estudiante;
        this.id_docente = id_docente;
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

    public long getId_asesoria() {
        return id_asesoria;
    }

    public void setId_asesoria(long id_asesoria) {
        this.id_asesoria = id_asesoria;
    }

    public long getId_estudiante() {
        return id_estudiante;
    }

    public void setId_estudiante(long id_estudiante) {
        this.id_estudiante = id_estudiante;
    }

    public long getId_docente() {
        return id_docente;
    }

    public void setId_docente(long id_docente) {
        this.id_docente = id_docente;
    }
}
