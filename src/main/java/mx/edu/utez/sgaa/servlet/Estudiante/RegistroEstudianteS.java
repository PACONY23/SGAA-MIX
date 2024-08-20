package mx.edu.utez.sgaa.servlet.Estudiante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
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
        String cuatrimestre = request.getParameter("Cuatrimestre");
        String grupo = request.getParameter("grupo");
        String division = request.getParameter("div_aca");
        String carrera = request.getParameter("carrera");
        String insti = "@utez.edu.mx";
        String email = matricula + insti;
        Boolean estatus = true;
        String rol = "Estudiante";

        Estudiante estudiante = new Estudiante();
        estudiante.setNombre(nombre);
        estudiante.setApellido(apellido);
        estudiante.setContrasena(password);
        estudiante.setMatricula(matricula);
        estudiante.setGrupo(grupo);
        estudiante.setCuatrimestre(cuatrimestre);
        estudiante.setEstatus(estatus);
        estudiante.setRol(rol);
        estudiante.setCorreoElectronico(email);

        // Debug output
        System.out.println("Parametros recibidos - Matricula: " + matricula + ", Contraseña: " + password + ", Nombre: " + nombre + ", Apellido: " + apellido);

        try {
            // Verificar si la matrícula ya existe
            if (daoEstudiante.existeEstudiante(matricula)) {
                // Si la matrícula ya existe, mostrar un mensaje de error
                request.setAttribute("message", "La matrícula ya está registrada.");
                request.setAttribute("alertType", "error");
                request.getRequestDispatcher("/vistas/Estudiante/RegistroEstudiante.jsp").forward(request, response);
                return;
            }

            int result = daoEstudiante.RegistrarEstudiante(estudiante);
            if (result > 0) {
                // Redirigir al login en caso de éxito
                request.setAttribute("message", "Estudiante registrado exitosamente.");
                request.setAttribute("alertType", "success");
                request.getRequestDispatcher("/vistas/Estudiante/LoginEstudiante.jsp").forward(request, response);
            } else {
                // Mostrar mensaje de error si el registro falla
                request.setAttribute("message", "Error al registrar estudiante.");
                request.setAttribute("alertType", "error");
                request.getRequestDispatcher("/vistas/Estudiante/RegistroEstudiante.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error al registrar estudiante.", e);
        }
    }
}