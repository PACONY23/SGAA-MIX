package mx.edu.utez.sgaa.servlet.Administrador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.dao.DaoEstudiante;

import java.io.IOException;

@WebServlet(name = "EstadoEstudianteS", value = "/EstadoEstudianteS")
public class EstadoEstudianteS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/ConsultarInformacion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        int id = Integer.parseInt(request.getParameter("ch_id_e"));
        System.out.println("ID del estudiante para cambiar estado: " + id);

        DaoEstudiante estudianteDao = new DaoEstudiante();
        boolean success = estudianteDao.cambiarEstadoEstudiante(id);

        if (success) {
            System.out.println("Estado del estudiante cambiado exitosamente");
        } else {
            System.out.println("Error al cambiar el estado del estudiante");
        }

        request.setAttribute("success", success);

        doGet(request, response);
    }
}