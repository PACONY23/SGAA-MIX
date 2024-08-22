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
    <title>UTEZORATE</title>

    <!-- Incluye el CSS de Bootstrap -->
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <%--<link rel="stylesheet" href="<%=context%>/css/cssIndex.css"> --%>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #141C32;
            color: white;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .header {
            background: linear-gradient(to right, #1b294e 15%, #16284e 28%, #1d2f5a 40%, #a1b3d1 100%);
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
            margin-left: auto; /* Asegura que el texto se alinee al final del contenedor */
            margin-right: 10px; /* Ajusta el margen derecho para que el texto esté más cerca del borde derecho */
            text-align: right;
        }
        .header a {
            color: white;
            font-size: 18px;
        }
        .content {
            background-color: #1b294e;
            padding: 35px;
            padding-bottom: 50px;
            border-radius: 20px;
            box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
            margin-top: 150px; /* Asegura que no se sobreponga con la cabecera */
            position: relative;
            width: 100%;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }
        h1 {
            margin-bottom: 35px;
            color: white;
            font-size: xx-large;
            font-weight: bold;
        }
        .main-content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            align-items: center;
        }
        .left-section, .right-section {
            flex: 1;
            margin: 10px;
        }
        .left-section img {
            max-width: 100%;
            height: auto;
        }
        .right-section {
            background-color: #3DB080;
            border-radius: 20px;
            box-shadow: 0 6px 16px 6px rgba(0, 0, 0, 0.4);
            color: white;
            padding: 45px 50px;
        }
        .right-section h2 {
            margin-bottom: 20px;
            font-size: x-large;
            font-weight: bold;
        }
        .button-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            padding: 15px;
        }
        .button-container button {
            background-color: #fff;
            border: none;
            border-radius: 20px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            max-width: 130px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s ease;
        }
        .button-container button:hover {
            background-color: rgb(16, 158, 99);
            box-shadow: 0 6px 16px 6px rgba(0, 0, 0, 0.4);
        }
        .button-container a {
            text-decoration: none;
        }
        .button-container a button {
            color: #3DB080;
        }
    </style>
</head>
<body>
<header class="header">
    <div class="container-fluid">
        <div class="row justify-content-end align-items-center">
            <div class="col-auto d-flex align-items-center">
                <nav class="me-3">
                    <a href="http://www.utez.edu.mx/" target="_blank" rel="noopener noreferrer">Sobre Nosotros</a>
                </nav>
                <img src="<%=context%>/IMG/logoUtez.png" alt="Icono Derecha">
            </div>
        </div>
    </div>
</header>

<div class="container">
    <div class="content">
        <h1 class="text-center">UTEZORATE</h1>
        <div class="main-content">
            <div class="left-section">
                <img src="<%=context%>/IMG/logoCalendario.png" style="width: auto; height: 350px;" alt="Imagen Principal" class="img-fluid">
            </div>
            <div class="right-section">
                <h2 class="text-center">¿Quién eres?</h2>
                <div class="button-container">
                    <a href="<%=context%>/vistas/Docente/LoginDocente.jsp"><button type="button" id="loginD" class="btn btn-light">Docente</button></a>
                    <a href="<%=context%>/vistas/Estudiante/LoginEstudiante.jsp"><button type="button" id="loginE" class="btn btn-light">Estudiante</button></a>
                    <a href="<%=context%>/RedirectLoginAdmin"><button type="button" id="loginA" class="btn btn-light" >Administrador</button></a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>