<%@page import="java.sql.SQLException"%>
<%@page import="database.*"%>
<html>
    <head>       
        <title>JSP Page</title>
    </head>
    <body>

<%
if ( request.getParameter("bt_crear") !=null ) {
                  try {
                    Dba db = new Dba(application.getRealPath("daw.mdb"));
//                    Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                    db.conectar();
                    String nombre = request.getParameter("ti_nombre");
                    String apellido = request.getParameter("ti_apellidos");
                    String usuario = request.getParameter("ti_usuario");
                    String contrasena  = request.getParameter("ti_password");
                    String query = ("INSERT into usuarios"
                                        + "(cuenta,nombres,apellidos,usuario,password) "
                                        + "VALUES('"+request.getParameter("ti_cuenta")+"'"
                                        + ",'"+ nombre +"'"
                                        + ",'"+ apellido +"'"
                                        + ",'"+ usuario +"'"
                                        + ",'"+ contrasena + "')");
                    
                    db.query.executeUpdate(query);
                    db.commit ();
                    db.desconectar();
                    out.println("Actualizado");
//                    if(contador==1){
//                        out.print("<script>alert('el usuario se creo correctamente');</script>");
//                    }
                     
                } catch (SQLException ex) {
                    ex.printStackTrace();
                    out.println("Inserting data failed!");
                }    
}
%>
<br>
        <br>
        <a href="listar.jsp">Regresar</a>
        <a href="index.jsp">Cerrar Sesión</a>
        <br>
        <h4>Nuevo Usuario</h4>
        <form name="f1" action="nuevo.jsp" method="POST">
                     Cuenta
                     <input type="text" name="ti_cuenta" value="" /><br> 
                     Nombre
                     <input type="text" name="ti_nombre" value="" /><br>
                     Apellidos
                     <input type="text" name="ti_apellidos" value="" /><br>
                     Usuario
                     <input type="text" name="ti_usuario" value="" /><br>
                     Password
                     <input type="text" name="ti_password" value="" /><br>
                    <input type="submit" value="crear" name="bt_crear" /><br>                      
        </form>
    </body>
</html>
