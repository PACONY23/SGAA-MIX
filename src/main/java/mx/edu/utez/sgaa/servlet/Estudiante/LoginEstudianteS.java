package mx.edu.utez.sgaa.servlet.Estudiante;

import mx.edu.utez.sgaa.dao.DaoEstudiante;
import mx.edu.utez.sgaa.model.Estudiante;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
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
        /* request.setCharacterEncoding("UTF-8");
       // response.setContentType("text/html; charset=UTF-8");
        if(request.getSession( false) == null){
            request.getSession(true);
        }
       // <%-- if(request.getParameter())--%>*/
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");

        // Debug output
        System.out.println("Parametros recibidos - Matricula: " + matricula + ", Contraseña: " + password);

        try {
            Estudiante estudiante = daoEstudiante.loginEstudiante(matricula, password);
            if (estudiante != null) {
                // Redirigir a una página de éxito o al dashboard del administrador
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