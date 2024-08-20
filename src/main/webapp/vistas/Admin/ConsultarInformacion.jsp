<%@ page import="mx.edu.utez.sgaa.model.Docente" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.model.Estudiante" %>
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
    <%--<link rel="stylesheet" href="<%=context%>/css/cssPlantillaBarra.css" />--%>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="<%=context%>/css/cssFuenteLetra.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Consulta Información</title>
    <style>
        :root {
            --bs-body-font-family: 'Poppins', sans-serif !important;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            margin: 0;
            height: 100vh;
            width: 100%;
            background-color: white;
            display: flex;
            font-family: 'Poppins', sans-serif;
        }
        .contenido {
            width: calc(100% - 300px);
            margin-top: 100px;
            height: auto;
            margin-left: 270px;
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
        .barra-lateral .nombre-pagina {
            width: 100%;
            height: 45px;
            display: flex;
            align-items: center;
            margin-top: 35px;
        }
        .barra-lateral .nombre-pagina img {
            margin-left: 15px;
            font-size: 50px;
        }
        .barra-lateral .nombre-pagina span {
            font-size: larger;
            opacity: 1;
            color: white;
            margin-left: 12px;
            transition: opacity 0.5s ease;
        }
        .barra-lateral .navegacion {
            margin-top: 50px;
            margin-right: 0;
            margin-left: 20px;
        }
        .barra-lateral .navegacion li {
            margin-top: 20px;
            list-style: none;
            display: flex;
            margin-bottom: 5px;
            margin-right: 0;
        }
        .barra-lateral .navegacion span {
            margin-left: 25px;
        }
        .barra-lateral .navegacion a {
            width: 100%;
            height: 50px;
            margin-left: 10px;
            display: flex;
            text-decoration: none;
            border-radius: 25px;
            color: white;
            transition: background-color 0.3s ease, color 0.3s ease, border-radius 0.3s ease;
        }
        .barra-lateral .navegacion a:hover {
            margin-right: 0;
            background-color: white;
            color: #141C32;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }
        .barra-lateral .navegacion a:hover #perfil-img {
            content: url('<%=context%>/IMG/perfil_v.png');
        }
        .barra-lateral .navegacion a:hover #materias-img {
            content: url('<%=context%>/IMG/materias_v.png');
        }
        .barra-lateral .navegacion a:hover #solicitud-acceso {
            content: url('<%=context%>/IMG/solicitud_v.png');
        }
        .barra-lateral .navegacion a:hover #asesorias-img {
            content: url('<%=context%>/IMG/asesorias_v.png');
        }
        .barra-lateral .navegacion a:hover #historial-img {
            content: url('<%=context%>/IMG/historial_v.png');
        }
        .barra-lateral .navegacion a:hover #logout-img {
            content: url('<%=context%>/IMG/logout_v.png'); /* Cambia la imagen al hacer hover */
        }

        .barra-lateral .navegacion img {
            margin-left: 15px;
        }
        .contenido-superior {
            width: calc(100% - 250px);
            height: 100px;
            overflow: hidden;
            background-color: white;
            padding: 32px 15px;
            margin-left: 250px;
            position: fixed;
        }
        .titulo-interfaz {
            width: 400px;
            height: 100px;
            font-weight: bold;
        }
        .titulo-interfaz span {
            font-size: xx-large;
            color: #141C32;
        }
        .rol-actual {
            position: fixed;
            top: 15px;
            right: 15px;
            padding: 10px 15px;
            border-radius: 5px;
            display: flex;
            align-items: center;
        }
        .rol-actual img {
            width: 40px;
            height: 40px;
        }
        .rol-actual span {
            color: #141C32;
            font-size: small;
            margin-right: 10px;
            margin-bottom: 20px;
            align-items: center;
        }
        .cuadro-contenido {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }
        .cuadro {
            background-color: #141C32;
            padding: 20px;
            border-radius: 20px;
            color: white;
            width: 100%;
            max-width: 400px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }
        .cuadro h2 {
            margin: 0 0 20px 0;
            font-size: 1.5em;
        }
        .cuadro input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #141C32;
            color: white;
            border: 1px solid #fff;
            border-radius: 5px;
        }
        .cuadro .botones-container {
            display: flex;
            flex-direction: column;
            width: 100%;
            gap: 10px;
        }
        .cuadro .botones-container button {
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            background-color: #1D815A;
            color: white;
            cursor: pointer;
            width: 100%;
            text-align: center;
        }
        .cuadro .botones-container button:hover {
            background-color: #145A42;
        }
        .cuadro .lista-usuarios {
            width: 100%;
            margin-top: 20px;
        }
        .cuadro .lista-usuarios ul {
            list-style: none;
            padding: 0;
        }
        .cuadro .lista-usuarios ul li {
            background-color: #f8f9fa;
            color: #333;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 5px;
            display: flex;
            justify-content: space-between;
        }
        .cuadro .lista-usuarios ul li span.estatus {
            font-weight: bold;
            color: red;
        }
    </style>
