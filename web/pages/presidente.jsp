<%if (session.getAttribute("s_user") == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>
<%@page import="database.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

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
                                        <div style="width: 50%;">
                                            <h3>Candidatos Presidenciales</h3>
                                        </div>
                                        <div style="text-align:right;width: 50%;">
                                            <a href="edit-presidentes.jsp"><button class="btn add-new btn-primary mt-100" type="button"><span>Gestionar</span></button></a>
                                        <!--<button class="btn add-new btn-info mt-100" type="button"><span>Editar</span></button>
                                            <button class="btn add-new btn-warning mt-100" type="button"><span>Modificar</span></button>
                                            <button class="btn add-new btn-danger mt-100" type="button"><span>Eliminar</span></button>-->
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="responsive">
                                        <%
                                            try {
                                                Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                db.conectar();
                                                db.query.execute("select nombre_presidente, photo_profile, src_url_logo_movimiento, genero_presidente from presidente");
                                                ResultSet rs = db.query.getResultSet();
                                                String centinela = "n";
                                                                                while (rs.next()) {%>
                                        <div class="card-content">
                                            <div class="img-logo">
                                                <img src="<%=rs.getString(2)%>" alt="<%=rs.getString(2)%>">
                                            </div>
                                            <div class="nombre-partido">
                                                <h4><%=rs.getString(1)%></h4>
                                            </div>
                                        </div>
                                        <%
                                                }
                                                db.desconectar();
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        %>                
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
