package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.model.Administrador;
import mx.edu.utez.sgaa.database.DatabaseConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoAdministrador {
    private PreparedStatement pstm;
    private ResultSet rs;
    private Connection con;
    private final DatabaseConnection DATA_BASE_CONNECTION = new DatabaseConnection();
    private final String[] QUERIES = {
    };
    public Administrador loginAdmin(String matricula, String password) throws ClassNotFoundException {
        String LOGIN_SQL = "SELECT * FROM admins WHERE matricula = ? AND contraseña = ?;";
        Administrador admin = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/estudiante", "root", "root")) {
                PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_SQL);
                preparedStatement.setString(1, matricula);
                preparedStatement.setString(2, password);

                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    admin = new Administrador();
                    admin.setMatricula(resultSet.getString("matricula"));
                    admin.setContrasena(resultSet.getString("contraseña"));
                    // Set other properties of admin if needed
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return admin;
    }


}


