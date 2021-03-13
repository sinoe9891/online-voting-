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

        <script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=true"></script>
        
        <!-- BEGIN: Page CSS-->
        <!-- <link rel="stylesheet" type="text/css" href="../src/app-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="../src/app-assets/css/plugins/forms/form-validation.css">
    <link rel="stylesheet" type="text/css" href="../src/app-assets/css/pages/app-user.css"> -->
        <!-- END: Page CSS-->
        <style>
            .votantes a{
                color:#c3151c;
            }
        </style>
    </head>  

    <script>
            function mod(pid, pnp, pd, pep, log) {
                var modal2 = document.getElementById("myModal");
                document.getElementById("idh1").value = pid;
                document.getElementById("ids1").value = pnp;
                document.getElementById("ids2").value = pd;
                document.getElementById("ids3").value = pep;
                document.getElementById("ids3").value = log;
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
                                                <a href="mesas-electorales.jsp"><i class="fas fa-arrow-left"></i>Regresar</a>
                                                <a href="../index.jsp"><i class="fas fa-sign-out-alt"></i>Cerrar Sesión</a>
                                            </div>
                                            <h3>Mesas Electorales</h3>
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
                                                String centro_de_votacion = request.getParameter("centro_de_votacion");
                                                String latitud = request.getParameter("latitud");
                                                String nombredomicilio = request.getParameter("nombredomicilio");
                                                String longitud = request.getParameter("longitud");
                                                String id_departamento_mesa = request.getParameter("id_departamento_mesa");
                                                String id_municipio_mesa = request.getParameter("id_municipio_mesa");
                                                //db.query.executeUpdate("SET CHARACTER SET 'UTF8'");
                                                int contador = db.query.executeUpdate("INSERT into mesas_electorales"
                                                        + "(centro_de_votacion,nombre_sector_domicilio,latitud,longitud,id_departamento_mesa,id_municipio_mesa) "
                                                        + "VALUES('"
                                                        + centro_de_votacion + "'"
                                                        + ",'" + nombredomicilio + "'"
                                                        + ",'" + latitud + "'"
                                                        + ",'" + longitud + "'"
                                                        + ",'" + id_departamento_mesa + "'"
                                                        + ",'" + id_municipio_mesa
                                                        + "')");

                                                request.setCharacterEncoding("UTF-8");

                                                db.commit();
                                                db.desconectar();
                                                if (contador == 1) {
                                                    String alerta = "<div class='alert alert-success' role='alert'><h4 class='alert-heading'>Partido Político Se agregó con éxito</h4></div>";
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
                                                int contador = db.query.executeUpdate("delete from mesas_electorales WHERE id_mesa='" + request.getParameter("p_id") + "' ");
                                                db.commit();
                                                db.desconectar();
                                                if (contador >= 1) {
                                                    String alerta = "<div class='alert alert-success' role='alert'><h4 class='alert-heading'>Registro Eliminado</h4></div>";
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
                                                int contador = db.query.executeUpdate("UPDATE mesas_electorales "
                                                        + "SET centro_de_votacion='" + request.getParameter("ti_nombre_presidente") + "',   "
                                                        + "nombre_sector_domicilio='" + request.getParameter("ti_url_photo") + "',   "
                                                        + "latitud='" + request.getParameter("latitud_mesa") + "',   "
                                                        + "longitud='" + request.getParameter("longitud_mesa") + "'"
                                                        + "WHERE id_mesa='" + request.getParameter("ti_id") + "' ");
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
                                                    <form name="f1" action="mesas-electorales-edit.jsp" method="POST">
                                                        <h3>Agregar Mesa Electoral</h3>
                                                        <div class="modal-body flex-grow-1">
                                                            <div class="form-group">
                                                                <label class="form-label" for="name-presidente">Centro de Votación</label>
                                                                <input type="text" name="centro_de_votacion" class="form-control dt-full-name" id="basic-icon-default-fullname" placeholder="Nombre Centro de Votación" >
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="basicSelect">Departamentos</label>
                                                                <select class="form-control" id="basicSelect" name="id_departamento_mesa">
                                                                    <% Dba dbaept = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                                        dbaept.conectar();
                                                                        dbaept.query.execute("SELECT nombre_departamento, id_departamento from departamentos ORDER BY nombre_departamento ASC");
                                                                        ResultSet rsdept = dbaept.query.getResultSet();
                                                                        String nombre_departamento1;
                                                                        String id_departamento1;
                                                                        while (rsdept.next()) {

                                                                            nombre_departamento1 = rsdept.getString(1);
                                                                            id_departamento1 = rsdept.getString(2);
                                                                    %>
                                                                    <option value="<%=id_departamento1%>" name=''>
                                                                        <%=nombre_departamento1%>
                                                                    </option>
                                                                    <%  }%> 
                                                                </select>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="form-label" for="enlace-url">Municipio</label>
                                                                <select class="form-control" id="basicSelect" name="id_municipio_mesa">
                                                                    <% Dba dbamuni = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                                        dbamuni.conectar();
                                                                        dbamuni.query.execute("SELECT a.nombre_municipio, b.nombre_departamento, a.id_municipio, b.id_departamento FROM municipios a, departamentos b WHERE a.id_departamento = b.id_departamento ORDER BY a.nombre_municipio ASC");
                                                                        ResultSet rsmuni = dbamuni.query.getResultSet();
                                                                        String nombremunicipio, idmunicipio, iddepartamento, nombredepartamento;
                                                                        while (rsmuni.next()) {

                                                                            nombremunicipio = rsmuni.getString(1);
                                                                            nombredepartamento = rsmuni.getString(2);
                                                                            idmunicipio = rsmuni.getString(3);
                                                                            iddepartamento = rsmuni.getString(3);

                                                                    %>
                                                                    <option value="<%=idmunicipio%>" name=''>
                                                                        <%=nombremunicipio%>
                                                                    </option>
                                                                    <%  }%> 
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="form-label" for="enlace-url">SECTOR DOMICILIO</label>
                                                                <input type="text" name="nombredomicilio"  id="basic-icon-default-uname" class="form-control dt-uname" placeholder="Domicilio" >
                                                            </div>  
                                                            <div class="form-group">
                                                                <label class="form-label" for="enlace-url">Latitud</label>
                                                                <input type="text" name="latitud"  id="basic-icon-default-uname" class="form-control dt-uname" placeholder="Latitud" >
                                                            </div>  
                                                            <div class="form-group">
                                                                <label class="form-label" for="enlace-url">Longitud</label>
                                                                <input type="text" name="longitud"  id="basic-icon-default-uname" class="form-control dt-uname" placeholder="Longitud" >
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
                                                <h3>Mesas Electorales</h3>
                                                <table class="user-list-table ">
                                                    <thead class="thead-light">
                                                        <tr>

                                                            <!--<th data-field="id">ID</th>-->
                                                            <th data-field="nombre" data-editable="false">NÚMERO DE MESA</th>
                                                            <th data-field="operaciones" data-editable="false">CENTRO DE VOTACIÓN</th>
                                                            <th data-field="operaciones" data-editable="false">SECTOR DOMICILIO</th>
                                                            <th data-field="descripcion" data-editable="false">DEPARTAMENTO</th>
                                                            <th data-field="operaciones" data-editable="false">MUNICIPIO</th>
                                                            <th data-field="operaciones" data-editable="false">COORDENADAS</th>
                                                            <th data-field="operaciones" data-editable="false">ACCIONES</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>

                                                        <% Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                            db.conectar();
                                                            db.query.execute("SELECT a.id_mesa, a.numero_mesa, a.nombre_sector_domicilio, a.centro_de_votacion, b.nombre_departamento, c.nombre_municipio, a.latitud, a.longitud "
                                                                    + "FROM mesas_electorales a, departamentos b, municipios c "
                                                                    + "WHERE a.id_departamento_mesa = b.id_departamento AND a.id_municipio_mesa = c.id_municipio "
                                                                    + "ORDER BY a.id_mesa DESC");
                                                            ResultSet rs = db.query.getResultSet();
                                                            String id_mesa, codigo_mesa, nombre_sector_domicilio, centro_de_votacion, nombre_departamento, nombre_municipio, latitud_centro, longitud_centro;
                                                            while (rs.next()) {

                                                                id_mesa = rs.getString(1);
                                                                codigo_mesa = rs.getString(2);
                                                                nombre_sector_domicilio = rs.getString(3);
                                                                centro_de_votacion = rs.getString(4);
                                                                nombre_departamento = rs.getString(5);
                                                                nombre_municipio = rs.getString(6);
                                                                latitud_centro = rs.getString(7);
                                                                longitud_centro = rs.getString(8);
                                                        %>
                                                        <tr role="row" class="odd">
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=codigo_mesa%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=centro_de_votacion%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=nombre_sector_domicilio%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=nombre_departamento%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=nombre_municipio%>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex justify-content-left align-items-center">
                                                                    <%=latitud_centro%>,<%=longitud_centro%>
                                                                </div>
                                                            </td>
                                                            <td> 
                                                                <div class="dropdown">
                                                                    <button type="button" class="btn btn-sm text-white dropdown-toggle hide-arrow" data-toggle="dropdown">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-more-vertical" style="
                                                                             color: black;"><circle cx="12" cy="12" r="1"></circle><circle cx="12" cy="5" r="1"></circle><circle cx="12" cy="19" r="1"></circle></svg>
                                                                    </button>
                                                                    <div class="dropdown-menu">
                                                                        <a class="dropdown-item"  data-toggle="modal" data-target="#inlineForm" onclick="mod('<%=id_mesa%>', '<%=centro_de_votacion%>', '<%=nombre_sector_domicilio%>', '<%=latitud_centro%>', '<%=longitud_centro%>')">
                                                                            <i data-feather="edit-2" class="mr-50"></i>
                                                                            <span>Modificar</span>
                                                                        </a>
                                                                        <a class="dropdown-item" href="mesas-electorales-edit.jsp?p_id=<%=id_mesa%>&p_eliminar=1">
                                                                            <i data-feather="trash" class="mr-50"></i>
                                                                            <span>Eliminar</span>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>

                                                            </td>
                                                        </tr>

                                                    </tbody>
                                                    <%  }%>
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
                    <form name="fM1" action="mesas-electorales-edit.jsp" method="POST">

                        <input type="hidden" id="idh1" name="ti_id" value="" />

                        <div class="modal-body">
                            <label>Centro de Votación: </label>
                            <div class="form-group">
                                <input id="ids1" type="text" name="ti_nombre_presidente" value="" class="form-control"/>
                            </div>

                            <label>Nombre del Sector: </label>
                            <div class="form-group">
                                <input id="ids2" type="text" name="ti_url_photo" value="" class="form-control"/>
                            </div>

                            <label>Latitud </label>
                            <div class="form-group">
                                <input id="ids3" type="text" name="latitud_mesa" value="" class="form-control"/>
                            </div>

                            <label>Longitud </label>
                            <div class="form-group">
                                <input id="ids4" type="text" name="longitud_mesa" value="" class="form-control"/>
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
