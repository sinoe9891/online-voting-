<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/normalize.css">
	<link rel="stylesheet" href="css/style.css">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;700&display=swap" rel="stylesheet">
	<title>Votación Online</title>
	<link rel="shortcut icon" href="src/img/unitec.ico" type="image/x-icon">
</head>

<body>
	<div class="main-login">
		<div class="container-login">

			<div class="col-8 imagen-login">
				<div class="container-center color-colum-second">
					<img class="logo-platform" src="src/img/Votem_Logo_Primary_Navy.png" alt="">
					<img class="logo" src="src/img/logo-ceutec.png" alt="">
					<img class="hero" src="src/img/login-v2.svg" alt="">
				</div>
			</div>

			<div class="col-4">
				<div class="container-center color-colum-one">
					<img class="logo-platform hidden" src="src/img/Votem_Logo_Primary_Navy.png" alt="">
					<img class="logo hidden" src="src/img/logo-ceutec.png" alt="">
					<div class="form-login">
						<div class="titulo-form">
							<h3>Bienvenido al<br>sistema de Votación! 👋</h3>
							<p>Inicie sesión con su cuenta para poder votar</p>
						</div>
						<div class="form">
							<form name="f1" action="autenticacion.jsp" method="POST">
								<div class="input-form">
									<label for="Usuario">Usuario</label>
									<input type="text" name="ti_usuario" value="" />
								</div>
								<div class="input-form">
									<label for="Usuario">Contraseña</label>
									<input type="password" name="ti_password" value="" />
								</div>
								<br>
								<div>
								<input type="submit" value="Login" name="bt_login" />
								</div>
								
							</form>
						</div>
					</div>
				</div>
				<div class="copyright">
					<p>Hecho por Danny Velásquez con 🧡</p>
				</div>
			</div>
		</div>
	</div>
	
</body>

</html>