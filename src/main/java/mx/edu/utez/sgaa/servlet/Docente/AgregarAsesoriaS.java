package mx.edu.utez.sgaa.servlet.Docente;

import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.dao.DaoEstudianteAsesoria;
import mx.edu.utez.sgaa.model.EstudiantesAsesoria;
import mx.edu.utez.sgaa.database.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "AgregarAsesoriaS", value = "/AgregarAsesoriaS")
public class AgregarAsesoriaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí puedes redirigir a una página de error o una vista específica si es necesario.
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
        int idAsesoria = Integer.parseInt(request.getParameter("idAsesoria"));
        String tema = request.getParameter("tema");
        System.out.println("idestudiante: " + idEstudiante + " idAsesoria: " + idAsesoria);

        EstudiantesAsesoria estudiantesAsesoria = new EstudiantesAsesoria(idEstudiante, idAsesoria, tema);
        try (Connection connection = DatabaseConnection.getConnection()) {
            DaoEstudianteAsesoria daoEstudianteAsesoria = new DaoEstudianteAsesoria();

            if(daoEstudianteAsesoria.isAsesoriaRegistrada(idEstudiante, idAsesoria)){
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                //Enviamos un mensaje de error al status
                response.getWriter().write("registerErrorDuplicate");
                return;
            }
            daoEstudianteAsesoria.agregarAsesoriaEstudiante(estudiantesAsesoria);
            response.setStatus(HttpServletResponse.SC_CREATED);
            //Enviamos un mensaje de éxito al status
            response.getWriter().write("registerOk");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            //Enviamos un mensaje de error al status
            response.getWriter().write("registerError");
        }
    }
}

