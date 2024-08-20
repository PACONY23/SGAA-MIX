<%--
  Created by IntelliJ IDEA.
  User: pilih
  Date: 24/07/2024
  Time: 10:18 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.model.HistorialAsesoria" %>

<%@ page import="mx.edu.utez.sgaa.dao.DaoEstudianteAsesoria" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%if(request.getSession(false) != null && session.getAttribute("matricula") != null){
    if (!(request.getSession().getAttribute("role").toString().toLowerCase().equals("docente"))){
      response.sendRedirect(context + "/index.jsp");
      return;
    }
  } else {
    response.sendRedirect(context + "/index.jsp");
    return;
  }
%>
<%
  // Obtener el atributo de la sesión
  String idDocenteStr = (String) session.getAttribute("idDocente");
  Integer idDocente = null;

  if (idDocenteStr != null) {
    try {
      idDocente = Integer.parseInt(idDocenteStr);
    } catch (NumberFormatException e) {
      e.printStackTrace(); // Manejar el error de conversión si es necesario
    }
  } else {
    idDocente = 0; // Valor por defecto si no está en la sesión
  }

%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <%--<link rel="stylesheet" href="<%=context%>/css/cssPlantillaBarra.css" >--%>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <%--<link rel="stylesheet" href="<%=context%>/css/cssBarraDocente.css" /> --%>
  <title>Historial docente</title>
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



    /*DISEÑO INTERFAZ*/
    .table-responsive {
      background-color: #13AC80;
      border-radius: 10px;
      padding: 20px;
      color: white;
    }

    .table th, .table td {
      color: white;
    }
    .table a{
      text-decoration: none;

    }
    .table .agregar {
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
      margin-left: 17px;
    }
    .boton-cerrar-sesion:hover {
      background-color: #fff;
      color: #141C32;
    }
  </style>
</head>
<body>
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
<div class="contenido-superior">
  <div class="titulo-interfaz">
    <span>Mi historial</span>
  </div>
  <div class="rol-actual">
    <span class="rol" id="asigna_rol">Docente</span>
  </div>
</div>

<div class="contenido">
  <div class="table-responsive">
    <table class="table">
      <thead>
      <tr>
        <th>Estudiante</th>
        <th>Materia</th>
        <th>Fecha</th>
        <th>Hora</th>
        <th>Calificación</th>
        <th></th>
      </tr>
      </thead>
      <%


        // Consultar la base de datos usando el DAO
        List<HistorialAsesoria> historialAsesorias = new ArrayList<>();
        if (idDocente != null) {
          try {
            DaoEstudianteAsesoria dao = new DaoEstudianteAsesoria();
            historialAsesorias = dao.obtenerHistorialAsesoriasPorDocente(idDocente);
          } catch (SQLException e) {
            e.printStackTrace(); // Manejo de errores
          }
        }
      %>
      <%
        if (historialAsesorias != null && !historialAsesorias.isEmpty()) {
          for (HistorialAsesoria asesoria : historialAsesorias) {
      %>
      <tr>
        <td><%= asesoria.getNombreEstudiante() %></td>
        <td><%= asesoria.getNombreMateria() %></td>
        <td><%= asesoria.getFecha() %></td>
        <td><%= asesoria.getHora() %></td>
        <td>
          <!-- Aquí puedes agregar el enlace o el formulario para calificar -->
          <a href="<%=request.getContextPath()%>/vistas/Docente/CalificarEstudiante.jsp">
            <div class="agregar">+</div>
          </a>
        </td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="6">No hay datos disponibles</td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>