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
	<link rel="stylesheet" href="../css/css/bootstrap.css">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="stylesheet" type="text/css" href="../css/css/pages/app-user.css">
	<link rel="stylesheet" type="text/css" href="../css/css/components.css">
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
						<li class="nav-item"><a href="#"><i class="fas fa-poll"></i>Métricas</li></a>
						<li class="nav-item"><a href="#"><i class="far fa-flag"></i>Partidos Políticos</li></a>
						<li class="nav-item"><a href="#"><i class="fas fa-user"></i>Presidente</li></a>
						<li class="nav-item"><a href="#"><i class="fas fa-user-friends"></i>Alcaldes</li></a>
						<li class="nav-item"><a href="#"><i class="fas fa-users"></i>Diputados</li></a>
						<li class="nav-item"><a href="#"><i class="fas fa-person-booth"></i>Votantes</li></a>
						<li class="nav-item"><a href="#"><i class="fas fa-user-cog"></i>Usuarios</li></a>
						<li class="nav-item header-item">TÍTULO</li>

					</ul>
				</nav>
			</div>
			
			<div class="main-body-page">
				<div class="content-wrapper">
					<div class="content-body">
						<!-- users list start -->
						<section class="app-user-list">
							<div class="card">
								<div class="card-datatable table-responsive pt-0">
									<table class="user-list-table table">
										<thead class="thead-light">
											<tr>
												<th>Nombre</th>
												<th>Apellidos</th>
												<th>Username</th>
												<th>Email</th>
												<th>Role</th>
												<th>Acción</th>
											</tr>
										</thead>
										<tbody>
											<%
												try {
													Dba db = new Dba(application.getRealPath("votacion_2021_honduras.mdb"));
													db.conectar();
													db.query.execute("select nombre, apellidos, username, identidad, email, role from users");
													ResultSet rs = db.query.getResultSet();
													String centinela = "n";
													while (rs.next()) {%>
											<tr role="row" class="odd">
												<td>
													<div class="d-flex justify-content-left align-items-center">
														<%=rs.getString(1)%>
													</div>
												</td>
												<td><%=rs.getString(2)%></td>
												<%-- <td><%=rs.getString(3)%></td>  --%>
												<td><%=rs.getString(4)%></td>
												<td><%=rs.getString(5)%></td>
												<td>
													<span class="text-truncate align-middle">
														<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
															viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
															stroke-linejoin="round" class="feather feather-database font-medium-3 text-success mr-50">
															<ellipse cx="12" cy="5" rx="9" ry="3"></ellipse>
															<path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"></path>
															<path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"></path>
														</svg>
														SuperAdmin
													</span><%=rs.getString(6)%>
												</td>
												<td>
													<div class="btn-group"><a class="btn btn-sm dropdown-toggle hide-arrow" data-toggle="dropdown"><svg
																xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-more-vertical font-small-4">
																<circle cx="12" cy="12" r="1"></circle>
																<circle cx="12" cy="5" r="1"></circle>
																<circle cx="12" cy="19" r="1"></circle>
															</svg></a>
														<div class="dropdown-menu dropdown-menu-right"><a href="app-user-view.html" class="dropdown-item"><svg
																	xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
																	stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
																	class="feather feather-file-text font-small-4 mr-50">
																	<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
																	<polyline points="14 2 14 8 20 8"></polyline>
																	<line x1="16" y1="13" x2="8" y2="13"></line>
																	<line x1="16" y1="17" x2="8" y2="17"></line>
																	<polyline points="10 9 9 9 8 9"></polyline>
																</svg>Details</a><a href="app-user-edit.html" class="dropdown-item"><svg
																	xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
																	stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
																	class="feather feather-archive font-small-4 mr-50">
																	<polyline points="21 8 21 21 3 21 3 8"></polyline>
																	<rect x="1" y="3" width="22" height="5"></rect>
																	<line x1="10" y1="12" x2="14" y2="12"></line>
																</svg>Edit</a><a href="javascript:;" class="dropdown-item delete-record"><svg
																	xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
																	stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
																	class="feather feather-trash-2 font-small-4 mr-50">
																	<polyline points="3 6 5 6 21 6"></polyline>
																	<path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
																	<line x1="10" y1="11" x2="10" y2="17"></line>
																	<line x1="14" y1="11" x2="14" y2="17"></line>
																</svg>Delete</a>
														</div>
													</div>
												</td>
											</tr>
											<%
													}
													db.desconectar();
												} catch (Exception e) {
													e.printStackTrace();
												}
											%>                
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
