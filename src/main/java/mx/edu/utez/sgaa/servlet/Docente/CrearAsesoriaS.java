package mx.edu.utez.sgaa.servlet.Docente;

import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.model.Asesoria;
import mx.edu.utez.sgaa.database.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;

@WebServlet(name = "CrearAsesoriaS", value = "/CrearAsesoriaS")
public class CrearAsesoriaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí puedes redirigir a una página de error o una vista específica si es necesario.
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idDocente = Integer.parseInt(request.getParameter("idDocente"));
        long idMateria = Long.parseLong(request.getParameter("idMateria"));
        String titulo = request.getParameter("titulo");
        Date fecha = Date.valueOf(request.getParameter("fecha"));
        Time hora = Time.valueOf(request.getParameter("hora"));

        Asesoria asesoria = new Asesoria(idDocente, idMateria, titulo, fecha, hora);

        try (Connection connection = DatabaseConnection.getConnection()) {
            DaoAsesoria daoAsesoria = new DaoAsesoria(connection);
            daoAsesoria.crearAsesoria(asesoria);
            response.setStatus(HttpServletResponse.SC_CREATED);
            response.getWriter().write("Asesoría creada con éxito");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al crear la asesoría");
        }
    }
}
