package mx.edu.utez.sgaa.servlet.Administrador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.model.Docente;

import java.io.IOException;

@WebServlet(name = "ActualizarEstudianteAdmin", value = "/ActualizarEstudianteAdmin")
public class ActualizarEstudianteAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/ConsultarInformacion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}