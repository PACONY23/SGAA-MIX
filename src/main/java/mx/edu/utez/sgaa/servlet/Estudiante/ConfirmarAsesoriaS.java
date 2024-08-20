package mx.edu.utez.sgaa.servlet.Estudiante;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import mx.edu.utez.sgaa.dao.DaoEstudianteAsesoria;
import mx.edu.utez.sgaa.model.EstudiantesAsesoria;
import java.sql.SQLException;

@WebServlet(name = "ConfirmarAsesoriaS", value = "/ConfirmarAsesoriaS")
public class ConfirmarAsesoriaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Puedes implementar lógica de doGet aquí si es necesario
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
        int idAsesoria = Integer.parseInt(request.getParameter("idAsesoria"));
        EstudiantesAsesoria estudiante = new EstudiantesAsesoria();
        estudiante.setIdEstudiante(idEstudiante);
        estudiante.setIdAsesoria(idAsesoria);
        DaoEstudianteAsesoria estudiantesAsesoria = new DaoEstudianteAsesoria();

        try {
            // Llamar al método que guarda la inscripción en la base de datos
            estudiantesAsesoria.agregarAsesoriaEstudiante(estudiante);
            response.getWriter().write("Inscripción exitosa");
        } catch (SQLException e) {
            response.getWriter().write("Error en la inscripción: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
