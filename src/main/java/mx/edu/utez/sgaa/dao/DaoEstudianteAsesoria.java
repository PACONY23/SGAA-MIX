package mx.edu.utez.sgaa.dao;
import mx.edu.utez.sgaa.model.EstudiantesAsesoria;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DaoEstudianteAsesoria {
    private Connection connection;

    public DaoEstudianteAsesoria(Connection connection) {
        this.connection = connection;
    }

    public void agregarAsesoriaEstudiante(EstudiantesAsesoria estudiantesAsesoria) throws SQLException {
        String query = "INSERT INTO EstudiantesAsesorias (idEstudiante, idAsesoria) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, estudiantesAsesoria.getIdEstudiante());
            stmt.setInt(2, estudiantesAsesoria.getIdAsesoria());
            stmt.executeUpdate();
        }
    }

    public List<EstudiantesAsesoria> obtenerAsesoriasEstudiante(int idEstudiante) throws SQLException {
        List<EstudiantesAsesoria> asesorias = new ArrayList<>();
        String query = "SELECT * FROM EstudiantesAsesorias WHERE idEstudiante = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, idEstudiante);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    EstudiantesAsesoria asesoria = new EstudiantesAsesoria();
                    asesoria.setIdEstudiante(rs.getInt("idEstudiante"));
                    asesoria.setIdAsesoria(rs.getInt("idAsesoria"));
                    asesorias.add(asesoria);
                }
            }
        }
        return asesorias;
    }
}
