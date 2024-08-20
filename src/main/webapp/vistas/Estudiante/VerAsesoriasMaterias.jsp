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

    .main-container {
      background-color: #141C32; /* Fondo oscuro */
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
      text-align: center;
      width: 80%;
      max-width: 1200px;
      margin: 80px 20px;
    }

    .main-container h1 {
      margin: 0;
      color: #FFFFFF;
      font-size: 28px;
    }

    .main-container table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      background-color: #1E2B46;
      color: #FFFFFF;
    }

    .main-container table th,
    .main-container table td {
      padding: 12px;
      border: 1px solid #1D815A;
    }

    .main-container table th {
      background-color: #1D815A;
    }

    .main-container table td {
      background-color: #145A42;
    }

    .no-asesorias {
      background-color: #1D815A;
      color: #FFFFFF;
      padding: 20px;
      border-radius: 10px;
      margin-top: 20px;
    }
  </style>
</head>
<body>
<div class="top-bar">
  <button type="button" class="btn btn-outline-secondary" onclick="window.history.back();">
    <i class="bi bi-arrow-left-circle" style="font-size: 25px; color: black;"></i> Regresar
  </button>
</div>


<div class="main-container">
  <h1>Asesorías para la materia: <%= nombreMateria %></h1>
  <% if (asesorias != null && !asesorias.isEmpty()) { %>
  <table>
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
  <div class="no-asesorias">No se encontraron asesorías para esta materia.</div>
  <% } %>
</div>
</body>
</html>

