<%--
  Created by IntelliJ IDEA.
  User: pilih
  Date: 11/07/2024
  Time: 04:28 p. m.
  To change this template use File | Settings | File Templates.
--%>
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

    <title>Crea tu Horario</title>
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




        /*DISEÑO INTERFAZ*/
        .contenido{
            height: 700px;
        }
        h1 {
            color: #1A1A3E;
        }
        table {
            margin-left: 60px;
            border-collapse: collapse;
            width: 90%;
            max-width: 1000px;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #1E8A82;
            color: white;
        }
        td {
            background-color: #fff;
            cursor: pointer;
        }
        td:hover {
            background-color: #f5f5f5;
        }
        /* Modal styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #1A1A3E;
            padding: 20px;
            border-radius: 10px;
            width: 300px;
            text-align: center;
            color: white;
        }
        .modal-content input {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: transparent;
            color: white;
            border: 1px solid white; /* Border color for input */
        }
        .modal-content button {
            background-color: #3DB080;
            border: none;
            border-radius: 20px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            color: white;
            margin-top: 10px;
        }
        .modal-content button:hover {
            background-color: #45c490;
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
<div class="contenido-superior">
    <div class="titulo-interfaz">
        <span>Crear horario</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Docente</span>
        <img src="imagenes/busqueda.png" alt="rol" />
    </div>
</div>

<div class="contenido">
    <table>
        <tr>
            <th>Hora</th>
            <th>Lunes</th>
            <th>Martes</th>
            <th>Miércoles</th>
            <th>Jueves</th>
            <th>Viernes</th>
        </tr>
        <tr>
            <td>7:00 - 8:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>8:00 - 9:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>9:00 - 10:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>10:00 - 11:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>11:00 - 12:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>12:00 - 13:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>13:00 - 14:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>14:00 - 15:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>15:00 - 16:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>16:00 - 17:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>17:00 - 18:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>18:00 - 19:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>19:00 - 20:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <tr>
            <td>20:00 - 21:00</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
            <td onclick="openModal(this)">Agregar evento</td>
        </tr>
        <!-- Repeat for each hour slot -->
    </table>
</div>


<!-- The Modal -->
<div id="myModal" class="modal">
    <!-- Modal content -->
    <div class="modal-content">
        <h2>Ingresa tu materia</h2>
        <input type="text" id="materia" placeholder="Materia">
        <button onclick="saveEvent()">Aceptar</button>
    </div>
</div>

<script>
    var modal = document.getElementById("myModal");
    var currentCell;

    function openModal(cell) {
        currentCell = cell;
        modal.style.display = "flex";
    }

    function closeModal() {
        modal.style.display = "none";
    }

    function saveEvent() {
        var materia = document.getElementById("materia").value;
        if (materia) {
            currentCell.innerText = materia;
        }
        closeModal();
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            closeModal();
        }
    }
</script>
</body>
</html>


