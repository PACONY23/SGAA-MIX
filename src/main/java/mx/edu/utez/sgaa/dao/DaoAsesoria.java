package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.model.Asesoria;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DaoAsesoria {
    private Connection connection;

    public DaoAsesoria(Connection connection) {
        this.connection = connection;
    }

    public void crearAsesoria(Asesoria asesoria) throws SQLException {
        String query = "INSERT INTO Asesorias (idDocente, idMateria, titulo, fecha, hora) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, asesoria.getIdDocente());
            stmt.setLong(2, asesoria.getIdMateria());
            stmt.setString(3, asesoria.getTitulo());

            // Convertir java.util.Date a java.sql.Date
            java.sql.Date sqlDate = new java.sql.Date(asesoria.getFecha().getTime());
            stmt.setDate(4, sqlDate);

            stmt.setTime(5, asesoria.getHora());
            stmt.executeUpdate();
        }
    }

    public List<Asesoria> obtenerAsesorias() throws SQLException {
        List<Asesoria> asesorias = new ArrayList<>();
        String query = "SELECT * FROM Asesorias";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Asesoria asesoria = new Asesoria();
                asesoria.setIdAsesoria(rs.getInt("idAsesoria"));
                asesoria.setIdDocente(rs.getInt("idDocente"));
                asesoria.setIdMateria(rs.getLong("idMateria"));
                asesoria.setTitulo(rs.getString("titulo"));

                // Convertir java.sql.Date a java.util.Date
                asesoria.setFecha(new java.util.Date(rs.getDate("fecha").getTime()));

                asesoria.setHora(rs.getTime("hora"));
                asesorias.add(asesoria);
            }
        }
        return asesorias;
    }

    public void eliminarAsesoria(int idAsesoria) throws SQLException {
        String query = "DELETE FROM Asesorias WHERE idAsesoria = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, idAsesoria);
            stmt.executeUpdate();
        }
    }

    public void actualizarAsesoria(Asesoria asesoria) throws SQLException {
        String query = "UPDATE Asesorias SET idDocente = ?, idMateria = ?, titulo = ?, fecha = ?, hora = ? WHERE idAsesoria = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, asesoria.getIdDocente());
            stmt.setLong(2, asesoria.getIdMateria());
            stmt.setString(3, asesoria.getTitulo());

            // Convertir java.util.Date a java.sql.Date
            java.sql.Date sqlDate = new java.sql.Date(asesoria.getFecha().getTime());
            stmt.setDate(4, sqlDate);

            stmt.setTime(5, asesoria.getHora());
            stmt.setInt(6, asesoria.getIdAsesoria());
            stmt.executeUpdate();
        }
    }

}
