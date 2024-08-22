package mx.edu.utez.sgaa.servlet.Administrador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.dao.DaoMateria;

import java.io.IOException;


@WebServlet(name = "EstadoDocenteS", value = "/EstadoDocenteS")
public class EstadoDocenteS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/ConsultarInformacion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        int id = Integer.parseInt(request.getParameter("ch_id"));
        System.out.println("ID del docente para cambiar estado: " + id);

        DaoDocente docenteDao = new DaoDocente();
        boolean success = docenteDao.cambiarEstadoDocente(id);

        if (success) {
            System.out.println("Estado del docente cambiado exitosamente");
        } else {
            System.out.println("Error al cambiar el estado del docente");
        }

        request.setAttribute("success", success);

        doGet(request, response);
    }
}