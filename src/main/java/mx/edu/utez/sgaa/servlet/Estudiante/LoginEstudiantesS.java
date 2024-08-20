package mx.edu.utez.sgaa.servlet.Estudiante;

import mx.edu.utez.sgaa.dao.DaoLoginDocente;
import mx.edu.utez.sgaa.dao.DaoLoginEstudiante;
import mx.edu.utez.sgaa.model.Estudiante;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet(name = "LoginEstudiantesS", value = "/LoginEstudiantesS")
public class LoginEstudiantesS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establece el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");

        // Redirige a la página principal del estudiante si hay sesión activa
        if (request.getSession(false) != null) {
            response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/PaginaPrincipalEstudiante.jsp");
        } else {
            request.getRequestDispatcher("/vistas/Estudiante/LoginEstudiante.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        DaoLoginEstudiante dao = new DaoLoginEstudiante();

        String matricula = request.getParameter("matricula");
        String contraseña = request.getParameter("password");

        System.out.println("Matricula: " + matricula);
        System.out.println("Contraseña: " + contraseña);

        // Buscar el estudiante usando el DAO
        String[] estudianteData = dao.findEstudianteDataByMatriculaAndContraseña(matricula, contraseña);

        if (estudianteData != null) {
            String idEstudiante = estudianteData[0];
            String nombre = estudianteData[2];
            String apellido = estudianteData[3];
            String correo = estudianteData[4];
            String grupo = estudianteData[5];
            String cuatrimestre = estudianteData[6];

            HttpSession session = request.getSession(true);
            // Guardar los atributos en la sesión
            session.setAttribute("idEstudiante", idEstudiante); // Guardar el id del estudiante en la sesión
            session.setAttribute("matricula", matricula);
            session.setAttribute("correo", correo);
            session.setAttribute("nombre", nombre);
            session.setAttribute("apellido", apellido);
            session.setAttribute("grupo", grupo);
            session.setAttribute("cuatrimestre", cuatrimestre);
            session.setAttribute("role", "estudiante"); // Guardar el rol en la sesión
            session.setAttribute("flag", true);

            System.out.println("Redirigiendo a PaginaPrincipalEstudiante.jsp");

            // Redirigir al estudiante a la página principal
            response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/PaginaPrincipalEstudiante.jsp");
        } else {
            System.out.println("Credenciales incorrectas");
            // Si las credenciales son incorrectas, establecer el flag en false y volver al login
            request.setAttribute("flag", false);
            request.getRequestDispatcher("/vistas/Estudiante/LoginEstudiante.jsp").forward(request, response);
        }
    }
}
