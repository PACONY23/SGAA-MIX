package mx.edu.utez.sgaa.servlet.Docente.nuevoSV;


import java.sql.Date;
import java.sql.Time;

public class Asesoria2 {
    private int idDocente;
    private long idMateria;
    private String titulo;
    private Date fecha;
    private Time hora;

    public Asesoria2(int idDocente, long idMateria, String titulo, Date fecha, Time hora) {
        this.idDocente = idDocente;
        this.idMateria = idMateria;
        this.titulo = titulo;
        this.fecha = fecha;
        this.hora = hora;
    }

    public int getIdDocente() {
        return idDocente;
    }

    public void setIdDocente(int idDocente) {
        this.idDocente = idDocente;
    }

    public long getIdMateria() {
        return idMateria;
    }

    public void setIdMateria(long idMateria) {
        this.idMateria = idMateria;
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
