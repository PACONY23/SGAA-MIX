package mx.edu.utez.sgaa.servlet.Docente;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.sgaa.dao.DaoCalificacion;

import java.io.IOException;

@WebServlet(name = "CalificarEstuditeS", value = "/CalificarEstuditeS")
public class CalificarEstuditeS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Docente/HistorialDocente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        int calificacion = Integer.parseInt(request.getParameter("calificacion"));
        int id_asesoria= Integer.parseInt(request.getParameter("asesoriaId"));
        int id_estudiante = Integer.parseInt(request.getParameter("estudianteId"));


        DaoCalificacion dao = new DaoCalificacion();
        dao.agregarCalificacion(id_asesoria, calificacion, id_estudiante);

       doGet(request, response);
    }
}
