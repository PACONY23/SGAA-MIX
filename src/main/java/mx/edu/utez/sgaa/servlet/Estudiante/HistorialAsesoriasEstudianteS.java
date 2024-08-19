package mx.edu.utez.sgaa.servlet.Estudiante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sgaa.dao.DaoEstudianteAsesoria;
import mx.edu.utez.sgaa.model.HistorialAsesoria;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import mx.edu.utez.sgaa.model.HistorialAsesoria;



@WebServlet("/historialAsesorias")
public class HistorialAsesoriasEstudianteS extends HttpServlet {

    private DaoEstudianteAsesoria historialAsesoriasDAO = new DaoEstudianteAsesoria();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            try {
                // Recuperar el ID del estudiante desde el parámetro del formulario
                String idEstudianteStr = request.getParameter("idEstudiante");
                System.out.println("ID Estudiante: " + idEstudianteStr);
                Integer idEstudiante = Integer.parseInt(idEstudianteStr);

                // Crear una instancia del DAO y obtener el historial de asesorías
                DaoEstudianteAsesoria historialAsesoriasDAO = new DaoEstudianteAsesoria();
                List<HistorialAsesoria> historialAsesorias = historialAsesoriasDAO.obtenerHistorialAsesoriasPorEstudiante(idEstudiante);

                // Establecer la lista como atributo en la solicitud
                request.setAttribute("historialAsesorias", historialAsesorias);

                // Redirigir a la vista JSP
                RequestDispatcher dispatcher = request.getRequestDispatcher("/vistas/Estudiante/HistorialEstudiante.jsp");
                dispatcher.forward(request, response);

            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace(); // Manejo de errores
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la solicitud.");
            }
    }
}


