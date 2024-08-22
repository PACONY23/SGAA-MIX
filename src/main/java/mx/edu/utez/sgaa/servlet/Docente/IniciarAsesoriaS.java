package mx.edu.utez.sgaa.servlet.Docente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.database.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/IniciarAsesoriaS")
public class IniciarAsesoriaS extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idAsesoriaParam = request.getParameter("ch_id");

        if (idAsesoriaParam != null && !idAsesoriaParam.isEmpty()) {
            try {
                int idAsesoria = Integer.parseInt(idAsesoriaParam);
                System.out.println("ID de la asesoría: " + idAsesoria);

                // Obtener la conexión de la base de datos
                try (Connection connection = DatabaseConnection.getConnection()) {
                    DaoAsesoria daoAsesoria = new DaoAsesoria(connection);
                    boolean success = daoAsesoria.iniciarAsesoria(idAsesoria);

                    if (success) {
                        // Redirigir o enviar una respuesta indicando éxito
                        request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
                    } else {
                        // Establecer mensaje de error y reenviar a la página de gestión de asesorías
                        request.setAttribute("errorMessage", "No se pudo iniciar la asesoría. Inténtelo de nuevo.");
                        request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Redirigir a una página de error con un mensaje claro
                    request.setAttribute("errorMessage", "Error al intentar iniciar la asesoría: " + e.getMessage());
                    request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                // Manejar el error de formato de número y redirigir a una página de error
                request.setAttribute("errorMessage", "ID de asesoría inválido. Inténtelo de nuevo.");
                request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
            }
        } else {
            // Manejar el caso en que no se proporciona un ID válido
            request.setAttribute("errorMessage", "No se proporcionó un ID válido para la asesoría.");
            request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
        }
    }
}
