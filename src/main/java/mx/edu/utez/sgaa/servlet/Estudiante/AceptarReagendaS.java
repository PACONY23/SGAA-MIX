package mx.edu.utez.sgaa.servlet.Estudiante;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.database.DatabaseConnection;

@WebServlet(name = "AceptarReagendaS", value = "/AceptarReagendaS")
public class AceptarReagendaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idAsesoriaStr = request.getParameter("d_id");
        if (idAsesoriaStr != null && !idAsesoriaStr.isEmpty()) {
            int idAsesoria = Integer.parseInt(idAsesoriaStr);
            System.out.println("Se recibio idasesoria para la reagenda " + idAsesoria);

            Connection connection = null;
            try {
                connection = DatabaseConnection.getConnection();
                DaoAsesoria dao = new DaoAsesoria(connection);

                // Llama al método adecuado en DaoAsesoria para manejar la aceptación
                // (Este método debe ser implementado en DaoAsesoria)
                dao.aceptarReagenda(idAsesoria);

                // Redirige a la página deseada después de aceptar la reagenda
                response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/Reagendas.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                // Manejo de errores
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
