package mx.edu.utez.sgaa.servlet.Materia;

import mx.edu.utez.sgaa.dao.DaoMateria;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
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

        String message;
        String alertType;

        try {
            boolean isDeleted = materiaDao.eliminarMateria(id);
            if (isDeleted) {
                message = "Materia eliminada exitosamente.";
                alertType = "success";
            } else {
                message = "No se pudo eliminar la materia. Puede estar en uso.";
                alertType = "error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error al eliminar la materia: " + e.getMessage();
            alertType = "error";
        }

        request.setAttribute("message", message);
        request.setAttribute("alertType", alertType);
        doGet(request, response);
    }
}

