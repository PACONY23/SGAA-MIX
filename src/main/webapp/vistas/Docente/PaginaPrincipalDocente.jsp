<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<%
    String matricula = (String) session.getAttribute("matricula");
    String nombre = (String) session.getAttribute("nombre");
    String apellido = (String) session.getAttribute("apellido");
    String correo = (String) session.getAttribute("correo");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <%--<link rel="stylesheet" href="<%=context%>/css/cssBarraDocente.css" /> --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Perfil</title>
    <style>
        /* ESTILO DE PLANTILLABARRA*/
        :root{
            --bs-body-font-family: 'Poppins', sans-serif !important;
        }
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body{
            margin: 0;
            height: 100vh;
            width: 100%;
            background-color: white;
            display: flex; /* Usar flexbox para el diseño */
            font-family: 'Poppins', sans-serif;
        }
        .contenido {
            width: calc(100% - 300px);
            margin-top: 100px; /* Ajusta según sea necesario */
            height: 600px; /* Ajusta según sea necesario */
            margin-left: 270px; /* Ajusta para evitar solapamiento con la barra lateral */
        }
        .barra-lateral {
            width: 250px;
            height: 100%;
            overflow: hidden;
            background-color: #141C32;
            transition: width 0.5s ease;
            position: fixed;
            top: 0;
        }
        /*nombre de la pagina*/
        .barra-lateral .nombre-pagina{
            width: 100%;
            height: 45px;
            display: flex;
            align-items: center;
            margin-top: 35px;
        }
        .barra-lateral .nombre-pagina img{
            margin-left: 15px;
            font-size: 50px;
        }
        .barra-lateral .nombre-pagina span{
            font-size: larger;
            opacity: 1;
            color: white;
            margin-left: 12px;
            transition: opacity 0.5s ease;
        }

        /*Menu de navegacion*/
        .barra-lateral .navegacion{
            margin-top: 55px;
            margin-right: 0;
            margin-left: 20px;
        }
        .barra-lateral .navegacion li{
            margin-top: 20px;
            list-style: none;
            display: flex;
            margin-bottom: 10px;
            margin-right: 0;
        }
        .barra-lateral .navegacion span{
            margin-left: 25px;
        }
        .barra-lateral .navegacion a{
            width: 100%;
            height: 50px;
            margin-left: 10px;
            display: flex;
            text-decoration: none;
            border-radius: 25px;
            color: white;
            transition: background-color 0.3s ease, color 0.3s ease, border-radius 0.3s ease;
        }
        .barra-lateral .navegacion a:hover{
            margin-right: 0;
            background-color: white;
            color: #141C32;
            border-top-right-radius: 0; /* Quitar radio del borde superior derecho */
            border-bottom-right-radius: 0; /* Quitar radio del borde inferior derecho */
        }

        .barra-lateral .navegacion a:hover #perfil-img {
            content: url('<%=context%>/IMG/perfil_v.png'); /* Cambia la imagen al hacer hover */
        }
        .barra-lateral .navegacion a:hover #calendario-img {
            content: url('<%=context%>/IMG/calendario_v.png'); /* Cambia la imagen al hacer hover */
        }
        .barra-lateral .navegacion a:hover #historial-img {
            content: url('<%=context%>/IMG/historial_v.png'); /* Cambia la imagen al hacer hover */
        }
        .barra-lateral .navegacion a:hover #asesorias-img {
            content: url('<%=context%>/IMG/asesorias_v.png'); /* Cambia la imagen al hacer hover */
        }
        .barra-lateral .navegacion a:hover #logout-img {
            content: url('<%=context%>/IMG/logout_v.png'); /* Cambia la imagen al hacer hover */
        }
        .barra-lateral .navegacion img{
            margin-left: 15px;
        }
        .contenido-superior{
            width: calc(100% - 250px); /* Resto del ancho de barra-lateral */
            height: 100px; /* Ajustar la altura según se necesite */
            overflow: hidden;
            background-color: white;
            padding: 32px 15px;
            margin-left: 250px;
            position: fixed;
        }
        .titulo-interfaz{
            width: 400px;
            height: 100px;
            font-weight: bold;
        }
        .titulo-interfaz span{
            font-size: xx-large;
            color: #141C32; /* Añadir color para que el texto sea visible */
        }
        .rol-actual{
            position: fixed; /* Posiciona este div de manera absoluta */
            top: 15px; /* Ajusta según la necesidad */
            right: 15px; /* Ajusta según la necesidad */
            padding: 10px 15px; /* Añadir padding si es necesario */
            border-radius: 5px;
            display: flex;
            align-items: center;
        }
        .rol-actual img{
            width: 40px;
            height: 40px;
        }
        .rol-actual span{
            color: #141C32;
            font-size: small;
            margin-right: 10px;
            top: 0;
            margin-bottom: 20px;
            align-items: center;
        }



        /* Estilos para el contenido principal */
        .contenedor-perfil {
            margin-left: 250px;
            width: calc(100% - 250px);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .perfil {
            width: 80%;
            justify-content: center;
            max-width: 1000px;
            background-color: #141C32;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: flex-start;
            color: #fff;
        }

        .perfil .foto {
            width: 50%;
            text-align: center;
            margin-right: 20px;
        }

        .perfil .foto img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 2px solid #fff;
            margin-bottom: 10px;
        }

        .perfil .foto input[type="file"] {
            display: block;
            margin: 10px auto;
            color: #fff;
        }

        .perfil .informacion {
            width: 50%;
            padding-left: 20px;
            margin-top: 20px;
        }

        .perfil .informacion div {
            margin-bottom: 20px;
        }

        .perfil .informacion label {
            color: #ccc;
            font-size: 16px;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .perfil .informacion input {
            background-color: #fff;
            color: #141C32;
            border: 1px solid #ccc;
            padding: 10px;
            width: calc(100% - 20px);
            border-radius: 5px;
            font-size: 16px;
        }

        .perfil .botones {
            width: 100%;
            text-align: center;
            margin-top: 20px;
        }

        .perfil .botones button {
            margin: 10px;
            padding: 10px 20px;
            background-color: #141C32;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .perfil .botones button:hover {
            background-color: #fff;
            color: #141C32;
        }

        /* Estilos para el modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            overflow: auto;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 5px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
        }

        .modal-content h2 {
            text-align: center;
        }

        .input-group {
            margin-bottom: 10px;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
        }

        .input-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .modal-buttons {
            text-align: center;
            margin-top: 20px;
        }

        /* Estilo para el botón de guardar dentro del modal */
        .modal-buttons button {
            margin: 10px;
            padding: 10px 20px;
            background-color: #141C32;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .modal-buttons button:hover {
            background-color: #fff;
            color: #141C32;
        }
        .boton-cerrar-sesion {
            margin: 10px;
            padding: 10px 20px;
            background-color: #141C32;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .boton-cerrar-sesion:hover {
            background-color: #fff;
            color: #141C32;
        }
    </style>
</head>
<body>

<!-- Barra lateral -->
<div class="barra-lateral">
    <div class="nombre-pagina">
        <img src="<%=context%>/IMG/logoCalendario.png" id="cloud" class="img-fluid" style="height: 40px; width: auto"/>
        <span>UTEZORATE</span>
    </div>
    <nav class="navegacion">
        <ul class="list-unstyled">
            <li>
                <a href="<%=context%>/vistas/Docente/PaginaPrincipalDocente.jsp" class="d-flex align-items-center">
                    <img id="perfil-img" src="<%=context%>/IMG/perfil_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Perfil</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Docente/CrearHorario.jsp" class="d-flex align-items-center">
                    <img id="calendario-img" src="<%=context%>/IMG/calendario_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Mi calendario</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Docente/HistorialDocente.jsp" class="d-flex align-items-center" >
                    <img id="historial-img" src="<%=context%>/IMG/historial_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Historial</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Docente/AsesoriasGestionDocente.jsp" class="d-flex align-items-center" >
                    <img id="asesorias-img" src="<%=context%>/IMG/asesorias_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Gestion asesorías</span>
                </a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/LogoutS" class="d-flex align-items-center" >
                    <img id="logout-img" src="<%=context%>/IMG/logout_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Cerrar sesión</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
<!-- CONTENIDO SUPERIOR -->
<div class="contenido-superior">
    <div class="titulo-interfaz">
        <span>Perfil Docente</span>
    </div>

    <div class="matricula-section" style="color: black;">
        Matrícula: <%=matricula != null ? matricula : "Desconocida" %>
    </div>
</div>



<div class="contenedor-perfil">
    <div class="perfil">
        <div class="informacion">
            <div class="dato">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" value="<%=nombre%>" readonly>
            </div>
            <div class="dato">
                <label for="apellidos">Apellidos:</label>
                <input type="text" id="apellidos" value="<%=apellido%>" readonly>
            </div>
            <div class="dato">
                <label for="correo">Correo:</label>
                <input type="email" id="correo" value="<%=matricula%>" readonly>
            </div>
            <div class="botones">
                <button id="editar">Editar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Edición -->
<div id="modalEditar" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Editar Perfil</h2>
        <form id="editarForm" action="<%=context%>/EditarDocente" method="post">
            <div class="input-group">
                <label for="nombreModal">Nombre:</label>
                <input type="text" id="nombreModal" name="nombre" value="<%=nombre%>" required>
                <div id="nombreError" class="text-danger" style="display:none;">Nombre inválido. Debe tener al menos 5 caracteres y solo letras.</div>
            </div>
            <div class="input-group">
                <label for="apellidosModal">Apellidos:</label>
                <input type="text" id="apellidosModal" name="apellidos" value="<%=apellido%>" required>
                <div id="apellidoError" class="text-danger" style="display:none;">Apellidos inválidos. Debe tener al menos 5 caracteres y solo letras.</div>
            </div>
            <div class="input-group">
                <label for="correoModal">Correo:</label>
                <input type="email" id="correoModal" name="matricula" value="<%=matricula%>" required>
                <div id="correoError" class="text-danger" style="display:none;">Campo obligatorio. Debe ser un correo válido con terminación @utez.edu.mx.</div>
            </div>
            <div class="modal-buttons">
                <button type="submit" id="guardarCambios">Guardar Cambios</button>
            </div>
        </form>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Elementos del modal
        const modal = document.getElementById('modalEditar');
        const btnEditar = document.getElementById('editar');
        const spanClose = document.querySelector('.modal .close');
        const form = document.getElementById('editarForm');
        const submitButton = document.getElementById('guardarCambios');

        // Abre el modal
        btnEditar.addEventListener('click', () => {
            modal.style.display = 'block';
        });

        // Cierra el modal cuando el usuario hace clic en la X
        spanClose.addEventListener('click', () => {
            modal.style.display = 'none';
        });

        // Cierra el modal si el usuario hace clic fuera del contenido del modal
        window.addEventListener('click', (event) => {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // Validar el formulario
        const validateForm = () => {
            let isValid = true;

            // Validar nombre
            const nombrePattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,}(?:\s[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,})?$/;
            if (!nombrePattern.test(document.getElementById('nombreModal').value.trim())) {
                document.getElementById('nombreError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('nombreError').style.display = 'none';
            }

            // Validar apellido
            const apellidoPattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,}(?:\s[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,})?$/;
            if (!apellidoPattern.test(document.getElementById('apellidosModal').value.trim())) {
                document.getElementById('apellidoError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('apellidoError').style.display = 'none';
            }

            // Validar correo
            const correoPattern = /^[a-zA-Z0-9]{3,}[^\s@]*@utez\.edu\.mx$/;
            if (!correoPattern.test(document.getElementById('correoModal').value.trim())) {
                document.getElementById('correoError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('correoError').style.display = 'none';
            }

            // Habilitar o deshabilitar el botón de guardar basado en la validez del formulario
            submitButton.disabled = !isValid;

            return isValid;
        };

        // Validar al enviar el formulario
        form.addEventListener('submit', (event) => {
            if (!validateForm()) {
                event.preventDefault(); // Evitar el envío del formulario si no es válido
            }
        });

        // Validar el formulario en cada entrada del usuario
        form.addEventListener('input', validateForm);

        // Inicializar el estado del botón de guardar
        validateForm();
    });
</script>
</body>
</html>
