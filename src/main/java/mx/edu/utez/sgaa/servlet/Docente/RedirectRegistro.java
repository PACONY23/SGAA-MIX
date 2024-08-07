package mx.edu.utez.sgaa.servlet.Docente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RedirectRegistro", value = "/RedirectRegistro")
public class RedirectRegistro extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establece el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");
        System.out.println("Redirigiendo a RegistroDocente.jsp");
        // Redirige a la página RegistroDocente.jsp
        request.getRequestDispatcher("/vistas/Docente/RegistroDocente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}