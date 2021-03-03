<%@page import="database.*"%>
<html>
    <head>       
        <title>JSP Page</title>
    </head>
    <body>

<%
if ( request.getParameter("bt_crear") !=null ) {
                  try {
                    Dba db = new Dba(application.getRealPath("")+"daw.mdb");
                    db.conectar();                                         
                    int contador=db.query.executeUpdate("insert into usuarios"
                                        + "(cuenta,nombres,apellidos,usuario,password) "
                                        + "values('"+request.getParameter("ti_cuenta")+"'"
                                        + ",'"+request.getParameter("ti_nombre")+"'"
                                        + ",'"+request.getParameter("ti_apellidos")+"'"
                                        + ",'"+request.getParameter("ti_usuario")+"'"
                                        + ",'"+request.getParameter("ti_password")+"')");

                    if(contador==1){
                        out.print("<script>alert('el usuario se creo correctamente');</script>");
                    }
                    db.commit();
                    db.desconectar();
                } catch (Exception e) {
                    e.printStackTrace();
                }    
}
%>
<br>
        <br>
        <a href="principal.jsp">Regresar...........................</a>
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
