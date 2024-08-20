package mx.edu.utez.sgaa.servlet.Estudiante;

import mx.edu.utez.sgaa.dao.DaoEstudiante;
import mx.edu.utez.sgaa.model.Estudiante;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginEstudianteS", value = "/LoginEstudianteS")
public class LoginEstudianteS extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoEstudiante daoEstudiante = new DaoEstudiante();

    public LoginEstudianteS() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Estudiante/PaginaPrincipalEstudiante.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");

        // Debug output
        System.out.println("Parametros recibidos - Matricula: " + matricula + ", Contraseña: " + password);

        try {
            Estudiante estudiante = daoEstudiante.loginEstudiante(matricula, password);
            if (estudiante != null) {
                // Redirigir a una página de éxito o al dashboard del estudiante
                response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/PaginaPrincipalEstudiante.jsp");
            } else {
                // Volver a la página de inicio de sesión con un mensaje de error
                response.sendRedirect(request.getContextPath() + "/vistas/Estudiante/LoginEstudiante.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error al iniciar sesión.", e);
        }
    }
}
