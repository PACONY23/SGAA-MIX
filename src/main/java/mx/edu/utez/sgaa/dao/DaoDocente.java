package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.database.DatabaseConnection;
import mx.edu.utez.sgaa.model.Docente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DaoDocente {
    private static final String JDBC_URL = "jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante";
    private static final String JDBC_USER = "admin";
    private static final String JDBC_PASSWORD = "2512032201Jafet";
    private Connection con;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cstm;
    private final DatabaseConnection DATA_BASE_CONNECTION = new DatabaseConnection();
    CallableStatement stmt = null;


    public int obtenerIdDocente(String matricula) {
        Connection connection = null;
        CallableStatement stmt = null;
        int idDocente = -1;

        try {
            // Establecer la conexión
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Definir la llamada al procedimiento almacenado
            String sql = "{ CALL ObtenerIdDocente(?, ?) }";

            // Preparar la llamada
            stmt = connection.prepareCall(sql);
            stmt.setString(1, matricula);
            stmt.registerOutParameter(2, Types.INTEGER);

            // Ejecutar la llamada
            stmt.execute();

            // Obtener el resultado
            idDocente = stmt.getInt(2);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar los recursos
            try {
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return idDocente;
    }


    public int RegistrarDocente(Docente docente) throws ClassNotFoundException {
        String CALL_PROCEDURE_SQL = "{CALL insertarDocente(?, ?, ?, ?, ?, ?, ?, ?)}";
        int result = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                CallableStatement callableStatement = connection.prepareCall(CALL_PROCEDURE_SQL);
                callableStatement.setString(1, docente.getMatricula());
                callableStatement.setString(2, docente.getNombres());
                callableStatement.setString(3, docente.getApellidos());

                // Usa setString para la contraseña aunque esté almacenada como VARBINARY en la base de datos
                callableStatement.setString(4, docente.getContrasena());

                callableStatement.setString(5, docente.getCorreoElectronico());
                callableStatement.setBoolean(6, docente.getEstatus());
                callableStatement.setBoolean(7, docente.isAdmission());

                // Verificar si el rol es null
                String rol = docente.getRol();
                if (rol == null) {
                    rol = "Docente";  // Asignar un valor predeterminado si es null
                }
                callableStatement.setString(8, rol);

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





    public Docente loginDocente(String matricula, String password) throws ClassNotFoundException {
        String LOGIN_SQL = "SELECT * FROM Docentes WHERE matricula = ? AND contraseña = ?;";
        Docente docente1 = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_SQL);
                preparedStatement.setString(1, matricula);
                preparedStatement.setString(2, password);

                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    docente1 = new Docente();
                    docente1.setMatricula(resultSet.getString("matricula"));
                    docente1.setContrasena(resultSet.getString("contraseña"));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return docente1;
    }

    public List<Docente> DocentesSinAdmitir() {
        List<Docente> docentes = new ArrayList<>();
        String sql = "SELECT * FROM Docentes WHERE admision = false";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Docente docente = new Docente();
                docente.setId(rs.getInt("idDocente"));
                docente.setMatricula(rs.getString("Matricula"));
                docente.setNombres(rs.getString("Nombre"));
                docente.setApellidos(rs.getString("Apellido"));
                docente.setAdmission(rs.getBoolean("admision"));
                docentes.add(docente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return docentes;
    }


    public boolean eliminarDocente(int id) throws ClassNotFoundException {
        String DELETE_DOCENTE_SQL = "DELETE FROM Docentes WHERE idDocente = ?;";
        int result = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                PreparedStatement preparedStatement = connection.prepareStatement(DELETE_DOCENTE_SQL);
                preparedStatement.setInt(1, id);
                System.out.println(preparedStatement);

                result = preparedStatement.executeUpdate();
                return result > 0; // Devuelve true si se eliminó al menos un registro
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean actualizarDocente(Docente docente) {
        String UPDATE_SQL = "UPDATE Docentes SET nombre = ?, apellido = ?, correoElectronico = ? WHERE matricula = ?;";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SQL);
                preparedStatement.setString(1, docente.getNombres());
                preparedStatement.setString(2, docente.getApellidos());
                preparedStatement.setString(3, docente.getCorreoElectronico());
                preparedStatement.setString(4, docente.getMatricula());

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

    public Docente getDocenteByMatricula(String matricula) {
        Docente docente = null;
        String sql = "SELECT matricula, nombre, apellido, correoElectronico, estatus FROM Docentes WHERE matricula = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    docente = new Docente();
                    docente.setMatricula(rs.getString("matricula"));
                    docente.setNombres(rs.getString("nombre"));
                    docente.setApellidos(rs.getString("apellido"));
                    docente.setCorreoElectronico(rs.getString("correoElectronico"));
                    docente.setEstatus(rs.getBoolean("estatus"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return docente;
    }

    public boolean desactivarDocente(String matricula) {
        String sqlSelect = "SELECT estatus FROM Docentes WHERE matricula = ?";
        String sqlUpdate = "UPDATE Docentes SET estatus = FALSE WHERE matricula = ?";

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

    public boolean activarDocente(String matricula) {
        String sqlSelect = "SELECT estatus FROM Docentes WHERE matricula = ?";
        String sqlUpdate = "UPDATE Docentes SET estatus = TRUE WHERE matricula = ?";

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

    public List<Docente> listarDocentes() {
        List<Docente> docentes = new ArrayList<>();
        String sql = "SELECT matricula, nombre, apellido, correoElectronico, estatus FROM Docentes";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Docente docente = new Docente();
                docente.setMatricula(rs.getString("matricula"));
                docente.setNombres(rs.getString("nombre"));
                docente.setApellidos(rs.getString("apellido"));
                docente.setCorreoElectronico(rs.getString("correoElectronico"));
                docente.setEstatus(rs.getBoolean("estatus"));
                docentes.add(docente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return docentes;
    }

    public boolean admitirDocente(int id) {
        try {
            con = DATA_BASE_CONNECTION.getConnection();
            String sql = "UPDATE Docentes SET admision = true WHERE idDocente = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, id);
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



}
