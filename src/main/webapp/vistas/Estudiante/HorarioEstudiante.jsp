<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales/es.js'></script> <!-- Añadir archivo de idioma -->
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
    <title>Crea tu Horario</title>
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
    </style>
</head>
<body>
<!-- Barra lateral -->
<div class="barra-lateral">
    <div class="nombre-pagina">
        <img src="<%=context%>/IMG/logoCalendario.png" id="cloud" class="img-fluid" style="height: 40px; width: auto"/>
        <span>UTESORATE</span>
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
                <a href="<%=context%>/vistas/Estudiante/HorarioEstudiante.jsp" class="d-flex align-items-center">
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
        </ul>
    </nav>
</div>
<div class="contenido">
    <div id='calendar'></div>

    <!-- Modal para crear asesoría -->
    <div class="modal fade" id="crearAsesoriaModal" tabindex="-1" aria-labelledby="crearAsesoriaModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="crearAsesoriaModalLabel">Agendar Asesoría</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="crearAsesoriaForm" action="<%=context%>/AgendarAsesoria" method="get" >
                        <%
                            DaoMateria MateriasExistentes = new DaoMateria();
                            List<Materia> materias = MateriasExistentes.getAllMaterias();
                            for (Materia materia : materias) {
                                System.out.println("Nombre: " + materia.getNombre());
                        %>
                        <div class="form-check">

                            <input class="form-check-input" type="checkbox" name="materias" value="<%=materia.getId()%>" id="<%=materia.getId()%>">
                            <label class="form-check-label" for="<%=materia.getId()%>">
                                <%=materia.getNombre() %>
                            </label>

                        </div>
                        <%
                            }
                        %>
                        <div class="mb-3">
                            <label for="dia" class="form-label">Día</label>
                            <input type="date" class="form-control" id="dia" required>
                        </div>
                        <div class="mb-3">
                            <label for="hora" class="form-label">Hora</label>
                            <input type="time" class="form-control" id="hora" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Agendar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal para la seleccionar materias
    <div class="modal fade" id="seleccionarMaterias" tabindex="-1" aria-labelledby="seleccionarMateriasLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="seleccionarMateriasLabel">Seleccionar materias</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                <%--
                    <form id="seleccionarMateriasForm" action="<%=context%>/GuardarMateriasSeleccionadasServlet" method="post">
                        <%
                            DaoMateria MateriasExistentes = new DaoMateria();
                            List<Materia> materias = MateriasExistentes.getAllMaterias();
                            for (Materia materia : materias) {
                                System.out.println("Nombre: " + materia.getNombre());
                        %>
                        <div class="form-check">

                            <input class="form-check-input" type="checkbox" name="materias" value="<%=materia.getId()%>" id="<%=materia.getId()%>">
                            <label class="form-check-label" for="<%=materia.getId()%>">
                                <%=materia.getNombre() %>
                            </label>

                        </div>
                        <%
                            }
                        %>
                        --%>
                        <button type="submit" class="btn btn-primary mt-3">Guardar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    -->

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                locale: 'es', // Configurar idioma español
                initialView: 'timeGridWeek',
                headerToolbar: {
                    left: 'customButtonCheckbox, customButton',
                    center: 'title',
                    right: 'prev,next today'
                },
                customButtons: {
                    customButton: {
                        text: 'Crear asesoría',
                        click: function() {
                            var modal = new bootstrap.Modal(document.getElementById('crearAsesoriaModal'));
                            modal.show();
                        }
                    },
                    customButtonCheckbox: {
                        text: 'Opciones',
                        click: function() {
                            var modal = new bootstrap.Modal(document.getElementById('seleccionarMaterias'));
                            modal.show();
                        }
                    }
                },
                slotMinTime: '07:00:00',
                slotMaxTime: '21:00:00',
                allDaySlot: false,
                height: '100%',
                expandRows: true,
                hiddenDays: [0, 6], // Ocultar sábado (6) y domingo (0)
                events: function(fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        url: '/CalendarEventServlet',
                        type: 'GET',
                        success: function(data) {
                            successCallback(data);
                        }
                    });
                },
                editable: true,
                selectable: true,
                select: function(info) {
                    var title = prompt('Ingrese el título del evento:');
                    if (title) {
                        $.ajax({
                            url: '/CalendarEventServlet',
                            type: 'POST',
                            data: {
                                title: title,
                                start: info.startStr,
                                end: info.endStr
                            },
                            success: function() {
                                calendar.refetchEvents();
                            }
                        });
                    }
                },
                eventClick: function(info) {
                    if (confirm('¿Desea eliminar este evento?')) {
                        $.ajax({
                            url: '/CalendarEventServlet',
                            type: 'DELETE',
                            data: {
                                id: info.event.id
                            },
                            success: function() {
                                calendar.refetchEvents();
                            }
                        });
                    }
                },
                eventDrop: function(info) {
                    var event = info.event;
                    $.ajax({
                        url: '/CalendarEventServlet',
                        type: 'PUT',
                        data: {
                            id: event.id,
                            title: event.title,
                            start: event.start.toISOString(),
                            end: event.end.toISOString()
                        },
                        success: function() {
                            calendar.refetchEvents();
                        }
                    });
                },
                eventResize: function(info) {
                    var event = info.event;
                    $.ajax({
                        url: '/CalendarEventServlet',
                        type: 'PUT',
                        data: {
                            id: event.id,
                            title: event.title,
                            start: event.start.toISOString(),
                            end: event.end.toISOString()
                        },
                        success: function() {
                            calendar.refetchEvents();
                        }
                    });
                }
            });
            calendar.render();

            // Manejar el envío del formulario del modal para crear asesoría
            document.getElementById('crearAsesoriaForm').addEventListener('submit', function(event) {
                event.preventDefault();
                var title = document.getElementById('titulo').value;
                var date = document.getElementById('dia').value;
                var time = document.getElementById('hora').value;
                var dateTime = date + 'T' + time + ':00';

                $.ajax({
                    url: '/CalendarEventServlet',
                    type: 'POST',
                    data: {
                        title: title,
                        start: dateTime,
                        end: dateTime // Asumimos que el evento dura una hora, ajustar según sea necesario
                    },
                    success: function() {
                        calendar.refetchEvents();
                        var modal = bootstrap.Modal.getInstance(document.getElementById('crearAsesoriaModal'));
                        modal.hide();
                    }
                });
            });

            // Manejar el envío del formulario del modal de checkboxes
            document.getElementById('seleccionarMateriasForm').addEventListener('submit', function(event) {
                event.preventDefault();
                // Aquí puedes agregar la lógica para manejar los checkboxes seleccionados
                var checkboxes = document.querySelectorAll('#seleccionarMateriasForm input[type="checkbox"]');
                var selectedOptions = [];
                checkboxes.forEach(function(checkbox) {
                    if (checkbox.checked) {
                        selectedOptions.push(checkbox.id);
                    }
                });
                console.log('Opciones seleccionadas:', selectedOptions);
                var modal = bootstrap.Modal.getInstance(document.getElementById('seleccionarMaterias'));
                modal.hide();
            });
        });
    </script>
    <div style="margin-bottom: 20px"></div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
