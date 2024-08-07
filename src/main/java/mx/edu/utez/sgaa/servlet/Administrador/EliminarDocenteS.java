package mx.edu.utez.sgaa.servlet.Administrador;

import mx.edu.utez.sgaa.dao.DaoDocente;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EliminarDocenteS", value = "/EliminarDocenteS")
public class EliminarDocenteS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Puedes redirigir o reenviar a una página después de eliminar
        request.getRequestDispatcher("/vistas/Admin/AprobarRegistro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        DaoDocente docenteDao = new DaoDocente();
        int id = Integer.parseInt(request.getParameter("r_id"));
        System.out.println("Id a eliminar: " + id);

        boolean isDeleted = false;
        try {
            isDeleted = docenteDao.eliminarDocente(id);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        if (isDeleted) {
            System.out.println("Docente eliminado exitosamente");
        } else {
            System.out.println("Error al eliminar el docente");
        }

        request.setAttribute("success", isDeleted);
        doGet(request, response);
    }
}
