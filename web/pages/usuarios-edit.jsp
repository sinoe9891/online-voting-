<%if (session.getAttribute("s_user") == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>
<%@page import="database.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/normalize.css">
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/sidebar.css">
        <link rel="stylesheet" href="../css/all.css">
        <link rel="stylesheet" href="../src/app-assets/css/bootstrap.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/pages/app-user.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/components.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;700&display=swap" rel="stylesheet">
        <title>Votación Online</title>
        <link rel="shortcut icon" href="../src/img/unitec.ico" type="image/x-icon">
        <!-- BEGIN: Vendor CSS-->
        <link rel="stylesheet" type="text/css" href="../src/app-assets/vendors/css/vendors.min.css">
        <link rel="stylesheet" type="text/css"
              href="../src/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css"
              href="../src/app-assets/vendors/css/tables/datatable/responsive.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css"
              href="../src/app-assets/vendors/css/tables/datatable/buttons.bootstrap4.min.css">
        <!-- END: Vendor CSS-->

        <!-- BEGIN: Theme CSS-->
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/bootstrap-extended.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/colors.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/components.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/themes/dark-layout.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/themes/bordered-layout.css">

        <!-- BEGIN: Page CSS-->
        <!-- <link rel="stylesheet" type="text/css" href="../src/app-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="../src/app-assets/css/plugins/forms/form-validation.css">
    <link rel="stylesheet" type="text/css" href="../src/app-assets/css/pages/app-user.css"> -->
        <!-- END: Page CSS-->
        <style>
            .usuarios a{
                color:#c3151c;
            }
        </style>
    </head>  

    <script>
        function mod(pid, pnp, pd, pep) {
            var modal2 = document.getElementById("myModal");
            document.getElementById("idh1").value = pid;
            document.getElementById("ids1").value = pnp;
            document.getElementById("ids2").value = pd;
            document.getElementById("ids3").value = pep;
        }

    </script>

    <body>
        <div class="main-sidebar">
            <div class="container-login">
                <%@include file="sidebar.jsp" %>
                <div class="main-body-page"> 
                    <div class="content-wrapper">
                        <div class="content-body">
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="nav-header">
                                        <div style="width: 100%;">
                                            <div style="display: flex;justify-content: space-between;margin:5px 0 15px 0">
                                                <a href="usuarios.jsp"><i class="fas fa-arrow-left"></i>Regresar</a>
                                                <a href="../logout.jsp"><i class="fas fa-sign-out-alt"></i>Cerrar Sesión</a>
                                            </div>
                                            <h3>Gestionar USUARIOS</h3>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section class="app-user-list">
                                <div class="card">
                                    <%
                                        //AGREGAR REGISTRO-----------------------------------------------
                                        if (request.getParameter("bt_crear") != null) {
                                            try {
                                                Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                db.conectar();

                                                String nombre_presidente = request.getParameter("nombre_presidente");
                                                String url_logo_partido = request.getParameter("url_photo_oficial");
                                                String genero_president = request.getParameter("genero_presi");
                                                String id_parti_president = request.getParameter("partido_presi");
                                                String nombre_movimiento = request.getParameter("nombre_movimiento");

                                                int contador = db.query.executeUpdate("INSERT into presidente"
                                                        + "(nombre_presidente,photo_profile,genero_presidente,nombre_movimiento_partido,id_parti_presidente) "
                                                        + "VALUES('"
                                                        + nombre_presidente + "'"
                                                        + ",'" + url_logo_partido + "'"
                                                        + ",'" + genero_president + "'"
                                                        + ",'" + nombre_movimiento + "'"
                                                        + ",'" + id_parti_president
                                                        + "')");

                                                db.commit();
                                                db.desconectar();
                                                if (contador == 1) {
                                                    String alerta = "<div class='alert alert-success' role='alert'><h4 class='alert-heading'>Partido Político Se agregó con éxito</h4></div>";
                                                    out.print(alerta);
                                                }
                                            } catch (Exception e) {
                                                 String alerta = "<div class='alert alert-danger' role='alert'><h4 class='alert-heading'>Registro no se creó</h4></div>";
                                                out.print(alerta);
                                                e.printStackTrace();
                                            }
                                        }
                                    %>

                                    
                                    <%
                                        if (request.getParameter("p_eliminar") != null) {
                                            //ELIMINAR PRODUCTO----------------------------------------------- 
                                            try {
                                                Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                db.conectar();
                                                int contador = db.query.executeUpdate("delete from presidente WHERE id_presidente='" + request.getParameter("p_id") + "' ");
                                                db.commit();
                                                db.desconectar();
                                                if (contador >= 1) {
                                                    String alerta = "<div class='alert alert-success' role='alert'><h4 class='alert-heading'>Registro Eliminado</h4></div>";
                                                    out.print(alerta);
                                                }
                                            } catch (Exception e) {
                                                String alerta = "<div class='alert alert-danger' role='alert'><h4 class='alert-heading'>Registro Eliminado</h4></div>";
                                                out.print(alerta);
                                                e.printStackTrace();
                                            }
                                        }
                                    %>

                                    
                                    <%
                                        //MODIFICAR un producto-----------------------------------------------   
                                        if (request.getParameter("bt_modificar") != null) {
                                            try {
                                                Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                db.conectar();
                                                int contador = db.query.executeUpdate("UPDATE presidente "
                                                        + "SET nombre_presidente='" + request.getParameter("ti_nombre_presidente") + "',   "
                                                        + "photo_profile='" + request.getParameter("ti_url_photo") + "',   "
                                                        + "genero_presidente='" + request.getParameter("genero_presidente") + "'"
                                                        + "WHERE id_presidente='" + request.getParameter("ti_id") + "' ");
                                                if (contador >= 1) {
                                                    String alerta = "<div class='alert alert-success' role='alert'><h4 class='alert-heading'>El registro se modificó correctamente</h4></div>";
                                                    out.print(alerta);
                                                }
                                                db.commit();
                                                db.desconectar();
                                            } catch (Exception e) {
                                                String alerta = "<div class='alert alert-danger' role='alert'><h4 class='alert-heading'>El registro no se modificó</h4></div>";
                                                out.print(alerta);
                                                e.printStackTrace();
                                            }
                                        }
                                    %>
                                    <section class="app-user-list">
                                        <div class="card">

                                            <div class="nav-header">
                                                <div style="text-align:left;width: 100%;">
                                                    <form name="f1" action="edit-presidentes.jsp" method="POST">
                                                        <h3>Agregar Candidato Presidencial</h3>
                                                        <div class="modal-body flex-grow-1">
                                                            <div class="form-group">
                                                                <label class="form-label" for="name-presidente">Nombre del Candidato</label>
                                                                <input type="text" name="nombre_presidente" class="form-control dt-full-name" id="basic-icon-default-fullname" placeholder="Nombre Completo" >
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="form-label" for="enlace-url">Fotografía Oficial</label>
                                                                <input type="text" name="url_photo_oficial"  id="basic-icon-default-uname" class="form-control dt-uname" placeholder=".jpg, .png" >
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="form-label" for="enlace-url">Género</label>
                                                                <select class="form-control" id="basicSelect" name="genero_presi">
                                                                    <option value="M">
                                                                        Masculina
                                                                    </option>
                                                                    <option value="F">
                                                                        Femenina
                                                                    </option>
                                                                </select>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="basicSelect">Partido Político</label>
                                                                <select class="form-control" id="basicSelect" name="partido_presi">
                                                                    <% Dba dba = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                                        dba.conectar();
                                                                        dba.query.execute("SELECT nombre, id from partidos_politicos ORDER BY id ASC");
                                                                        ResultSet rsdb = dba.query.getResultSet();
                                                                        String nombre_partido;
                                                                        String id_partido;
                                                                        while (rsdb.next()) {

                                                                            nombre_partido = rsdb.getString(1);
                                                                            id_partido = rsdb.getString(2);
                                                                    %>
                                                                    <option value="<%=id_partido%>">
                                                                        <%=nombre_partido%>
                                                                    </option>
                                                                    <%  }%> 
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="form-label" for="enlace-url">Nombre Movimiento</label>
                                                                <input type="text" name="nombre_movimiento"  id="basic-icon-default-uname" class="form-control dt-uname" placeholder="Nombre Movimiento" >
                                                            </div>  
                                                            <button type="submit" class="btn btn-primary mr-1 data-submit waves-effect waves-float waves-light" value="crear" name="bt_crear">Crear</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </section>

                                    <section class="app-user-list">
                                        <div class="card">
                                            <div class="card-datatable table-responsive pt-0">
                                                <h3>Lista de Presidentes</h3>
                                                <table class="user-list-table ">
                                                    <thead class="thead-light">
                                                        <tr>

                                                            <!--<th data-field="id">ID</th>-->
                                                            <th data-field="nombre" data-editable="false">FOTO</th>
                                                            <th data-field="descripcion" data-editable="false">NOMBRE</th>
                                                            <th data-field="operaciones" data-editable="false">PARTIDO</th>
                                                            <th data-field="operaciones" data-editable="false">NOMBRE MOVIMIENTO</th>
                                                            <th data-field="operaciones" data-editable="false">GENERO</th>
                                                            <th data-field="operaciones" data-editable="false">ACCIONES</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>

                                                        <% Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                            db.conectar();
                                                            db.query.execute("SELECT a.id_presidente, a.nombre_presidente, a.photo_profile, a.src_url_logo_movimiento, a.genero_presidente, a.id_parti_presidente, a.nombre_movimiento_partido, b.id, b.nombre, b.src_url_logo FROM presidente a, partidos_politicos b WHERE a.id_parti_presidente = b.id  ORDER BY a.id_presidente DESC");
                                                            ResultSet rs = db.query.getResultSet();
                                                            String id_presidente, nombre, photo, url_logo, genero, partido_politico, nombre_movimiento, src_url_logo;
                                                            while (rs.next()) {

                                                                id_presidente = rs.getString(1);
                                                                partido_politico = rs.getString(9);
                                                                nombre = rs.getString(2);
                                                                photo = rs.getString(3);
                                                                url_logo = rs.getString(4);
                                                                genero = rs.getString(5);
                                                                nombre_movimiento = rs.getString(7);
                                                                src_url_logo = rs.getString(10);
                                                        %>
                                                        <tr role="row" class="odd">
<!--                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=id_presidente%>
                                                                </div>
                                                            </td>-->
                                                            <td>
                                                                <div class="img-logo-gestionar-partido">
                                                                    <img src="<%=photo%>" alt="<%=photo%>" style="width: 60% !important;">
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=nombre%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=partido_politico%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                
                                                                    <%=nombre_movimiento%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=genero%>
                                                                </div>
                                                            </td>
                                                            <td> 
                                                                <div class="dropdown">
                                                                    <button type="button" class="btn btn-sm text-white dropdown-toggle hide-arrow" data-toggle="dropdown">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-more-vertical" style="
                                                                             color: black;"><circle cx="12" cy="12" r="1"></circle><circle cx="12" cy="5" r="1"></circle><circle cx="12" cy="19" r="1"></circle></svg>
                                                                    </button>
                                                                    <div class="dropdown-menu">
                                                                        <a class="dropdown-item"  data-toggle="modal" data-target="#inlineForm" onclick="mod('<%=id_presidente%>', '<%=nombre%>', '<%=photo%>', '<%=genero%>')">
                                                                            <i data-feather="edit-2" class="mr-50"></i>
                                                                            <span>Modificar</span>
                                                                        </a>
                                                                        <a class="dropdown-item" href="edit-presidentes.jsp?p_id=<%=id_presidente%>&p_eliminar=1">
                                                                            <i data-feather="trash" class="mr-50"></i>
                                                                            <span>Eliminar</span>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <%  }%>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Modal-->
        <div class="modal fade text-left" id="inlineForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
            <div d="myModal" class="modal-dialog modal-dialog-centered" role="document" i>
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel33">Modificar Partido Político</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form name="fM1" action="edit-presidentes.jsp" method="POST">
                        <input type="hidden" id="idh1" name="ti_id" value="" />
                        <div class="modal-body">
                            <label>Nombre Partido Político: </label>
                            <div class="form-group">
                                <input id="ids1" type="text" name="ti_nombre_presidente" value="" class="form-control"/>
                            </div>

                            <label>URL de Bandera: </label>
                            <div class="form-group">
                                <input id="ids2" type="text" name="ti_url_photo" value="" class="form-control"/>
                            </div>

                            <label>Género: </label>
                            <div class="form-group">
                                <input id="ids3" type="text" name="genero_presidente" value="" class="form-control"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Modificar Producto" name="bt_modificar" /><br>    
                            <!--<button type="button" name="bt_modificar" class="btn btn-primary" data-dismiss="modal">Actualizar</button>-->
                        </div>
                    </form>    
                </div>
            </div>
        </div>






        <!-- BEGIN: Vendor JS-->
        <script src="../src/app-assets/vendors/js/vendors.min.js"></script>
        <!-- BEGIN Vendor JS-->

        <!-- BEGIN: Page Vendor JS-->
        <script src="../src/app-assets/vendors/js/tables/datatable/jquery.dataTables.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/datatables.bootstrap4.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/dataTables.responsive.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/responsive.bootstrap4.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/datatables.buttons.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/buttons.bootstrap4.min.js"></script>
        <script src="../src/app-assets/vendors/js/forms/validation/jquery.validate.min.js"></script>
        <!-- END: Page Vendor JS-->

        <!-- BEGIN: Theme JS-->
        <script src="../src/app-assets/js/core/app-menu.js"></script>
        <script src="../src/app-assets/js/core/app.js"></script>
        <!-- END: Theme JS-->

        <!-- BEGIN: Page JS-->
        <script src="../src/app-assets/js/scripts/pages/app-user-list.js"></script>
        <!-- END: Page JS-->

    </body>

</html>