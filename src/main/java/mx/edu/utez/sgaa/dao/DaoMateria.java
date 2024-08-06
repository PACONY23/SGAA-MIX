package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.database.DatabaseConnection;
import mx.edu.utez.sgaa.model.Materia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoMateria {
    private Connection con;
    private PreparedStatement pstm;
    private ResultSet rs;
    private final DatabaseConnection DATA_BASE_CONNECTION = new DatabaseConnection();
    private final String[] QUERIES = {
            "INSERT INTO Materias (Nombre_materia) VALUES (?);",
            "DELETE FROM Materias WHERE idMateria = ?;",
            "UPDATE Materias SET Nombre_materia=? WHERE idMateria=?;",
            "SELECT * FROM Materias WHERE idMateria=?;",
            "UPDATE MATERIAS SET materia_estado = ? WHERE idMateria = ?"
    };

    public boolean agregarMateria(Materia nombre) {
        try {
            con = DATA_BASE_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            pstm.setString(1, nombre.getNombre());
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public boolean eliminarMateria(long id) {
        try {
            con = DATA_BASE_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[1]);
            pstm.setLong(1, id);
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public List<Materia> getAllMaterias() {
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
}
