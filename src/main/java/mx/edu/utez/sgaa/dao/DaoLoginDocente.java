package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.database.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoLoginDocente {
    private final DatabaseConnection DB_Connection  = new DatabaseConnection();
    public String[] findDocenteByMatriculaAndContraseña(String matricula, String contraseña) {
        String[] data = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;


        try {
            con = DB_Connection.getConnection();
            String query = "SELECT nombre,apellido,correoElectronico,idDocente, rol FROM Docentes WHERE matricula = ? AND contraseña = ? AND estatus = true AND admision = true";
            ps = con.prepareStatement(query);
            ps.setString(1, matricula);
            ps.setString(2, contraseña);
            rs = ps.executeQuery();

            if (rs.next()) {
                data = new String[5];
                data[0] = rs.getString("idDocente"); // idDocente como String
                data[1] = rs.getString("rol"); // rol
                data[2] = rs.getString("nombre");
                data[3] = rs.getString("apellido");
                data[4] = rs.getString("correoElectronico");
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

        return data;
    }
}
