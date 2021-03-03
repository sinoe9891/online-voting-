<%@page import="java.sql.*"%> 
<%@page import="database.*"%>
<%
    try {
//      Conexión Apache  Dba db = new Dba(application.getRealPath("") + "daw.mdb");
        Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
        db.conectar();
        db.query.execute("select username, password from users");
        ResultSet rs = db.query.getResultSet();
        String centinela = "n";
        while (rs.next()) {
            if (request.getParameter("ti_usuario").equals(rs.getString(1))
                    && request.getParameter("ti_password").equals(rs.getString(2))) {
                centinela = "s";
            }
        }
        if (centinela.equals("s")) {
            //guardar variables de session
            session.setAttribute("s_user", request.getParameter("ti_usuario"));
            session.setAttribute("s_pass", request.getParameter("ti_password"));
            //llamar jsp correspondiete desde linea de comando
            request.getRequestDispatcher("principal.jsp").forward(request, response);
        } else {
            out.print("<script>alert('el usuario no existe')</script>");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
