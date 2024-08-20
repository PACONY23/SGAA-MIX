package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.database.DatabaseConnection;
import mx.edu.utez.sgaa.model.Materia;
import mx.edu.utez.sgaa.model.MateriasDocentes;
import mx.edu.utez.sgaa.model.Asesoria;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DaoMateria {
    private Connection con;
    private PreparedStatement pstm;
    private ResultSet rs;
    private final DatabaseConnection DATA_BASE_CONNECTION = new DatabaseConnection();
    private CallableStatement callableStatement;


    private final String[] QUERIES = {
            "INSERT INTO Materias (Nombre_materia) VALUES (?);",
            "DELETE FROM Materias WHERE idMateria = ?;",
            "UPDATE Materias SET Nombre_materia=? WHERE idMateria=?;",
            "SELECT * FROM Materias WHERE idMateria=?;",
            "UPDATE Materias SET materia_estado = ? WHERE idMateria = ?"
    };

    public boolean agregarMateria(Materia materia) {
        Connection con = null;
        CallableStatement callableStatement = null;

        try {
            // Obtener la conexión
            con = DATA_BASE_CONNECTION.getConnection();

            // Preparar la llamada al procedimiento almacenado
            String sql = "{CALL agregarMateria(?)}";
            callableStatement = con.prepareCall(sql);

            // Establecer el parámetro de entrada (nombre de la materia)
            callableStatement.setString(1, materia.getNombre());

            // Ejecutar el procedimiento almacenado
            boolean hasResultSet = callableStatement.execute();

            // Procesar el resultado
            if (hasResultSet) {
                ResultSet rs = callableStatement.getResultSet();
                if (rs.next()) {
                    String mensaje = rs.getString("mensaje");
                    System.out.println(mensaje);
                    // Si el mensaje indica éxito, retornamos true
                    return mensaje.equals("Materia agregada exitosamente.");
                }
            }

            return false;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            // Cerrar el CallableStatement y la conexión
            if (callableStatement != null) {
                try {
                    callableStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }


    public boolean eliminarMateria(long id) {
        Connection con = null;
        CallableStatement callableStatement = null;

        try {
            // Obtiene la conexión
            con = DATA_BASE_CONNECTION.getConnection();

            // Prepara el procedimiento almacenado
            String sql = "{CALL borrarMaterias(?)}";
            callableStatement = con.prepareCall(sql);

            // Establece el parámetro de entrada
            callableStatement.setLong(1, id);

            // Ejecuta la llamada al procedimiento almacenado
            int result = callableStatement.executeUpdate();

            // Retorna true si se eliminó con éxito
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            // Cierra el CallableStatement
            if (callableStatement != null) {
                try {
                    callableStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            // Cierra la conexión
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    //1500
    public List<Materia> getAllMaterias(String matriculaDocente) {
        List<Materia> materias = new ArrayList<>();
        List<String> materiasDocente = new ArrayList<>();
        try {
            // Obtener materias asociadas al docente
            DaoMateriasDocentes daoMateriasDocentes = new DaoMateriasDocentes();
            List<MateriasDocentes> materiasDocentesList = daoMateriasDocentes.obtenerMateriasDocente(matriculaDocente);
            for (MateriasDocentes materiaDocente : materiasDocentesList) {
                materiasDocente.add(materiaDocente.getNombreMateria());
            }

            // Obtener todas las materias
            con = DATA_BASE_CONNECTION.getConnection();
            pstm = con.prepareStatement("SELECT * FROM Materias;");
            rs = pstm.executeQuery();

            // Agregar materias a la lista si no están en la lista de materias del docente
            while (rs.next()) {
                Materia materia = new Materia();
                materia.setId(rs.getLong("idMateria"));
                materia.setNombre(rs.getString("Nombre_materia"));
                materia.setMateria_estado(rs.getBoolean("materia_estado"));

                // Solo agregar si la materia no está en la lista de materias del docente
                if (!materiasDocente.contains(materia.getNombre())) {
                    materias.add(materia);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return materias;
    }

    public List<Materia> getAllMaterias1() {
        List<Materia> materias = new ArrayList<>();
        try {
            con = DATA_BASE_CONNECTION.getConnection();
            pstm = con.prepareStatement("SELECT * FROM Materias;");
            rs = pstm.executeQuery();

            while (rs.next()) {
                Materia materia = new Materia();
                materia.setId(rs.getLong("idMateria"));
                materia.setNombre(rs.getString("Nombre_materia"));
                materia.setMateria_estado(rs.getBoolean("materia_estado"));
                materias.add(materia);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return materias;
    }

    public boolean actualizarMateria(Materia materia) {
        try {
            con = DATA_BASE_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[2]);
            pstm.setString(1, materia.getNombre());
            pstm.setLong(2, materia.getId());
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public Materia findMateriaById(Long id) {
        Materia found = null;
        try {
            con = DATA_BASE_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[3]);
            pstm.setLong(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                found = new Materia();
                found.setId(rs.getLong("idMateria"));
                found.setNombre(rs.getString("Nombre_materia"));
                found.setMateria_estado(rs.getBoolean("materia_estado"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return found;
    }

    public boolean cambiarEstadoMateria(long id) {
        Materia found = findMateriaById(id);
        if (found != null) {
            try {
                con = DATA_BASE_CONNECTION.getConnection();
                boolean nuevoEstado = !found.isMateria_estado(); // Alternar el estado actual

                pstm = con.prepareStatement(QUERIES[4]);
                pstm.setBoolean(1, nuevoEstado);
                pstm.setLong(2, id);
                int result = pstm.executeUpdate();

                return result > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            } finally {
                closeConnection();
            }
        }
        return false;
    }

    private void closeConnection() {
        try {
            if (con != null) {
                con.close();
            }
            if (pstm != null) {
                pstm.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<Asesoria> mostrarMateriaAsesorias(String nombreMateria) {
        List<Asesoria> asesorias = new ArrayList<>();
        String sql = "{CALL mostrarMateriaAsesorias(?)}";

        try (Connection con = DATA_BASE_CONNECTION.getConnection();
             CallableStatement stmt = con.prepareCall(sql)) {

            stmt.setString(1, nombreMateria);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Asesoria asesoria = new Asesoria();
                    asesoria.setDocenteNombre(rs.getString("Nombre"));
                    asesoria.setDocenteApellido(rs.getString("Apellido"));
                    asesoria.setTitulo(rs.getString("Titulo"));
                    asesoria.setFecha(rs.getDate("Fecha"));
                    asesoria.setHora(rs.getTime("Hora"));
                    asesorias.add(asesoria);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return asesorias;
    }
}
