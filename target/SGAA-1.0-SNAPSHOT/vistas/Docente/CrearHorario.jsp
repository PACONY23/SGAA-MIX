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

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                locale: 'es', // Configurar idioma español
                initialView: 'timeGridWeek',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'timeGridWeek'
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
        });
    </script>
</div>
</body>
</html>
