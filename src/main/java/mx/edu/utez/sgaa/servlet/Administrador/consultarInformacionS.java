package mx.edu.utez.sgaa.servlet.Administrador;

import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.dao.DaoEstudiante;
import mx.edu.utez.sgaa.model.Docente;
import mx.edu.utez.sgaa.model.Estudiante;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "consultarInformacionS", value = "/consultarInformacionS")
public class consultarInformacionS extends HttpServlet {
    private DaoDocente daoDocente;
    private DaoEstudiante daoEstudiante;

    @Override
    public void init() throws ServletException {
        daoDocente = new DaoDocente();
        daoEstudiante = new DaoEstudiante();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String tipo = request.getParameter("tipo");
        String action = request.getParameter("action");
        String json = "";

        if ("listarDocentes".equals(action)) {
            List<Docente> docentes = daoDocente.listarDocentes();
            json = new Gson().toJson(docentes);
        } else if ("listarEstudiantes".equals(action)) {
            List<Estudiante> estudiantes = daoEstudiante.listarEstudiantes();
            json = new Gson().toJson(estudiantes);
        } else {
            if ("docente".equalsIgnoreCase(tipo)) {
                Docente docente = daoDocente.getDocenteByMatricula(matricula);
                json = new Gson().toJson(docente);
            } else if ("estudiante".equalsIgnoreCase(tipo)) {
                Estudiante estudiante = daoEstudiante.getEstudianteByMatricula(matricula);
                json = new Gson().toJson(estudiante);
            }
        }

        response.setContentType("application/json");
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateDocente".equalsIgnoreCase(action)) {
            updateDocente(request, response);
        } else if ("updateEstudiante".equalsIgnoreCase(action)) {
            updateEstudiante(request, response);
        } else if ("desactivarDocente".equalsIgnoreCase(action)) {
            desactivarDocente(request, response);
        } else if ("desactivarEstudiante".equalsIgnoreCase(action)) {
            desactivarEstudiante(request, response);
        } else if ("activarDocente".equalsIgnoreCase(action)) {
            activarDocente(request, response);
        } else if ("activarEstudiante".equalsIgnoreCase(action)) {
            activarEstudiante(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void updateDocente(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String matricula = request.getParameter("matricula");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String correoElectronico = request.getParameter("correoElectronico");

        Docente docente = new Docente();
        docente.setMatricula(matricula);
        docente.setNombres(nombres);
        docente.setApellidos(apellidos);
        docente.setCorreoElectronico(correoElectronico);

        boolean success = daoDocente.actualizarDocente(docente);

        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }

    private void updateEstudiante(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String matricula = request.getParameter("matricula");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correoElectronico = request.getParameter("correoElectronico");
        String grupo = request.getParameter("grupo");
        String cuatrimestre = request.getParameter("cuatrimestre");

        Estudiante estudiante = new Estudiante();
        estudiante.setMatricula(matricula);
        estudiante.setNombre(nombre);
        estudiante.setApellido(apellido);
        estudiante.setCorreoElectronico(correoElectronico);
        estudiante.setGrupo(grupo);
        estudiante.setCuatrimestre(Integer.parseInt(cuatrimestre));

        boolean success = daoEstudiante.actualizarEstudiante(estudiante);

        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }

    private void desactivarDocente(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String matricula = request.getParameter("matricula");
        boolean success = daoDocente.desactivarDocente(matricula);
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }

    private void desactivarEstudiante(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String matricula = request.getParameter("matricula");
        boolean success = daoEstudiante.desactivarEstudiante(matricula);
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }

    private void activarDocente(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String matricula = request.getParameter("matricula");
        boolean success = daoDocente.activarDocente(matricula);
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }

    private void activarEstudiante(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String matricula = request.getParameter("matricula");
        boolean success = daoEstudiante.activarEstudiante(matricula);
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }
}
