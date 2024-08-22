package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.database.DatabaseConnection;
import mx.edu.utez.sgaa.model.MateriasDocentes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class DaoMateriasDocentes {
    private Connection connection;
    private static final String JDBC_URL = "jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante";
    private static final String JDBC_USER = "admin";
    private static final String JDBC_PASSWORD = "2512032201Jafet";
    private Connection con;
    CallableStatement stmt = null;
    ResultSet rs = null;
    private final DatabaseConnection DATA_BASE_CONNECTION = new DatabaseConnection();

    public DaoMateriasDocentes() {
        // Constructor vacío, asegúrate de que no esté lanzando ninguna excepción
    }



    public List<MateriasDocentes> obtenerMateriasDocente(String matricula) {
        List<MateriasDocentes> materiasDocente = new ArrayList<>();
        Connection connection = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establecer la conexión
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Definir la llamada al procedimiento almacenado
            String sql = "{ CALL tomarMateriasDocentes(?)}";

            // Preparar la llamada
            stmt = connection.prepareCall(sql);
            stmt.setString(1, matricula);

            // Ejecutar la llamada y obtener los resultados
            rs = stmt.executeQuery();

            // Procesar los resultados
            while (rs.next()) {
                int idMateria = rs.getInt("idMateria"); // Asegúrate de que 'idMateria' sea el nombre correcto del campo en la base de datos
                String nombreDocente = rs.getString("Nombre");
                String nombreMateria = rs.getString("Nombre_materia");
                materiasDocente.add(new MateriasDocentes(idMateria, nombreDocente, nombreMateria));
                System.out.println(nombreMateria);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar los recursos
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return materiasDocente;
    }


    public void insertarMateriaDocente(String idMateria, String matriculaDocente) throws SQLException {
        Connection connection = null;
        CallableStatement stmt = null;

        try {
            // Establecer la conexión
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Definir la llamada al procedimiento almacenado
            String sql = "{ CALL insertarMateriasDocentes(?, ?) }";

            // Preparar la llamada
            stmt = connection.prepareCall(sql);
            stmt.setString(1, idMateria);
            stmt.setString(2, matriculaDocente);

            // Ejecutar la llamada
            stmt.execute();
        } catch (SQLException e) {
            // Lanzar la excepción para que pueda ser manejada en el servlet
            throw e;
        } finally {
            // Cerrar los recursos
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    }





    public static void main(String[] args) {
        Connection connection = null;
        Scanner sc = new Scanner(System.in);
        try {
            // Establecer la conexión
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Crear una instancia de DaoMateriasDocentes
            DaoMateriasDocentes dao = new DaoMateriasDocentes();

            // Obtener las materias del docente con la matrícula proporcionada
            System.out.println("Ingresa la matricula del docente");
            String matricula = sc.nextLine();

            List<MateriasDocentes> materias = dao.obtenerMateriasDocente(matricula);

            // Imprimir los resultados
            for (MateriasDocentes materia : materias) {
                System.out.println(materia);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar la conexión
            try {
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
