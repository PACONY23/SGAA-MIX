package mx.edu.utez.sgaa.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante",
                    "admin",
                    "2512032201Jafet");
            System.out.println("Conexion exitosa");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    public static void main(String[] args) {
        DatabaseConnection.getConnection();
    }
}
