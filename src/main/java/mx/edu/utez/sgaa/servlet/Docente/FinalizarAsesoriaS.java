package mx.edu.utez.sgaa.servlet.Docente;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sgaa.dao.DaoAsesoria;
import java.sql.Connection;
import mx.edu.utez.sgaa.database.DatabaseConnection;

@WebServlet("/FinalizarAsesoriaS")
public class FinalizarAsesoriaS extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID de la asesoría del formulario
        String idAsesoriaStr = request.getParameter("f_id");

        if (idAsesoriaStr != null && !idAsesoriaStr.isEmpty()) {
            try {
                int idAsesoria = Integer.parseInt(idAsesoriaStr);
                System.out.println("ID de la asesoría a finalizar: " + idAsesoria);

                // Obtener la conexión de la clase DatabaseConnection
                DatabaseConnection dbConnection = new DatabaseConnection();
                Connection connection = dbConnection.getConnection();

                // Crear una instancia del DAO con la conexión
                DaoAsesoria daoAsesoria = new DaoAsesoria(connection);

                // Llamar al método para finalizar la asesoría
                daoAsesoria.finalizarAsesoria(idAsesoria);

                // Cerrar la conexión después de usarla
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }

                // Redirigir al usuario a la página de asesorías
                request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                e.printStackTrace(); // Manejar el error de formato de número
                response.sendRedirect(request.getContextPath() + "/errorPage.jsp"); // Redirigir a una página de error
            } catch (SQLException e) {
                e.printStackTrace(); // Manejar el error de SQL
                response.sendRedirect(request.getContextPath() + "/errorPage.jsp"); // Redirigir a una página de error
            }
        } else {
            // Manejar el caso cuando el ID de la asesoría no está presente
            response.sendRedirect(request.getContextPath() + "/errorPage.jsp");
        }
    }
}
