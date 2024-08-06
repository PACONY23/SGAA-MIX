package mx.edu.utez.sgaa.servlet.Estudiante;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import mx.edu.utez.sgaa.dao.DaoEstudiante;
import mx.edu.utez.sgaa.model.Estudiante;

@WebServlet(name = "EditarEstudiante", value = "/EditarEstudiante")
public class EditarEstudiante extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoEstudiante daoEstudiante = new DaoEstudiante();

    public EditarEstudiante() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");

        Estudiante estudiante = new Estudiante();
        estudiante.setMatricula(matricula);
        estudiante.setNombre(nombre);
        estudiante.setApellido(apellidos);

        boolean actualizado = daoEstudiante.actualizarEstudiante(estudiante);

        if (actualizado) {
            response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/PaginaPrincipalEstudiante.jsp");
            System.out.println("Estudiante actualizado");
        } else {
            response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/PaginaPrincipalEstudiante.jsp");
            System.out.println("No se encontro al estudiante");
        }
    }
}