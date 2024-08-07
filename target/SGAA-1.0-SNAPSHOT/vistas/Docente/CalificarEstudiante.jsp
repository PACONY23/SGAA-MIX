<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <%--<link rel="stylesheet" href="<%=context%>/css/cssPlantillaBarra.css">--%>
    <%--<link rel="stylesheet" href="<%=context%>/css/cssBarraDocente.css" /> --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <title>Califica al estudiante</title>
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
        .label-docente {
            color: black;
            font-size: 18px;

        }
        .caja-preguntas {
            display: flex;
            justify-content: center;
            flex-direction: column;
            width: 1000px;
            gap: 18px;
            padding-top: 35px;
            margin: 0 auto; /* Centra horizontalmente */
        }
        .pregunta {
            display: flex;
            align-items: center;
            height: 65px;
            background-color: #13AC80;
            padding: 10px;
            border-radius: 12px;
            font-size: 16px;
            color: black;
        }
        .icono {
            background-color: #141C32;
            width: 25px;
            height: 25px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 16px;
            margin-right: 8px;
        }

        .checkbox-form {
            margin-left: auto;
            margin-right: 8px;
            cursor: pointer;
        }


        #btn-modal {
            display: none;
        }
        .container-modal {
            width: 100%;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: rgba(144, 148, 150, 0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 100;
        }

        #btn-modal:checked ~ .container-modal {
            display: flex;
        }

        .content-modal {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background-color: #141C32;
            border-radius: 22px;
            text-align: center;
        }

        .content-modal h2 {
            margin-bottom: 15px;
            color: white;
        }

        .content-modal p {
            padding: 15px 0px;
            border-top: 1px solid rgb(245, 231, 231);
            border-bottom: 1px solid rgb(245, 231, 231);
        }

        .btn-cerrar {
            width: 100%;
            margin-top: 15px;
            display: flex;
            justify-content: flex-end;
        }

        .btn-cerrar label {
            padding: 7px 10px;
            font-weight: bold;
            font-size:small;
            background-color: #1E8A82;
            color: #141C32;
            border-radius: 15px;
            cursor: pointer;
            transition: all 300ms ease;
        }

        .btn-cerrar label:hover {
            background-color: #0f6862;
        }

        .cerrar-modal {
            width: 100%;
            height: 100vh;
            position: absolute;
            top: 0; left: 0;
            z-index: -1;
        }


        /*modal responsive*/
        .div-modal{
            width: 100%;
            height: 80px;
            margin-top: 20px;
            position: relative;
        }
        .div-boton{
            height: 60px;
            width: 300px;
            margin-left: 749px;
            position: relative;
        }
        .boton-modal {
            position: absolute; /* Botón absoluto */
            top: 10px;
            right: 20px;
            left: auto;
            padding: 8px 10px;
            width: 80px;
            background-color: #1D815A;
            color: white;
            border: none;
            border-radius: 60px;
            font-size: 16px;
            cursor: pointer;
        }
        .boton-modal label {
            position: absolute; /* Etiqueta absoluta */
            top: 0;
            left: 0;
            padding: 8px 20px;
            background-color: #1D815A;
            color: white;
            border-radius: 15px;
            cursor: pointer;
            transition: all 300ms ease;
        }
        .boton-modal:hover {
            background-color: #145A42;
        }

        .boton-modal label:hover {
            background-color: #145A42;
        }
    </style>
</head>
<body>
<div class="barra-lateral">
    <div class="nombre-pagina">
        <img src="<%=context%>/IMG/logoCalendario.png" id="cloud" class="img-fluid" style="height: 40px; width: auto"/>
        <span>UTESORATE</span>
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
        </ul>
    </nav>
</div>
<div class="contenido-superior">
    <div class="titulo-interfaz">
        <span>Tu historial</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Estudiante</span>
        <img src="imagenes/busqueda.png" alt="rol" />
    </div>
</div>

<div class="contenido">
    <label class="label-docente">Docente: Mauro Bahena</label>
    <div class="caja-preguntas">
        <div class="pregunta">
            <div class="icono">?</div>
            <span
            >Las explicaciones del docente son claras y fáciles de
            entender.</span
            >
            <input type="checkbox" class="checkbox-form" />
        </div>
        <div class="pregunta">
            <div class="icono">?</div>
            <span
            >El docente respondió de manera efectiva a las preguntas y dudas
            durante la asesoría.</span
            >
            <input type="checkbox" class="checkbox-form" />
        </div>
        <div class="pregunta">
            <div class="icono">?</div>
            <span>El docente comienza y termina la asesoría a tiempo.</span>
            <input type="checkbox" class="checkbox-form" />
        </div>
        <div class="pregunta">
            <div class="icono">?</div>
            <span>El docente fomenta una comunicación abierta y respetuosa.</span>
            <input type="checkbox" class="checkbox-form" />
        </div>
        <div class="pregunta">
            <div class="icono">?</div>
            <span
            >El docente se adapta a las necesidades y estilos de aprendizaje de
            los estudiantes.</span
            >
            <input type="checkbox" class="checkbox-form" />
        </div>
        <div class="pregunta">
            <div class="icono">?</div>
            <span
            >El docente muestra un profundo conocimiento sobre el tema
            tratado.</span
            >
            <input type="checkbox" class="checkbox-form" />
        </div>
    </div>

    <!-- boton abre modal mensaje -->
    <div class="div-modal">
        <div class="div-boton">
            <div class="boton-modal">
                <label for="btn-modal">Enviar</label>
            </div>
        </div>
    </div>
</div>

<!-- Ventana modal mensaje -->
<input type="checkbox" id="btn-modal" />
<div class="container-modal">
    <div class="content-modal">
        <h2>Calificacion asignada</h2>
        <div class="btn-cerrar"></div>
    </div>
    <label for="btn-modal" class="cerrar-modal"></label>
</div>
</body>
</html>
