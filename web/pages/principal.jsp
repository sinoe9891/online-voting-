<%
    if (session.getAttribute("s_user") == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>


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
            .metricas a{
                color:#c3151c;
            }
        </style>
    </head>

    <body>
        <div class="main-sidebar">
            <div class="container-login">
                <div class="sidebar-main">
                    <div class="img-log">
                        <img class="logo-plat-sidebar" src="../src/img/Votem_Logo_Primary_Navy.png" alt="">
                        <img class="logo-sidebar" src="../src/img/logo-ceutec.png" alt=""></a>
                    </div>
                    <nav>
                        <ul class="navigation navigation-main">
                            <li class="nav-item metricas"><a href="principal.jsp"><i class="fas fa-poll"></i>Métricas</li></a>
                            <li class="nav-item"><a href="votacion.jsp"><i class="fas fa-sign-out-alt"></i></i>votacion</li></a>
                            <li class="nav-item partidos"><a href="partidos-politicos.jsp"><i class="far fa-flag"></i>Partidos Políticos</li></a>
                            <li class="nav-item presidente"><a href="presidente.jsp"><i class="fas fa-user"></i>Presidente</li></a>
                            <li class="nav-item alcaldes"><a href="#"><i class="fas fa-user-friends"></i>Alcaldes</li></a>
                            <li class="nav-item diputados"><a href="#"><i class="fas fa-users"></i>Diputados</li></a>
                            <li class="nav-item mesas"><a href="mesas-electorales.jsp"><i class="fas fa-person-booth"></i>Mesas Electorales</li></a>
                            <li class="nav-item votantes"><a href="votantes.jsp"><i class="fas fa-users"></i>Votantes</li></a>
                            <li class="nav-item usuarios"><a href="usuarios.jsp"><i class="fas fa-user-cog"></i>Usuarios</li></a>
                            <li class="nav-item header-item">CONFIGURACIÓN</li>
                            <li class="nav-item"><a href="../logout.jsp"><i class="fas fa-sign-out-alt"></i></i>Cerrar Sesión</li></a>
                        </ul>
                    </nav>
                </div>
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
                                                <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i>Cerrar Sesión</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="responsive">
                                        <div class="card-content">

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