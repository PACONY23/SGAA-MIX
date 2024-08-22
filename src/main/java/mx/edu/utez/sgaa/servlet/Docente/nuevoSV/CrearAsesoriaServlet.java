package mx.edu.utez.sgaa.servlet.Docente.nuevoSV;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/CrearAsesoriaS")
public class CrearAsesoriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoAsesoria2 daoAsesoria = new DaoAsesoria2();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Boolean flag = (Boolean) request.getAttribute("flag");

        if (flag != null && flag) {
            request.setAttribute("successMessage", "Asesoria creado exitosamente.");
        } else if (flag != null && !flag) {
            request.setAttribute("errorMessage", "Error al crear la asesoria. Inténtalo de nuevo.");
        }
        request.getRequestDispatcher("/vistas/Docente/CrearHorario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configurar el tipo de contenido de la solicitud
        request.setCharacterEncoding("UTF-8");

        LocalDateTime fechaHoraAsesoria = LocalDateTime.parse(request.getParameter("fecha") + "T" + request.getParameter("hora"));
        LocalDateTime fechaHoraActual = LocalDateTime.now();

        if (fechaHoraAsesoria.isBefore(fechaHoraActual)) {
            request.setAttribute("flag", false);
            doGet(request, response);
            return;
        }


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
            if(success){
                request.setAttribute("flag", true);

            }else{
                request.setAttribute("flag", false);
            }
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("flag", false);
            doGet(request, response);
        }
        doGet(request, response);

    }
}