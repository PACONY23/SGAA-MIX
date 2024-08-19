package mx.edu.utez.sgaa.servlet.Docente;

import mx.edu.utez.sgaa.dao.DaoMateriasDocentes;
import mx.edu.utez.sgaa.model.MateriasDocentes;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "CrearHorarioS", value = "/CrearHorarioS")
public class CrearHorarioS extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Obtener la sesión sin crear una nueva
        if (session != null) {
            String matricula = (String) session.getAttribute("matricula"); // Obtener la matrícula de la sesión

            if (matricula != null) {
                try {
                    // Establecer la conexión a la base de datos
                    Connection connection = DriverManager.getConnection("jdbc:mysql://db-sgaa.cf75ndzosmhf.us-east-1.rds.amazonaws.com:3306/estudiante", "admin", "2512032201Jafet");

                    // Crear una instancia de DaoMateriasDocentes y pasarle la conexión
                    DaoMateriasDocentes daoMateriasDocentes = new DaoMateriasDocentes();
                    List<MateriasDocentes> materiasDocente = daoMateriasDocentes.obtenerMateriasDocente("matricula");

                    // Enviar la lista de materias al JSP
                    request.setAttribute("materiasDocente", materiasDocente);
                    request.getRequestDispatcher("/vistas/Docente/CrearHorario.jsp").forward(request, response);

                    // Cerrar la conexión
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    // En caso de error, redirigir a una página de error o mostrar un mensaje apropiado
                    response.sendRedirect(request.getContextPath() + "/error.jsp");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/vistas/Docente/LoginDocente.jsp"); // Redirigir al login si no hay matrícula
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/vistas/Docente/LoginDocente.jsp"); // Redirigir al login si no hay sesión
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Delegar en doGet para reutilizar lógica
    }
}
