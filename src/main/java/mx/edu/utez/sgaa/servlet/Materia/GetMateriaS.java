package mx.edu.utez.sgaa.servlet.Materia;

import mx.edu.utez.sgaa.model.Materia;
import mx.edu.utez.sgaa.dao.DaoMateria;
import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "GetMateriaS", value = "/GetMateriaS")
public class GetMateriaS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        Long id = Long.parseLong(request.getParameter("id"));
        Materia materia = new DaoMateria().findMateriaById(id);
        String json = new Gson().toJson(materia);
        response.getWriter().write(json);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}