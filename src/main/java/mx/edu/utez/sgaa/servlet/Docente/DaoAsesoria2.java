package mx.edu.utez.sgaa.servlet.Docente;



import mx.edu.utez.sgaa.database.DatabaseConnection;

import java.sql.*;

public class DaoAsesoria2 {
    private static final String PROCEDURE_CREATE_ASSESSORIA = "{CALL CrearAsesoria(?, ?, ?, ?, ?)}";

    public boolean crearAsesoria(int idDocente, int idMateria, String titulo, String fecha, String hora) {
        boolean success = false;
        try (Connection con = DatabaseConnection.getConnection();
             Connection connection = DriverManager.getConnection("jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante", "admin", "2512032201Jafet");
             CallableStatement stmt = con.prepareCall(PROCEDURE_CREATE_ASSESSORIA)) {

            stmt.setInt(1, idDocente);
            stmt.setInt(2, idMateria);
            stmt.setString(3, titulo);
            stmt.setDate(4, Date.valueOf(fecha));
            stmt.setTime(5, Time.valueOf(hora));

            int result = stmt.executeUpdate();
            success = result > 0;
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    // Método de prueba para verificar la conexión y agregar una asesoría
    public static void main(String[] args) {
        try (Connection con = DriverManager.getConnection(
                "jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante", "root", "2512032201Jafet")) {
            if (con != null) {
                System.out.println("Conexión exitosa");

                // Crear una asesoría de prueba
                String procedure = "{CALL CrearAsesoria(?, ?, ?, ?, ?)}";
                try (CallableStatement stmt = con.prepareCall(procedure)) {
                    stmt.setInt(1, 1); // idDocente
                    stmt.setInt(2, 1); // idMateria
                    stmt.setString(3, "gominola"); // titulo
                    stmt.setDate(4, Date.valueOf("2022-02-02")); // fecha
                    stmt.setTime(5, Time.valueOf("10:10:00")); // hora

                    int result = stmt.executeUpdate();
                    if (result > 0) {
                        System.out.println("Asesoría creada exitosamente");
                    } else {
                        System.out.println("Error al crear la asesoría");
                    }
                }
            } else {
                System.out.println("Fallo en la conexión");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
