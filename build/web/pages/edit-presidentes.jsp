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
    </head>  

    <script>
        function mod(pid, pnp, pd, pep, pp, pe, pfv) {
            var modal2 = document.getElementById("myModal");
            document.getElementById("idh1").value = pid;
            document.getElementById("ids1").value = pnp;
            document.getElementById("ids2").value = pd;
        }

    </script>

    <body>
        <div class="main-sidebar">
            <div class="container-login">

                <div class="sidebar-main">
                    <div class="img-log">
                        <img class="logo-plat-sidebar" src="../src/img/Votem_Logo_Primary_Navy.png" alt="">
                        <img class="logo-sidebar" src="../src/img/logo-ceutec.png" alt="">
                    </div>
                    <nav>
                        <ul class="navigation navigation-main">
                            <li class="nav-item"><a href="partidos-politicos.jsp"><i class="far fa-flag"></i>Partidos Políticos</li></a>
                            <li class="nav-item"><a href="presidente.jsp"><i class="fas fa-user"></i>Presidente</li></a>
                            <li class="nav-item"><a href="#"><i class="fas fa-user-friends"></i>Alcaldes</li></a>
                            <li class="nav-item"><a href="#"><i class="fas fa-users"></i>Diputados</li></a>
                            <li class="nav-item"><a href="#"><i class="fas fa-person-booth"></i>Votantes</li></a>
                            <li class="nav-item"><a href="usuarios.jsp"><i class="fas fa-user-cog"></i>Usuarios</li></a>
                            <li class="nav-item header-item">TÍTULO</li>
                            <li class="nav-item"><a href="#"><i class="fas fa-poll"></i>Métricas</li></a>
                        </ul>
                    </nav>
                </div>
                <div class="main-body-page"> 
                    <div class="content-wrapper">
                        <div class="content-body">
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="nav-header">
                                        <div style="width: 100%;">
                                            <h3>Gestionar</h3>
                                            <div style="display: flex;justify-content: space-between;">
                                                <a href="presidente.jsp"><i class="fas fa-arrow-left"></i>Regresar</a>
                                                <a href="../index.jsp"><i class="fas fa-sign-out-alt"></i>Cerrar Sesión</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section class="app-user-list">
                                <div class="card">
                                    <%
                                        if (request.getParameter("bt_crear") != null) {
                                            try {
                                                Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                db.conectar();

                                                String nombre_partido = request.getParameter("nombre_partido");
                                                String url_logo_partido = request.getParameter("url_logo_partido");

                                                int contador = db.query.executeUpdate("INSERT into partidos_politicos"
                                                        + "(nombre,src_url_logo) "
                                                        + "VALUES('"
                                                        + nombre_partido + "'"
                                                        + ",'" + url_logo_partido
                                                        + "')");

                                                db.commit();
                                                db.desconectar();
                                                if (contador == 1) {
                                                    String alerta = "<div class='alert alert-success' role='alert'><h4 class='alert-heading'>Partido Político Se agregó con éxito</h4></div>";
                                                    out.print(alerta);
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        }
                                    %>

                                    <section class="app-user-list">
                                        <div class="card">

                                            <div class="nav-header">
                                                <div style="text-align:left;width: 100%;">
                                                    <form name="f1" action="edit-presidentes.jsp" method="POST">
                                                        <div class="modal-body flex-grow-1">
                                                            <div class="form-group">
                                                                <label class="form-label" for="name-partido">Nombre del Partido Político</label>
                                                                <input type="text" name="nombre_partido" class="form-control dt-full-name" id="basic-icon-default-fullname" placeholder="Partido Político" >
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="form-label" for="enlace-url">Enlace de la imagen</label>
                                                                <input type="text" name="url_logo_partido"  id="basic-icon-default-uname" class="form-control dt-uname" placeholder=".jpg, .png" >
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="form-label" for="basic-icon-default-uname">Cargar Logo</label>
                                                                <input type="file" id="logo" class="form-control dt-uname" placeholder="Web Developer" name="user-name">
                                                            </div>
                                                            <button type="submit" class="btn btn-primary mr-1 data-submit waves-effect waves-float waves-light" value="crear" name="bt_crear">Crear</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </section>

                                    <%
                                        if (request.getParameter("p_eliminar") != null) {
                                            //ELIMINAR PRODUCTO 
                                            try {
                                                Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                db.conectar();
                                                int contador = db.query.executeUpdate("delete from partidos_politicos WHERE id='" + request.getParameter("p_id") + "' ");
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
                                        //MODIFICAR un producto   
                                        if (request.getParameter("bt_modificar") != null) {
                                            try {
                                                Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                db.conectar();
                                                int contador = db.query.executeUpdate("UPDATE presidente "
                                                        + "SET nombre_presidente='" + request.getParameter("ti_nombre_presidente") + "',   "
                                                        + "photo_profile='" + request.getParameter("ti_url_photo") + "'"
                                                        + "WHERE id_presidente='" + request.getParameter("ti_id") + "' ");
                                                if (contador >= 1) {
                                                    out.print("<script>alert('el usuario fue modificado correctamente');</script>");
                                                }
                                                db.commit();
                                                db.desconectar();
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        }
                                    %>

                                    <section class="app-user-list">
                                        <div class="card">
                                            <div class="card-datatable table-responsive pt-0">

                                                <table class="user-list-table ">
                                                    <thead class="thead-light">
                                                        <tr>

                                                            <th data-field="id">ID</th>
                                                            <th data-field="nombre" data-editable="false">NOMBRE</th>
                                                            <th data-field="descripcion" data-editable="false">NOMBRE</th>
                                                            <th data-field="operaciones" data-editable="false">GENERO</th>
                                                            <th data-field="operaciones" data-editable="false">ACCIONES</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>

                                                        <% Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                            db.conectar();
                                                            db.query.execute("SELECT id_presidente, nombre_presidente, photo_profile, src_url_logo_movimiento, genero_presidente from presidente ORDER BY id_presidente ASC");
                                                            ResultSet rs = db.query.getResultSet(); 
                                                            String id_presidente, nombre, photo, url_logo, genero ;
                                                            while (rs.next()) {

                                                                id_presidente = rs.getString(1);
                                                                nombre = rs.getString(2);
                                                                photo = rs.getString(3);
                                                                url_logo = rs.getString(4);
                                                                genero = rs.getString(5);
                                                        %>
                                                        <tr role="row" class="odd">
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=id_presidente%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="img-logo-gestionar-partido">
                                                                    <img src="<%=photo%>" alt="<%=photo%>">
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=nombre%>
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
                                                                        <a class="dropdown-item"  data-toggle="modal" data-target="#inlineForm" onclick="mod('<%=id_presidente%>', '<%=nombre%>', '<%=photo%>')">
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