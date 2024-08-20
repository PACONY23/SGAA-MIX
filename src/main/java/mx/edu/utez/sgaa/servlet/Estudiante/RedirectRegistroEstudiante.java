package mx.edu.utez.sgaa.servlet.Estudiante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RedirectRegistroEstudiante", value = "/RedirectRegistroEstudiante")
public class RedirectRegistroEstudiante extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establece el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("Redirigiendo a RegistroEstudiante.jsp");
        // Redirige a la página RegistroEstudiante.jsp
        request.getRequestDispatcher("/vistas/Estudiante/RegistroEstudiante.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
