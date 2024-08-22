package mx.edu.utez.sgaa.servlet.Docente;

import com.google.gson.Gson;
import mx.edu.utez.sgaa.dao.DaoDocente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ObtenerIdDocenteServlet", urlPatterns = "/ObtenerIdDocenteServlet")
public class ObtenerIdDocenteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoDocente daoDocente = new DaoDocente();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        int idDocente = daoDocente.obtenerIdDocente(matricula);

        // Crear el objeto de respuesta
        IdDocenteResponse responseObject = new IdDocenteResponse(idDocente);

        // Convertir el objeto a JSON usando Gson
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(responseObject);

        // Configurar el tipo de contenido y escribir la respuesta
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
    }

    // Clase de respuesta para convertir a JSON
    private static class IdDocenteResponse {
        private int idDocente;

        public IdDocenteResponse(int idDocente) {
            this.idDocente = idDocente;
        }

        public int getIdDocente() {
            return idDocente;
        }
    }
}
