<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

<%-- paso 3 actualizar los nuevos datos en la base de datos--%>
<%
 if (request.getParameter("bt_modificar") != null) {
    try {
        Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
        db.conectar(); 
        
        int contador=db.query.executeUpdate("UPDATE usuarios "
                + "SET nombres='"+request.getParameter("ti_nombre")+"',   "
                + "apellidos='"+request.getParameter("ti_apellidos")+"',   "
                + "usuario='"+request.getParameter("ti_usuario")+"',       "
                + "password='"+request.getParameter("ti_password")+"'"
                + "WHERE cuenta='"+ request.getParameter("ti_cuenta")+"' ");

        if(contador>=1){
             out.print("<script>alert('el usuario fue modificado correctamente');</script>");
        }
        db.commit();
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
 }
%>
<%-- FIN paso 3--%>


<%-- paso #1 listar los usuarios--%>

<br>
        <br>
        <a href="principal.jsp">Regresar</a>
        <a href="principal.jsp">Cerrar Sesión</a>
        <br>


        <h1>Modificar Usuario</h1>
         <p align="center"><b><font face="Arial" color="#FFFFFF" size="12">Modificar Producto</font></b></p>
            <table>
                <thead>
                    <tr>
                        <th>Cuenta</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                                //listar los productos que existen en la base de datos
                try {
                    Dba db = new Dba(application.getRealPath("")+"daw.mdb");
                    db.conectar();
                    db.query.execute("SELECT cuenta,nombres,apellidos,usuario,password FROM usuarios");
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
                        String v_cuenta = rs.getString(1);
                        String v_nombres = rs.getString(2);
                        String v_apellidos = rs.getString(3);
                        String v_usuario = rs.getString(4);
                        String v_password = rs.getString(5);
                    %>
                    <tr>
                        <td><%=v_cuenta%></td>
                        <td><%=v_nombres%></td>
                        <td><%=v_apellidos%></td>
                        <td><a href="modificar.jsp?p_cuenta=<%=v_cuenta%>&p_nombres=<%=v_nombres%>&p_apellidos=<%=v_apellidos%>&p_usuario=<%=v_usuario%>&p_password=<%=v_password%>&p_editar=1">modificar</a></td>
                    </tr>
                    <%
                    }                   
                    db.desconectar();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                    %>
                </tbody>
            </table>
<%-- FIN paso #1--%>

 <%
//paso #2 si preciono el link para modificar
if( request.getParameter("p_editar")!=null  ){
    %>
    <br>
    <hr>
        <form name="f1" action="modificar.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Cuenta</td>                        
                        <td><input type="text" name="ti_cuenta" value="<%= request.getParameter("p_cuenta") %>" readonly="readonly"  />   </td>
                        <td>Nombre</td>
                        <td><input type="text" name="ti_nombre" value="<%= request.getParameter("p_nombres") %>" /></td>
                    </tr>
                    <tr>
                        <td>Apellidos</td>
                        <td><input type="text" name="ti_apellidos" value="<%= request.getParameter("p_apellidos") %>" /></td>
                        <td>Usuario</td>
                        <td><input type="text" name="ti_usuario" value="<%= request.getParameter("p_usuario") %>" /></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="text" name="ti_password" value="<%= request.getParameter("p_password") %>" /></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td> <input type="submit" value="modificar" name="bt_modificar" />   </td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </form>

<%
}
%>
    </body>
</html>


