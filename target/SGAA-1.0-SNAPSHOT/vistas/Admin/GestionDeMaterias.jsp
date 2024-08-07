<%@ page import="mx.edu.utez.sgaa.dao.DaoMateria" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgaa.model.Materia" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String context = request.getContextPath(); %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <title>Agregar materias</title>
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
                <a href="<%=context%>/vistas/Admin/GestionAsesorias.jsp" class="d-flex align-items-center" >
                    <img id="asesorias-img" src="<%=context%>/IMG/asesorias_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Gestión de asesorías</span>
                </a>
            </li>
            <li>
                <a href="<%=context%>/vistas/Admin/ConsultarInformacion.jsp" class="d-flex align-items-center" >
                    <img id="historial-img" src="<%=context%>/IMG/historial_b.png" class="img-fluid" style="width: auto; height: 35px;" />
                    <span>Información de usuarios</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
<div class="contenido-superior">
    <div class="titulo-interfaz">
        <span>Materias</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Administrador</span>
        <img src="imagenes/busqueda.png" alt="rol" />
    </div>
</div>

<div class="contenido">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <button id="agregar-btn" class="btn btn-primary rounded-circle" style="background-color: #141C32;" data-bs-toggle="modal" data-bs-target="#agregarModal">+</button>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th scope="col">Nombre</th>
                <th scope="col" style="text-align: center">Opciones</th>
            </tr>
            </thead>
            <tbody id="materiasTableBody">
            <%
                DaoMateria MateriasExistentes = new DaoMateria();
                List<Materia> materias = MateriasExistentes.getAllMaterias();
                for (Materia materia : materias) {
                    System.out.println("Nombre: " + materia.getNombre());
                    String rowClass = !materia.isMateria_estado() ? "table-active" : "table-primary";
            %>
            <tr id="materia-<%=materia.getId()%>" class="<%= rowClass %>">
                <td><%=materia.getNombre() %></td>
                <td style="text-align: center">
                    <button id="materia-<%=materia.getId()%>" onclick="materiasBorrado(<%=materia.getId()%>)" class="btn p-0">
                        <i class="bi bi-trash-fill" style="font-size: 25px; color: black;" data-bs-toggle="modal" data-bs-target="#borrarMateria"></i>
                    </button>
                    <button id="estado-<%=materia.isMateria_estado()%>" onclick="materiasEstado(<%=materia.getId()%>)" class="btn p-0 ms-2">
                        <i class="bi bi-arrow-repeat" style="font-size: 25px; color: black;" data-bs-toggle="modal" data-bs-target="#estadoMateria"></i>
                    </button>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<%-- modal de agregar materias --%>
<div class="modal fade" id="agregarModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="agregarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="agregarModalLabel">Agregar Materia</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/AgregarMateriasS" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <input type="hidden" id="a_id" name="id">
                        <label for="Nombre_materia" class="form-label">Nombre de la Materia</label>
                        <input type="text" class="form-control" name="Nombre_materia" id="Nombre_materia" placeholder="Ingrese el nombre de la materia">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary" id="guardarMateriaBtn">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- modal cambio estado materias --%>
<div class="modal fade" id="estadoMateria" data-bs-backdrop="static" tabindex="-1" aria-labelledby="confirmarEstadoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarEstadoModalLabel">Cambio del estado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/EstadoMateriaS" method="post">
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

<%-- modal borra materias --%>
<div class="modal fade" id="borrarMateria" data-bs-backdrop="static" tabindex="-1" aria-labelledby="confirmarBorrarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarBorrarModalLabel">Confirmar Borrado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/EliminarMateria" method="post">
                <div class="modal-body">
                    <input type="hidden" id="d_id" name="d_id" required>
                    ¿Estás seguro de que deseas borrar esta materia?
                    <label id="d_name" style="font-weight: bold"></label>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Borrar</button>
                    <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
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

    function materiasEstado(id) {
        document.getElementById('ch_id').value = id;
    }
</script>
</body>
</html>
