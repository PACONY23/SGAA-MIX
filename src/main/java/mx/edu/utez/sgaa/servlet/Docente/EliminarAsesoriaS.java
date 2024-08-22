package mx.edu.utez.sgaa.servlet.Docente;

import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "EliminarAsesoriaS", value = "/EliminarAsesoriaS")
public class EliminarAsesoriaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí puedes redirigir a una página de error o una vista específica si es necesario.
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAsesoria = Integer.parseInt(request.getParameter("idAsesoria"));

        try (Connection connection = DatabaseConnection.getConnection()) {
            DaoAsesoria daoAsesoria = new DaoAsesoria(connection);
            daoAsesoria.eliminarAsesoria(idAsesoria);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Asesoría eliminada con éxito");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al eliminar la asesoría");
        }
    }
}

