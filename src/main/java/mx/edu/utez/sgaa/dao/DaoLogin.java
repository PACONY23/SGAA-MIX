package mx.edu.utez.sgaa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import mx.edu.utez.sgaa.database.DatabaseConnection;

public class DaoLogin {
    private final DatabaseConnection DB_Connection  = new DatabaseConnection();


    public String findAdminByMatriculaAndContraseña(String matricula, String contraseña) {
        String role = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;


        try {
            con = DB_Connection.getConnection();
            String query = "SELECT rol FROM admins WHERE matricula = ? AND contraseña = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, matricula);
            ps.setString(2, contraseña);
            rs = ps.executeQuery();

            if (rs.next()) {
                role = rs.getString("rol");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return role;
    }



    public Boolean findAdmin(String matricula, String contraseña) {
        Boolean found = false;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;


        try {
            con = DB_Connection.getConnection();
            String query = "SELECT * FROM admins WHERE matricula = ? AND contraseña = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, matricula);
            ps.setString(2, contraseña);
            rs = ps.executeQuery();

            if (rs.next()) {
                found = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return found;
    }
}


