package mx.edu.utez.sgaa.database;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLOutput;

public class DatabaseConnection {
   public Connection getConnection(){
       Connection con = null;
       try{
           Class.forName("com.mysql.cj.jdbc.Driver");
           con = DriverManager.getConnection(
                   "jdbc:mysql://localhost:3306/estudiante",
                    "root",
                    "root");
           System.out.println("Conexion exitosa");
       }catch (Exception e){
           e.printStackTrace();
       }
       return con;
   }

   public static void main (String[] args){
       DatabaseConnection dbcon = new DatabaseConnection();
       dbcon.getConnection();
   }
}


