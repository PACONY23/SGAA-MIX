package mx.edu.utez.sgaa.servlet.Docente.nuevoSV;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import mx.edu.utez.sgaa.dao.DaoAsesoria;
import mx.edu.utez.sgaa.model.Asesoria;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/obtenerAsesorias")
public class ObtenerAsesoriasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Instancia del DAO para obtener las asesorías
    private DaoAsesoria daoAsesoria = new DaoAsesoria();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            List<Asesoria> asesorias = daoAsesoria.obtenerAsesorias();
            Gson gson = new Gson();
            Type asesoriasType = new TypeToken<List<Asesoria>>(){}.getType();
            String json = gson.toJson(asesorias, asesoriasType);
            out.print(json);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"message\": \"Error al recuperar las asesorías.\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}
