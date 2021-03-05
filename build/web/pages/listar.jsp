<%if (session.getAttribute("s_user") == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>
<%@page import="database.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Desarrollo de Aplicaciones Web</title>
    </head>     
    <body>
        Clase: <%=request.getParameter("clase")%><br>
        Campus: <%=request.getParameter("campus")%>      
        <br>
        <br>
        <a href="nuevo.jsp">Regresar</a>
        <a href="../index.jsp">Cerrar Sesión</a>
        <br>

        <h4>LISTA DE USUARIOS</h4>         
        <table border="1px">
            <thead>
                <tr>
                    <th>NOMBRES</th>
                    <th>APELLIDOS</th>
                    <th>USUARIO</th>
                    <th>IDENTIDAD</th>
                </tr>
            </thead>
            <tbody>
                <%
                        try {
                            Dba db = new Dba(application.getRealPath("daw.mdb"));
                            db.conectar();
                            db.query.execute("select cuenta, nombres, apellidos,usuario from usuarios");                            
                            ResultSet rs = db.query.getResultSet();
                            String centinela = "n";
                            while (rs.next()) {%>
                               <tr> <td><%=rs.getString(1)%></td> <td><%=rs.getString(2)%></td>
                                       <td><%=rs.getString(3)%></td > <td><%=rs.getString(4)%></td > 
                               </tr>         
                            <%  
                            }                                      
                            db.desconectar();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>                
          
            </tbody>
        </table>      </body> </html>
