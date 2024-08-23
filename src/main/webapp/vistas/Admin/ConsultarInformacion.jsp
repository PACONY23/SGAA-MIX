<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoDocente" %>
<%@ page import="mx.edu.utez.sgaa.model.Docente" %>
<%@ page import="mx.edu.utez.sgaa.model.Estudiante" %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoEstudiante" %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoEstudianteAsesoria" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();
    if(request.getSession(false) != null && session.getAttribute("matricula") != null){
        if (!(request.getSession().getAttribute("role").toString().toLowerCase().equals("admin"))){
            response.sendRedirect(context + "/index.jsp");
            return;
        }
    } else {
        response.sendRedirect(context + "/index.jsp");
        return;
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

    <title>Gestión de usuarios</title>
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
        .barra-lateral .navegacion a:hover #materias-img {
            content: url('<%=context%>/IMG/materias_v.png'); /* Cambia la imagen al hacer hover */
        }
        .barra-lateral .navegacion a:hover #solicitud-acceso{
            content: url('<%=context%>/IMG/solicitud_v.png'); /* Cambia la imagen al hacer hover */
        }
        .barra-lateral .navegacion a:hover #asesorias-img{
            content: url('<%=context%>/IMG/asesorias_v.png'); /* Cambia la imagen al hacer hover */
        }
        .barra-lateral .navegacion a:hover #historial-img {
            content: url('<%=context%>/IMG/historial_v.png'); /* Cambia la imagen al hacer hover */
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
                <a href="<%=context%>/vistas/Admin/PaginaPrincipalAdmin.jsp" class="d-flex align-items-center">
                    <img id="perfil-img" src="<%=context%>/IMG/perfil_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Perfil</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/GestionDeMaterias.jsp" class="d-flex align-items-center">
                    <img id="materias-img" src="<%=context%>/IMG/materias_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Gestión de materias</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/AprobarRegistro.jsp" class="d-flex align-items-center" >
                    <img id="solicitud-acceso" src="<%=context%>/IMG/solicitud_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Solicitud de acceso</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/ConsultarInformacion.jsp" class="d-flex align-items-center" >
                    <img id="historial-img" src="<%=context%>/IMG/historial_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Información de usuarios</span>
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
        <span>Gestión de usuarios</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Administrador</span>
    </div>
</div>

