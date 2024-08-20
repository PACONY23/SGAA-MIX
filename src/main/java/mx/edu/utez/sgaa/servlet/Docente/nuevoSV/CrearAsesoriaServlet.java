package mx.edu.utez.sgaa.servlet.Docente.nuevoSV;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CrearAsesoriaS")
public class CrearAsesoriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoAsesoria2 daoAsesoria = new DaoAsesoria2();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configurar el tipo de contenido de la solicitud
        request.setCharacterEncoding("UTF-8");

        try {
            // Leer los parámetros de la solicitud
            int idDocente = Integer.parseInt(request.getParameter("idDocente"));
            int idMateria = Integer.parseInt(request.getParameter("idMateria"));
            String titulo = request.getParameter("titulo");
            String fecha = request.getParameter("fecha");
            String hora = request.getParameter("hora");

            // Llamar al método para crear la asesoría
            boolean success = daoAsesoria.crearAsesoria(idDocente, idMateria, titulo, fecha, hora);

            // Configurar la respuesta
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"" + (success ? "success" : "error") + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
