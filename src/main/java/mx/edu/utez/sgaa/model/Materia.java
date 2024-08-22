package mx.edu.utez.sgaa.model;

public class Materia {
    private Long id;
    private String nombre;
    private boolean materia_estado;

    public Materia() {
    }

    public Materia(String nombre)
    {
        this.nombre = nombre;
        this.id = id;
        this.materia_estado = materia_estado;
    }

    public String getNombre()
    {
        return nombre;
    }
    public void setNombre(String nombre)

    {
        this.nombre = nombre;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public boolean isMateria_estado() {
        return materia_estado;
    }

    public void setMateria_estado(boolean materia_estado) {
        this.materia_estado = materia_estado;
    }
}
