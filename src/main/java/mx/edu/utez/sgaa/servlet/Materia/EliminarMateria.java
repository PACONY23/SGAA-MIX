package mx.edu.utez.sgaa.servlet.Materia;

import mx.edu.utez.sgaa.dao.DaoMateria;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EliminarMateria", value = "/EliminarMateria")
public class EliminarMateria extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/GestionDeMaterias.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        DaoMateria materiaDao = new DaoMateria();
        Long id = Long.parseLong(request.getParameter("d_id"));
        System.out.println("Id a eliminar: " + id);

        boolean isDeleted = materiaDao.eliminarMateria(id);
        if (isDeleted) {
            System.out.println("Materia eliminada exitosamente");
        } else {
            System.out.println("Error al eliminar la materia");
        }

        request.setAttribute("success", isDeleted);
        doGet(request, response);
    }
}
