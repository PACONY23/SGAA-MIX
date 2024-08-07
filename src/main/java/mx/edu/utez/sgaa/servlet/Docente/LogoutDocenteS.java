package mx.edu.utez.sgaa.servlet.Docente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet(name = "LogoutDocenteS", value = "/LogoutDocenteS")
public class LogoutDocenteS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/vistas/Docente/LoginDocente.jsp");
    }
}