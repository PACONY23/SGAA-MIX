package mx.edu.utez.sgaa.servlet.Estudiante;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import mx.edu.utez.sgaa.dao.DaoMateria;
import mx.edu.utez.sgaa.model.Asesoria;
import java.util.List;

@WebServlet(name = "buscarMateriaS", value = "/buscarMateriaS")
public class buscarMateriaS extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Puedes implementar lógica de doGet aquí si es necesario
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configurar el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");

        // Obtener el nombre de la materia del parámetro de la solicitud
        String nombreMateria = request.getParameter("materiaNombre");
        System.out.println("Nombre de la materia: " + nombreMateria);

        if (nombreMateria != null && !nombreMateria.isEmpty()) {
            DaoMateria daoMateria = new DaoMateria();
            List<Asesoria> asesorias = daoMateria.mostrarMateriaAsesorias(nombreMateria);

            // Guardar la lista de asesorías en el request
            request.setAttribute("asesorias", asesorias);
            request.setAttribute("nombreMateria", nombreMateria);

            // Redirigir al JSP que mostrará las asesorías
            request.getRequestDispatcher("/vistas/Estudiante/VerAsesoriasMaterias.jsp").forward(request, response);
        } else {
            // Manejar el caso donde no se proporciona el nombre de la materia
            request.setAttribute("error", "Nombre de materia no proporcionado");
        }
    }
}
