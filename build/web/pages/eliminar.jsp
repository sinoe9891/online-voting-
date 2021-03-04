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
 if ( request.getParameter("p_editar")!=null ) {
    try {
        Dba db = new Dba(application.getRealPath("")+"daw.mdb");
        db.conectar(); 
        
        int contador=db.query.executeUpdate("delete from usuarios WHERE cuenta='"+ request.getParameter("p_cuenta")+"' ");

        if(contador>=1){
             out.print("<script>alert('el usuario fue Elimnado correctamente');</script>");
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
        <h1>Eliminar Usuario</h1>
         <p align="center"><b><font face="Arial" color="#FFFFFF" size="12">Eliminar Producto</font></b></p>
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
                        <td><a href="eliminar.jsp?p_cuenta=<%=v_cuenta%>&p_nombres=<%=v_nombres%>&p_apellidos=<%=v_apellidos%>&p_usuario=<%=v_usuario%>&p_password=<%=v_password%>&p_editar=1">eliminar</a></td>
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

         
         
         

    </body>
</html>


