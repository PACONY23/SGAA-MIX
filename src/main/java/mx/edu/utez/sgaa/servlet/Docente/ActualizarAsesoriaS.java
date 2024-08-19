package mx.edu.utez.sgaa.servlet.Docente;

import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.model.Asesoria;
import mx.edu.utez.sgaa.database.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;

@WebServlet(name = "ActualizarAsesoriaS", value = "/ActualizarAsesoriaS")
public class ActualizarAsesoriaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí puedes redirigir a una página de error o una vista específica si es necesario.
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAsesoria = Integer.parseInt(request.getParameter("idAsesoria"));
        int idDocente = Integer.parseInt(request.getParameter("idDocente"));
        long idMateria = Long.parseLong(request.getParameter("idMateria"));
        String titulo = request.getParameter("titulo");
        Date fecha = Date.valueOf(request.getParameter("fecha"));
        Time hora = Time.valueOf(request.getParameter("hora"));

        Asesoria asesoria = new Asesoria(idDocente, idMateria, titulo, fecha, hora);
        asesoria.setIdAsesoria(idAsesoria);

        try (Connection connection = DatabaseConnection.getConnection()) {
            DaoAsesoria daoAsesoria = new DaoAsesoria(connection);
            daoAsesoria.actualizarAsesoria(asesoria);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Asesoría actualizada con éxito");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al actualizar la asesoría");
        }
    }
}

