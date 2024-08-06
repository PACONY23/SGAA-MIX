package mx.edu.utez.sgaa.servlet.Materia;

import mx.edu.utez.sgaa.dao.DaoMateria;
import mx.edu.utez.sgaa.model.Materia;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AgregarMateriasS", value = "/AgregarMateriasS")
public class AgregarMateriasS extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoMateria daoMateria = new DaoMateria();

    public AgregarMateriasS() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/GestionDeMaterias.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String nombre = request.getParameter("Nombre_materia");

        Materia materia=new Materia();
        materia.setNombre(nombre);

        DaoMateria dao = new DaoMateria();

        dao.agregarMateria(materia);
        doGet(request, response);
    }
}