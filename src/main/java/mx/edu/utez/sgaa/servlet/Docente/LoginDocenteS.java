package mx.edu.utez.sgaa.servlet.Docente;

import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.model.Docente;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginDocenteS", value = "/LoginDocenteS")
public class LoginDocenteS extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoDocente daoDocente = new DaoDocente();

    public LoginDocenteS() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Docente/LoginDocente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");

        // Debug output
        System.out.println("Parametros recibidos - Matricula: " + matricula + ", Contraseña: " + password);

        try {
            Docente docente = daoDocente.loginDocente(matricula, password);
            if (docente != null) {
                // Redirigir a una página de éxito o al dashboard del docente
                System.out.println("Login exitoso - Matricula: " + docente.getMatricula());
                response.sendRedirect(request.getContextPath() + "/vistas/Docente/PaginaPrincipalDocente.jsp");
            } else {
                // Volver a la página de inicio de sesión con un mensaje de error
                System.out.println("Login fallido - Matricula o contraseña incorrecta");
                response.sendRedirect(request.getContextPath() + "/vistas/Docente/LoginDocente.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error al iniciar sesión.", e);
        }
    }
}