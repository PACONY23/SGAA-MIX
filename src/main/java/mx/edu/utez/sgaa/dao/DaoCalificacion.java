package mx.edu.utez.sgaa.dao;

import mx.edu.utez.sgaa.database.DatabaseConnection;
import mx.edu.utez.sgaa.model.Calificacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DaoCalificacion {
    private DatabaseConnection DB_CONNECTION = new DatabaseConnection();
    private Connection con;
    private PreparedStatement pstm;
    private ResultSet rs;
    private String [] QUERIES = {
            "UPDATE Historial_asesorias SET calificacionEstudiante=? WHERE id_asesoria=? AND id_estudiante=?;",
            "UPDATE Historial_asesorias SET calificacionDocente=? WHERE id_asesoria=? AND id_docente=?;"
    };

    public boolean agregarCalificacion(long id, int calificacion, int estudiante){
        try{
            con = DB_CONNECTION.getConnection();
            pstm= con.prepareStatement(QUERIES[0]);
            pstm.setLong(1, calificacion);
            pstm.setLong(2, id);
            pstm.setLong(3,estudiante);
            return pstm.executeUpdate()==1;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public boolean agregarCalificacionD(long id, int calificacion, int docente){
        try{
            con = DB_CONNECTION.getConnection();
            pstm= con.prepareStatement(QUERIES[1]);
            pstm.setLong(1, calificacion);
            pstm.setLong(2, id);
            pstm.setLong(3,docente);
            return pstm.executeUpdate()==1;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }


    public static void main(String[] args) {
        DaoCalificacion dao = new DaoCalificacion();
        dao.agregarCalificacion(0, 3,3);
    }
}
