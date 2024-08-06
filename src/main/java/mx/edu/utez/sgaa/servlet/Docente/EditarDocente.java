package mx.edu.utez.sgaa.servlet.Docente;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import mx.edu.utez.sgaa.dao.DaoDocente;
import mx.edu.utez.sgaa.model.Docente;

@WebServlet(name = "EditarDocente", value = "/EditarDocente")
public class EditarDocente extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DaoDocente daoDocente = new DaoDocente();

    public EditarDocente() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");

        Docente docente = new Docente();
        docente.setMatricula(matricula);
        docente.setNombres(nombre);
        docente.setApellidos(apellidos);

        boolean actualizado = daoDocente.actualizarDocente(docente);

        if (actualizado) {
            response.sendRedirect(request.getContextPath() + "/vistas/Docente/PaginaPrincipalDocente.jsp");
            System.out.println("Docente actualizado");
        } else {
            response.sendRedirect(request.getContextPath() + "/vistas/Docente/ErrorActualizacion.jsp");
            System.out.println("No se encontró al docente");
        }
    }
}
