package mx.edu.utez.sgaa.servlet.Estudiante;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "PaginaPrincipalEstudianteS", value = "/PaginaPrincipalEstudianteS")
public class PaginaPrincipalEstudianteS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Estudiante/PaginaPrincipalEstudiante.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}