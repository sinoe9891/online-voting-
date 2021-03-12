<%-- 
    Document   : index.jsp
    Created on : May 30, 2017, 6:31:19 PM
    Author     : Carlos Galindo
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Manejo de Mapas</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAY7Ys2hwRXTru00HE2Dxn6BEGU7t6s2_A&callback=initMap"></script>
        <script type="text/javascript">
            function mostrar_amigos() {
                var ubicacion = new google.maps.LatLng(14.6203, -87.644);
                var opciones = {zoom: 7,
                    center: ubicacion,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                var map = new google.maps.Map(document.getElementById("mapa"), opciones);

            <%
                String lat = "", lon = "", info = "";
                int ami = 0;
                int cont = 1;
                try {
                    Dba db = new Dba(application.getRealPath("daw.mdb"));

                    db.conectar();
//                    db.query.execute("select amigo, latitud, longitud, info from amigos");
                    db.query.execute("select numero_mesa, latitud, longitud, centro_de_votacion from mesas_electorales");

                    ResultSet rs = db.query.getResultSet();

                    while (rs.next()) {
                        ami = rs.getInt(1);
                        lat = rs.getString(2);
                        lon = rs.getString(3);
                        info = rs.getString(4);

            %>
                mi_ubicacion<%=cont%> = new google.maps.Marker({
                    position: new google.maps.LatLng(<%=lat%>, <%=lon%>),
                    map: map,
                    title: '<%=ami%>'
                });

                var infowindow<%=cont%> = new google.maps.InfoWindow({
                    content: '<%=info%>'
                });

                google.maps.event.addListener(mi_ubicacion<%=cont%>, 'click', function () {
                    infowindow<%=cont%>.open(map, mi_ubicacion<%=cont%>);
                });

            <%
                        cont++;
                    }
                    db.desconectar();
                } catch (Exception e) {
                    e.printStackTrace();
                }


            %>

            }



        </script>       
    </head>
    <center>
        <body onload="mostrar_mapa(0)">
            <div id="mapa" style="width: 900px; height: 500px; border: 5px groove #006600;"></div>
            <input type="button" value="amigos" onclick="mostrar_amigos()"/>
        </body>
    </center>
</html>