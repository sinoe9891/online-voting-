<%@page import="database.*"%>
<html>
    <head>       
        <title>JSP Page</title>
    </head>
    <body>

        <%
            if (request.getParameter("bt_crear") != null) {
                try {
                    Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                    db.conectar();
                    db.query.execute("select nombre, apellidos, username, identidad from users");
                    db.conectar();
                    int contador = db.query.executeUpdate("insert into users"
                            + "(username, nombre, apellidos, identidad, email, password, role) "
                            + ",'" + request.getParameter("ti_usuario") + "'"
                            + ",'" + request.getParameter("ti_nombre") + "'"
                            + ",'" + request.getParameter("ti_apellidos") + "'"
                            + ",'" + request.getParameter("ti_identidad") + "'"
                            + ",'" + request.getParameter("ti_email") + "'"
                            + ",'" + request.getParameter("ti_password") + "'"
                            + ",'" + request.getParameter("ti_role") + "'"
                            // + "values('" + request.getParameter("ti_cuenta") + "'"
                            + ")");

                    if (contador == 1) {
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
        <a href="principal.jsp">Regresar</a>
        <a href="principal.jsp">Cerrar Sesión</a>
        <br>
        <h4>Nuevo Usuario</h4>
        <form name="f1" action="nuevo.jsp" method="POST">
            Nombres
            <input type="text" name="ti_nombre" value="" /><br> 
            Apellidos
            <input type="text" name="ti_apellidos" value="" /><br>
            Usuario
            <input type="text" name="ti_usuario" value="" /><br>
            identidad
            <input type="text" name="ti_identidad" value="" /><br>
            Email
            <input type="text" name="ti_email" value="" /><br>
            Password
            <input type="text" name="ti_password" value="" /><br>
            Role
            <input type="text" name="ti_role" value="" /><br>
            <input type="submit" value="crear" name="bt_crear" /><br>                      
        </form>
    </body>
</html>
