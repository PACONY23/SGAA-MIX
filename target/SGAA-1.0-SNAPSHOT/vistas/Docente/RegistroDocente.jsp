<%--
  Created by IntelliJ IDEA.
  User: pilih
  Date: 10/07/2024
  Time: 09:33 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Registro docente</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0; /* Fondo claro */
            font-family: 'Poppins', sans-serif;
        }
        .contenido-interfaz {
            height: auto;
            width: auto;
            padding-top: 140px;
            margin-top: 100px;
        }
        .container {
            background-color: #121631; /* Color de fondo del contenedor */
            padding: 40px; /* Ajustar el padding para darle más espacio al contenido */
            border-radius: 20px;
            box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
            width: 700px; /* Aumentar el ancho del contenedor */
            text-align: center;
            color: white;
            height: auto;
            margin: 35px 0; /* Margen supeior e inferior de 35px */
        }
        .container img {
            width: 50px;
            margin-bottom: 20px;
        }
        .container h1 {
            margin: 0;
            font-size: 24px;
        }
        .container a {
            margin: 10px 0;
            color: #ddd;
            font-size: 18px; /* Tamaño de fuente ajustado */
            cursor: pointer;
            text-decoration: none;
        }
        .container input[type="text"],
        .container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; /* Asegurarse de que el padding no aumente el tamaño total del input */
            background-color: transparent; /* Hacer el fondo de los inputs transparente */
            color: white; /* Cambiar el color del texto */
        }
        .container button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #1E8A82;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .container button:hover {
            background-color: #0f6862;
            text-decoration: underline;
        }
        .container button.seleccion-mat{
            background-color: transparent;
            border: 1px solid #ccc;
            max-width: 100%;
            width: 300px;
            border-radius: 5px;
            padding: 10px;
        }
        .divider {
            margin: 20px 0;
            border-bottom: 1px solid #ccc;
        }
        .info-extra {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }
        .info-extra input {
            width: 100%;
            padding: 5px; /* Inputs más pequeños */
            margin: 0; /* Quitar el margen entre inputs */
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; /* Asegurarse de que el padding no aumente el tamaño total del input */
            background-color: transparent; /* Hacer el fondo de los inputs transparente */
            color: white; /* Cambiar el color del texto */
        }
    </style>
</head>
<body>
<div class="contenido-interfaz">
    <div class="container">
        <img src="https://via.placeholder.com/50" alt="Logo">
        <h1>CREA TU CUENTA</h1>
        <h4>DOCENTE</h4>

        <div class="divider"></div>

        <!-- Formulario de registro -->
        <form action="<%=request.getContextPath()%>/RegistroEstudianteS" method="get">  <!-- cambiar el metodo al post, get solo fue momentáneo-->
            <input type="text" name="matricula" id="matricula_registro" placeholder="Matrícula">
            <input type="text" name="nombre" id="nombre" placeholder="Nombre">
            <input type="text" name="apellido" id="apellido" placeholder="Apellido">
            <input type="password" name="password" id="contrasena_registro" placeholder="Contraseña">
            <input type="password" name="confirmar_contrasena" id="confirmar_contrasena" placeholder="Confirmar contraseña">
            <div class="info-extra">
                <input type="text" name="div_aca" id="division_aca" placeholder="División Académica">
                <input type="text" name="carrera" id="carrera" placeholder="Carrera">
                <input type="text" name="grado" id="grado" placeholder="Grado">
                <input type="text" name="grupo" id="grupo" placeholder="Grupo">
            </div>
            <button type="button" class="seleccion-mat" data-toggle="modal" data-target="#materiasModal">Seleccionar materias</button>
            <button type="submit">Siguiente</button>
        </form>
    </div>
</div>

<!-- Modal de selección de materias -->
<div class="modal fade" id="materiasModal" tabindex="-1" role="dialog" aria-labelledby="materiasModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="materiasModalLabel">Seleccionar Materias</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="materiasForm">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="Matemáticas" id="materia1">
                        <label class="form-check-label" for="materia1">
                            Matemáticas
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="Física" id="materia2">
                        <label class="form-check-label" for="materia2">
                            Física
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="Química" id="materia3">
                        <label class="form-check-label" for="materia3">
                            Química
                        </label>
                    </div>
                    <!-- Agrega más materias según sea necesario -->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="guardarMateriasBtn">Guardar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    document.getElementById('guardarMateriasBtn').addEventListener('click', function() {
        var materiasSeleccionadas = [];
        $('#materiasForm input:checked').each(function() {
            materiasSeleccionadas.push($(this).val());
            $('#materiasModal').modal('hide');
        });

        // Aquí puedes enviar las materias seleccionadas a la base de datos
        $.ajax({
            type: 'POST',
            url: '<%=request.getContextPath()%>/GuardarMateriasServlet', // URL del servlet que maneja la lógica de guardado
            data: { materias: materiasSeleccionadas },
            success: function(response) {
                $('#materiasModal').modal('hide');
                // Puedes agregar más lógica aquí si es necesario
            }
        });
    });
</script>
</body>
</html>
