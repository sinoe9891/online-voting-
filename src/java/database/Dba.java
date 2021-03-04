package database;

import java.sql.*;

public class Dba {

    private String base_datos;
    private Connection dbcon;
    public Statement query;

    public Dba(String base_datos) {
        this.base_datos = base_datos;
    }

    public void setBase_datos(String base_datos) {
        this.base_datos = base_datos;
    }

    public void conectar() {
        try {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            String driver = "jdbc:ucanaccess://";
            dbcon = DriverManager.getConnection(driver + base_datos, "", "");
            query = dbcon.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int loguear(String usuario, String contras) {
        Connection conn;
        PreparedStatement pst;
        ResultSet rs;
        int cont = 0;
        int role = 0;
        String sql = "select role from users where username = " + usuario + " and password = " + contras;
        try {
            Class.forName(this.base_datos);
            conn = this.dbcon;
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                role = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return role;
    }

    public void desconectar() {
        try {
            query.close();
            dbcon.close();
        } catch (Exception e) {
        }
    }

    public void commit() {
        try {
            dbcon.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
