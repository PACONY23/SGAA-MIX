package mx.edu.utez.sgaa.servlet.Materia;

import com.google.gson.Gson;
import mx.edu.utez.sgaa.dao.DaoMateria;
import mx.edu.utez.sgaa.model.Materia;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetAllMateriasS", value = "/GetAllMateriasS")
public class GetAllMateriasS extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configurar codificación y tipo de contenido
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        // Crear instancia del DAO y obtener la lista de materias
        DaoMateria dao = new DaoMateria();
        List<Materia> materias = dao.getAllMaterias1();

        // Convertir la lista de materias a JSON
        Gson gson = new Gson();
        String json = gson.toJson(materias);

        // Enviar el JSON como respuesta
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Reutilizar el método doGet para el POST
    }
}
