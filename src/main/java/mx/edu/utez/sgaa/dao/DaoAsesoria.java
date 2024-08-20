package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.model.Asesoria;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import mx.edu.utez.sgaa.database.DatabaseConnection;
public class DaoAsesoria {
    private Connection connection;

    public DaoAsesoria(Connection connection) {
        this.connection = connection;
    }

    public DaoAsesoria() {

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
        System.out.println("Ejecutando consulta: " + query);
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
        System.out.println("Número de asesorías recuperadas en DAO: " + asesorias.size());
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

    // Método para obtener las asesorías reagendadas
    public List<Asesoria> obtenerAsesoriasReagendaEstudiante(int idEstudiante) throws SQLException {
        List<Asesoria> asesorias = new ArrayList<>();
        CallableStatement callableStatement = null;
        ResultSet resultSet = null;
        try {
            String sql = "{CALL obtenerAsesoriasReagendaEstudiante(?)}";
            callableStatement = connection.prepareCall(sql);
            callableStatement.setInt(1, idEstudiante);
            resultSet = callableStatement.executeQuery();

            while (resultSet.next()) {
                Asesoria asesoria = new Asesoria();
                asesoria.setIdAsesoria(resultSet.getInt("idAsesoria"));
                asesoria.setDocenteNombre(resultSet.getString("NombreDocente"));
                asesoria.setDocenteApellido(resultSet.getString("ApellidoDocente"));
                asesoria.setNombreMateria(resultSet.getString("NombreMateria"));
                asesoria.setFecha(resultSet.getDate("fecha"));
                asesoria.setHora(resultSet.getTime("hora"));

                asesorias.add(asesoria);
            }
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (callableStatement != null) {
                try {
                    callableStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return asesorias;
    }

    public void aceptarReagenda(int idAsesoria) throws SQLException {
        String sql = "UPDATE EstudiantesAsesoria SET reagenda = false WHERE idAsesoria = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, idAsesoria);
            preparedStatement.executeUpdate();
        }
    }
    public void rechazarReagenda(int idAsesoria, int idEstudiante) throws SQLException {
        String sql = "delete from EstudiantesAsesoria where idAsesoria = ? and idEstudiante = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, idAsesoria);
            preparedStatement.setInt(2,idEstudiante);
            preparedStatement.executeUpdate();
        }
    }
    public List<Asesoria> obtenerAsesoriasNoIniciadas(int idDocente) throws SQLException {
        List<Asesoria> asesorias = new ArrayList<>();
        Connection connection = null;
        CallableStatement callableStatement = null;
        ResultSet resultSet = null;
        try {
            connection = DatabaseConnection.getConnection();
            String sql = "{CALL obtenerAsesoriaNoIniciada(?)}";
            callableStatement = connection.prepareCall(sql);
            callableStatement.setInt(1, idDocente);
            resultSet = callableStatement.executeQuery();

            while (resultSet.next()) {
                Asesoria asesoria = new Asesoria();
                asesoria.setIdAsesoria(resultSet.getInt("idAsesoria"));
                asesoria.setTitulo(resultSet.getString("titulo"));
                asesoria.setNombreMateria(resultSet.getString("NombreMateria"));
                asesoria.setFecha(resultSet.getDate("fecha"));
                asesoria.setHora(resultSet.getTime("hora"));

                asesorias.add(asesoria);
            }
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (callableStatement != null) {
                try {
                    callableStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return asesorias;
    }


    public List<Asesoria> obtenerAsesoriasIniciadas(int idDocente) throws SQLException {
        List<Asesoria> asesorias = new ArrayList<>();
        Connection connection = null;
        CallableStatement callableStatement = null;
        ResultSet resultSet = null;
        try {
            connection = DatabaseConnection.getConnection();
            String sql = "{CALL obtenerAsesoriaIniciada(?)}";
            callableStatement = connection.prepareCall(sql);
            callableStatement.setInt(1, idDocente);
            resultSet = callableStatement.executeQuery();

            while (resultSet.next()) {
                Asesoria asesoria = new Asesoria();
                asesoria.setIdAsesoria(resultSet.getInt("idAsesoria"));
                asesoria.setTitulo(resultSet.getString("titulo"));
                asesoria.setNombreMateria(resultSet.getString("NombreMateria"));
                asesoria.setFecha(resultSet.getDate("fecha"));
                asesoria.setHora(resultSet.getTime("hora"));

                asesorias.add(asesoria);
            }
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (callableStatement != null) {
                try {
                    callableStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return asesorias;
    }

    public boolean iniciarAsesoria(int idAsesoria) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean result = false;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "UPDATE Asesorias SET estado = TRUE WHERE idAsesoria = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idAsesoria);

            int rowsUpdated = preparedStatement.executeUpdate();
            result = (rowsUpdated > 0); // Si se actualizaron filas, el resultado es true

        } finally {
            if (preparedStatement != null) {
                try { preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return result;
    }


    public void finalizarAsesoria(int asesoriaID) throws SQLException {
        CallableStatement stmt = null;

        try {
            // Preparar la llamada al procedimiento almacenado
            String sql = "{CALL FinalizarAsesoria(?)}";
            stmt = connection.prepareCall(sql);

            // Establecer el parámetro de entrada
            stmt.setInt(1, asesoriaID);

            // Ejecutar el procedimiento almacenado
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones
            throw e;
        } finally {
            // Cerrar el CallableStatement
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Manejo de excepciones
                }
            }
        }
    }

    public void actualizarAsesoriaYReagendar(int idAsesoria, Date nuevaFecha, Time nuevaHora) throws SQLException {
        CallableStatement stmt = null;

        try {
            // Preparar la llamada al procedimiento almacenado
            String sql = "{CALL ActualizarAsesoriaYReagendar(?, ?, ?)}";
            stmt = connection.prepareCall(sql);

            // Establecer los parámetros de entrada
            stmt.setInt(1, idAsesoria);
            stmt.setDate(2, nuevaFecha);
            stmt.setTime(3, nuevaHora);

            // Ejecutar el procedimiento almacenado
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones
            throw e;
        } finally {
            // Cerrar el CallableStatement
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Manejo de excepciones
                }
            }
        }
    }

}