</head>
<body>
<!-- Barra lateral -->
<div class="barra-lateral">
    <div class="nombre-pagina">
        <img src="<%=context%>/IMG/logoCalendario.png" id="cloud" class="img-fluid" style="height: 40px; width: auto" />
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
                <a href="<%=context%>/vistas/Admin/AprobarRegistro.jsp" class="d-flex align-items-center">
                    <img id="solicitud-acceso" src="<%=context%>/IMG/solicitud_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Solicitud de acceso</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/ConsultarInformacion.jsp" class="d-flex align-items-center">
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
        <span></span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Administrador</span>
    </div>
</div>

<div class="contenido">
    <div class="cuadro-contenido">
        <div class="cuadro">
            <h2>Consulta de Docentes</h2>
            <input id="matricula-docente" type="text" placeholder="Matrícula del docente">
            <div class="botones-container">
                <button id="consultar-docente-btn" data-toggle="modal" data-target="#consultarDocenteModal">Consultar</button>
                <button id="editar-docente-btn" data-toggle="modal" data-target="#editarDocenteModal">Editar</button>
                <button id="desactivar-docente-btn">Deshabilitar</button>
                <button id="activar-docente-btn">Habilitar</button>
            </div>
            <div class="lista-usuarios">
                <ul id="lista-docentes"></ul>
            </div>
        </div>
        <div class="cuadro">
            <h2>Consulta de Estudiantes</h2>
            <input id="matricula-estudiante" type="text" placeholder="Matrícula del estudiante">
            <div class="botones-container">
                <button id="consultar-estudiante-btn" data-toggle="modal" data-target="#consultarEstudianteModal">Consultar</button>
                <button id="editar-estudiante-btn" data-toggle="modal" data-target="#editarEstudianteModal">Editar</button>
                <button id="desactivar-estudiante-btn">Deshabilitar</button>
                <button id="activar-estudiante-btn">Habilitar</button>
            </div>
            <div class="lista-usuarios">
                <ul id="lista-estudiantes"></ul>
            </div>
        </div>
    </div>

</div>

<!-- Modal de consulta Docente -->
<div class="modal fade" id="consultarDocenteModal" tabindex="-1" role="dialog" aria-labelledby="consultarDocenteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="consultarDocenteModalLabel">Información del Docente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="modalDocenteNombre">Nombre:</label>
                            <input type="text" id="modalDocenteNombre" class="form-control" readonly>
                        </div>
                        <div class="col-md-4">
                            <label for="modalDocenteApellido">Apellido:</label>
                            <input type="text" id="modalDocenteApellido" class="form-control" readonly>
                        </div>
                        <div class="col-md-4">
                            <label for="modalDocenteCorreo">Email:</label>
                            <input type="email" id="modalDocenteCorreo" class="form-control" readonly>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal de consulta Estudiante -->
<div class="modal fade" id="consultarEstudianteModal" tabindex="-1" role="dialog" aria-labelledby="consultarEstudianteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="consultarEstudianteModalLabel">Información del Estudiante</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="modalEstudianteNombre">Nombre:</label>
                            <input type="text" id="modalEstudianteNombre" class="form-control" readonly>
                        </div>
                        <div class="col-md-4">
                            <label for="modalEstudianteApellido">Apellido:</label>
                            <input type="text" id="modalEstudianteApellido" class="form-control" readonly>
                        </div>
                        <div class="col-md-4">
                            <label for="modalEstudianteCorreo">Email:</label>
                            <input type="email" id="modalEstudianteCorreo" class="form-control" readonly>
                        </div>
                        <div class="col-md-4">
                            <label for="modalEstudianteGrupo">Grupo:</label>
                            <input type="text" id="modalEstudianteGrupo" class="form-control" readonly>
                        </div>
                        <div class="col-md-4">
                            <label for="modalEstudianteCuatrimestre">Cuatrimestre:</label>
                            <input type="text" id="modalEstudianteCuatrimestre" class="form-control" readonly>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal de edición Docente -->
<div class="modal fade" id="editarDocenteModal" tabindex="-1" role="dialog" aria-labelledby="editarDocenteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarDocenteModalLabel">Editar Información del Docente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="editDocenteNombre">Nombre:</label>
                            <input type="text" id="editDocenteNombre" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="editDocenteApellido">Apellido:</label>
                            <input type="text" id="editDocenteApellido" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="editDocenteCorreo">Email:</label>
                            <input type="email" id="editDocenteCorreo" class="form-control">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="guardar-docente-btn">Guardar cambios</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal de edición Estudiante -->
