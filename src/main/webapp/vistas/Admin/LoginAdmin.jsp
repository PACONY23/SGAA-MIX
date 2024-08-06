<%--
  Created by IntelliJ IDEA.
  User: pilih
  Date: 15/07/2024
  Time: 05:38 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%--<link rel="stylesheet" href="<%=context%>/css/cssInicioSesion.css" /> --%>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <title>Inicio de Sesión admin</title>
<style>
    :root{
        --bs-body-font-family: 'Poppins', sans-serif !important;
    }

    /* Estilos básicos para el cuerpo y el diseño principal */
    body {
        margin: 0;
        font-family: 'Poppins', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #F0F4FF; /* Fondo claro */
    }

    /* Estilos para la barra superior */
    .top-bar {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 50px;
        background-color: #141C32; /* Fondo oscuro */
        display: flex;
        align-items: center;
        padding-left: 20px;
    }

    .top-bar img {
        margin-left: 20px;
        width: 30px;
        height: 30px;
    }

    /* Estilos para el contenedor del formulario de inicio de sesión */
    .login-container {
        background-color: #141C32; /* Fondo oscuro */
        padding: 40px;
        border-radius: 20px; /* Redondez en las esquinas */
        box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
        text-align: center;
        width: 340px; /* Aumento del ancho */
        max-width: 80%; /* Limitar el ancho máximo para mantener la responsividad */
        height: auto; /* Ajuste automático de altura */
        margin: 20px; /* Espacio alrededor del contenedor */
    }

    .login-container h1 {
        margin: 0;
        color: #FFFFFF; /* Texto blanco */
        font-size: 24px; /* Tamaño de fuente aumentado */
    }

    .login-container h2 {
        margin: 10px 0;
        color: #AAAAAA; /* Texto gris claro */
        font-size: 18px; /* Tamaño de fuente aumentado */
    }

    .login-container input {
        width: calc(100% - 20px); /* Ajuste para evitar desbordamiento */
        padding: 12px; /* Aumento del relleno */
        margin: 10px 0;
        border: 1px solid #AAAAAA; /* Borde gris claro */
        border-radius: 8px; /* Redondez en los inputs */
        box-sizing: border-box; /* Incluir el borde en el cálculo del ancho */
        font-size: 16px; /* Tamaño de fuente aumentado */
        background-color: #1E2B46; /* Color de fondo del input */
        color: #FFFFFF; /* Color de texto blanco */
    }

    .login-container button {
        width: 140px; /* Ajuste similar al de los inputs */
        padding: 12px;
        background-color: #1D815A; /* Botón verde */
        color: #FFFFFF; /* Texto blanco */
        border: none;
        border-radius: 8px; /* Redondez en el botón */
        cursor: pointer;
        margin-top: 15px; /* Espaciado aumentado */
        font-size: 16px; /* Tamaño de fuente aumentado */
    }
    .login-container button:hover{
        background-color: #145A42; /* Botón verde */
    }
    .login-container a {
        display: block;
        margin-top: 15px;
        color: #AAAAAA; /* Texto gris claro */
        text-decoration: none;
        font-size: 14px; /* Tamaño de fuente ajustado */
        cursor: pointer;
    }

    .login-container a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<!-- Barra superior -->
<div class="top-bar">
    <img src="<%=context%>/IMG/logoCalendario.png" id="cloud" class="img-fluid" style="height: 40px; width: auto"/>
</div>

<!-- Contenedor del formulario de inicio de sesión -->
<div class="login-container">
    <h1>Bienvenido</h1>
    <h2>Admin</h2>
    <form action="<%=context%>/LoginAdminS" method="post"> <!-- cambiar el metodo al post, get solo fue momentáneo-->
        <input type="text" name="matricula" placeholder="Matrícula" required>
        <input type="password" name="password" placeholder="Contraseña" required>
        <button type="submit">Iniciar sesión</button>
    </form>
</div>
</body>
</html>