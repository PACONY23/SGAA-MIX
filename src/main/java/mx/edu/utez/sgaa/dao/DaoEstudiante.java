package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.model.Estudiante;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DaoEstudiante {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/estudiante";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    public int RegistrarEstudiante(Estudiante estudiante) throws ClassNotFoundException {
        String INSERT_USERS_SQL = "INSERT INTO estudiantes (matricula, contraseña, nombre, apellido, grupo, cuatrimestre, correoElectronico, estatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
        int result = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL);
                preparedStatement.setString(1, estudiante.getMatricula());
                preparedStatement.setString(2, estudiante.getContrasena());
                preparedStatement.setString(3, estudiante.getNombre());
                preparedStatement.setString(4, estudiante.getApellido());
                preparedStatement.setString(5, estudiante.getGrupo());
                preparedStatement.setInt(6, estudiante.getCuatrimestre());
                preparedStatement.setString(7, estudiante.getCorreoElectronico());
                preparedStatement.setBoolean(8, estudiante.getEstatus()); // Cambiado a booleano
                System.out.println(preparedStatement);

                result = preparedStatement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return result;
    }

    public List<Estudiante> listarEstudiantes() {
        List<Estudiante> estudiantes = new ArrayList<>();
        String sql = "SELECT matricula, estatus FROM estudiantes";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Estudiante estudiante = new Estudiante();
                estudiante.setMatricula(rs.getString("matricula"));
                estudiante.setEstatus(rs.getBoolean("estatus")); // Cambiado a booleano
                estudiantes.add(estudiante);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return estudiantes;
    }

    public boolean actualizarEstudiante(Estudiante estudiante) {
        String UPDATE_SQL = "UPDATE estudiantes SET nombre = ?, apellido = ?, grupo = ?, cuatrimestre = ?, correoElectronico = ? WHERE matricula = ?;";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SQL);
                preparedStatement.setString(1, estudiante.getNombre());
                preparedStatement.setString(2, estudiante.getApellido());
                preparedStatement.setString(3, estudiante.getGrupo());
                preparedStatement.setInt(4, estudiante.getCuatrimestre());
                preparedStatement.setString(5, estudiante.getCorreoElectronico());
                preparedStatement.setString(6, estudiante.getMatricula());

                int affectedRows = preparedStatement.executeUpdate();
                return affectedRows > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean desactivarEstudiante(String matricula) {
        String sqlSelect = "SELECT estatus FROM estudiantes WHERE matricula = ?";
        String sqlUpdate = "UPDATE estudiantes SET estatus = 0 WHERE matricula = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement selectStmt = connection.prepareStatement(sqlSelect);
             PreparedStatement updateStmt = connection.prepareStatement(sqlUpdate)) {

            selectStmt.setString(1, matricula);
            ResultSet resultSet = selectStmt.executeQuery();

            if (resultSet.next()) {
                boolean estatus = resultSet.getBoolean("estatus");
                if (!estatus) {
                    return false; // Ya está deshabilitado
                } else {
                    updateStmt.setString(1, matricula);
                    updateStmt.executeUpdate();
                    return true; // Deshabilitado exitosamente
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean activarEstudiante(String matricula) {
        String sqlSelect = "SELECT estatus FROM estudiantes WHERE matricula = ?";
        String sqlUpdate = "UPDATE estudiantes SET estatus = 1 WHERE matricula = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement selectStmt = connection.prepareStatement(sqlSelect);
             PreparedStatement updateStmt = connection.prepareStatement(sqlUpdate)) {

            selectStmt.setString(1, matricula);
            ResultSet resultSet = selectStmt.executeQuery();

            if (resultSet.next()) {
                boolean estatus = resultSet.getBoolean("estatus");
                if (estatus) {
                    return false; // Ya está habilitado
                } else {
                    updateStmt.setString(1, matricula);
                    updateStmt.executeUpdate();
                    return true; // Habilitado exitosamente
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Estudiante getEstudianteByMatricula(String matricula) {
        Estudiante estudiante = null;
        String SELECT_ESTUDIANTE_SQL = "SELECT matricula, nombre, apellido, grupo, cuatrimestre, correoElectronico FROM estudiantes WHERE matricula = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ESTUDIANTE_SQL)) {

            preparedStatement.setString(1, matricula);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                estudiante = new Estudiante();
                estudiante.setMatricula(resultSet.getString("matricula"));
                estudiante.setNombre(resultSet.getString("nombre"));
                estudiante.setApellido(resultSet.getString("apellido"));
                estudiante.setGrupo(resultSet.getString("grupo"));
                estudiante.setCuatrimestre(resultSet.getInt("cuatrimestre"));
                estudiante.setCorreoElectronico(resultSet.getString("correoElectronico"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return estudiante;
    }

    public Estudiante loginEstudiante(String matricula, String password) {
        return null;
    }
}
