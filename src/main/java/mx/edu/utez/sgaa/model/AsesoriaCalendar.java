package mx.edu.utez.sgaa.model;

import java.sql.Time;
import java.util.Date;

public class AsesoriaCalendar {
    private int idAsesoria;
    private int idDocente;
    private Materia materia;
    private String titulo;
    private Date fecha;
    private Time hora;

    public AsesoriaCalendar() {
    }

    public AsesoriaCalendar(int idDocente, Materia materia, String titulo, Date fecha, Time hora) {
        this.idDocente = idDocente;
        this.materia = materia;
        this.titulo = titulo;
        this.fecha = fecha;
        this.hora = hora;
    }

    public AsesoriaCalendar(int idAsesoria, int idDocente, Materia materia, String titulo, Date fecha, Time hora) {
        this.idAsesoria = idAsesoria;
        this.idDocente = idDocente;
        this.materia = materia;
        this.titulo = titulo;
        this.fecha = fecha;
        this.hora = hora;
    }

    public int getIdAsesoria() {
        return idAsesoria;
    }

    public void setIdAsesoria(int idAsesoria) {
        this.idAsesoria = idAsesoria;
    }

    public int getIdDocente() {
        return idDocente;
    }

    public void setIdDocente(int idDocente) {
        this.idDocente = idDocente;
    }

    public Materia getMateria() {
        return materia;
    }

    public void setMateria(Materia materia) {
        this.materia = materia;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Time getHora() {
        return hora;
    }

    public void setHora(Time hora) {
        this.hora = hora;
    }
}
