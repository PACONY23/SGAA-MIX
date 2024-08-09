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
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales/es.js'></script>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
    <title>Crea tu Horario</title>
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
        }
        .contenido {
            width: calc(100% - 300px);
            margin-top: 100px;
            height: calc(100vh - 100px); /* Ajustar según sea necesario */
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
            margin-top: 55px;
            margin-left: 20px;
        }
        .barra-lateral .navegacion li {
            margin-top: 20px;
            list-style: none;
            display: flex;
            margin-bottom: 10px;
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
            background-color: white;
            color: #141C32;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }
        .barra-lateral .navegacion img {
            margin-left: 15px;
        }
        .contenido-superior {
            width: calc(100% - 250px);
            height: 100px;
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
            top: 0;
            margin-bottom: 20px;
            align-items: center;
        }
        .contenido {
            height: calc(100vh - 100px);
            overflow: hidden;
        }
        #calendar {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>
<div class="barra-lateral">
    <div class="nombre-pagina">
        <img src="<%=context%>/IMG/logoCalendario.png" id="cloud" class="img-fluid" style="height: 40px; width: auto"/>
        <span>UTESORATE</span>
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
                <a href="<%=context%>/vistas/Docente/HistorialDocente.jsp" class="d-flex align-items-center">
                    <img id="historial-img" src="<%=context%>/IMG/historial_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Historial</span>
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
                    <h5 class="modal-title" id="crearAsesoriaModalLabel">Crear Asesoría</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="crearAsesoriaForm">
                        <div class="mb-3">
                            <label for="titulo" class="form-label">Nombre del Evento</label>
                            <input type="text" class="form-control" id="titulo" required>
                        </div>
                        <div class="mb-3">
                            <label for="materia" class="form-label">Materia</label>
                            <select class="form-select" id="materia" required>
                                <!-- Opciones de materias se llenarán dinámicamente -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="dia" class="form-label">Día</label>
                            <input type="date" class="form-control" id="dia" required>
                        </div>
                        <div class="mb-3">
                            <label for="hora" class="form-label">Hora</label>
                            <input type="time" class="form-control" id="hora" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

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
                        url: '<%=context%>/ConsultarAsesoriasS',
                        type: 'GET',
                        success: function(data) {
                            successCallback(data);
                        }
                    });
                },
                editable: true,
                selectable: true,
                select: function(info) {
                    var modal = new bootstrap.Modal(document.getElementById('crearAsesoriaModal'));
                    document.getElementById('dia').value = info.startStr.split('T')[0];
                    document.getElementById('hora').value = info.startStr.split('T')[1].substring(0, 5);
                    modal.show();
                },
                eventClick: function(info) {
                    if (confirm('¿Desea eliminar este evento?')) {
                        $.ajax({
                            url: '<%=context%>/EliminarAsesoriaS',
                            type: 'POST',
                            data: {
                                idAsesoria: info.event.id
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
                        url: '<%=context%>/ActualizarAsesoriaS',
                        type: 'POST',
                        data: {
                            idAsesoria: event.id,
                            idDocente: event.extendedProps.idDocente,
                            idMateria: event.extendedProps.idMateria,
                            titulo: event.title,
                            fecha: event.start.toISOString().split('T')[0],
                            hora: event.start.toISOString().split('T')[1].substring(0, 5)
                        },
                        success: function() {
                            calendar.refetchEvents();
                        }
                    });
                },
                eventResize: function(info) {
                    var event = info.event;
                    $.ajax({
                        url: '<%=context%>/ActualizarAsesoriaS',
                        type: 'POST',
                        data: {
                            idAsesoria: event.id,
                            idDocente: event.extendedProps.idDocente,
                            idMateria: event.extendedProps.idMateria,
                            titulo: event.title,
                            fecha: event.start.toISOString().split('T')[0],
                            hora: event.start.toISOString().split('T')[1].substring(0, 5)
                        },
                        success: function() {
                            calendar.refetchEvents();
                        }
                    });
                }
            });
            calendar.render();

            // Obtener las materias del docente y llenar el select
            $.ajax({
                url: '<%=context%>/ObtenerMateriasDocenteS',
                type: 'GET',
                success: function(data) {
                    var materias = JSON.parse(data);
                    var select = document.getElementById('materia');
                    select.innerHTML = '';
                    materias.forEach(function(materia) {
                        var option = document.createElement('option');
                        option.value = materia.idMateria;
                        option.text = materia.nombreMateria;
                        select.appendChild(option);
                    });
                }
            });

            // Manejar el envío del formulario del modal para crear asesoría
            document.getElementById('crearAsesoriaForm').addEventListener('submit', function(event) {
                event.preventDefault();
                var title = document.getElementById('titulo').value;
                var date = document.getElementById('dia').value;
                var time = document.getElementById('hora').value;
                var dateTime = date + 'T' + time + ':00';
                var idMateria = document.getElementById('materia').value;

                $.ajax({
                    url: '<%=context%>/CrearAsesoriaS',
                    type: 'POST',
                    data: {
                        idDocente: 1, // Deberás ajustar esto para que sea dinámico según el docente que esté logueado
                        idMateria: idMateria,
                        titulo: title,
                        fecha: date,
                        hora: time
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
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
