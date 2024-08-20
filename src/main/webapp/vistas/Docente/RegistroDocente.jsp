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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Registro docente</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
            font-family: 'Poppins', sans-serif;
        }
        .contenido-interfaz {
            height: auto;
            width: auto;
            padding-top: 20px;
            margin-top: 20px;
        }
        .container {
            background-color: #121631;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
            width: 700px;
            text-align: center;
            color: white;
            height: auto;
            margin: 35px 0;
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
            font-size: 18px;
            cursor: pointer;
            text-decoration: none;
        }
        .container input[type="text"],
        .container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: transparent;
            color: white;
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
            text-decoration: underline;
        }
        .container button.seleccion-mat {
            background-color: transparent;
            border: 1px solid #ccc;
            max-width: 100%;
            width: 300px;
            border-radius: 5px;
            padding: 10px;
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
            padding: 5px;
            margin: 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: transparent;
            color: white;
        }
        .container button[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #1E8A82;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, opacity 0.3s ease;
        }
        .container button[type="submit"]:hover {
            background-color: #0f6862;
            text-decoration: underline;
        }
        .container button[type="submit"]:disabled {
            background-color: #ccc;
            color: #666;
            cursor: not-allowed;
            opacity: 0.7;
        }
        .container input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: transparent;
            color: white;
        }
        .error-msg {
            color: red;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>
<body>

<%
    String message = (String) request.getAttribute("message");
    String alertType = (String) request.getAttribute("alertType");
    if (message != null) {
%>
<script defer>
    Swal.fire({
        icon: '<%= alertType %>',
        title: '<%= alertType.equals("success") ? "Acción completada" : "Error" %>',
        text: '<%= message %>',
        showConfirmButton: false,
        timer: 2000
    });
</script>
<% } %>

<div class="contenido-interfaz">
    <div class="container">
        <img src="<%=context%>/IMG/logoCalendario.png" class="img-fluid" style="width: auto; height: 50px;" alt="Logo">
        <h1>CREA TU CUENTA</h1>
        <h4>DOCENTE</h4>

        <div class="divider"></div>

        <form action="<%=request.getContextPath()%>/RegistroDocentesS" method="post" id="registroForm">
            <div>
                <input type="text" name="matricula" id="matricula_registro" placeholder="Correo electronico">
                <div class="error-msg" id="matriculaError">La matrícula debe tener al menos 3 caracteres antes de '@utez.edu.mx'.</div>
            </div>
            <div>
                <input type="text" name="nombre" id="nombre" placeholder="Nombre">
                <div class="error-msg" id="nombreError">Este campo es obligatorio.</div>
            </div>
            <div>
                <input type="text" name="apellido" id="apellido" placeholder="Apellido">
                <div class="error-msg" id="apellidoError">Este campo es obligatorio.</div>
            </div>
            <div>
                <input type="password" name="password" id="contrasena_registro" placeholder="Contraseña">
                <div class="error-msg" id="passwordError">Este campo es obligatorio.</div>
            </div>
            <button type="submit" id="submit-button" disabled>Siguiente</button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const form = document.getElementById('registroForm');
        const matriculaInput = document.getElementById('matricula_registro');
        const nombreInput = document.getElementById('nombre');
        const apellidoInput = document.getElementById('apellido');
        const passwordInput = document.getElementById('contrasena_registro');
        const submitButton = document.getElementById('submit-button');

        const validateForm = () => {
            let isValid = true;

            // Validar matrícula
            const matriculaPattern = /^[a-zA-Z0-9]{3,}[^\s@]*@utez\.edu\.mx$/;
            if (!matriculaInput.value.trim() || !matriculaPattern.test(matriculaInput.value.trim())) {
                document.getElementById('matriculaError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('matriculaError').style.display = 'none';
            }

            // Validar nombre
            const nombrePattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,}(?:\s[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,})?$/;
            if (!nombrePattern.test(nombreInput.value.trim())) {
                document.getElementById('nombreError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('nombreError').style.display = 'none';
            }

            // Validar apellido
            const apellidoPattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,}(?:\s[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,})?$/;
            if (!apellidoPattern.test(apellidoInput.value.trim())) {
                document.getElementById('apellidoError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('apellidoError').style.display = 'none';
            }

            // Validar contraseña
            if (passwordInput.value.trim().length < 3) {
                document.getElementById('passwordError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('passwordError').style.display = 'none';
            }

            // Habilitar o deshabilitar el botón de submit basado en las validaciones
            submitButton.disabled = !isValid;
        };

        form.addEventListener('input', validateForm);
    });
</script>
</body>
</html>