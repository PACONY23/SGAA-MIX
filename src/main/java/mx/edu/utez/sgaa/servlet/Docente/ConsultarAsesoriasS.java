package mx.edu.utez.sgaa.servlet.Docente;

import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.model.Asesoria;
import mx.edu.utez.sgaa.database.DatabaseConnection;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ConsultarAsesoriasS", value = "/ConsultarAsesoriasS")
public class ConsultarAsesoriasS extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DatabaseConnection.getConnection()) {
            DaoAsesoria daoAsesoria = new DaoAsesoria(connection);
            List<Asesoria> asesorias = daoAsesoria.obtenerAsesorias();
            String json = new Gson().toJson(asesorias);
            response.setContentType("application/json");
            response.getWriter().write(json);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

