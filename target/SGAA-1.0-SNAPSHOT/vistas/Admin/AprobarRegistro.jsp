<%--
  Created by IntelliJ IDEA.
  User: pilih
  Date: 15/07/2024
  Time: 06:01 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mx.edu.utez.sgaa.dao.DaoDocente" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.model.Docente" %>

<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%-- <link rel="stylesheet" href="<%=context%>/css/cssPlantillaBarra.css">--%>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">

    <title>Aprobar docente</title>
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


        /*DISEÑO INTRFAZ*/
        .table-responsive {
            background-color: #13AC80;
            border-radius: 10px;
            padding: 20px;
            color: white;
        }

        .table th, .table td {
            color: white;
        }
        .table td{
            font-size: 18px;
        }
        .table a {
            text-decoration: none;
        }
        .table .aprobar, .table .rechazar {
            background-color: #141C32;
            width: 60px;
            height: 40px;
            border-radius: 15%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 12px;
            color: white;
            cursor: pointer;
        }
        .btn-add-docente {
            position: absolute;
            top: 0;
            right: 20px;
            margin-bottom: 10px;
            padding: 10px 20px;
            background-color: #1D815A;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-add-docente:hover {
            background-color: #145A42;
        }
        #agregar-btn{
            background-color: rgba(0, 0, 0, 0.05); /* Mismo fondo que la caja de simbología */
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            color: #141C32; /* Color del texto */
            transition: background-color 0.3s ease;
        }

        #btn-aprobar{
            background-color: rgba(0, 0, 0, 0.05); /* Mismo fondo que la caja de simbología */
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            color: #141C32; /* Color del texto */
            transition: background-color 0.3s ease;
        }
        #btn-aprobar:hover{
            background-color: #5393d5; /* Hover recomendado: azul */
            color: white; /* Color de texto blanco en hover */
        }
        #agregar-btn:hover{
            background-color: #5393d5; /* Hover recomendado: azul */
            color: white; /* Color de texto blanco en hover */
        }
        #btn-rechazar{
            background-color: rgba(0, 0, 0, 0.05); /* Mismo fondo que la caja de simbología */
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            color: #141C32; /* Color del texto */
            transition: background-color 0.3s ease;
        }
        #btn-rechazar:hover{
            background-color: #5393d5; /* Hover recomendado: azul */
            color: white; /* Color de texto blanco en hover */
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
        <span>Aprobar docentes</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Administrador</span>
    </div>
</div>

