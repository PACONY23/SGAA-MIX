<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String context = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= context %>/css/cssFuenteLetra.css">
    <title>Inicio de Sesión Docente</title>
    <style>
        :root {
            --bs-body-font-family: 'Poppins', sans-serif !important;
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #F0F4FF; /* Fondo claro */
        }

        .top-bar {
            background: linear-gradient(to right, #1b294e 15%, #16284e 28%, #1d2f5a 40%, #a1b3d1 100%);
            height: 50px;
            display: flex;
            align-items: center;
            padding-left: 20px;
            width: 100%;
            position: fixed;
            top: 0;
            z-index: 1000;
        }

        .top-bar img {
            margin-left: 20px;
            width: 40px;
            height: 40px;
        }

        .login-container {
            background-color: #141C32; /* Fondo oscuro */
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
            text-align: center;
            width: 380px; /* Ancho aumentado */
            max-width: 80%; /* Limitar el ancho máximo para mantener la responsividad */
            height: auto; /* Ajuste automático de altura */
            margin: 80px 20px 20px; /* Margen superior para evitar que se superponga con la barra superior */
        }

        .login-container h1 {
            margin: 0;
            color: #FFFFFF;
            font-size: 24px;
        }

        .login-container h2 {
            margin: 10px 0;
            color: #AAAAAA;
            font-size: 18px;
        }

        .login-container input {
            width: calc(100% - 20px);
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #AAAAAA;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            background-color: #1E2B46;
            color: #FFFFFF;
        }

        .login-container input:invalid + .error-msg {
            display: block;
        }

        .login-container .error-msg {
            color: #ff6666;
            font-size: 14px;
            text-align: left;
            display: none;
        }

        .login-container button {
            width: 100%;
            padding: 12px;
            background-color: #1D815A;
            color: #FFFFFF;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 15px;
            font-size: 16px;
            opacity: 0.5;
            transition: opacity 0.3s ease;
        }

        .login-container button:enabled {
            opacity: 1;
        }

        .login-container a {
            display: block;
            margin-top: 15px;
            color: #AAAAAA;
            text-decoration: none;
            font-size: 14px;
        }

        .login-container a:hover {
            text-decoration: underline;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1050;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background-color: rgba(0,0,0,0.5);

            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: #141C32;
            color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
            width: 300px;
            text-align: center;
        }

        .modal-content h4 {
            margin-bottom: 20px;
        }

        .modal-content button {
            background-color: #1D815A;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
        }

        .modal-content button:hover {
            background-color: #145A42;
        }
    </style>
</head>
<body>
<!-- Barra superior -->
<div class="top-bar">
    <img src="<%= context %>/IMG/logoCalendario.png" alt="Logo"/>
</div>

<!-- Contenedor del formulario de inicio de sesión -->
<div class="login-container">
    <h1>Bienvenido</h1>
    <h2>DOCENTE</h2>
    <form id="loginForm" action="<%= context %>/LoginDocentesS" method="post">
        <input type="text" id="matricula" name="matricula" placeholder="Correo electronico" required>
        <div class="error-msg">Campo obligatorio</div>
        <input type="password" id="password" name="password" placeholder="Contraseña" required>
        <div class="error-msg">Campo obligatorio</div>
        <button type="submit" disabled>Iniciar sesión</button>
    </form>
    <a href="<%=context%>/RedirectRegistro">Crea tu cuenta...</a>
</div>

<!-- Modal -->
<div class="modal" id="errorModal">
    <div class="modal-content">
        <h4>Credenciales no válidas o aún no has sido dado de alta</h4>
        <button id="closeModal">OK</button>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const form = document.getElementById('loginForm');
        const matriculaInput = document.getElementById('matricula');
        const passwordInput = document.getElementById('password');
        const submitButton = form.querySelector('button[type="submit"]');
        const errorModal = document.getElementById('errorModal');
        const closeModal = document.getElementById('closeModal');

        const checkFormValidity = () => {
            if (matriculaInput.value && passwordInput.value) {
                submitButton.disabled = false;
            } else {
                submitButton.disabled = true;
            }
        };

        matriculaInput.addEventListener('input', checkFormValidity);
        passwordInput.addEventListener('input', checkFormValidity);

        closeModal.addEventListener('click', () => {
            errorModal.style.display = 'none';
        });

        <% if (request.getAttribute("flag") != null && !(Boolean)request.getAttribute("flag")) { %>
        errorModal.style.display = 'flex';
        <% } %>
    });
</script>
</body>
</html>
