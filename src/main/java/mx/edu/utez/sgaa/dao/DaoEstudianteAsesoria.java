package mx.edu.utez.sgaa.dao;
import mx.edu.utez.sgaa.model.Asesoria;
import mx.edu.utez.sgaa.model.EstudiantesAsesoria;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import mx.edu.utez.sgaa.database.DatabaseConnection;
import mx.edu.utez.sgaa.model.HistorialAsesoria;

public class DaoEstudianteAsesoria {
    private Connection connection;



    public DaoEstudianteAsesoria() {
        this.connection = DatabaseConnection.getConnection();
    }

    public void agregarAsesoriaEstudiante(EstudiantesAsesoria estudiantesAsesoria) throws SQLException {
        String query = "INSERT INTO EstudiantesAsesoria (idEstudiante, idAsesoria) VALUES (?, ?)";
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

    public List<Asesoria> obtenerDetallesAsesoriasEstudiante(int idEstudiante) throws SQLException {
        List<Asesoria> asesorias = new ArrayList<>();
        String query = "SELECT a.* FROM Asesorias a " +
                "JOIN EstudiantesAsesorias ea ON a.idAsesoria = ea.idAsesoria " +
                "WHERE ea.idEstudiante = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, idEstudiante);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Asesoria asesoria = new Asesoria();
                    asesoria.setIdAsesoria(rs.getInt("idAsesoria"));
                    asesoria.setIdDocente(rs.getInt("idDocente"));
                    asesoria.setIdMateria(rs.getLong("idMateria"));
                    asesoria.setTitulo(rs.getString("titulo"));
                    asesoria.setFecha(rs.getDate("fecha"));
                    asesoria.setHora(rs.getTime("hora"));
                    asesorias.add(asesoria);
                }
            }
        }
        return asesorias;
    }

    public List<Asesoria> obtenerTodasAsesorias() throws SQLException {
        List<Asesoria> asesorias = new ArrayList<>();
        String query = "SELECT * FROM Asesorias";
        System.out.println("Ejecutando consulta SQL: " + query);

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Asesoria asesoria = new Asesoria();
                asesoria.setIdAsesoria(rs.getInt("idAsesoria"));
                asesoria.setIdDocente(rs.getInt("idDocente"));
                asesoria.setIdMateria(rs.getLong("idMateria"));
                asesoria.setTitulo(rs.getString("titulo"));
                asesoria.setFecha(rs.getDate("fecha"));
                asesoria.setHora(rs.getTime("hora"));
                asesorias.add(asesoria);
                System.out.println("Asesoria encontrada: " + asesoria.getTitulo());
            }
        } catch (SQLException e) {
            System.out.println("Error en la consulta SQL: " + e.getMessage());
        }

        System.out.println("Número de asesorías recuperadas: " + asesorias.size());
        return asesorias;
    }

    public List<HistorialAsesoria> obtenerHistorialAsesoriasPorEstudiante(int idEstudiante) throws SQLException {
        List<HistorialAsesoria> historialAsesorias = new ArrayList<>();

        String query = "SELECT D.Nombre AS Nombre_docente, " +
                "M.Nombre_Materia, A.Fecha, A.Hora " +
                "FROM Historial_asesorias HA " +
                "JOIN Docentes D ON HA.id_Docente = D.idDocente " +
                "JOIN Materias M ON HA.id_Materia = M.idMateria " +
                "JOIN Asesorias A ON HA.id_Asesoria = A.idAsesoria " +
                "JOIN Estudiantes E ON HA.id_Estudiante = E.idEstudiante " +
                "WHERE HA.id_Estudiante = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, idEstudiante);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    HistorialAsesoria historialAsesoria = new HistorialAsesoria();
                    historialAsesoria.setNombreDocente(resultSet.getString("Nombre_docente"));
                    historialAsesoria.setNombreMateria(resultSet.getString("Nombre_Materia"));
                    historialAsesoria.setFecha(resultSet.getDate("Fecha"));
                    historialAsesoria.setHora(resultSet.getTime("Hora"));

                    historialAsesorias.add(historialAsesoria);
                }
            }
        }

        return historialAsesorias;
    }

    public List<HistorialAsesoria> obtenerHistorialAsesoriasPorDocente(int idDocente) throws SQLException {
        List<HistorialAsesoria> historialAsesorias = new ArrayList<>();

        String query = "SELECT E.Nombre AS Nombre_estudiante, " +
                "M.Nombre_Materia, " +
                "A.Fecha, " +
                "A.Hora " +
                "FROM Historial_asesorias HA " +
                "JOIN Docentes D ON HA.id_Docente = D.idDocente " +
                "JOIN Materias M ON HA.id_Materia = M.idMateria " +
                "JOIN Asesorias A ON HA.id_Asesoria = A.idAsesoria " +
                "JOIN Estudiantes E ON HA.id_Estudiante = E.idEstudiante " +
                "WHERE HA.id_Docente = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, idDocente);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    HistorialAsesoria historial = new HistorialAsesoria();
                    historial.setNombreEstudiante(resultSet.getString("Nombre_estudiante"));
                    historial.setNombreMateria(resultSet.getString("Nombre_Materia"));
                    historial.setFecha(resultSet.getDate("Fecha"));
                    historial.setHora(resultSet.getTime("Hora"));

                    historialAsesorias.add(historial);
                }
            }
        }

        return historialAsesorias;
    }

}