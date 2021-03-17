<%
    if (session.getAttribute("s_user") == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>
<%@page import="java.sql.*"%> 
<%@page import="database.*"%>

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
        <!--BEGIN: Vendor CSS-->
        <link rel="stylesheet" type="text/css" href="../src/app-assets/vendors/css/vendors.min.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/vendors/css/tables/datatable/responsive.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/vendors/css/tables/datatable/buttons.bootstrap4.min.css">
        <!--END: Vendor CSS-->

        <!--BEGIN: Theme CSS-->
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/bootstrap-extended.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/colors.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/components.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/themes/dark-layout.css">
        <link rel="stylesheet" type="text/css" href="../src/app-assets/css/themes/bordered-layout.css">

        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/export-data.js"></script>
        <style>
            .elector a{
                color:#c3151c;
            }
            #container {
                min-width: 310px;
                max-width: 800px;
                height: 400px;
                margin: 0 auto
            }

            .buttons {
                min-width: 310px;
                text-align: center;
                margin-bottom: 1.5rem;
                font-size: 0;
            }

            .buttons button {
                cursor: pointer;
                border: 1px solid silver;
                border-right-width: 0;
                background-color: #f8f8f8;
                font-size: 1rem;
                padding: 0.5rem;
                outline: none;
                transition-duration: 0.3s;
                margin: 0;
            }

            .buttons button:first-child {
                border-top-left-radius: 0.3em;
                border-bottom-left-radius: 0.3em;
            }

            .buttons button:last-child {
                border-top-right-radius: 0.3em;
                border-bottom-right-radius: 0.3em;
                border-right-width: 1px;
            }

            .buttons button:hover {
                color: white;
                background-color: rgb(158, 159, 163);
                outline: none;
            }

            .buttons button.active {
                background-color: #0051B4;
                color: white;
            }

        </style>
    </head>

    <body>
        <div class="main-sidebar">
            <div class="container-login">
                <%@include file="sidebar-magistrados.jsp" %>
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
                                    <div class="responsive">
                                        <%
                                            String photo = "";
                                            String nombre_presidente = "";
                                            String color = "";
                                            String url_perfil = "";
                                            try {
                                                Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
                                                db.conectar();
                                                db.query.execute("SELECT a.id_presidente, a.numero_votos, b.id_presidente, b.nombre_presidente, b.photo_profile, b.id_parti_presidente, c.id, c.nombre, c.src_url_logo, c.color "
                                                        + "FROM votos_presidentes a, presidente b, partidos_politicos c "
                                                        + "WHERE  a.id_presidente = b.id_presidente AND b.id_parti_presidente = c.id "
                                                        + "ORDER BY a.numero_votos DESC");
                                                ResultSet rs = db.query.getResultSet();

                                                while (rs.next()) {

                                                    photo = rs.getString(5);
                                                    color = rs.getString(10);
                                                    url_perfil += "     ['" + rs.getString(4) + "'     ,   " + rs.getString(2) + "    ,       '" + photo + "'      " +  "    ,       '" + color + "'      " +   "],";
                                                    nombre_presidente += rs.getString(4);

                                                    url_perfil = url_perfil.substring(0, url_perfil.length() - 1);
                                                    url_perfil = url_perfil + ",";
                                        %>

                                        <%
                                                }
                                                db.desconectar();
                                                //quitar la ultima coma de las cadenas

                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        %>  
                                    </div>
                                </div>
                            </section>
                            <section class="app-user-list">
                                <div class="card">
                                    <div class="card-body" style="display: flex;justify-content: center;text-align: center;">
                                        <div style="width: 100%;">
                                            <div class="buttons">
                                                <button id="2021" class="active">
                                                    2021
                                                </button>
                                            </div>
                                            <div id="container"></div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!--BEGIN: Vendor JS-->
        <script src="../src/app-assets/vendors/js/vendors.min.js"></script>

        <!--BEGIN: Page Vendor JS-->
        <script src="../src/app-assets/vendors/js/tables/datatable/jquery.dataTables.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/datatables.bootstrap4.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/dataTables.responsive.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/responsive.bootstrap4.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/datatables.buttons.min.js"></script>
        <script src="../src/app-assets/vendors/js/tables/datatable/buttons.bootstrap4.min.js"></script>
        <script src="../src/app-assets/vendors/js/forms/validation/jquery.validate.min.js"></script>
        <!--END: Page Vendor JS-->

        <!--BEGIN: Theme JS-->
        <script src="../src/app-assets/js/core/app-menu.js"></script>
        <script src="../src/app-assets/js/core/app.js"></script>
        <!--END: Theme JS-->

        <!--BEGIN: Page JS-->
        <script src="../src/app-assets/js/scripts/pages/app-user-list.js"></script>
        <!--END: Page JS-->
        <script>


            var data = {
                2021: [
                    <%=url_perfil%>
                ]
            };
            
            console.log(data);

            function getData(data) {
                return data.map(function (country, i) {
                    return {
                        name: country[0], 
                        y: country[1],
                        photo: country[2],
                        color: country[3]
                    };
                });
            }

            var chart = Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Resultado Elecciones Presidenciales'
                },
                subtitle: {
                    text: 'Escrutinio Final 2021'
                },
                plotOptions: {
                    series: {
                        grouping: false,
                        borderWidth: 0
                    }
                },
                legend: {
                    enabled: false
                },
                tooltip: {
                    shared: true,
                    headerFormat: '<span style="font-size: 15px">{point.point.name}</span><br/>',
                    pointFormat: '<span style="color:{point.color}">\u25CF</span> {series.name}: <b>{point.y} votos</b><br/>'
                },
                xAxis: {
                    type: 'category',
                    max: 4,
                    labels: {
                        useHTML: true,
                        animate: true,
                        formatter: function () {
                            var value = this.value,
                                    output;
                            

                            getData(data[2021]).forEach(function (country) {
                                if (country.name === value) {
                                    output = country.photo;
                            console.log(country);
                                }
                            });
//                            console.log(output);
                            return '<span><img src="' + output + '" style="width: 40px; height: 40px;"/><br></span>';
                        }
                    }
                },
                yAxis: [{
                        title: {
                            text: 'Porcentaje'
                        },
                        showFirstLabel: false
                    }],
                series: [{
                        name: '2021',
                        id: 'main',
                        dataSorting: {
                            enabled: true,
                            matchByName: true
                        },
                        dataLabels: [{
                                enabled: true,
                                inside: true,
                                style: {
                                    fontSize: '16px'
                                }
                            }],
                        data: getData(data[2021]).slice()
                    }],
                exporting: {
                    allowHTML: true
                }
            });

            


        </script>

    </body>

</html>