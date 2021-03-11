<%@page import="java.sql.*"%> 
<%@page import="database.*"%>
<%
    try {
//      Conexión Apache  Dba db = new Dba(application.getRealPath("") + "daw.mdb");
        Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
        db.conectar();
        db.query.execute("select username, password, role from users");
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
            
            out.print(request.getParameter("role"));
            if (request.getParameter("role").equals("1")) {
                 request.getRequestDispatcher("pages/principal.jsp").forward(request, response);
            }else if (request.getParameter("role").equals("5")) {
                 request.getRequestDispatcher("pages/votacion.jsp").forward(request, response);
            }else{
                out.print("<script>alert('el usuario no existe')</script>");
            }
            //llamar jsp correspondiete desde linea de comando

        } else {
            out.print("<script>alert('el usuario no existe')</script>");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
