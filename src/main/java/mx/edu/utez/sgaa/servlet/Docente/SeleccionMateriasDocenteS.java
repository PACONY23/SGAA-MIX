package mx.edu.utez.sgaa.servlet.Docente;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SeleccionMateriasDocenteS", value = "/SeleccionMateriasDocenteS")
public class SeleccionMateriasDocenteS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Vistas/Docente/SeleccionMateriasDocenteS.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}