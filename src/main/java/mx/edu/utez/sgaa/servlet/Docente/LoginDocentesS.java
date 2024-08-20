package mx.edu.utez.sgaa.servlet.Docente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sgaa.dao.DaoLoginDocente;

import java.io.IOException;

@WebServlet(name = "LoginDocentesS", value = "/LoginDocentesS")
public class LoginDocentesS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establece el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");

        // Redirige a la página principal del admin si hay sesión activa
        if (request.getSession(false) != null) {
            System.out.println("Sesión activa encontrada, redirigiendo a PaginaPrincipalDocente.jsp");
            response.sendRedirect(request.getContextPath() + "/vistas/Docente/PaginaPrincipalDocente.jsp");
        } else {
            System.out.println("No hay sesión activa, mostrando LoginDocente.jsp");
            request.getRequestDispatcher("/vistas/Docente/LoginDocente.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        DaoLoginDocente dao = new DaoLoginDocente();

        String matricula = request.getParameter("matricula");
        String contraseña = request.getParameter("password");

        System.out.println("Matricula: " + matricula);
        System.out.println("Contraseña: " + contraseña);

        String[] docenteData = dao.findDocenteByMatriculaAndContraseña(matricula, contraseña);

        if (docenteData != null) {
            String idDocente = docenteData[0];
            String nombre = docenteData[2];
            String apellido = docenteData[3];
            String correo = docenteData[4];
            HttpSession session = request.getSession(true);
            session.setAttribute("idDocente", idDocente);
            session.setAttribute("matricula", matricula);
            session.setAttribute("nombre", nombre);
            session.setAttribute("apellido", apellido);
            session.setAttribute("correo", correo);
            session.setAttribute("role", "docente"); // Guardar el rol en la sesión
            session.setAttribute("flag", true);
            System.out.println("Redirigiendo a PaginaPrincipalDocente.jsp");
            response.sendRedirect(request.getContextPath() + "/vistas/Docente/PaginaPrincipalDocente.jsp"); // Redirigir a la página principal del admin
        } else {
            System.out.println("Credenciales incorrectas");
            request.setAttribute("flag", false);
            request.getRequestDispatcher("/vistas/Docente/LoginDocente.jsp").forward(request, response);
        }
    }
}
