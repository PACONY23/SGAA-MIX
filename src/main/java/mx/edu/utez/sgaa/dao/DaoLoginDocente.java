package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.database.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoLoginDocente {
    private final DatabaseConnection DB_Connection  = new DatabaseConnection();
    public String findDocenteByMatriculaAndContraseña(String matricula, String contraseña) {
        String role = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;


        try {
            con = DB_Connection.getConnection();
            String query = "SELECT rol FROM docentes  WHERE matricula = ? AND contraseña = ?";
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
}
