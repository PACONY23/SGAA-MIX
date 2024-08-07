<%--
  Created by IntelliJ IDEA.
  User: pilih
  Date: 10/07/2024
  Time: 09:33 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <title>Registro estudiante</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0; /* Fondo claro */
            font-family: 'Poppins', sans-serif;
        }
        .contenido-interfaz {
            height: auto;
            width: auto;
            margin-top: 140px;
        }
        .container {
            background-color: #121631; /* Color de fondo del contenedor */
            padding: 40px; /* Ajustar el padding para darle más espacio al contenido */
            border-radius: 20px;
            box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
            width: 400px; /* Aumentar el ancho del contenedor */
            text-align: center;
            color: white;
            height: auto;
            margin: 35px; /* Margen superior e inferior de 35px */
        }
        .container img {
            width: 50px;
            margin-bottom: 20px;
        }
        .container h1 {
            margin: 0;
            font-size: 24px;
        }
        .container a {
            margin: 10px 0;
            color: #ddd;
            font-size: 18px; /* Tamaño de fuente ajustado */
            cursor: pointer;
            text-decoration: none;
        }
        .container button:hover {
            text-decoration: underline;
        }
        .container input[type="text"],
        .container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; /* Asegurarse de que el padding no aumente el tamaño total del input */
            background-color: transparent; /* Hacer el fondo de los inputs transparente */
            color: white; /* Cambiar el color del texto */
        }
        .container button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #1E8A82;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .container button:hover {
            background-color: #0f6862;
        }
        .divider {
            margin: 20px 0;
            border-bottom: 1px solid #ccc;
        }
        .info-extra {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }
        .info-extra input {
            width: 100%;
            padding: 5px; /* Inputs más pequeños */
            margin: 0; /* Quitar el margen entre inputs */
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; /* Asegurarse de que el padding no   aumente el tamaño total del input */
            background-color: transparent; /* Hacer el fondo de los inputs transparente */
            color: white; /* Cambiar el color del texto */
        }
    </style>
</head>
<body>
<div class="contenido-interfaz">
    <div class="container">
        <img src="https://via.placeholder.com/50" alt="Logo">
        <h1>CREA TU CUENTA</h1>
        <h4>ESTUDIANTE</h4>

        <div class="divider"></div>

        <!-- Formulario de registro -->
        <form action="<%=request.getContextPath()%>/RegistroEstudianteS" method="get">  <!-- cambiar el metodo al post, get solo fue momentáneo-->
            <input type="text" name="matricula" id="matricula_registro" placeholder="Matrícula">
            <input type="text" name="nombre" id="nombre" placeholder="Nombre">
            <input type="text" name="apellido" id="apellido" placeholder="Apellido">
            <input type="password" name="password" id="contrasena_registro" placeholder="Contraseña">
            <input type="password" name="confirmar_contrasena" id="confirmar_contrasena" placeholder="Confirmar contraseña">
            <div class="info-extra">
                <input type="text" name="div_aca" id="division_aca" placeholder="División Académica">
                <input type="text" name="carrera" id="carrera" placeholder="Carrera">
                <input type="text" name="grado" id="grado" placeholder="Grado">
                <input type="text" name="grupo" id="grupo" placeholder="Grupo">
            </div>
            <button type="submit">Siguiente</button>
        </form>
    </div>
</div>

</body>
</html>
