package mx.edu.utez.sgaa.servlet.Docente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.sql.SQLException;

import mx.edu.utez.sgaa.database.DatabaseConnection;
import mx.edu.utez.sgaa.dao.DaoAsesoria;

@WebServlet(name = "ReagendarAsesoriaS", value = "/ReagendarAsesoriaS")
public class ReagendarAsesoriaS extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idAsesoriaStr = request.getParameter("a_id");
        String fechaReagendadaStr = request.getParameter("fechaReagendada");
        String horaReagendadaStr = request.getParameter("horaReagendada");

        if (idAsesoriaStr != null && !idAsesoriaStr.isEmpty() &&
                fechaReagendadaStr != null && !fechaReagendadaStr.isEmpty() &&
                horaReagendadaStr != null && !horaReagendadaStr.isEmpty()) {

            try {
                int idAsesoria = Integer.parseInt(idAsesoriaStr);

                Date fechaReagendada;
                Time horaReagendada;
                try {
                    fechaReagendada = Date.valueOf(fechaReagendadaStr);
                    horaReagendada = Time.valueOf(horaReagendadaStr);
                    System.out.println("Fecha de reagenda: " + fechaReagendada + ", hora de reagenda: " + horaReagendada);
                } catch (IllegalArgumentException e) {
                    System.out.println("Formato de fecha o hora inválido. Asegúrese de que la hora esté en formato 'hh:mm:ss'.");
                    request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
                    return;
                }

                Date fechaActual = new Date(System.currentTimeMillis());

                if (fechaReagendada.before(fechaActual)) {
                    System.out.println("La fecha seleccionada no puede ser una fecha pasada.");
                    request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
                    return;
                }

                DaoAsesoria daoAsesoria = new DaoAsesoria(DatabaseConnection.getConnection());
                daoAsesoria.actualizarAsesoriaYReagendar(idAsesoria, fechaReagendada, horaReagendada);

                response.sendRedirect(request.getContextPath() + "/vistas/Docente/AsesoriasGestionDocente.jsp");

            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Error en la base de datos.");
                request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Ocurrió un error inesperado.");
                request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
            }
        } else {
            System.out.println("Datos incompletos.");
            request.setAttribute("errorMessage", "Datos incompletos.");
            request.getRequestDispatcher("/vistas/Docente/AsesoriasGestionDocente.jsp").forward(request, response);
        }
    }
}
