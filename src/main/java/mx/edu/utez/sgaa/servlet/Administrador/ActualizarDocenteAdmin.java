package mx.edu.utez.sgaa.servlet.Administrador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.model.Docente;

import java.io.IOException;

@WebServlet(name = "ActualizarDocenteAdmin", value = "/ActualizarDocenteAdmin")
public class ActualizarDocenteAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/ConsultarInformacion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Recupera los datos del formulario
        String id = request.getParameter("u_id");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String contrasena = request.getParameter("contrasena");

        // Crea un objeto Docente con los datos recibidos
        Docente docente = new Docente();
        docente.setId(Integer.parseInt(id)); // Usamos el ID del docente
        docente.setNombres(nombres);
        docente.setApellidos(apellidos);
        docente.setContrasena(contrasena);

        // Llama al método actualizarDocenteAdmin del DAO
        DaoDocente daoDocente = new DaoDocente();
        boolean actualizado = daoDocente.actualizarDocenteAdmin(docente);

        // Verifica si la actualización fue exitosa y redirige o muestra un mensaje
        if (actualizado) {
            // Si fue exitoso, redirige a una página de éxito o lista actualizada
            response.sendRedirect(request.getContextPath() + "/vistas/Admin/ConsultarInformacion.jsp?status=success");
        } else {
            // Si falló, redirige a una página de error o muestra un mensaje
            request.setAttribute("error", "No se pudo actualizar el docente. Inténtalo nuevamente.");
            request.getRequestDispatcher("/vistas/Admin/ConsultarInformacion.jsp").forward(request, response);
        }
    }
}
