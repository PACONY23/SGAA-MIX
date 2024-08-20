<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoAsesoria" %>
<%@ page import="mx.edu.utez.sgaa.model.Asesoria" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String context = request.getContextPath();
    if(request.getSession(false) != null && session.getAttribute("matricula") != null){
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
        <span>Mis asesorías</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Docente</span>
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
            <tr style="background-color: #0d6efd; color: white;">
                <th scope="col">Titulo asesoría</th>
                <th scope="col" style="text-align: center">Materia</th>
                <th scope="col">Fecha</th>
                <th scope="col">Hora</th>
                <th scope="col" style="text-align: center">Acciones</th> <!-- Columna para los botones -->
            </tr>
            </thead>
            <tbody id="materiasTableBody">
            <%
                if (idDocente != null && idDocente > 0) {
                    DaoAsesoria daoAsesoria = new DaoAsesoria();
                    List<Asesoria> asesoriasNoIniciadas = daoAsesoria.obtenerAsesoriasNoIniciadas(idDocente);

                    for (Asesoria asesoria : asesoriasNoIniciadas) {
            %>
            <tr style="background-color: #ffffff; color: #000000;">
                <td style="background-color: #ffffff; color: #000000;"><%=asesoria.getTitulo() %></td>
                <td style="background-color: #ffffff; color: #000000; text-align: center;"><%=asesoria.getNombreMateria() %></td>
                <td style="background-color: #ffffff; color: #000000;"><%=asesoria.getFecha() %></td>
                <td style="background-color: #ffffff; color: #000000;"><%=asesoria.getHora() %></td>
                <td style="background-color: #ffffff; color: #000000; text-align: center;">
                    <div class="d-flex justify-content-center">
                        <button id="estado-<%=asesoria.getIdAsesoria()%>" onclick="setAsesoriaId(<%=asesoria.getIdAsesoria()%>)" class="btn p-0 ms-2" style="display: flex; flex-direction: column; align-items: center; background-color: #ffffff; color: #000000;" data-bs-toggle="modal" data-bs-target="#iniciarAsesoria">
                            <i class="bi bi-play-fill" style="font-size: 20px;"></i>
                            <span class="small text-muted">Iniciar</span>
                        </button>
                        <button id="materia-<%=asesoria.getIdAsesoria()%>" onclick="openReagendarModal(<%=asesoria.getIdAsesoria()%>)" class="btn p-0 ms-2" style="display: flex; flex-direction: column; align-items: center; background-color: #ffffff; color: #000000;">
                            <i class="bi bi-calendar-event-fill" style="font-size: 20px;"></i>
                            <span class="small text-muted">Reagendar</span>
                        </button>
                    </div>
                </td>
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
            <tr style="background-color: #0d6efd; color: white;">
                <th scope="col">Titulo asesoría</th>
                <th scope="col" style="text-align: center">Materia</th>
                <th scope="col">Fecha</th>
                <th scope="col">Hora</th>
                <th scope="col" style="text-align: center">Acciones</th> <!-- Columna para los botones -->
            </tr>
            </thead>
            <tbody id="asesoriasIniciadasTableBody">
            <%
                if (idDocente != null && idDocente > 0) {
                    DaoAsesoria daoAsesoria = new DaoAsesoria();
                    List<Asesoria> asesoriasIniciadas = daoAsesoria.obtenerAsesoriasIniciadas(idDocente);

                    for (Asesoria asesoria : asesoriasIniciadas) {
            %>
            <tr>
                <td><%=asesoria.getTitulo() %></td>
                <td style="text-align: center;"><%=asesoria.getNombreMateria() %></td>
                <td><%=asesoria.getFecha() %></td>
                <td><%=asesoria.getHora() %></td>
                <td style="text-align: center;">
                    <div class="d-flex justify-content-center">
                        <!-- Solo el botón de "Finalizar" en la tabla de asesorías iniciadas -->
                        <button id="finalizar-<%=asesoria.getIdAsesoria()%>" onclick="openFinalizarModal(<%=asesoria.getIdAsesoria()%>)" class="btn p-0 ms-2" style="display: flex; flex-direction: column; align-items: center; background-color: #ffffff; color: #000000;" data-bs-toggle="modal" data-bs-target="#finalizarAsesoria">
                            <i class="bi bi-stop-fill" style="font-size: 20px;"></i>
                            <span class="small text-muted">Finalizar</span>
                        </button>
                    </div>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>









<!-- Modal para reagendar asesoría -->
<div class="modal fade" id="reagendarAsesoria" tabindex="-1" aria-labelledby="reagendarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reagendarModalLabel">Reagendar Asesoría</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="reagendarForm" action="<%=context%>/ReagendarAsesoriaS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="a_id" name="a_id">
                    <div class="mb-3">
                        <label for="fechaReagendada" class="form-label">Selecciona el día</label>
                        <input type="date" class="form-control" id="fechaReagendada" name="fechaReagendada" required>
                    </div>
                    <div class="mb-3">
                        <label for="horaReagendada" class="form-label">Hora (HH:mm:ss)</label>
                        <input type="text" class="form-control" id="horaReagendada" name="horaReagendada" placeholder="HH:mm:ss" required>
                        <small class="form-text text-muted">Ingrese la hora en formato HH:mm:ss.</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>
</div>


<%-- modal inicar asesoria --%>
<div class="modal fade" id="iniciarAsesoria" data-bs-backdrop="static" tabindex="-1" aria-labelledby="iniciarALabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="iniciarALabel">Iniciar asesoría</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/IniciarAsesoriaS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="ch_id" name="ch_id">
                    ¿Estás seguro que deseas iniciar la asesoría?
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-danger">Iniciar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- modal finalizar asesoria --%>
<div class="modal fade" id="finalizarAsesoria" data-bs-backdrop="static" tabindex="-1" aria-labelledby="finalizarALabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="finalizarALabel">Finalizar asesoría</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/FinalizarAsesoriaS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="f_id" name="f_id">
                    ¿Estás seguro que deseas finalizar la asesoría?
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-danger">Finalizar</button>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    function materiasBorrado(id) {
        document.getElementById('d_id').value = id;
    }

    function setAsesoriaId(idAsesoria) {
        document.getElementById('ch_id').value = idAsesoria;
    }
</script>
<script>
    function openFinalizarModal(idAsesoria) {
        // Asignar el ID de la asesoría al campo oculto del modal
        document.getElementById('f_id').value = idAsesoria;
    }
</script>
<script>
    function openReagendarModal(idAsesoria) {
        // Asignar el ID de la asesoría al campo oculto del modal
        document.getElementById('a_id').value = idAsesoria;

        // Verificar en la consola
        console.log("ID de Asesoría:", idAsesoria);
        console.log("Valor del campo oculto:", document.getElementById('a_id').value);

        // Limpiar campos de fecha y hora si es necesario
        document.getElementById('fechaReagendada').value = '';
        document.getElementById('horaReagendada').value = '';

        // Abrir el modal
        var myModal = new bootstrap.Modal(document.getElementById('reagendarAsesoria'));
        myModal.show();
    }

    // Validar el formulario antes de enviarlo
    document.getElementById('reagendarForm').addEventListener('submit', function(event) {
        var fecha = document.getElementById('fechaReagendada').value;
        var hora = document.getElementById('horaReagendada').value;

        // Validar que todos los campos estén completos
        if (!fecha || !hora) {
            event.preventDefault(); // Evitar el envío del formulario
            alert('Por favor, completa todos los campos.');
            return;
        }

        // Validar la fecha seleccionada
        var fechaSeleccionada = new Date(fecha);
        var fechaActual = new Date();
        fechaActual.setHours(0, 0, 0, 0); // Ajustar la fecha actual a la medianoche para comparación

        if (fechaSeleccionada < fechaActual) {
            event.preventDefault(); // Evitar el envío del formulario
            alert('La fecha seleccionada no puede ser una fecha pasada.');
            return;
        }

        // Validar el formato de la hora (HH:mm:ss)
        var horaRegex = /^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)$/;
        if (!horaRegex.test(hora)) {
            event.preventDefault(); // Evitar el envío del formulario
            alert('El formato de la hora debe ser HH:mm:ss.');
        }
    });
</script>

</body>
</html>
