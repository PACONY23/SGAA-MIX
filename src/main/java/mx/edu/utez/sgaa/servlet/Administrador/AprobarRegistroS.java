package mx.edu.utez.sgaa.servlet.Administrador;

import mx.edu.utez.sgaa.dao.DaoDocente;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AprobarRegistroS", value = "/AprobarRegistroS")
public class AprobarRegistroS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/AprobarRegistro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        int id = Integer.parseInt(request.getParameter("ch_id"));
        System.out.println("ID del docente a admitir: " + id);

        DaoDocente docenteDao = new DaoDocente();
        boolean success = docenteDao.admitirDocente(id);

        if (success) {
            System.out.println("Docente admitido exitosamente");
        } else {
            System.out.println("Error al admitir el docente");
        }

        doGet(request, response);
    }
}
