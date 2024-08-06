package mx.edu.utez.sgaa.servlet.Materia;

import mx.edu.utez.sgaa.dao.DaoMateria;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EstadoMateriaS", value = "/EstadoMateriaS")
public class EstadoMateriaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/GestionDeMaterias.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        Long id = Long.parseLong(request.getParameter("ch_id"));
        System.out.println("ID de la materia para cambiar estado: " + id);

        DaoMateria materiaDao = new DaoMateria();
        boolean success = materiaDao.cambiarEstadoMateria(id);

        if (success) {
            System.out.println("Estado de la materia cambiado exitosamente");
        } else {
            System.out.println("Error al cambiar el estado de la materia");
        }

        request.setAttribute("success", success);

        doGet(request, response);
    }
}
