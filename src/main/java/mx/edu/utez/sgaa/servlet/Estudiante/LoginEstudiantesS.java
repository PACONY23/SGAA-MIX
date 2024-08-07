package mx.edu.utez.sgaa.servlet.Estudiante;

import mx.edu.utez.sgaa.dao.DaoLoginDocente;
import mx.edu.utez.sgaa.dao.DaoLoginEstudiante;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginEstudiantesS", value = "/LoginEstudiantesS")
public class LoginEstudiantesS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establece el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");

        // Redirige a la página principal del admin si hay sesión activa
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

        String role = dao.findEstudianteByMatriculaAndContraseña(matricula, contraseña);

        if (role != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("matricula", matricula);
            session.setAttribute("role", role); // Guardar el rol en la sesión
            session.setAttribute("flag", true);
            System.out.println("Redirigiendo a PaginaPrincipalEstudiante.jsp");
            response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/PaginaPrincipalEstudiante.jsp"); // Redirigir a la página principal del admin
        } else {
            System.out.println("Credenciales incorrectas");
            request.setAttribute("flag", false);
            request.getRequestDispatcher("/vistas/Estudiante/LoginEstudiante.jsp").forward(request, response);
        }
    }
}