package mx.edu.utez.sgaa.servlet.Docente;

import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.model.Docente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegistroDocentesS", value = "/RegistroDocentesS")
public class RegistroDocentesS extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoDocente daoDocente = new DaoDocente();

    public RegistroDocentesS() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Docente/SeleccionMateriasDocente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("email");
        Boolean estatus = true;
        Boolean admision = false;
        String rol = "Docente";

        Docente docente = new Docente();
        docente.setNombres(nombre);
        docente.setApellidos(apellido);
        docente.setContrasena(password);
        docente.setMatricula(matricula);
        docente.setCorreoElectronico(correo);
        docente.setEstatus(estatus);
        docente.setAdmission(admision);
        docente.setRol(rol);

        // Debug output
        System.out.println("Parametros recibidos - Matricula: " + matricula + ", Contraseña: " + password + ", Nombre: " + nombre + ", Apellido: " + apellido + ", Rol: " + rol);

        try {
            int result = daoDocente.RegistrarDocente(docente);
            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/vistas/Docente/LoginDocente.jsp");
                response.getWriter().println("Docente registrado exitosamente.");
            } else {
                response.getWriter().println("Error al registrar docente.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error al registrar docente.", e);
        }
    }
}
