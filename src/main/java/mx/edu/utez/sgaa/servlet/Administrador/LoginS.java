package mx.edu.utez.sgaa.servlet.Administrador;

import mx.edu.utez.sgaa.dao.DaoLogin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginS", value = "/LoginS")
public class LoginS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establece el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");

        // Redirige a la página principal del admin si hay sesión activa
        if (request.getSession(false) != null) {
            response.sendRedirect(request.getContextPath() + "/vistas/Admin/PaginaPrincipalAdmin.jsp");
        } else {
            request.getRequestDispatcher("/vistas/Admin/LoginAdmin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        DaoLogin dao = new DaoLogin();

        String matricula = request.getParameter("matricula");
        String contraseña = request.getParameter("password");

        System.out.println("Matricula: " + matricula);
        System.out.println("Contraseña: " + contraseña);

        String role = dao.findAdminByMatriculaAndContraseña(matricula, contraseña);

        if (role != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("matricula", matricula);
            session.setAttribute("role", role); // Guardar el rol en la sesión
            session.setAttribute("flag", true);
            System.out.println("Redirigiendo a PaginaPrincipalAdmin.jsp");
            response.sendRedirect(request.getContextPath() + "/vistas/Admin/PaginaPrincipalAdmin.jsp"); // Redirigir a la página principal del admin
        } else {
            System.out.println("Credenciales incorrectas");
            request.setAttribute("flag", false);
            request.getRequestDispatcher("/vistas/Admin/LoginAdmin.jsp").forward(request, response);
        }
    }

}