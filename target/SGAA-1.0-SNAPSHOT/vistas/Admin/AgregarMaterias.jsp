<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
  <%--<link rel="stylesheet" href="<%=context%>/css/cssPlantillaBarra.css">--%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
      <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">

    <title>Agregar Materia admin</title>
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
            padding: 20px 15px;
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
            margin-top: 15px;
        }
        .barra-lateral .nombre-pagina img{
            min-width: 70px;
            margin-left: 10px;
            font-size: 50px;
            cursor: pointer;
        }
        .barra-lateral .nombre-pagina span{
            font-size: larger;
            opacity: 1;
            color: white;
            transition: opacity 0.5s ease;
        }

        /*Menu de navegacion*/
        .barra-lateral .navegacion{
            margin-top: 50px;
        }
        .barra-lateral .navegacion li{
            margin-top: 20px;
            list-style: none;
            display: flex;
            margin-bottom: 5px;
        }
        .barra-lateral .navegacion span{
            margin-left: 33px;
        }
        .barra-lateral .navegacion a{
            width: 100%;
            height: 50px;
            margin-left: 13px;
            display: flex;
            align-items: center;
            text-decoration: none;
            border-radius: 10px;
            color: white;
        }
        .barra-lateral .navegacion a:hover{
            margin-right: 0%;
            background-color: white;
            border-radius: 15px;
            color: #141C32;
        }
        .barra-lateral .navegacion img{
            min-height: 45px;
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


        /*diseño interfaz*/
        .tarjeta {
            background-color: #13AC80;
            border-radius: 10px;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            margin-left: 20px;
            margin-right: 20px;
            color: white;
        }
        .tarjeta .info {
            display: flex;
            flex-direction: column;
        }
        .tarjeta .info h2 {
            margin: 0;
            font-size: 18px;
        }
        .tarjeta .info p {
            margin: 5px 0 0 0;
            font-size: 14px;
        }
        .tarjeta .agregar {
            background-color: #141C32;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            color: white;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="barra-lateral">
    <div class="nombre-pagina">
        <img src="logo_utez.jpg" id="cloud" style="width: 50px" />
        <span>UTESORATE</span>
    </div>
    <nav class="navegacion">
        <ul>
            <li>
                <a href="<%=context%>/vistas/Admin/PaginaPrincipalAdmin.jsp">
                    <img src="logo_utez.jpg" />
                    <span>Perfil</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/GestionDeMaterias.jsp">
                    <img src="logo_utez.jpg" />
                    <span>Gestión de materias</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/AprobarRegistro.jsp">
                    <img src="logo_utez.jpg" />
                    <span>Aprobar docente</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/GestionAsesorias.jsp">
                <img src="logo_utez.jpg" />
                    <span>Gestión de asesorías</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/ConsultarInformacion.jsp">">
                    <img src="logo_utez.jpg" />
                    <span>Información de usuarios</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/">
                    <img src="logo_utez.jpg" />
                    <span>Estadísticas</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
      <div class="contenido-superior">
        <div class="titulo-interfaz">
          <span>Agregar materia</span>
        </div>
        <div class="rol-actual">
          <span class="rol" id="asigna_rol">Administrador</span>
          <img src="imagenes/busqueda.png" alt="rol" />
        </div>
      </div>

    <div class="contenido">
        <div class="tarjeta">
            <div class="info">
                <h2>Nueva materia</h2>
                <p>Espacio para agregar materia</p>
            </div>
            <div class="agregar"><button id="agregar-btn" data-toggle="modal" data-target="#agregarModal">+</button></div>
        </div>
        <div class="tarjeta">
            <div class="info">
                <h2>Nueva materia</h2>
                <p>Espacio para agregar materia</p>
            </div>
            <div class="agregar">+</div>
        </div>
        <div class="tarjeta">
            <div class="info">
                <h2>Nueva materia</h2>
                <p>Espacio para agregar materia</p>
            </div>
            <div class="agregar">+</div>
        </div>
        <div class="tarjeta">
            <div class="info">
                <h2>Nueva materia</h2>
                <p>Espacio para agregar materia</p>
            </div>
            <div class="agregar">+</div>
        </div>
        <div class="tarjeta">
            <div class="info">
                <h2>Nueva materia</h2>
                <p>Espacio para agregar materia</p>
            </div>
            <div class="agregar">+</div>
        </div>
    </div>
</body>
</html>