<div class="contenido">

    <div class="container mt-2">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <button id="agregar-btn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#agregarDocenteModal">
                <i class="bi bi-plus-circle"></i>  Añadir docente
            </button>
        </div>
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th>Solicitudes de docentes</th>
                    <th></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <%
                    DaoDocente docentesAcceso = new DaoDocente();
                    List<Docente> docentes = docentesAcceso.DocentesSinAdmitir();
                    for (Docente docente : docentes) {
                %>
                <tr id="materia-<%=docente.getId()%>">
                    <td><%=docente.getNombres() %> <%=docente.getApellidos()%></td>
                    <td style="text-align: center">
                        <button id="btn-aprobar" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#aprobarDocente" onclick="aprobarDocente(<%=docente.getId()%>)">
                            <i class="bi bi-check-circle"></i> Aprobar
                        </button>
                    </td>
                    <td>
                        <button id="btn-rechazar" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#rechazaDocente" onclick="rechazarDocente(<%=docente.getId()%>)">
                            <i class="bi bi-x-circle"></i> Rechazar
                        </button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="agregarDocenteModal" tabindex="-1" aria-labelledby="agregarDocenteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="agregarDocenteModalLabel">Registrar Docente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%=context%>/AgregarDocenteAdminS" id="formAgregarDocente" method="post" novalidate>
                    <div class="mb-3">
                        <label for="matricula" class="form-label">Correo electronico</label>
                        <input type="text" class="form-control" id="matricula" name="matricula" required>
                        <div id="matriculaError" class="text-danger" style="display:none;">Campo obligatorio. Debe ser un correo válido con terminación @utez.edu.mx.</div>
                    </div>
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                        <div id="nombreError" class="text-danger" style="display:none;">Campo obligatorio. Solo un nombre y al menos 3 letras.</div>
                    </div>
                    <div class="mb-3">
                        <label for="apellido" class="form-label">Apellido</label>
                        <input type="text" class="form-control" id="apellido" name="apellido" required>
                        <div id="apellidoError" class="text-danger" style="display:none;">Campo obligatorio. Al menos 5 letras.</div>
                    </div>
                    <div class="mb-3">
                        <label for="contrasena" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="contrasena" name="password" required>
                        <div id="passwordError" class="text-danger" style="display:none;">Campo obligatorio. Al menos 3 carácteres.</div>
                    </div>
                    <!--<div class="mb-3">
                        <label for="correoElectronico" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="correoElectronico" name="email" required>
                        <div id="emailError" class="text-danger" style="display:none;">Campo obligatorio. Debe ser un correo válido con terminación @utez.edu.mx.</div>
                    </div>-->
                    <button type="submit" class="btn btn-primary">Registrar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Rechazar Docente -->
<div class="modal fade" id="rechazaDocente" tabindex="-1" aria-labelledby="rechazaDocenteLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="rechazaDocenteLabel">Rechazar Docente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/EliminarDocenteS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="r_id" name="r_id">
                    ¿Estás seguro de que deseas rechazar al docente?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-danger">Rechazar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Aprobar Docente -->
<div class="modal fade" id="aprobarDocente" tabindex="-1" aria-labelledby="aprobarDocenteLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="aprobarDocenteLabel">Confirmar el Registro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/AprobarRegistroS" method="post">
                <div class="modal-body">
                    <input type="hidden" id="ch_id" name="ch_id">
                    ¿Estás seguro de aprobar a este docente?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>



<!-- Bootstrap JS (incluye Popper.js) -->

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    function aprobarDocente(docenteId) {
        // Establecer el valor del campo oculto en el modal de aprobar
        document.getElementById('ch_id').value = docenteId;
    }

    function rechazarDocente(docenteId) {
        // Establecer el valor del campo oculto en el modal de rechazar
        document.getElementById('r_id').value = docenteId;
    }
</script>
</script>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const form = document.getElementById('formAgregarDocente'); // Formulario en tu modal
        const matriculaInput = document.getElementById('matricula'); // ID del input de matrícula
        const nombreInput = document.getElementById('nombre'); // ID del input de nombre
        const apellidoInput = document.getElementById('apellido'); // ID del input de apellido
        const passwordInput = document.getElementById('contrasena'); // ID del input de contraseña
        //const emailInput = document.getElementById('correoElectronico'); // ID del input de correo electrónico
        const submitButton = form.querySelector('button[type="submit"]');

        const validateForm = () => {
            let isValid = true;

            // Validar matrícula (formato similar al correo electrónico)
            const matriculaPattern = /^[a-zA-Z0-9]{3,}[^\s@]*@utez\.edu\.mx$/;
            if (!matriculaPattern.test(matriculaInput.value.trim())) {
                document.getElementById('matriculaError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('matriculaError').style.display = 'none';
            }

            // Validar nombre (sin números, permite acentos y al menos 3 caracteres)
            const nombrePattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ]{3,}$/;
            if (!nombrePattern.test(nombreInput.value.trim())) {
                document.getElementById('nombreError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('nombreError').style.display = 'none';
            }

            // Validar apellido (sin números, permite acentos, mínimo 5 letras por apellido)
            const apellidoPattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,}(?:\s[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,})?$/;
            if (!apellidoPattern.test(apellidoInput.value.trim())) {
                document.getElementById('apellidoError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('apellidoError').style.display = 'none';
            }

            // Validar contraseña (al menos 3 caracteres)
            if (passwordInput.value.trim().length < 3) {
                document.getElementById('passwordError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('passwordError').style.display = 'none';
            }

            // Validar correo electrónico
            /*const emailPattern = /^[a-zA-Z]{3,}[^\s@]*@utez\.edu\.mx$/;
            if (!emailInput.value.trim() || !emailPattern.test(emailInput.value.trim())) {
                document.getElementById('emailError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('emailError').style.display = 'none';
            }*/

            submitButton.disabled = !isValid;
        };

        form.addEventListener('input', validateForm);
    });
</script>

</body>
</html>
