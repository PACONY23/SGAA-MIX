<%--
  Created by IntelliJ IDEA.
  User: EKT9962
  Date: 17/08/2024
  Time: 02:13 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>
<%@ page import ="mx.edu.utez.sgaa.database.DatabaseConnection"%>
<%@ page import="mx.edu.utez.sgaa.model.Asesoria"%>
<%if(request.getSession(false) != null && session.getAttribute("matricula") != null){
  if (!(request.getSession().getAttribute("role").toString().toLowerCase().equals("estudiante"))){
    response.sendRedirect(context + "/index.jsp");
    return;
  }
} else {
  response.sendRedirect(context + "/index.jsp");
  return;
}
%>
<%
  // Obtener el nombre de la materia y la lista de asesorías del atributo
  String nombreMateria = (String) request.getAttribute("nombreMateria");
  List<Asesoria> asesorias = (List<Asesoria>) request.getAttribute("asesorias");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
  <title>Asesorías</title>
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
    .barra-lateral .navegacion a:hover #materias-img {
      content: url('<%=context%>/IMG/materias_v.png'); /* Cambia la imagen al hacer hover */
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





    /*DISEÑO INTERFAZ */
    .busqueda {
      background-color: #141C32;
      color: white;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
    }
    .busqueda input {
      width: 100%;
      padding: 10px;
      border: none;
      border-radius: 5px;
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
        <a href="<%=context%>/vistas/Estudiante/PaginaPrincipalEstudiante.jsp" class="d-flex align-items-center">
          <img id="perfil-img" src="<%=context%>/IMG/perfil_b.png" class="img-fluid" style="width: auto; height: 35px;" />
          <span>Perfil</span>
        </a>
      </li>
      <li>
        <a href="<%=context%>/HorarioEstudianteS" class="d-flex align-items-center">
          <img id="calendario-img" src="<%=context%>/IMG/calendario_b.png" class="img-fluid" style="width: auto; height: 35px;" />
          <span>Mi calendario</span>
        </a>
      </li>
      <li>
        <a href="<%=context%>/vistas/Estudiante/HistorialEstudiante.jsp" class="d-flex align-items-center">
          <img id="historial-img" src="<%=context%>/IMG/historial_b.png" class="img-fluid" style="width: auto; height: 35px;" />
          <span>Historial</span>
        </a>
      </li>
      <li>
        <a href="<%=context%>/vistas/Estudiante/buscarMateria.jsp" class="d-flex align-items-center">
          <img id="buscador-img" src="<%=context%>/IMG/buscador_b.png" class="img-fluid" style="width: auto; height: 35px;" />
          <span>Buscar materias</span>
        </a>
      </li>
      <li>
        <a href="<%=context%>/vistas/Estudiante/Reagendas.jsp" class="d-flex align-items-center">
          <img id="materias-img" src="<%=context%>/IMG/materias_b.png" class="img-fluid" style="width: auto; height: 35px;" />
          <span>Reagendas</span>
        </a>
      </li>
      <li>
        <a href="<%=context%>/vistas/Estudiante/GestionAsesoriaEstudiante.jsp" class="d-flex align-items-center" >
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
    <span>Materias en curso</span>
  </div>
  <div class="rol-actual">
    <span class="rol" id="asigna_rol">Estudiante</span>
  </div>
</div>

<div class="contenido">
  <div class="main-container">
    <h4>Asesorías para la materia: <%= nombreMateria %></h4>

    <% if (asesorias != null && !asesorias.isEmpty()) { %>
    <table class="table table-striped table-hover">
      <thead>
      <tr>
        <th>Título</th>
        <th>Docente</th>
        <th>Fecha</th>
        <th>Hora</th>
      </tr>
      </thead>
      <tbody>
      <% for (Asesoria asesoria : asesorias) { %>
      <tr>
        <td><%= asesoria.getTitulo() %></td>
        <td><%= asesoria.getDocenteNombre() %> <%= asesoria.getDocenteApellido() %></td>
        <td><%= asesoria.getFecha() %></td>
        <td><%= asesoria.getHora() %></td>
      </tr>
      <% } %>
      </tbody>
    </table>
    <% } else { %>
    <div class="alert alert-info mt-4">No se encontraron asesorías para esta materia.</div>
    <% } %>
  </div>
</div>

</body>
</html>

