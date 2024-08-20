<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.model.EstudiantesAsesoria" %>
<%@ page import="mx.edu.utez.sgaa.model.Asesoria" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
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
        idEstudiante = 0; // Valor por defecto si no está en la sesión
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales/es.js'></script>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
    <title>Crea tu Horario</title>

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
            margin-left: 290px; /* Asegúrate de que este valor coincida con el ancho de la barra lateral */
            margin-top: 30px; /* Ajusta según sea necesario para el margen superior */
            height: calc(100vh - 100px); /* Ajustar según sea necesario */
            width: calc(100% - 250px); /* Asegúrate de que el ancho esté ajustado */
            overflow: hidden;
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
        .contenido {
            height: 80vh; /* Ajusta según tus necesidades */
            overflow-y: auto; /* Agrega scroll vertical si el contenido es mayor que el contenedor */
            overflow-x: hidden; /* Previene el scroll horizontal */
        }

        #calendar {
            min-height: 100%; /* Ajusta el tamaño del calendario dentro del contenedor */
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
                <a href="<%=request.getContextPath()%>/LogoutS" class="d-flex align-items-center" >
                    <img id="logout-img" src="<%=context%>/IMG/logout_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Cerrar sesión</span>
                </a>
            </li>
        </ul>
    </nav>
</div>


<div class="contenido">
    <div id="calendar"></div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Título del Evento</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="modalDate">Fecha y Hora</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-success" id="inscribirseBtn">Inscribirse</button>
            </div>
        </div>
    </div>
</div>
<script>
    // Definir la variable idEstudiante en JavaScript
    var idEstudiante = '<%= idEstudiante %>'; // Convertir el idEstudiante a string para evitar problemas en el lado del cliente
</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'es',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            views: {
                timeGridDay: {
                    buttonText: 'Día'
                },
                timeGridWeek: {
                    buttonText: 'Semana'
                },
                dayGridMonth: {
                    buttonText: 'Mes'
                }
            },
            events: [
                <%
                    List<Asesoria> asesorias = (List<Asesoria>) request.getAttribute("asesorias");
                    if (asesorias != null) {
                        for (int i = 0; i < asesorias.size(); i++) {
                            Asesoria asesoria = asesorias.get(i);
                            String start = new java.text.SimpleDateFormat("yyyy-MM-dd").format(asesoria.getFecha()) + "T" +
                                           new java.text.SimpleDateFormat("HH:mm:ss").format(asesoria.getHora());
                            String title = asesoria.getTitulo();
                            int idAsesoria = asesoria.getIdAsesoria();
                %>
                {
                    title: '<%= title %>',
                    start: '<%= start %>',
                    id: '<%= idAsesoria %>'
                }<% if (i < asesorias.size() - 1) { %>,<% } %>
                <%
                        }
                    }
                %>
            ],
            eventClick: function(info) {
                var selectedEvent = info.event;
                var title = info.event.title;
                var start = info.event.start.toISOString().slice(0, 19).replace('T', ' ');
                var idAsesoria = info.event.id;

                document.getElementById('modalTitle').innerText = title;
                document.getElementById('modalDate').innerText = start;
                var myModal = new bootstrap.Modal(document.getElementById('myModal'), {
                    keyboard: false
                });

                document.getElementById('inscribirseBtn').addEventListener('click', function() {
                    selectedEvent.setProp('backgroundColor', 'green');
                    selectedEvent.setProp('borderColor', 'green');
                    selectedEvent.setProp('textColor', 'white');

                    fetch('AgregarAsesoriaS', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: new URLSearchParams({
                            'idEstudiante': idEstudiante, // Usar la variable inyectada
                            'idAsesoria': idAsesoria
                        })
                    })
                        .then(response => response.text())
                        .then(data => {
                            console.log('Inscripción realizada:', data);
                        })
                        .catch(error => console.error('Error en la inscripción:', error));

                    myModal.hide();
                });

                myModal.show();
            }
        });

        calendar.render();
    });
</script>
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
