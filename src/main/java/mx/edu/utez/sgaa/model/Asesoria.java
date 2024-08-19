package mx.edu.utez.sgaa.model;

import java.sql.Time;
import java.util.Date;

public class Asesoria {
    private int idAsesoria;
    private int idDocente;
    private long idMateria;
    private String titulo;
    private Date fecha;
    private Time hora;
    private String DocenteNombre;
    private String DocenteApellido;
    private String nombreMateria;

    public Asesoria() {
    }

    public Asesoria(int idDocente, long idMateria, String titulo, Date fecha, Time hora) {
        this.idDocente = idDocente;
        this.idMateria = idMateria;
        this.titulo = titulo;
        this.fecha = fecha;
        this.hora = hora;
        // Establecer valores predeterminados o null para otros campos
        this.DocenteNombre = "";
        this.DocenteApellido = "";
        this.nombreMateria = "";
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
    public String getDocenteNombre() {
        return DocenteNombre;
    }
    public void setDocenteNombre(String DocenteNombre) {this.DocenteNombre = DocenteNombre;}
    public String getDocenteApellido() {
        return DocenteApellido;
    }
    public void setDocenteApellido(String DocenteApellido) {this.DocenteApellido = DocenteApellido;}
    public String getNombreMateria() {
        return nombreMateria;
    }
    public void setNombreMateria(String nombreMateria) {this.nombreMateria = nombreMateria;}
}
