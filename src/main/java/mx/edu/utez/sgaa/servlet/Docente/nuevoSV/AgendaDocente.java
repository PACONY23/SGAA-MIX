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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/obtenerAsesoriasS")
public class AgendaDocente extends HttpServlet {

    private DaoAsesoria daoAsesoria;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Establecer conexión a la base de datos
            Connection connection = DriverManager.getConnection("jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante", "admin", "2512032201Jafet");
            daoAsesoria = new DaoAsesoria(connection);
        } catch (SQLException e) {
            throw new ServletException("No se pudo conectar a la base de datos", e);
        }
    }

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
