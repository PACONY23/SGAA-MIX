package mx.edu.utez.sgaa.servlet.Docente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

import mx.edu.utez.sgaa.dao.DaoMateriasDocentes;

@WebServlet(name = "SeleccionMateriasDocenteS", value = "/SeleccionMateriasDocenteS")
public class SeleccionMateriasDocenteS extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoMateriasDocentes dao = new DaoMateriasDocentes();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Este método no hace nada en la implementación actual
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String materiaId = request.getParameter("materiaId");
        String matriculaDocente = request.getParameter("matriculaDocente");

        try {
            dao.insertarMateriaDocente(materiaId, matriculaDocente);
        } catch (SQLException e) {
            e.printStackTrace();
            // Manejo de errores adicional si es necesario
        }

        response.sendRedirect(request.getContextPath() + "/vistas/Docente/CrearHorario.jsp");
    }
}
