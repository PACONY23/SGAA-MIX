<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%--<link rel="stylesheet" href="<%=context%>/css/cssPlantillaBarra.css" >--%>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <%-- <link rel="stylesheet" href="<%=context%>/css/cssBarraEstudiante.css" />--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>perfil estudiante</title>
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
            margin-top: 50px;
            margin-right: 0;
            margin-left: 20px;
        }
        .barra-lateral .navegacion li{
            margin-top: 20px;
            list-style: none;
            display: flex;
            margin-bottom: 5px;
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
        .barra-lateral .navegacion a:hover #buscador-img {
            content: url('<%=context%>/IMG/buscador_v.png'); /* Cambia la imagen al hacer hover */
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
    </style>
</head>
<body>
<!-- Barra lateral -->
<div class="barra-lateral">
    <div class="nombre-pagina">
        <img src="<%=context%>/IMG/logoCalendario.png" id="cloud" class="img-fluid" style="height: 40px; width: auto"/>
        <span>UTESORATE</span>
    </div>
    <nav class="navegacion">
        <ul class="list-unstyled">
            <li>
                <a href="<%=context%>/vistas/Estudiante/PaginaPrincipalEstudiante.jsp" class="d-flex align-items-center">
                    <img id="perfil-img" src="<%=context%>/IMG/perfil_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Perfil</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Estudiante/HorarioEstudiante.jsp" class="d-flex align-items-center">
                    <img id="calendario-img" src="<%=context%>/IMG/calendario_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Mi calendario</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Estudiante/HistorialEstudiante.jsp" class="d-flex align-items-center" >
                    <img id="historial-img" src="<%=context%>/IMG/historial_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Historial</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Estudiante/buscarMateria.jsp" class="d-flex align-items-center" >
                    <img id="buscador-img" src="<%=context%>/IMG/buscador_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Buscar materias</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
<!-- Contenedor principal -->
<div class="contenedor-perfil">
    <div class="perfil">
        <div class="foto">
            <img src="foto_perfil.png" alt="Foto del Estudiante">
            <input type="file" id="subirFoto">
        </div>
        <div class="informacion">
            <div class="dato">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" value="Nombre actual">
            </div>
            <div class="dato">
                <label for="apellidos">Apellidos:</label>
                <input type="text" id="apellidos" value="Apellidos actuales">
            </div>
            <div class="dato">
                <label for="correo">Correo:</label>
                <input type="email" id="correo" value="correo@ejemplo.com">
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
        <form id="editarForm">
            <div class="input-group">
                <label for="nombreModal">Nombre:</label>
                <input type="text" id="nombreModal" value="Nombre actual">
            </div>
            <div class="input-group">
                <label for="apellidosModal">Apellidos:</label>
                <input type="text" id="apellidosModal" value="Apellidos actuales">
            </div>
            <div class="input-group">
                <label for="correoModal">Correo:</label>
                <input type="email" id="correoModal" value="correo@ejemplo.com">
            </div>
            <div class="modal-buttons">
                <button type="button" id="guardarCambios">Guardar Cambios</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var modal = document.getElementById('modalEditar');
        var btnEditar = document.getElementById('editar');
        var spanClose = modal.querySelector('.close');

        // Mostrar modal al hacer clic en Editar
        btnEditar.onclick = function() {
            modal.style.display = 'block';
        }

        // Ocultar modal al hacer clic en X
        spanClose.onclick = function() {
            modal.style.display = 'none';
        }

        // Ocultar modal al hacer clic fuera de él
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }

        // Guardar cambios (simulado)
        var btnGuardar = document.getElementById('guardarCambios');
        btnGuardar.onclick = function() {
            var nombre = document.getElementById('nombreModal').value;
            var apellidos = document.getElementById('apellidosModal').value;
            var correo = document.getElementById('correoModal').value;

            // Aquí iría la lógica para guardar los cambios
            console.log('Nombre:', nombre);
            console.log('Apellidos:', apellidos);
            console.log('Correo:', correo);

            // Simular cierre del modal
            modal.style.display = 'none';
        }
    });
</script>
</body>
</html>
