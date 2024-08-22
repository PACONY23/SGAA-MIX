package mx.edu.utez.sgaa.servlet.Administrador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.dao.DaoEstudiante;
import mx.edu.utez.sgaa.model.Docente;
import mx.edu.utez.sgaa.model.Estudiante;

import java.io.IOException;

@WebServlet(name = "ActualizarEstudianteAdmin", value = "/ActualizarEstudianteAdmin")
public class ActualizarEstudianteAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/vistas/Admin/ConsultarInformacion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");


        String id = request.getParameter("u_id_e");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String grupo = request.getParameter("grupo");
        String cuatrimestre = request.getParameter("cuatrimestre");
        String contrasena_e = request.getParameter("contrasena_e");

        Estudiante estudiante = new Estudiante();
        estudiante.setId(Integer.parseInt(id)); // Usamos el ID del docente
        estudiante.setNombre(nombre);
        estudiante.setApellido(apellido);
        estudiante.setGrupo(grupo);
        estudiante.setCuatrimestre(cuatrimestre);
        estudiante.setContrasena(contrasena_e);

        DaoEstudiante daoEstudiante = new DaoEstudiante();
        boolean actualizado = daoEstudiante.actualizarEstudianteAdmin(estudiante);

        if(actualizado){
            response.sendRedirect(request.getContextPath() + "/vistas/Admin/ConsultarInformacion.jsp?status=success");
        }else {
            // Si falló, redirige a una página de error o muestra un mensaje
            request.setAttribute("error", "No se pudo actualizar el docente. Inténtalo nuevamente.");
            request.getRequestDispatcher("/vistas/Admin/ConsultarInformacion.jsp").forward(request, response);
        }

    }
}