<div class="contenido">
    <!-- Título DOCENTES -->
    <div class="text-center mb-4">
        <h5 class="fw-bold" style="font-family: 'Poppins', sans-serif; color: #141C32;">Docentes</h5>
        <hr style="width: 50px; border: 2px solid #141C32; margin: auto;">
    </div>

    <div class="table-responsive mb-5">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th scope="col">Correo</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido</th>
                <th scope="col" style="text-align: center">Editar</th>
                <th scope="col" style="text-align: center">Estado</th>
                <th scope="col" style="text-align: center">Calificación</th>
            </tr>
            </thead>
            <tbody id="materiasTableBody">
            <%
                DaoDocente docentesLista = new DaoDocente();
                List<Docente> docentes = docentesLista.listarDocentes();
                for (Docente docente : docentes) {
                    String rowClass = !docente.isEstatus() ? "table-active" : "table-primary";
            %>

            <tr id="materia-<%=docente.getId()%>" class="<%= rowClass %>">
                <td><%=docente.getMatricula() %></td>
                <td><%=docente.getNombres() %></td>
                <td><%=docente.getApellidos() %></td>
                <td style="text-align: center">
                    <button id="materia-<%=docente.getId()%>" onclick="cargarDatosDocente(<%=docente.getId()%>, '<%=docente.getNombres()%>', '<%=docente.getApellidos()%>', '<%=docente.getContrasena()%>')" class="btn p-0">
                        <i class="bi bi-pencil-fill" style="font-size: 25px; color: black;" data-bs-toggle="modal" data-bs-target="#editarDocente"></i>
                    </button>
                </td>

                <td style="text-align: center">
                    <button id="estado-<%=docente.isEstatus()%>" onclick="estadoDocente(<%=docente.getId()%>)" class="btn btn-outline-secondary ms-4" data-bs-toggle="modal" data-bs-target="#estadoDocente">
                         <span class="small">
                              <%= !docente.isEstatus() ? "Habilitar" : "Deshabilitar" %>
                         </span>
                    </button>
                </td>
                <%
                    DaoEstudianteAsesoria dao1 = new DaoEstudianteAsesoria();
                    float calificacion =dao1.verDocentesCalificacio(docente.getId());
                %>
                    <% if(calificacion==0.0){ %>
                <td style="align-content: center; text-align: center">S/C</td> <%}else{ %>
                <td style="align-content: center; text-align: center"><%=calificacion%></td>
           <% }%>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <!-- Título ESTUDIANTES -->
    <div class="text-center mb-4">
        <h5 class="fw-bold" style="font-family: 'Poppins', sans-serif; color: #141C32;">Estudiantes</h5>
        <hr style="width: 50px; border: 2px solid #141C32; margin: auto;">
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th scope="col">Correo</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido</th>
                <th scope="col">Grupo</th>
                <th scope="col">Cuatrimestre</th>
                <th scope="col" style="text-align: center">Editar</th>
                <th scope="col" style="text-align: center">Estado</th>
                <th scope="col" style="text-align: center">Calificacion</th>

            </tr>
            </thead>
            <tbody id="estudiantesTableBody">
            <%
                DaoEstudiante estudiantesLista  = new DaoEstudiante();
                List<Estudiante> estudiantes = estudiantesLista.listarEstudiantes();
                for (Estudiante estudiante : estudiantes) {
                    String rowClass = !estudiante.isEstatus() ? "table-active" : "table-primary";
                    System.out.println("ID del estudiante: " + estudiante.getId());
            %>
            <%
                DaoEstudianteAsesoria dao1 = new DaoEstudianteAsesoria();
                float calificacionE =dao1.verEstudianteCalificacio(estudiante.getId());
            %>
            <tr id="materia-<%=estudiante.getId()%>" class="<%= rowClass %>">
                <td><%=estudiante.getMatricula() %></td>
                <td><%=estudiante.getNombre() %></td>
                <td><%=estudiante.getApellido() %></td>
                <td><%=estudiante.getGrupo() %></td>
                <td><%=estudiante.getCuatrimestre()%></td>
                <td style="text-align: center">
                    <button id="materia-<%=estudiante.getId()%>" onclick="cargarDatosEstudiante(<%=estudiante.getId()%>, '<%=estudiante.getNombre()%>', '<%=estudiante.getApellido()%>', '<%=estudiante.getGrupo()%>', '<%=estudiante.getCuatrimestre()%>', '<%=estudiante.getContrasena()%>')" class="btn p-0">
                        <i class="bi bi-pencil-fill" style="font-size: 25px; color: black;" data-bs-toggle="modal" data-bs-target="#editarEstudiante"></i>
                    </button>
                </td>
                <td style="text-align: center">
                    <button id="estado-<%=estudiante.isEstatus()%>" onclick="estadoEstudiante(<%=estudiante.getId()%>)" class="btn btn-outline-secondary ms-4" data-bs-toggle="modal" data-bs-target="#estadoEstudiante">
                         <span class="small">
                              <%= !estudiante.isEstatus() ? "Habilitar" : "Deshabilitar" %>
                         </span>
                    </button>
                </td>
                <% if(calificacionE==0.0){ %>
                <td style="align-content: center; text-align: center">S/C</td> <%}else{ %>
                <td style="align-content: center; text-align: center"><%=calificacionE%></td>
                <% }%>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>




<%-- modal cambio estado docente --%>
<div class="modal fade" id="estadoDocente" data-bs-backdrop="static" tabindex="-1" aria-labelledby="confirmarEstadoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarEstadoModalLabel">Cambio del estado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/EstadoDocenteS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="ch_id" name="ch_id">
                    ¿Estás seguro de que deseas realizar este cambio?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-danger">Cambiar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- modal editar docente --%>
<div class="modal fade" id="editarDocente" data-bs-backdrop="static" tabindex="-1" aria-labelledby="confirmarBorrarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarBorrarModalLabel">Editar docente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="formEditarDocente" action="<%=context%>/ActualizarDocenteAdmin" method="post">
                <div class="modal-body">
                    <input type="hidden" id="u_id" name="u_id">
                    <div class="mb-3">
                        <label for="nombres" class="form-label">Nombre</label>
                        <input type="text" class="form-control" name="nombres" id="nombres" placeholder="nombre" required>
                        <div id="nombresError" class="text-danger" style="display:none;">El nombre debe tener al menos 3 letras y no puede contener números.</div>
                    </div>
                    <div class="mb-3">
                        <label for="apellidos" class="form-label">Apellido</label>
                        <input type="text" class="form-control" name="apellidos" id="apellidos" placeholder="apellido" required>
                        <div id="apellidosError" class="text-danger" style="display:none;">El apellido debe tener al menos 3 letras y no puede contener números.</div>
                    </div>
                    <div class="mb-3">
                        <label for="contrasena" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" name="contrasena" id="contrasena" placeholder="Contraseña" required>
                        <div id="contrasenaError" class="text-danger" style="display:none;">La contraseña debe tener al menos 3 caracteres.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger" id="guardarCambiosBtn" disabled>Confirmar cambios</button>
                    <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- modal cambio estado estudiante --%>
<div class="modal fade" id="estadoEstudiante" data-bs-backdrop="static" tabindex="-1" aria-labelledby="confirmarrEstadoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarrEstadoModalLabel">Cambio del estado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/EstadoEstudianteS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="ch_id_e" name="ch_id_e">
                    ¿Estás seguro de que deseas realizar este cambio?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-danger">Cambiar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal editar estudiante -->
<div class="modal fade" id="editarEstudiante" data-bs-backdrop="static" tabindex="-1" aria-labelledby="confirmarrBorrarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarrBorrarModalLabel">Editar estudiante</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="formEditarEstudiante" action="<%=context%>/ActualizarEstudianteAdmin" method="post">
                <div class="modal-body">
                    <input type="hidden" id="u_id_e" name="u_id_e">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Nombre" required>
                        <div id="nombreError" class="text-danger" style="display:none;">El nombre debe tener al menos 3 letras y no puede contener números.</div>
                    </div>
                    <div class="mb-3">
                        <label for="apellido" class="form-label">Apellido</label>
                        <input type="text" class="form-control" name="apellido" id="apellido" placeholder="Apellido" required>
                        <div id="apellidoError" class="text-danger" style="display:none;">El apellido debe tener al menos 3 letras y no puede contener números.</div>
                    </div>
                     <div class="mb-3">
                        <label for="grupo" class="form-label">Grupo</label>
                        <select class="form-control" name="grupo" id="grupo" required>
                            <option value="" disabled selected>Seleccione un grupo</option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                            <option value="E">E</option>
                            <option value="F">F</option>
                            <option value="G">G</option>
                        </select>
                        <div id="grupoError" class="text-danger" style="display:none;">Debe seleccionar un grupo.</div>
                    </div>

                    <div class="mb-3">
                        <label for="cuatrimestre" class="form-label">Cuatrimestre</label>
                        <select class="form-control" name="cuatrimestre" id="cuatrimestre" required>
                            <option value="" disabled selected>Seleccione un cuatrimestre</option>
                            <option value="1">1er Cuatrimestre</option>
                            <option value="2">2do Cuatrimestre</option>
                            <option value="3">3er Cuatrimestre</option>
                            <option value="4">4to Cuatrimestre</option>
                            <option value="5">5to Cuatrimestre</option>
                        </select>
                        <div id="cuatrimestreError" class="text-danger" style="display:none;">Debe seleccionar un cuatrimestre.</div>
                    </div>

                    <div class="mb-3">
                        <label for="contrasena_e" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" name="contrasena_e" id="contrasena_e" placeholder="Contraseña" required>
                        <div id="contrasenaError_e" class="text-danger" style="display:none;">La contraseña debe tener al menos 3 caracteres.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger" id="guardarCambiosBtn_e" disabled>Confirmar cambios</button>
                    <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    function estadoDocente(id) {
        document.getElementById('ch_id').value = id;
    }
    function estadoEstudiante(id) {
        document.getElementById('ch_id_e').value = id;
    }

    //parte del docente
    function cargarDatosDocente(id, nombres, apellidos, matricula) {
        document.getElementById('u_id').value = id;  // Asigna el ID del docente al campo oculto
        document.getElementById('nombres').value = nombres;  // Asigna los nombres al input
        document.getElementById('apellidos').value = apellidos;  // Asigna los apellidos al input
        document.getElementById('contrasena').value = matricula;  // Puedes modificar esto para otro dato si es necesario
    }

    document.addEventListener('DOMContentLoaded', () => {
        const form = document.getElementById('formEditarDocente');
        const nombresInput = document.getElementById('nombres');
        const apellidosInput = document.getElementById('apellidos');
        const contrasenaInput = document.getElementById('contrasena');
        const submitButton = document.getElementById('guardarCambiosBtn');

        const nombresError = document.getElementById('nombresError');
        const apellidosError = document.getElementById('apellidosError');
        const contrasenaError = document.getElementById('contrasenaError');

        const validateForm = () => {
            let isValid = true;

            // Validar nombres (mínimo 3 letras, solo letras y acentos permitidos)
            const namePattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]{3,}$/;
            if (!namePattern.test(nombresInput.value.trim())) {
                nombresError.style.display = 'block';
                isValid = false;
            } else {
                nombresError.style.display = 'none';
            }

            // Validar apellidos (mínimo 3 letras, solo letras y acentos permitidos)
            if (!namePattern.test(apellidosInput.value.trim())) {
                apellidosError.style.display = 'block';
                isValid = false;
            } else {
                apellidosError.style.display = 'none';
            }

            // Validar que la contraseña tenga al menos 3 caracteres
            if (contrasenaInput.value.trim().length < 3) {
                contrasenaError.style.display = 'block';
                isValid = false;
            } else {
                contrasenaError.style.display = 'none';
            }

            submitButton.disabled = !isValid;
        };

        form.addEventListener('input', validateForm);
    });


    function cargarDatosEstudiante(id, nombre, apellido, contrasena, grupo, cuatrimestre) {
        document.getElementById('u_id_e').value = id;  // Asigna el ID del estudiante al campo oculto
        document.getElementById('nombre').value = nombre;  // Asigna el nombre al input
        document.getElementById('apellido').value = apellido;  // Asigna el apellido al input
        document.getElementById('grupo').value = grupo;
        document.getElementById('cuatrimestre').value = cuatrimestre;
        document.getElementById('contrasena_e').value = contrasena;  // Asigna la contraseña al input
        console.log("Datos recibidos:", id, nombre, apellido, contrasena, grupo, cuatrimestre); // Para verificar los datos

    }

    document.addEventListener('DOMContentLoaded', () => {
        const form = document.getElementById('formEditarEstudiante');
        const nombreInput = document.getElementById('nombre');
        const apellidoInput = document.getElementById('apellido');
        const contrasenaInput = document.getElementById('contrasena_e');
        const grupoSelect = document.getElementById('grupo');
        const cuatrimestreSelect = document.getElementById('cuatrimestre');
        const submitButton = document.getElementById('guardarCambiosBtn_e');

        const nombreError = document.getElementById('nombreError');
        const apellidoError = document.getElementById('apellidoError');
        const contrasenaError = document.getElementById('contrasenaError_e');
        const grupoError = document.getElementById('grupoError');
        const cuatrimestreError = document.getElementById('cuatrimestreError');

        const validateForm = () => {
            let isValid = true;

            // Validar nombre (mínimo 3 letras, solo letras y acentos permitidos)
            const namePattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]{3,}$/;
            if (!namePattern.test(nombreInput.value.trim())) {
                nombreError.style.display = 'block';
                isValid = false;
            } else {
                nombreError.style.display = 'none';
            }

            // Validar apellido (mínimo 3 letras, solo letras y acentos permitidos)
            if (!namePattern.test(apellidoInput.value.trim())) {
                apellidoError.style.display = 'block';
                isValid = false;
            } else {
                apellidoError.style.display = 'none';
            }

            // Validar que la contraseña tenga al menos 3 caracteres
            if (contrasenaInput.value.trim().length < 3) {
                contrasenaError.style.display = 'block';
                isValid = false;
            } else {
                contrasenaError.style.display = 'none';
            }

            // Validar que se haya seleccionado un grupo
            if (grupoSelect.value === "") {
                grupoError.style.display = 'block';
                isValid = false;
            } else {
                grupoError.style.display = 'none';
            }

            // Validar que se haya seleccionado un cuatrimestre
            if (cuatrimestreSelect.value === "") {
                cuatrimestreError.style.display = 'block';
                isValid = false;
            } else {
                cuatrimestreError.style.display = 'none';
            }

            submitButton.disabled = !isValid;
        };

        form.addEventListener('input', validateForm);
    });
</script>

</body>
</html>
