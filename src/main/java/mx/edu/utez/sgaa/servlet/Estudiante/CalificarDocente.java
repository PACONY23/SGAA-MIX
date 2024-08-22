package mx.edu.utez.sgaa.servlet.Estudiante;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.sgaa.dao.DaoCalificacion;

import java.io.IOException;

@WebServlet(name = "CalificarDocente", value = "/CalificarDocente")
public class CalificarDocente extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Estudiante/HistorialEstudiante.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        int calificacion = Integer.parseInt(request.getParameter("calificacion"));
        int id_asesoria= Integer.parseInt(request.getParameter("asesoriaId"));
        int id_docente = Integer.parseInt(request.getParameter("docenteId"));


        DaoCalificacion dao = new DaoCalificacion();
        dao.agregarCalificacionD(id_asesoria, calificacion, id_docente);

        System.out.println("asesoria" + id_asesoria);
        System.out.println("calificacion" + calificacion);
        System.out.println("docente" + id_docente);

        doGet(request, response);
    }
}
