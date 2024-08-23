package mx.edu.utez.sgaa.servlet.Administrador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.model.Docente;

@WebServlet(name = "AgregarDocenteAdminS", value = "/AgregarDocenteAdminS")
public class AgregarDocenteAdminS extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoDocente daoDocente = new DaoDocente();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/AprobarRegistro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("email");
        Boolean estatus = true;
        Boolean admision = true;
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

        String message;
        String alertType;

        try {
            if (daoDocente.existeDocente(matricula)) {
                message = "El docente ya está registrado.";
                alertType = "error";
            } else {
                int result = daoDocente.RegistrarDocente(docente);
                if (result > 0) {
                    message = "Docente registrado exitosamente.";
                    alertType = "success";
                } else {
                    message = "Error al registrar el docente.";
                    alertType = "error";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error al registrar docente: " + e.getMessage();
            alertType = "error";
        }

        request.setAttribute("message", message);
        request.setAttribute("alertType", alertType);
        doGet(request, response);
    }
}
