package mx.edu.utez.sgaa.servlet.Estudiante;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
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
        String grupo = request.getParameter("grupo");
        String cuatrimestre = request.getParameter("cuatrimestre");

        Estudiante estudiante = new Estudiante();
        estudiante.setMatricula(matricula);
        estudiante.setNombre(nombre);
        estudiante.setApellido(apellidos);
        estudiante.setGrupo(grupo);
        estudiante.setCuatrimestre(cuatrimestre);
        System.out.println("Est Ma: " +estudiante.getMatricula());
        System.out.println("Est No: " +estudiante.getNombre());
        System.out.println("Est Ap: " +estudiante.getApellido());
        System.out.println("Est Grupo: " +estudiante.getGrupo());
        System.out.println("Est Cuat: " +estudiante.getCuatrimestre());


        boolean actualizado = daoEstudiante.actualizarEstudianteJE(estudiante);

        if (actualizado) {
            response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/PaginaPrincipalEstudiante.jsp");
            System.out.println("Estudiante actualizado");
        } else {
            response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/PaginaPrincipalEstudiante.jsp");
            System.out.println("No se encontró al estudiante");
        }
    }
}
