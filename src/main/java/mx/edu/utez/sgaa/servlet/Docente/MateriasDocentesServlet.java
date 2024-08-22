package mx.edu.utez.sgaa.servlet.Docente;

import com.google.gson.Gson;
import mx.edu.utez.sgaa.dao.DaoMateriasDocentes;
import mx.edu.utez.sgaa.model.MateriasDocentes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "MateriasDocentesServlet", value = "/MateriasDocentesServlet")
public class MateriasDocentesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoMateriasDocentes daoMateriasDocentes = new DaoMateriasDocentes();

    public MateriasDocentesServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");

        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula es requerida");
            return;
        }

        List<MateriasDocentes> materias = daoMateriasDocentes.obtenerMateriasDocente(matricula);

        // Configurar el tipo de contenido de la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Convertir la lista de materias a JSON
        Gson gson = new Gson();
        String json = gson.toJson(materias);

        // Escribir el JSON en la respuesta
        response.getWriter().write(json);
    }
}
