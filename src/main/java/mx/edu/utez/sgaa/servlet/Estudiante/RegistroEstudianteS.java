package mx.edu.utez.sgaa.servlet.Estudiante;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import mx.edu.utez.sgaa.dao.DaoEstudiante;
import mx.edu.utez.sgaa.model.Estudiante;

@WebServlet(name = "RegistroEstudianteS", value = "/RegistroEstudianteS")
public class RegistroEstudianteS extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoEstudiante daoEstudiante = new DaoEstudiante();

    public RegistroEstudianteS() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Estudiante/LoginEstudiante.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");

        Estudiante estudiante = new Estudiante();
        estudiante.setNombre(nombre);
        estudiante.setApellido(apellido);
        estudiante.setContrasena(password);
        estudiante.setMatricula(matricula);

        // Debug output
        System.out.println("Parametros recibidos - Matricula: " + matricula + ", Contraseña: " + password + ", Nombre: " + nombre + ", Apellido: " + apellido);

        try {
            int result = daoEstudiante.RegistrarEstudiante(estudiante);
            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/LoginEstudiante.jsp");
                response.getWriter().println("Estudiante registrado exitosamente.");

            } else {
                response.getWriter().println("Error al registrar estudiante.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error al registrar estudiante.", e);
        }

    }
}