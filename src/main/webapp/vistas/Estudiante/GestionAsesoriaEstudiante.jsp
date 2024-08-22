<%--
  Created by IntelliJ IDEA.
  User: EKT9962
  Date: 20/08/2024
  Time: 09:39 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String context = request.getContextPath(); %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoAsesoria" %>
<%@ page import="mx.edu.utez.sgaa.model.Asesoria" %>
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
    // Obtener el atributo de la sesión
    String idEstudianteStr = (String) session.getAttribute("idEstudiante");
    Integer idEstudiante = null;

    if (idEstudianteStr != null) {
        try {
            idEstudiante = Integer.parseInt(idEstudianteStr);
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Manejar el error de conversión si es necesario
        }
    } else {
        // Valor por defecto si no está en la sesión
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">

    <title>Gestión asesorías</title>
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



        /*DISEÑO INTERFAZ*/
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
        }
        .table-bordered {
            border: 1px solid #dee2e6;
            border-radius: 15px;
            overflow: hidden; /* Para que las celdas dentro de la tabla también se adapten al borde redondeado */
        }

        .table-bordered th, .table-bordered td {
            border: 1px solid #dee2e6;
        }

        .table-responsive {
            border-radius: 15px;
            overflow: hidden; /* Para mantener los bordes redondeados si hay contenido adicional */
            border-top: 2px solid #141C32; /* Borde más grueso o más oscuro en la parte superior */
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
        <span>Mis asesorias</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Estudiante</span>
    </div>
</div>
<div class="contenido">
    <!-- Tabla de asesorías no iniciadas -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="d-flex align-items-center">
            <div class="p-2" style="border: 1px solid #dee2e6; border-radius: 0.25rem; background-color: rgba(0, 0, 0, 0.05);">
                <span class="badge me-1" style="background-color: #0d6efd; width: 12px; height: 12px; border-radius: 50%; display: inline-block;"></span> En curso
                <span class="badge ms-3" style="background-color: #6c757d; width: 12px; height: 12px; border-radius: 50%; display: inline-block;"></span> Sin iniciar
            </div>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover table-primary">
            <thead>
            <tr>
                <th colspan="5" style="text-align: center; background-color: #f8f9fa;">Pendientes</th>
            </tr>
            <tr style="background-color: #0d6efd; color: white;">
                <th scope="col">Titulo asesoría</th>
                <th scope="col" style="text-align: center">Materia</th>
                <th scope="col" style="text-align: center"> Docente asignado </th>
                <th scope="col">Fecha</th>
                <th scope="col">Hora</th>

            </tr>
            </thead>
            <tbody id="materiasTableBody">
            <%
                if (idEstudiante != null && idEstudiante > 0) {
                    DaoAsesoria daoAsesoria = new DaoAsesoria();
                    List<Asesoria> asesoriasNoIniciadas = daoAsesoria.obtenerAsesoriasNoIniciadasPorEstudiante(idEstudiante);

                    for (Asesoria asesoria : asesoriasNoIniciadas) {
            %>
            <tr style="background-color: #ffffff; color: #000000;">
                <td style="background-color: #ffffff; color: #000000;"><%=asesoria.getTitulo() %></td>
                <td style="background-color: #ffffff; color: #000000; text-align: center;"><%=asesoria.getNombreMateria() %></td>
                <td style="background-color: #ffffff; color: #000000; text-align: center;"><%=asesoria.getDocenteNombre() %></td>
                <td style="background-color: #ffffff; color: #000000;"><%=asesoria.getFecha() %></td>
                <td style="background-color: #ffffff; color: #000000;"><%=asesoria.getHora() %></td>

            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>

    <!-- Tabla de asesorías iniciadas -->
    <div class="d-flex justify-content-between align-items-center mb-3 mt-5">
        <div class="d-flex align-items-center">

        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover table-primary">
            <thead>
            <tr>
                <th colspan="5" style="text-align: center; background-color: #f8f9fa;">En curso</th>
            </tr>
            <tr style="background-color: #0d6efd; color: white;">
                <th scope="col">Titulo asesoría</th>
                <th scope="col" style="text-align: center">Materia</th>
                <th scope="col" style="text-align: center">Docente asignado</th>
                <th scope="col">Fecha</th>
                <th scope="col">Hora</th>
                <!-- Columna para los botones -->
            </tr>
            </thead>
            <tbody id="asesoriasIniciadasTableBody">
            <%
                if (idEstudiante != null && idEstudiante > 0) {
                    DaoAsesoria daoAsesoria = new DaoAsesoria();
                    List<Asesoria> asesoriasIniciadas = daoAsesoria.obtenerAsesoriasIniciadasPorEstudiante(idEstudiante);

                    for (Asesoria asesoria : asesoriasIniciadas) {
            %>
            <tr>
                <td><%=asesoria.getTitulo() %></td>
                <td style="text-align: center;"><%=asesoria.getNombreMateria() %></td>
                <td style="text-align: center;"><%=asesoria.getDocenteNombre() %></td>
                <td><%=asesoria.getFecha() %></td>
                <td><%=asesoria.getHora() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>