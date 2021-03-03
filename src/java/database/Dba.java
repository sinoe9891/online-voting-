package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class Dba {
    private String base_datos;
    private Connection dbcon;
    public Statement query;
    
    public Dba(String base_datos){
        this.base_datos=base_datos;
    }

    public void setBase_datos(String base_datos) {
        this.base_datos = base_datos;
    }        
    
   public void conectar(){
        try {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            String driver = "jdbc:ucanaccess://";
            dbcon = DriverManager.getConnection(driver+base_datos,"","");             
            query = dbcon.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   
   public void desconectar() {
        try {
            query.close();
            dbcon.close();
        } catch (Exception e) {
        }
    }
   
   public void commit(){
       try{
           dbcon.commit();
       }catch(Exception e){
           e.printStackTrace();
       }
   }
    
    
}
