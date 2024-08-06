package mx.edu.utez.sgaa.servlet.Administrador;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "PaginaPrincipalAdmnistradorS", value = "/PaginaPrincipalAdmnistradorS")
public class PaginaPrincipalAdmnistradorS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/paginaPrincipalAdmnistrador.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}