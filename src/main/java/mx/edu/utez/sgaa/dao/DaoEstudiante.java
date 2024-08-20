package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.model.Estudiante;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DaoEstudiante {
    private static final String JDBC_URL = "jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante";
    private static final String JDBC_USER = "admin";
    private static final String JDBC_PASSWORD = "2512032201Jafet";

    public int RegistrarEstudiante(Estudiante estudiante) throws ClassNotFoundException {
        String CALL_PROCEDURE_SQL = "{CALL insertarEstudiante(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        int result = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                CallableStatement callableStatement = connection.prepareCall(CALL_PROCEDURE_SQL);
                callableStatement.setString(1, estudiante.getMatricula());
                callableStatement.setString(2, estudiante.getNombre());
                callableStatement.setString(3, estudiante.getApellido());
                callableStatement.setString(4, estudiante.getGrupo());
                callableStatement.setString(5, estudiante.getCuatrimestre());

                callableStatement.setString(6, estudiante.getContrasena());
                callableStatement.setString(7, estudiante.getCorreoElectronico());
                callableStatement.setBoolean(8, estudiante.getEstatus());

                // Verificar si el rol es null
                String rol = estudiante.getRol();
                if (rol == null) {
                    rol = "Estudiante"; // Asigna un valor predeterminado si es null
                }
                callableStatement.setString(9, rol);

                System.out.println(callableStatement);

                result = callableStatement.executeUpdate();
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
        String sql = "SELECT matricula, estatus FROM Estudiantes";
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
        String UPDATE_SQL = "UPDATE Estudiantes SET nombre = ?, apellido = ?, grupo = ?, cuatrimestre = ?, correoElectronico = ? WHERE matricula = ?;";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SQL);
                preparedStatement.setString(1, estudiante.getNombre());
                preparedStatement.setString(2, estudiante.getApellido());
                preparedStatement.setString(3, estudiante.getGrupo());
                preparedStatement.setString(4, estudiante.getCuatrimestre());
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
        String sqlSelect = "SELECT estatus FROM Estudiantes WHERE matricula = ?";
        String sqlUpdate = "UPDATE Estudiantes SET estatus = 0 WHERE matricula = ?";

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
        String sqlSelect = "SELECT estatus FROM Estudiantes WHERE matricula = ?";
        String sqlUpdate = "UPDATE Estudiantes SET estatus = 1 WHERE matricula = ?";

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
        String SELECT_ESTUDIANTE_SQL = "SELECT matricula, nombre, apellido, grupo, cuatrimestre, correoElectronico FROM Estudiantes WHERE matricula = ?";

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
                estudiante.setCuatrimestre(resultSet.getString("cuatrimestre"));
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
