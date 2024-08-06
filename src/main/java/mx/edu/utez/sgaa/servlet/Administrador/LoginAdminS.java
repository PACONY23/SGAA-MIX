package mx.edu.utez.sgaa.servlet.Administrador;

import mx.edu.utez.sgaa.dao.DaoAdministrador;
import mx.edu.utez.sgaa.model.Administrador;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginAdminS", value = "/LoginAdminS")
public class LoginAdminS extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoAdministrador daoAdmin = new DaoAdministrador();

    public LoginAdminS() {
        super();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/PaginaPrincipalAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");

        // Debug output
        System.out.println("Parametros recibidos - Matricula: " + matricula + ", Contraseña: " + password);

        try {
            Administrador admin = daoAdmin.loginAdmin(matricula, password);
            if (admin != null) {
                // Redirigir a una página de éxito o al dashboard del administrado
                response.sendRedirect(request.getContextPath() + "/vistas/Admin/PaginaPrincipalAdmin.jsp");
            } else {
                // Volver a la página de inicio de sesión con un mensaje de error
                response.sendRedirect(request.getContextPath() + "/vistas/Admin/LoginAdmin.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error al iniciar sesión.", e);
        }
    }
}