<%@page import="java.sql.*"%> 
<%@page import="database.*"%>
<%
    try {
//      Conexión Apache  Dba db = new Dba(application.getRealPath("") + "daw.mdb");
        Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
        db.conectar();
        db.query.execute("select nombre_votante, identidad, role from votantes");
        ResultSet rs = db.query.getResultSet();
        String centinela = "n";
        while (rs.next()) {
            if (request.getParameter("ti_usuario").equals(rs.getString(1))
                    && request.getParameter("ti_password").equals(rs.getString(2)) && request.getParameter("role").equals(rs.getString(3))) {
                centinela = "s";
            }
        }
        if (centinela.equals("s")) {
            //guardar variables de session
            session.setAttribute("s_user", request.getParameter("ti_usuario"));
            session.setAttribute("s_pass", request.getParameter("ti_password"));
            session.setAttribute("s_role", request.getParameter("role"));
            
//            request.getParameter("role").toString().equals(rs.getString(3));
            
            out.print(request.getParameter("role"));
            if (request.getParameter("role").equals("2")) {
                 request.getRequestDispatcher("elector.jsp").forward(request, response);
            }else{
                out.print("<script>alert('el usuario no existe')</script>");
            }
            //llamar jsp correspondiete desde linea de comando

        } else {
            out.print("<script>alert('el usuario no existe')</script>");
            request.getRequestDispatcher("elector_login.jsp").forward(request, response);
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
