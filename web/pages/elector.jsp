<%
    if (session.getAttribute("s_user") == null) {
        request.getRequestDispatcher("elector_login.jsp").forward(request, response);
    }
%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="database.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <link rel="stylesheet" type="text/css" href="../src/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/vendors/css/tables/datatable/responsive.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/vendors/css/tables/datatable/buttons.bootstrap4.min.css">
        <!-- END: Vendor CSS-->

        <!-- BEGIN: Theme CSS-->
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/bootstrap-extended.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/colors.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/components.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/themes/dark-layout.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/themes/bordered-layout.css">
        <style>
            .elector a{
                color:#c3151c;
            }
            li.list-group-item {
                text-align: left;
            }
        </style>
    </head>

    <body>
        <div class="main-sidebar">
            <div class="container-login">
                <%@include file="sidebar-mesas.jsp" %>
                <div class="main-body-page"> 
                    <div class="content-wrapper">
                        <div class="content-body">
                            <!-- users list start -->
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="nav-header">
                                        <div style="width: 100%;">
                                            <div style="display: flex;justify-content: space-between;margin:5px 0 15px 0">
                                                <h3>Bienvenidos al Sistema de Votación Online 👋</h3>
                                                <a href="../logout.jsp"><i class="fas fa-sign-out-alt"></i>Cerrar Sesión</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="col-md-12">
                                        <% Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                            db.conectar();
                                            db.query.execute("SELECT a.id_votante, a.identidad, a.nombre_votante, a.apellidos_votantes, a.sexo, a.fecha_nacimiento, a.estado, b.nombre_departamento, c.nombre_municipio, d.nombre_sector_domicilio, d.numero_mesa, d.linea, d.nombre_sector_domicilio, d.centro_de_votacion, d.latitud, d.longitud "
                                                    + "FROM votantes a, departamentos b, municipios c, mesas_electorales d WHERE  a.identidad "
                                                    + "LIKE '" + request.getParameter("identidad") + "' "
                                                    + "AND a.id_departamento_mesa = b.id_departamento AND a.id_municipio_mesa = c.id_municipio AND a.numero_mesa = d.id_mesa "
                                                    + "ORDER BY a.nombre_votante DESC");
                                            ResultSet rs = db.query.getResultSet();
                                            String id_votante, identidad, nombres, apellidos, sexo, estatus, departamento, municipio, colonia, numero_mesa, linea, habilitado, bloqueadoTab;
                                            Boolean estado;
                                            while (rs.next()) {

                                                id_votante = rs.getString(1);
                                                identidad = rs.getString(2);
                                                nombres = rs.getString(3);
                                                apellidos = rs.getString(4);
                                                sexo = rs.getString(5);

                                                String fecha_nacimiento2 = rs.getString(6);
                                                Date fechaNacimiento = new SimpleDateFormat("yyyy-MM-dd").parse(fecha_nacimiento2);
                                                String fecha_nacimiento = new SimpleDateFormat("dd/MM/yyyy").format(fechaNacimiento);

                                                estado = rs.getBoolean(7);
                                                departamento = rs.getString(8);
                                                municipio = rs.getString(9);
                                                colonia = rs.getString(10);
                                                numero_mesa = rs.getString(11);
                                                linea = rs.getString(12);

                                                if (estado) {
                                                    estatus = "Habilitado";
                                                    habilitado = "bg-gradient-success";
                                                    bloqueadoTab = "";

                                                } else {
                                                    estatus = "Inhabilitado";
                                                    habilitado = "bg-gradient-secondary";
                                                    bloqueadoTab = "disabled";
                                                }
                                        %>
                                        <div class="card text-center">
                                            <div class="card-header py-2">
                                                <ul class="nav nav-pills card-header-pills ml-0" id="pills-tab" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true"><i class="fas fa-info"></i>Información Lector</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link  <%=bloqueadoTab%>" id="pills-profile-tab" data-toggle="pill" href="#pills-presidente" role="tab" aria-controls="pills-profile" aria-selected="false"><i class="fas fa-user"></i>Presidentes</li></a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link  <%=bloqueadoTab%>" id="pills-profile-tab" data-toggle="pill" href="#pills-alcalde" role="tab" aria-controls="pills-profile" aria-selected="false"><i class="fas fa-user-friends"></i>Alcaldes</li></a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link  <%=bloqueadoTab%>" id="pills-profile-tab" data-toggle="pill" href="#pills-diputado" role="tab" aria-controls="pills-profile" aria-selected="false"><i class="fas fa-users"></i>Diputados</li></a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link <%=bloqueadoTab%>" href="elector_login.jsp" tabindex="-1" ><i class="fas fa-sign-out-alt"></i></i>Cerrar Sesión</li></a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="card-body">
                                                <div class="tab-content" id="pills-tabContent">
                                                    <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">   
                                                        <h4 class="card-title">Información</h4>

                                                        <div class="card-title" style="text-align: center;display: flex;justify-content: center;">
                                                            <div class="<%=habilitado%>" style="width: 300px;padding: 10px;border-radius: 10px;">
                                                                <%=estatus%>
                                                            </div>

                                                        </div>
                                                        <ul class="list-group list-group-flush">
                                                            <li class="list-group-item">NÚMERO DE IDENTIDAD: <strong> <%=identidad%> </strong></li>
                                                            <li class="list-group-item">NOMBRE APARECE EN CENSO: <strong> <%=nombres%> <%=apellidos%></strong></li>
                                                            <li class="list-group-item">SEXO: <strong><%=sexo%></strong></li>
                                                            <li class="list-group-item">FECHA DE NACIMIENTO: <strong><%=fecha_nacimiento%></strong></li>
                                                            <li class="list-group-item">DEPARTAMENTO Y MUNICIPIO DE DOMICILIO: <strong><%=municipio%>, <%=departamento%></strong></li>
                                                            <li class="list-group-item">NOMBRE DEL SECTOR DOMICILIO: <strong><%=colonia%></strong></li>
                                                            <li class="list-group-item">MESA:<strong> <%=numero_mesa%></strong></li>
                                                            <li class="list-group-item">LÍNEA:<strong> <%=linea%></strong></li>
                                                        </ul>
                                                        <%  }%>
                                                    </div>



                                                    <div class="tab-pane fade" id="pills-presidente" role="tabpanel" aria-labelledby="pills-profile-tab">
                                                        <h4 class="card-title">Presidentes</h4>
                                                    </div>
                                                    <div class="tab-pane fade" id="pills-alcalde" role="tabpanel" aria-labelledby="pills-profile-tab">
                                                        <h4 class="card-title">Alcaldes</h4>
                                                        <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                                    </div>
                                                    <div class="tab-pane fade" id="pills-diputado" role="tabpanel" aria-labelledby="pills-profile-tab">
                                                        <h4 class="card-title">Diputados</h4>
                                                        <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>

                        </div>
                    </div>
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
        <!-- BEGIN: Vendor JS-->
        <script src="../src/app-assets/vendors/js/vendors.min.js"></script>
        <!-- BEGIN Vendor JS-->

        <!-- BEGIN: Page Vendor JS-->
        <!-- END: Page Vendor JS-->

        <!-- BEGIN: Theme JS-->
        <script src="../src/app-assets/js/core/app-menu.js"></script>
        <script src="../src/app-assets/js/core/app.js"></script>
        <!-- END: Theme JS-->
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