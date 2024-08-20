<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>
<%@ page import="java.util.List" %>
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
    String matricula = (String) session.getAttribute("matricula");
    if (matricula != null) {
%>

<%
} else {
%>
<p>No hay sesión activa.</p>
<%
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.css" rel="stylesheet" />
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
        .barra-lateral {
            width: 250px;
            height: 100%;
            overflow: hidden;
            background-color: #141C32;
            transition: width 0.5s ease;
            position: fixed;
            top: 0;
            left: 0;
            /* Asegúrate de que la barra lateral esté fija en el lado izquierdo */
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
        .barra-lateral .navegacion img {
            margin-left: 15px;
        }
        .contenido {
            margin-left: 290px; /* Asegúrate de que este valor coincida con el ancho de la barra lateral */
            margin-top: 30px; /* Ajusta según sea necesario para el margen superior */
            height: calc(100vh - 100px); /* Ajustar según sea necesario */
            width: calc(100% - 250px); /* Asegúrate de que el ancho esté ajustado */
            overflow: hidden;
            overflow-y: auto; /* Agrega scroll vertical si el contenido es mayor que el contenedor */
            overflow-x: hidden; /* Previene el scroll horizontal */
        }
        #calendar {
            min-height: 100%; /* Ajusta el tamaño del calendario dentro del contenedor */
        }
        .btn-custom {
            background-color: #141c32;
            color: #fff;
        }
        .boton-cerrar-sesion:hover {
            background-color: #fff;
            color: #141C32;
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
                <a href="<%=context%>/vistas/Docente/HistorialDocente.jsp" class="d-flex align-items-center">
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
<div class="contenido">

    <!-- Aquí puedes añadir el contenido específico para esta página -->

    <!-- Botón para abrir el modal de selección de materias -->
    <button type="button" class="btn btn-custom" onclick="openSelectMateriasModal()">Seleccionar Materias</button>
    <!-- Botón para abrir el modal de visualización de materias -->
    <button type="button" class="btn btn-custom" onclick="openMateriasDocentesModal()">Agendar Asesoria</button>
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
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'es',
            events: function(fetchInfo, successCallback, failureCallback) {
                fetch('<%=request.getContextPath()%>/obtenerAsesoriasS')
                    .then(response => response.json())
                    .then(data => {
                        console.log('Asesorías:', data);

                        // Transformar los datos al formato esperado por FullCalendar
                        const events = data.map(asesoria => ({
                            id: asesoria.idAsesoria,
                            title: asesoria.titulo,
                            start: new Date(asesoria.fecha).toISOString(), // Convertir la fecha al formato ISO
                            allDay: true // Si las asesorías son eventos de todo el día
                        }));

                        // Pasar los eventos a FullCalendar
                        successCallback(events);
                    })
                    .catch(error => {
                        console.error('Error al cargar las asesorías:', error);
                        failureCallback(error);
                    });
            },
            eventClick: function(info) {
                // Manejar el clic en el evento aquí, si es necesario
                console.log('Evento clickeado:', info.event);
                // Por ejemplo, abrir el modal con la información del evento
                document.getElementById('modalTitle').textContent = info.event.title;
                document.getElementById('modalDate').textContent = info.event.startStr;
                var myModal = new bootstrap.Modal(document.getElementById('myModal'));
                myModal.show();
            }
        });
        calendar.render();
    });
</script>

