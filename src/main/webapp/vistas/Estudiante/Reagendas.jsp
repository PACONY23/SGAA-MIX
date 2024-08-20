<%--
  Created by IntelliJ IDEA.
  User: EKT9962
  Date: 17/08/2024
  Time: 04:52 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoAsesoria" %>
<%@ page import="mx.edu.utez.sgaa.model.Asesoria" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="mx.edu.utez.sgaa.database.DatabaseConnection"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String context = request.getContextPath(); %>
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

    List<Asesoria> historialAsesorias = new ArrayList<>();
    Connection connection = null;
    DaoAsesoria dao = null;

    try {
        // Obtener la conexión a la base de datos
        connection = DatabaseConnection.getConnection();
        dao = new DaoAsesoria(connection);

        // Obtener la lista de asesorías reagendadas para el estudiante
        if (idEstudiante != null) {
            try {
                historialAsesorias = dao.obtenerAsesoriasReagendaEstudiante(idEstudiante);
            } catch (SQLException e) {
                e.printStackTrace(); // Manejo de errores SQL
            }
        }
    } finally {
        // Cerrar la conexión si no es nula
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace(); // Manejo de errores al cerrar la conexión
            }
        }
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

    <title>Reagendas</title>
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
        #agregar-btn {
            background-color: rgba(0, 0, 0, 0.05); /* Mismo fondo que la caja de simbología */
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            color: #141C32; /* Color del texto */
            transition: background-color 0.3s ease;
        }

        #agregar-btn:hover {
            background-color: #5393d5; /* Hover recomendado: azul */
            color: white; /* Color de texto blanco en hover */
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
        <span>Mis reagendas</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Estudiante</span>
    </div>
</div>


<div class="contenido">
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th scope="col">Docente</th>
                <th scope="col">Materia</th>
                <th scope="col">Fecha</th>
                <th scope="col">Hora</th>
                <th scope="col" style="text-align: center">Acciones</th>
            </tr>
            </thead>
            <tbody id="materiasTableBody">
            <%
                if (historialAsesorias != null && !historialAsesorias.isEmpty()) {
                    for (Asesoria asesoria : historialAsesorias) {
            %>
            <tr id="materia-<%= asesoria.getIdAsesoria() %>" class="">
                <td><%= asesoria.getDocenteNombre() %> <%= asesoria.getDocenteApellido() %></td>
                <td><%= asesoria.getNombreMateria() %></td>
                <td><%= asesoria.getFecha() %></td>
                <td><%= asesoria.getHora() %></td>
                <td style="text-align: center">
                    <button id="materia-<%= asesoria.getIdAsesoria() %>" onclick="aceptarReagenda(<%= asesoria.getIdAsesoria() %>)" class="btn p-0">
                        <i class="bi bi-check-circle-fill" style="font-size: 25px; color: #1D815A;" data-bs-toggle="modal" data-bs-target="#aceptarReagendaModal"></i>
                    </button>
                    <button id="estado-<%= asesoria.getIdAsesoria() %>" onclick="rechazarReagenda(<%= asesoria.getIdAsesoria() %>)" class="btn p-0 ms-4">
                        <i class="bi bi-x-circle-fill" style="font-size: 25px; color: #145A42;" data-bs-toggle="modal" data-bs-target="#cancelarReagendaModal"></i>
                    </button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" class="text-center">No hay asesorías reagendadas disponibles.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>




<!-- Modal para rechazar reagenda -->
<div class="modal fade" id="cancelarReagendaModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="cancelarReagendaModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cancelarReagendaModalLabel">Confirmar rechazo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/RechazarReagendaS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="r_id" name="r_id" required>
                    <input type="hidden" id="e_id" name="e_id" required>
                    ¿Estás seguro de rechazar esta reagenda?
                    <label id="r_name" style="font-weight: bold"></label>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Rechazar</button>
                    <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal para aceptar reagenda -->
<div class="modal fade" id="aceptarReagendaModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="confirmarBorrarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarBorrarModalLabel">Confirmar reagenda</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/AceptarReagendaS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="d_id" name="d_id" required>
                    ¿Estás seguro de aceptar esta reagenda?
                    <label id="d_name" style="font-weight: bold"></label>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Aceptar</button>
                    <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    function aceptarReagenda(idAsesoria) {
        // Configurar el ID de la asesoría en el campo oculto
        document.getElementById('d_id').value = idAsesoria;

        // Opcional: Configurar el nombre de la asesoría en el modal
        const label = document.getElementById('d_name');
        label.textContent = `Asesoría con ID ${idAsesoria}`; // Ajusta según tus necesidades
    }
</script>
<script>
    function rechazarReagenda(idAsesoria) {
        // Configurar el ID de la asesoría en el campo oculto
        document.getElementById('r_id').value = idAsesoria;

        // Configurar el ID del estudiante en el campo oculto
        // Suponiendo que el ID del estudiante está disponible globalmente o de alguna otra manera
        const idEstudiante = '<%= idEstudiante %>'; // Asegúrate de que `idEstudiante` esté disponible en el JSP

        document.getElementById('e_id').value = idEstudiante;

        // Opcional: Configurar el nombre de la asesoría en el modal
        const label = document.getElementById('r_name');
        label.textContent = `Asesoría con ID ${idAsesoria}`; // Ajusta según tus necesidades
    }
</script>
</body>
</html>
