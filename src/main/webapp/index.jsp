<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    response.setContentType("text/html; charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    String context = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTESORATE</title>

    <!-- Incluye el CSS de Bootstrap -->
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <%--<link rel="stylesheet" href="<%=context%>/css/cssIndex.css"> --%>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        margin: 0;
        font-family:'Poppins', sans-serif;
        background-color: #141C32;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .header {
        background: linear-gradient(to right, #1b294e 15%, #16284e 28%, #1d2f5a 40%, #a1b3d1 100%); /* Ajuste del gradiente para una transición más suave */
        padding: 10px 20px;
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000;
    }
    .header img {
        height: 50px;
    }
    .header nav {
        margin-left: auto;
        margin-right: 10px;
        text-align: right;
        width: 150px;
        align-items: center;
        display: flex; /* Utiliza flexbox para una mejor alineación */
        justify-content: flex-end; /* Alinea el contenido al final (derecha) */
    }
    .header a {
        color: white;
        font-size: 18px;
    }
    .content {
        background-color: #1b294e;
        padding: 35px;
        padding-bottom: 50px; /* Añadido para asegurar espacio suficiente para el enlace del administrador */
        border-radius: 20px; /* Redondez en las esquinas */
        box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
        margin-top: 65px; /* Margen superior reducido */
        position: relative; /* Añadido para posicionamiento absoluto del enlace del administrador */
    }

    h1 {
        margin-bottom: 35px;
        color: white;
        font-size:xx-large;
        margin-top: 15px;
        font-weight: bold;
    }
    .main-content {
        display: flex;
        flex-wrap: wrap; /* Asegura que los elementos se envuelvan en pantallas pequeñas */
        justify-content:space-around;
        align-items: center;
    }
    .left-section {
        flex: 1;
        display: flex;
        margin-left: 10px;
        justify-content: center;
        margin-bottom: 20px; /* Espacio inferior para separar los elementos */
    }
    .left-section img {
        max-width: 100%; /* Ajusta el tamaño máximo de la imagen */
        height: auto; /* Asegura que la imagen se ajuste proporcionalmente */
    }
    .right-section {
        flex:1;
        background-color: #3DB080;
        border-radius: 20px;
        margin-right: 25px; /* Espacio lateral */
        box-shadow: 0 6px 16px 6px rgba(0, 0, 0, 0.4);
        color: white;
        padding: 45px 70px;
    }
    .right-section h2 {
        margin-bottom: 20px;
        font-size:x-large;
        font-weight: bold;
    }
    .right-section .button-container {
        display: flex;
        gap: 25px; /* Espacio entre los botones */
        justify-content: space-around;
        padding: 15px;
    }
    .right-section button {
        background-color: #fff;
        border: none;
        border-radius: 20px;
        padding: 10px 20px;
        cursor: pointer;
        font-size: 16px;
        width: 100%; /* Ancho completo en dispositivos pequeños */
        max-width: 140px; /* Ancho máximo */
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.3s ease;
    }
    .right-section button:hover {
        background-color: rgb(16, 158, 99);
        box-shadow: 0 6px 16px 6px rgba(0, 0, 0, 0.4);
    }
    .button-container a{
        text-decoration-line: none;
    }
    .contenedor-admin{
        position: absolute; /* Posicionamiento absoluto */
        bottom: 10px; /* Ajusta según sea necesario */
        right: 20px; /* Ajusta según sea necesario */
        margin: 0; /* Elimina márgenes */
    }
    .contenedor-admin a{
        color: #a1a1a1;
    }

</style>
</head>
<body>
<header class="header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-8 col-md-4">
                <img src="<%=context%>/IMG/logoCalendario.png" alt="Icono Izquierda">
            </div>
            <div class="col">
                <nav class="text-end">
                    <a href="http://www.utez.edu.mx/" target="_blank" rel="noopener noreferrer">Sobre Nosotros</a>
                </nav>
            </div>
            <div class="col-auto">
                <img src="<%=context%>/IMG/logoUtez.png" alt="Icono Derecha">
            </div>
        </div>
    </div>
</header>
<div class="container">
    <div class="content">
    <div class="container-fluid">
                <h1 class="text-center">UTESORATE </h1>
                <div class="main-content">
                    <div class="col-lg-4 col-md-5">
                        <div class="left-section">
                            <img src="https://via.placeholder.com/300.png" alt="Imagen Principal" class="img-fluid">
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-7">
                        <div class="right-section">
                            <h2 class="text-center">¿Quién eres?</h2>
                            <div class="button-container">
                                <div><a href="<%=context%>/vistas/Docente/LoginDocente.jsp"><button type="button" id="loginD" class="btn btn-light">Docente</button></a></div>
                                <div><a href="<%=context%>/vistas/Estudiante/LoginEstudiante.jsp"><button type="button" id="loginE" class="btn btn-light">Estudiante</button></a></div>
                            </div>
                        </div>
                    </div>
                </div>
        <div class="contenedor-admin">
            <a href="<%=context%>/vistas/Admin/LoginAdmin.jsp">Administrador</a>
        </div>
    </div>
</div>
</div>
<!-- Incluye el JavaScript de Bootstrap al final del body para mejorar la carga -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