<!-- Modal para seleccionar materias -->
<div class="modal fade" id="seleccionarMaterias" tabindex="-1" aria-labelledby="seleccionarMateriasLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="seleccionarMateriasLabel">Seleccionar materias</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="materiasForm" action="<%=context%>/SeleccionMateriasDocenteS" method="post">
                    <input type="hidden" id="matriculaDocente" name="matriculaDocente" value="<%=matricula%>" />
                    <div id="materiasContainer">
                        <%
                            DaoMateria materiasExistentes = new DaoMateria();
                            List<Materia> materias = materiasExistentes.getAllMaterias(matricula);
                            for (Materia materia : materias) {
                        %>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span><%=materia.getNombre() %></span>
                            <button class="btn btn-sm btn-primary" type="button" onclick="agregarMateria('<%=materia.getId()%>', '<%=matricula%>')">Agregar</button>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal para reagendar asesorías -->
<div class="modal fade" id="reagendaDocentesModal" tabindex="-1" aria-labelledby="reagendaDocentesModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reagendaDocentesModalLabel">Reagendar Asesoría</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="fecha" class="form-label">Fecha</label>
                    <input type="date" class="form-control" id="r_fecha" name="fecha" required>
                </div>
                <div class="mb-3">
                    <label for="hora" class="form-label">Hora (HH:mm:ss)</label>
                    <input type="time" class="form-control" id="r_hora" name="hora" required>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="guardarReagenda()">Guardar Cambios</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal para visualizar materias docentes -->
<div class="modal fade" id="materiasDocentesModal" tabindex="-1" aria-labelledby="materiasDocentesModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="materiasDocentesModalLabel">Agenda tu asesoría</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="materiasSelect" class="form-label">Selecciona una Materia</label>
                    <select class="form-select" id="materiasSelect" name="idMateria" required>
                        <option value="" selected disabled>Elige una materia</option>
                        <!-- Opciones de materias se cargarán aquí -->
                    </select>
                </div>
                <form id="asesoriaForm" method="post">
                    <input type="hidden" id="idDocente" name="idDocente">
                    <input type="hidden" id="idMateria" name="idMateria">
                    <div class="mb-3">
                        <label for="titulo" class="form-label">Título</label>
                        <input type="text" class="form-control" id="titulo" name="titulo" required>
                    </div>
                    <div class="mb-3">
                        <label for="fecha" class="form-label">Fecha</label>
                        <input type="date" class="form-control" id="fecha" name="fecha" required>
                    </div>
                    <div class="mb-3">
                        <label for="hora" class="form-label">Hora (HH:mm:ss)</label>
                        <input type="text" class="form-control" id="hora" name="hora" pattern="\d{2}:\d{2}:\d{2}" placeholder="HH:mm:ss" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitAsesoria()">Crear Asesoría</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    function loadMaterias() {
        const matricula = '<%=matricula%>';
        console.log('Matrícula que se enviará al servidor:', matricula);

        fetch(`<%=request.getContextPath()%>/MateriasDocentesServlet?matricula=${matricula}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(materias => {
                console.log('Materias recibidas:', materias);
                const materiasSelect = document.getElementById('materiasSelect');
                if (materiasSelect) {
                    materiasSelect.innerHTML = '<option value="" selected disabled>Elige una materia</option>'; // Opción por defecto

                    materias.forEach(materia => {
                        const option = document.createElement('option');
                        option.value = materia.idMateria;
                        option.textContent = materia.nombreMateria;
                        materiasSelect.appendChild(option);
                    });

                    // Agregar el manejador de eventos para el cambio de selección
                    materiasSelect.addEventListener('change', (event) => {
                        const selectedIdMateria = event.target.value;
                        console.log('Materia seleccionada con ID:', selectedIdMateria);
                    });
                } else {
                    console.error('No se encontró el elemento con ID "materiasSelect"');
                }
            })
            .catch(error => console.error('Error al cargar las materias:', error));
    }

    function submitAsesoria() {
        // Actualizar el campo oculto idMateria con el valor del select
        const selectedIdMateria = document.getElementById('materiasSelect').value;
        document.getElementById('idMateria').value = selectedIdMateria;

        const form = document.getElementById('asesoriaForm');
        const formData = new FormData(form);

        // Convertir FormData a URLSearchParams para enviar como parámetros
        const params = new URLSearchParams();
        formData.forEach((value, key) => {
            params.append(key, value);
        });
        console.log('Datos enviados en la solicitud POST:', params.toString());

        // Enviar solicitud POST
        fetch('<%=request.getContextPath()%>/CrearAsesoriaS', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: params.toString()
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('Asesoría creada:', data);

                // Cerrar el modal usando Bootstrap
                const myModal = bootstrap.Modal.getInstance(document.getElementById('materiasDocentesModal'));
                if (myModal) {
                    myModal.hide();
                }

                // Recargar la página para actualizar la lista de asesorías
                window.location.reload();
            })
            .catch(error => console.error('Error al crear la asesoría:', error));
    }

    loadMaterias(); // Cargar las materias cuando se carga la página

    document.addEventListener('DOMContentLoaded', function() {
        const matricula = '<%=matricula%>'; // Obtener matrícula desde JSP

        fetch(`<%=request.getContextPath()%>/ObtenerIdDocenteServlet?matricula=${matricula}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('ID Docente recibido:', data.idDocente);
                document.getElementById('idDocente').value = data.idDocente; // Guardar el idDocente en el campo oculto
                cargarMaterias(data.idDocente); // Cargar materias
            })
            .catch(error => console.error('Error al obtener el idDocente:', error));

        function cargarMaterias(idDocente) {
            fetch(`<%=request.getContextPath()%>/MateriasDocentesServlet?matricula=${matricula}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(materias => {
                    console.log('Materias recibidas:', materias);
                    const materiasForm = document.getElementById('materiasForm2');
                    if (materiasForm) {
                        materiasForm.innerHTML = '';

                        materias.forEach(materia => {
                            const div = document.createElement('div');
                            div.classList.add('form-check');

                            const checkbox = document.createElement('input');
                            checkbox.classList.add('form-check-input');
                            checkbox.type = 'checkbox';
                            checkbox.value = materia.idMateria;
                            checkbox.id = `materia${materia.idMateria}`;

                            const label = document.createElement('label');
                            label.classList.add('form-check-label');
                            label.setAttribute('for', checkbox.id);
                            label.textContent = materia.nombreMateria;

                            div.appendChild(checkbox);
                            div.appendChild(label);
                            materiasForm.appendChild(div);
                        });

                        materiasForm.addEventListener('change', (event) => {
                            if (event.target.type === 'checkbox') {
                                if (event.target.checked) {
                                    console.log('Materia seleccionada con ID:', event.target.value);
                                    document.getElementById('idMateria').value = event.target.value;
                                }
                            }
                        });
                    }
                })
                .catch(error => console.error('Error al obtener las materias:', error));
        }
    });

    function openSelectMateriasModal() {
        var modal = new bootstrap.Modal(document.getElementById('seleccionarMaterias'));
        modal.show();
    }

    function agregarMateria(idMateria, matriculaDocente) {
        var form = document.getElementById('materiasForm');
        var hiddenInputMateria = document.createElement('input');
        hiddenInputMateria.type = 'hidden';
        hiddenInputMateria.name = 'materiaId';
        hiddenInputMateria.value = idMateria;
        form.appendChild(hiddenInputMateria);

        form.submit();

        console.log('Materia:', idMateria, 'Docente:', matriculaDocente);
    }

    function openMateriasDocentesModal() {
        const modal = document.getElementById('materiasDocentesModal');
        if (modal) {
            const modalInstance = new bootstrap.Modal(modal);
            modalInstance.show();
        } else {
            console.error('No se encontró el modal con ID "materiasDocentesModal"');
        }
    }

    function openReagendaDocentesModal() {
        const modal = document.getElementById('reagendaDocentesModal');
        if (modal) {
            const modalInstance = new bootstrap.Modal(modal);

            // Cargar materias con asesorías
            const matricula = '<%=matricula%>';
            fetch(`<%=request.getContextPath()%>/ObtenerMateriasConAsesorias?matricula=${matricula}`)
                .then(response => response.json())
                .then(materias => {
                    const materiasSelect = document.getElementById('materiasConAsesoriaSelect');
                    materiasSelect.innerHTML = '<option value="" selected disabled>Selecciona una materia</option>';

                    materias.forEach(materia => {
                        const option = document.createElement('option');
                        option.value = materia.idMateria;
                        option.textContent = materia.nombreMateria;
                        materiasSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error al cargar materias:', error));

            modalInstance.show();
        } else {
            console.error('No se encontró el modal con ID "reagendaDocentesModal"');
        }
    }

    function guardarReagenda() {
        const idMateria = document.getElementById('materiasConAsesoriaSelect').value;
        const fecha = document.getElementById('fecha').value;
        const hora = document.getElementById('hora').value;

        if (idMateria && fecha && hora) {
            const params = new URLSearchParams();
            params.append('idMateria', idMateria);
            params.append('fecha', fecha);
            params.append('hora', hora);

            fetch('<%=request.getContextPath()%>/ActualizarAsesoriaS', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params.toString()
            })
                .then(response => response.json())
                .then(data => {
                    console.log('Asesoría actualizada:', data);
                    // Cerrar el modal y recargar la página si es necesario
                    const modal = bootstrap.Modal.getInstance(document.getElementById('reagendaDocentesModal'));
                    modal.hide();
                    window.location.reload();
                })
                .catch(error => console.error('Error al actualizar la asesoría:', error));
        } else {
            alert('Por favor, completa todos los campos.');
        }
    }


</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>