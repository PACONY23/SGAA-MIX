package mx.edu.utez.sgaa.servlet.Docente;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "PaginaPrincipalDocenteS", value = "/PaginaPrincipalDocenteS")
public class PaginaPrincipalDocenteS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Vista/Docente/PaginaPrincipalDocente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}