<div class="modal fade" id="editarEstudianteModal" tabindex="-1" role="dialog" aria-labelledby="editarEstudianteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarEstudianteModalLabel">Editar Información del Estudiante</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="editEstudianteNombre">Nombre:</label>
                            <input type="text" id="editEstudianteNombre" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="editEstudianteApellido">Apellido:</label>
                            <input type="text" id="editEstudianteApellido" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="editEstudianteCorreo">Email:</label>
                            <input type="email" id="editEstudianteCorreo" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="editEstudianteGrupo">Grupo:</label>
                            <input type="text" id="editEstudianteGrupo" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="editEstudianteCuatrimestre">Cuatrimestre:</label>
                            <input type="text" id="editEstudianteCuatrimestre" class="form-control">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="guardar-estudiante-btn">Guardar cambios</button>
            </div>
        </div>
    </div>
</div>
</body>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        function fetchDocentes() {
            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'GET',
                data: {action: 'listarDocentes'},
                success: function (response) {
                    let lista = $('#lista-docentes');
                    lista.empty();
                    response.forEach(function (docente) {
                        let estatus = docente.estatus ? '' : ' - <span class="estatus">Deshabilitado</span>';
                        lista.append('<li>' + docente.matricula + estatus + '</li>');
                    });
                }
            });
        }

        function fetchEstudiantes() {
            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'GET',
                data: {action: 'listarEstudiantes'},
                success: function (response) {
                    let lista = $('#lista-estudiantes');
                    lista.empty();
                    response.forEach(function (estudiante) {
                        let estatus = estudiante.estatus ? '' : ' - <span class="estatus">Deshabilitado</span>';
                        lista.append('<li>' + estudiante.matricula + estatus + '</li>');
                    });
                }
            });
        }

        fetchDocentes();
        fetchEstudiantes();

        $('#consultar-docente-btn').on('click', function () {
            let matricula = $('#matricula-docente').val();
            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'GET',
                data: {matricula: matricula, tipo: 'docente'},
                success: function (response) {
                    $('#modalDocenteNombre').val(response.nombres);
                    $('#modalDocenteApellido').val(response.apellidos);
                    $('#modalDocenteCorreo').val(response.correoElectronico);
                }
            });
        });

        $('#consultar-estudiante-btn').on('click', function () {
            let matricula = $('#matricula-estudiante').val();
            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'GET',
                data: {matricula: matricula, tipo: 'estudiante'},
                success: function (response) {
                    $('#modalEstudianteNombre').val(response.nombre);
                    $('#modalEstudianteApellido').val(response.apellido);
                    $('#modalEstudianteCorreo').val(response.correoElectronico);
                    $('#modalEstudianteGrupo').val(response.grupo);
                    $('#modalEstudianteCuatrimestre').val(response.cuatrimestre);
                }
            });
        });

        $('#guardar-docente-btn').on('click', function () {
            let matricula = $('#matricula-docente').val();
            let nombres = $('#editDocenteNombre').val();
            let apellidos = $('#editDocenteApellido').val();
            let correoElectronico = $('#editDocenteCorreo').val();

            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'POST',
                data: {
                    action: 'updateDocente',
                    matricula: matricula,
                    nombres: nombres,
                    apellidos: apellidos,
                    correoElectronico: correoElectronico
                },
                success: function () {
                    fetchDocentes();
                    $('#editarDocenteModal').modal('hide');
                }
            });
        });

        $('#guardar-estudiante-btn').on('click', function () {
            let matricula = $('#matricula-estudiante').val();
            let nombre = $('#editEstudianteNombre').val();
            let apellido = $('#editEstudianteApellido').val();
            let correoElectronico = $('#editEstudianteCorreo').val();
            let grupo = $('#editEstudianteGrupo').val();
            let cuatrimestre = $('#editEstudianteCuatrimestre').val();

            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'POST',
                data: {
                    action: 'updateEstudiante',
                    matricula: matricula,
                    nombre: nombre,
                    apellido: apellido,
                    correoElectronico: correoElectronico,
                    grupo: grupo,
                    cuatrimestre: cuatrimestre
                },
                success: function () {
                    fetchEstudiantes();
                    $('#editarEstudianteModal').modal('hide');
                }
            });
        });

        $('#desactivar-docente-btn').on('click', function () {
            let matricula = $('#matricula-docente').val();
            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'POST',
                data: {action: 'desactivarDocente', matricula: matricula},
                success: function () {
                    fetchDocentes();
                }
            });
        });

        $('#desactivar-estudiante-btn').on('click', function () {
            let matricula = $('#matricula-estudiante').val();
            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'POST',
                data: {action: 'desactivarEstudiante', matricula: matricula},
                success: function () {
                    fetchEstudiantes();
                }
            });
        });

        $('#activar-docente-btn').on('click', function () {
            let matricula = $('#matricula-docente').val();
            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'POST',
                data: {action: 'activarDocente', matricula: matricula},
                success: function () {
                    fetchDocentes();
                }
            });
        });

        $('#activar-estudiante-btn').on('click', function () {
            let matricula = $('#matricula-estudiante').val();
            $.ajax({
                url: '<%=context%>/consultarInformacionS',
                method: 'POST',
                data: {action: 'activarEstudiante', matricula: matricula},
                success: function () {
                    fetchEstudiantes();
                }
            });
        });
    });
</script>

</html>
