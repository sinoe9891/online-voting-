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
        <!--<script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=true"></script>-->
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAY7Ys2hwRXTru00HE2Dxn6BEGU7t6s2_A&callback=initMap"></script>
        <script type="text/javascript">

            function mostrar_mapa(centinela) {

                //UbicaciÃ³n inicial del mapa.
                var ubicacion = new google.maps.LatLng(<%= request.getParameter("p_nombres")%>,<%= request.getParameter("p_apellidos")%>); //Latitud y Longitud

                console.log(ubicacion.lat());
                if (ubicacion.lat() == 0 && ubicacion.lng() == 0) {
                    document.getElementById("id_mapa_ver").style.display = "none";
                } else {
                    document.getElementById("id_mapa_ver").style.display = "initial";
                }


                //ParÃ¡metros Iniciales
                var opciones = {zoom: <%= request.getParameter("zoom_m")%>, //acercamiento
                    center: ubicacion,
                    mapTypeId: google.maps.MapTypeId.SATELLITE, //Las posibles opciones son ROADMAP/SATELLITE/HYBRID/TERRA
                    disableDefaultUI: true,
                    disableDoubleClickZoom: true,
                    draggable: false
                };

                //Creacion del mapa
                var map = new google.maps.Map(document.getElementById("mapa"), opciones);

                //recuperar ubicacion donde hago click
                var iw = new google.maps.InfoWindow(
                        {content: '<%= request.getParameter("p_centro")%>',
                            position: ubicacion});
                iw.open(map);
                // configurar evento click sobre el mapa
//                map.addListener('click', function (mapsMouseEvent) {
//                    iw.close();
//                    iw = new google.maps.InfoWindow({position: mapsMouseEvent.latLng});
//                    iw.setContent(mapsMouseEvent.latLng.toString());
//                    iw.open(map);
//                });


                if (centinela == 1) {
                    //Colocar una marca sobre el Mapa
                    mi_ubicacion = new google.maps.Marker({
                        position: new google.maps.LatLng(14.104173, -87.186145), //PosiciÃ³n de la marca
                        icon: 'persona.jpg', //Imagen que aparecerÃ¡ en la marca, debe estar en el server
                        map: map, //Mapa donde estarÃ¡ la marca
                        title: 'Danny Velásquez' //TÃ­tulo all hacer un mouseover
                    });

                    //Mostrar InformaciÃ³n al hacer click en la marca
                    var infowindow = new google.maps.InfoWindow({
                        content: 'Elaborado Por: Danny Velásquez Cadenas<br/>'
                    });

                    google.maps.event.addListener(mi_ubicacion, 'click', function () {
                        //Calling the open method of the InfoWindow
                        infowindow.open(map, mi_ubicacion);
                    });
                }
            }



        </script>
        <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">-->
        <!--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.10.20/datatables.min.css"/>-->


        <style>
            .mesas a{
                color:#c3151c;
            }
        </style>
    </head>   
    <body>
        <div class="main-sidebar">
            <div class="container-login">
                <%@include file="sidebar-votante.jsp" %>
                <div class="main-body-page"> 
                    <div class="content-wrapper">
                        <div class="content-body">
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="nav-header">
                                        <div style="width: 50%;">
                                            <h3>Mesas Electorales</h3>
                                        </div>
                                        <div style="text-align:right;width: 50%;">
                                            <a href="mesas-electorales-edit.jsp"><button class="btn add-new btn-primary mt-100" type="button"><span>Gestionar</span></button></a>
                                            <!--<button class="btn add-new btn-info mt-100" type="button"><span>Editar</span></button>
                                                <button class="btn add-new btn-warning mt-100" type="button"><span>Modificar</span></button>
                                                <button class="btn add-new btn-danger mt-100" type="button"><span>Eliminar</span></button>-->
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section class="app-user-list" id="id_mapa_ver">
                                <div class="card">
                                    <div class="nav-header">
                                        <div>
                                            <center>
                                                <body onload="mostrar_mapa(0)" >
                                                    <br>
                                                    <br>
                                                    <h4>Ubicación de Sector Domicilio</h4>
                                                    <br>
                                                    <br>
                                                    <div id="mapa" style="width: 650px; height: 400px;"></div>
                                                </body>
                                            </center>
                                        </div>
                                        <div>
                                            <%
                                                //paso #2 si preciono el link 
                                                if (request.getParameter("ver_mapa") != null) {
                                            %>
                                            <br>
                                            <hr>
                                            <form name="f1" action="modificar.jsp" method="POST">                   
                                                <input type="text" name="ti_cuenta" value="<%= request.getParameter("p_cuenta")%>" readonly="readonly"  />  
                                                Nombre
                                                <input type="text" name="ti_nombre" value="<%= request.getParameter("p_nombres")%>" />
                                                <input type="text" name="ti_nombre" value="<%= request.getParameter("p_apellidos")%>" />
                                                <input type="text" name="ti_nombre" value="<%= request.getParameter("p_centro")%>" />
                                                <input type="text" name="ti_nombre" value="<%= request.getParameter("zoom_m")%>" />

                                            </form>
                                        </div>

                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </section>
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="card-datatable table-responsive pt-0" style='padding: 1rem !important;'>
                                        <div class="card-header border-bottom">
                                            <h4 class="card-title">Mesas Electorales</h4>
                                        </div>
                                        <table class="user-list-table "  id="datatable">
                                            <thead class="thead-light">
                                                <tr class = "thead-dark">
                                                    <th data-field="nombre" data-editable="false">NÚMERO DE MESA</th>
                                                    <th data-field="operaciones" data-editable="false">CENTRO DE VOTACIÓN</th>
                                                    <th data-field="operaciones" data-editable="false">SECTOR DOMICILIO</th>
                                                    <th data-field="descripcion" data-editable="false">DEPARTAMENTO</th>
                                                    <th data-field="operaciones" data-editable="false">MUNICIPIO</th>
                                                    <th data-field="operaciones" data-editable="false">UBICACIÓN</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));

                                                    db.conectar();

                                                    db.query.execute(
                                                            "SELECT a.id_mesa, a.numero_mesa, a.centro_de_votacion, b.nombre_departamento, c.nombre_municipio, a.nombre_sector_domicilio, a.latitud, a.longitud "
                                                            + "FROM mesas_electorales a, departamentos b, municipios c "
                                                            + "WHERE a.id_departamento_mesa = b.id_departamento AND a.id_municipio_mesa = c.id_municipio ORDER BY a.centro_de_votacion DESC");
                                                    ResultSet rs = db.query.getResultSet();
                                                    String id_mesa, codigo_mesa, centro_de_votacion, nombre_departamento, nombre_municipio, nombre_sector_domicilio, latitud, longitud;

                                                    while (rs.next()) {

                                                        id_mesa = rs.getString(1);
                                                        codigo_mesa = rs.getString(2);
                                                        centro_de_votacion = rs.getString(3);
                                                        nombre_departamento = rs.getString(4);
                                                        nombre_municipio = rs.getString(5);
                                                        nombre_sector_domicilio = rs.getString(6);
                                                        latitud = rs.getString(7);
                                                        longitud = rs.getString(8);
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
                                                            <!--<a href="href="modificar.jsp?p_cuenta=<%=id_mesa%>&p_nombres=<%=longitud%>&p_apellidos=<%=codigo_mesa%>&p_editar=1"> Ver ubicación</a>-->
                                                            <a href="mesas-electorales.jsp?p_cuenta=<%=id_mesa%>&p_nombres=<%=latitud%>&p_apellidos=<%=longitud%>&p_centro=<%=centro_de_votacion%>&zoom_m=19&ver_mapa=1" onclick="mostrar_mapa(1)">Ver ubicación</a>
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
                    </div>
                </div>
            </div>
        </div>

        <script src="https://unpkg.com/jquery@3.3.1/dist/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.10.20/datatables.min.js"></script>
        <script>
                                                                $("#datatable").DataTable();
        </script>
        <!-- BEGIN: Vendor JS-->
        <script src="../src/app-assets/vendors/js/vendors.min.js"></script>
        <!-- BEGIN Vendor JS-->

        <!-- BEGIN: Page Vendor JS-->
        <script src="../src/app-assets/vendors/js/tables/datatable/jquery.dataTables.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/datatables.bootstrap4.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/dataTables.responsive.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/responsive.bootstrap4.js"></script>
        <!--<script src="../src/app-assets/vendors/js/pickers/flatpickr/flatpickr.min.js"></script>-->
        <script src="../src/app-assets/vendors/js/tables/datatable/datatables.buttons.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/buttons.bootstrap4.min.js"></script>
        <script src="../src/app-assets/vendors/js/forms/validation/jquery.validate.min.js"></script>
        <script src="../src/app-assets/js/scripts/tables/table-datatables-advanced.js"></script>
        <!-- END: Page Vendor JS-->
        <script>
                                                                $(window).on('load', function () {
                                                                    if (feather) {
                                                                        feather.replace({
                                                                            width: 14,
                                                                            height: 14
                                                                        });
                                                                    }
                                                                })
        </script> 
        <!-- BEGIN: Theme JS-->
        <script src="../src/app-assets/js/core/app-menu.js"></script>
        <script src="../src/app-assets/js/core/app.js"></script>
        <!-- END: Theme JS-->

        <!-- BEGIN: Page JS-->
        <script src="../src/app-assets/js/scripts/pages/app-user-list.js"></script>
        <!-- END: Page JS-->
    </body> 
</html>
