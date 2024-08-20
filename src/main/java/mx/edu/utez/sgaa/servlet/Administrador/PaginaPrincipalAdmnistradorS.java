package mx.edu.utez.sgaa.servlet.Administrador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "PaginaPrincipalAdmnistradorS", value = "/PaginaPrincipalAdmnistradorS")
public class PaginaPrincipalAdmnistradorS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/PaginaPrincipalAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Implementar la lógica del POST aquí si es necesario
    }
}
