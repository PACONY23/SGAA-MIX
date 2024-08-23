package mx.edu.utez.sgaa.servlet.Materia;

import mx.edu.utez.sgaa.dao.DaoMateria;
import mx.edu.utez.sgaa.model.Materia;
import mx.edu.utez.sgaa.database.DatabaseConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
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

        Materia materia = new Materia();
        materia.setNombre(nombre);

        DaoMateria dao = new DaoMateria();

        String message;
        String alertType;

        boolean isAdded = dao.agregarMateria(materia);

        if (isAdded) {
            message = "Materia agregada exitosamente.";
            alertType = "success";
        } else {
            message = "La materia no se pudo agregar. Es posible que ya esté registrada.";
            alertType = "error";
        }

        request.setAttribute("message", message);
        request.setAttribute("alertType", alertType);
        doGet(request, response);
    }
}
