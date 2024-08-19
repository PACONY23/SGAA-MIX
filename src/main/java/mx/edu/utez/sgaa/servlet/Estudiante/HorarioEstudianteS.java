package mx.edu.utez.sgaa.servlet.Estudiante;

import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.model.Asesoria;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

public class HorarioEstudianteS extends HttpServlet {

    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante";
        String user = "admin";
        String password = "2512032201Jafet";
        System.out.println("Conectando a la base de datos con URL: " + url);
        return DriverManager.getConnection(url, user, password);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Solicitud GET recibida en HorarioEstudianteS");

        try (Connection connection = getConnection()) {
            System.out.println("Conexión a la base de datos establecida.");
            DaoAsesoria daoAsesoria = new DaoAsesoria(connection);
            List<Asesoria> asesorias = daoAsesoria.obtenerAsesorias();

            if (asesorias != null && !asesorias.isEmpty()) {
                System.out.println("Número de asesorías recuperadas: " + asesorias.size());
                for (Asesoria asesoria : asesorias) {
                    System.out.println("Asesoría: " + asesoria.getTitulo() + ", Fecha: " + asesoria.getFecha() + ", Hora: " + asesoria.getHora());
                }
            } else {
                System.out.println("La lista de asesorías es null o está vacía");
            }

            // Configura el atributo para la vista
            request.setAttribute("asesorias", asesorias);
            // Redirige a la vista
            request.getRequestDispatcher("/vistas/Estudiante/HorarioEstudiante.jsp").forward(request, response);

        } catch (SQLException e) {
            System.out.println("Error al obtener asesorías: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error al obtener las asesorías", e);
        } catch (Exception e) {
            System.out.println("Error general: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error general", e);
        }
    }
}
