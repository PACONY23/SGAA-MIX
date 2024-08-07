package mx.edu.utez.sgaa.servlet.Estudiante;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet(name = "LogouEstudianteS", value = "/LogouEstudianteS")
public class LogouEstudianteS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/LoginEstudiante.jsp");
    }
}