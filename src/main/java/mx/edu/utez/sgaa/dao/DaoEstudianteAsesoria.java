package mx.edu.utez.sgaa.dao;
import mx.edu.utez.sgaa.model.Asesoria;
import mx.edu.utez.sgaa.model.EstudiantesAsesoria;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import mx.edu.utez.sgaa.database.DatabaseConnection;
import mx.edu.utez.sgaa.model.HistorialAsesoria;
import mx.edu.utez.sgaa.model.Docente;

import javax.print.Doc;

public class DaoEstudianteAsesoria {
    private Connection connection;



    public DaoEstudianteAsesoria() {
        this.connection = DatabaseConnection.getConnection();
    }

    public void agregarAsesoriaEstudiante(EstudiantesAsesoria estudiantesAsesoria) throws SQLException {
        String query = "INSERT INTO EstudiantesAsesoria (idEstudiante, idAsesoria, tituloAsesoria) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            //if(estudiantesAsesoria.getTema()!= null){
                stmt.setInt(1, estudiantesAsesoria.getIdEstudiante());
                stmt.setInt(2, estudiantesAsesoria.getIdAsesoria());
                stmt.setString(3, estudiantesAsesoria.getTema());

                stmt.executeUpdate();
            //}

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

        String query = "SELECT D.Nombre AS Nombre_docente, " + "HA.id_Asesoria,"+ "HA.id_Docente,"+
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
                    historialAsesoria.setId_asesoria(resultSet.getLong("id_asesoria"));
                    historialAsesoria.setId_docente(resultSet.getLong("id_Docente"));
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

        String query = "SELECT E.Nombre AS Nombre_estudiante," +"HA.id_Asesoria,"+ "HA.id_Estudiante,"+
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
                    historial.setId_asesoria(resultSet.getLong("id_asesoria"));
                    historial.setId_estudiante(resultSet.getLong("id_estudiante"));
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

    public int contarEstudiantesPorAsesoria(int idAsesoria) {
        int count = 0;
        String sql = "SELECT count(*) FROM EstudiantesAsesoria WHERE idAsesoria = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idAsesoria);

            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }



    public int contarEstudiantesPorAsesoriaYReagenda(int idAsesoria) {
        int count = 0;
        String sql = "select count(*) from EstudiantesAsesoria where idAsesoria = ? and reagenda =true;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idAsesoria);

            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public int contarEstudiantesEnAsesoria(int idAsesoria) {
        int count = 0;
        String sql = "SELECT count(*) FROM EstudiantesAsesoria EA " +
                "JOIN Asesorias A ON A.idAsesoria = EA.idAsesoria " +
                "WHERE A.idAsesoria = ? AND A.Estado = 1";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idAsesoria);

            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    count = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }


    public float verDocentesCalificacio(int idDocente) {
        float calificacion = 0.0f;  // Variable para almacenar la calificación
        String sql = "select (AVG(CalificacionDocente)*2) AS Calificacion from Historial_asesorias where id_Docente = ?;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idDocente);

            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    DecimalFormat df = new DecimalFormat("#.#");
                    calificacion = resultSet.getFloat("Calificacion");
                    calificacion = Float.parseFloat(df.format(calificacion));  // Formatea la calificación
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return calificacion;  // Retorna la calificación calculada
    }



    public float verEstudianteCalificacio(int idEstudiante) {
        float calificacion = 0.0f;  // Variable para almacenar la calificación
        String sql = "select (AVG(CalificacionDocente)*2) AS Calificacion from Historial_asesorias where id_Estudiante = ?;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idEstudiante);

            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    DecimalFormat df = new DecimalFormat("#.#");
                    calificacion = resultSet.getFloat("Calificacion");
                    calificacion = Float.parseFloat(df.format(calificacion));  // Formatea la calificación
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return calificacion;  // Retorna la calificación calculada
    }
    public boolean isAsesoriaRegistrada(int idEstudiante, int idAsesoria) throws SQLException {
        String query = "SELECT COUNT(*) FROM EstudiantesAsesoria WHERE idEstudiante = ? AND idAsesoria = ?";
        try(Connection connection = DatabaseConnection.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, idEstudiante);
            preparedStatement.setInt(2, idAsesoria);
            try(ResultSet resultSet = preparedStatement.executeQuery()) {
                if(resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }
        }
        return false;
    }



}