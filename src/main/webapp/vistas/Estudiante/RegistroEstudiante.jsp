<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=context%>/css/cssFuenteLetra.css">
    <title>Registro estudiante</title>
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
            margin-top: 140px;
        }
        .container {
            background-color: #121631; /* Color de fondo del contenedor */
            padding: 40px; /* Ajustar el padding para darle más espacio al contenido */
            border-radius: 20px;
            box-shadow: 0 8px 16px 4px rgba(0, 0, 0, 0.4);
            width: 400px; /* Aumentar el ancho del contenedor */
            text-align: center;
            color: white;
            height: auto;
            margin: 35px; /* Margen superior e inferior de 35px */
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
        .container button:hover {
            text-decoration: underline;
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
        .container button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #1E8A82; /* Color del botón habilitado */
            color: white;
            font-size: 16px;
            cursor: pointer;
            opacity: 1; /* Totalmente visible */
            transition: background-color 0.3s, opacity 0.3s; /* Transiciones para suavizar el cambio de estado */
        }
        .container button:disabled {
            background-color: #6c757d; /* Color del botón deshabilitado */
            opacity: 0.6; /* Menos visible cuando está deshabilitado */
            cursor: not-allowed; /* Cambiar el cursor para indicar que está deshabilitado */
        }
        .container button:hover:not(:disabled) {
            background-color: #0f6862; /* Color del botón cuando está habilitado y se pasa el cursor por encima */
        }
        .error-message {
            color: #ff4d4d; /* Color del mensaje de error */
            font-size: 12px;
            margin-top: -8px; /* Ajustar la posición del mensaje si es necesario */
            margin-bottom: 10px;
            display: block; /* Asegurarse de que el mensaje ocupe toda la línea */
        }
        /* Estilo para el contenedor del select */
        .custom-select {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        /* Estilo para el select */
        .custom-select select {
            background-color: #121631;
            color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            width: 100%;
            box-sizing: border-box; /* Asegurarse de que el padding no aumente el tamaño total del select */
            font-size: 16px;
            cursor: pointer;
        }

        /* Estilo para la opción seleccionada */
        .custom-select select:focus {
            outline: none;
            border-color: #1E8A82; /* Color del borde al enfocar */
        }

        /* Estilo para el contenedor del select cuando se abre */
        .custom-select::after {
            content: '▼';
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            pointer-events: none;
            color: white;
        }

        /* Estilo opcional para la lista desplegable */
        .custom-select select option {
            background-color: #ffffff;
            color: #121631;
        }

    </style>
</head>
<body>
<div class="contenido-interfaz">
    <div class="container">
        <img src="<%=context%>/IMG/logoCalendario.png" class="img-fluid" style="width: auto; height: 50px;" alt="Logo">
        <h1>CREA TU CUENTA</h1>
        <h4>ESTUDIANTE</h4>

        <div class="divider"></div>

        <!-- Formulario de registro -->
        <form id="registro-form" action="<%=request.getContextPath()%>/RegistroEstudianteS" method="post">
            <input type="text" name="matricula" id="matricula_registro" placeholder="Matrícula">
            <span class="error-message" id="matricula-error" style="display: none;">La matricula es obligatoria</span>

            <input type="text" name="nombre" id="nombre" placeholder="Nombre">
            <span class="error-message" id="nombre-error" style="display: none;">El nombre es obligatorio</span>

            <input type="text" name="apellido" id="apellido" placeholder="Apellido">
            <span class="error-message" id="apellido-error" style="display: none;">El apellido es obligatorio</span>

            <input type="password" name="password" id="contrasena_registro" placeholder="Contraseña">
            <span class="error-message" id="password-error" style="display: none;">La contraseña es obligatoria</span>

            <!--<input type="text" name="email" id="email" placeholder="Correo electronico">
            <span class="error-message" id="email-error" style="display: none;">El correo debe terminar en @utez.edu.mx</span>-->

            <div class="custom-select">
                <label for="division_aca">División Académica:</label>
                <select name="div_aca" id="division_aca">
                    <option value="" disabled selected>Selecciona una división académica</option>
                    <option value="ingenieria">DATID</option>
                    <option value="ciencias">DAMI</option>
                    <option value="humanidades">DACEA</option>
                </select>

                <label for="carrera">Carrera:</label>
                <select name="carrera" id="carrera">
                    <option value="" disabled selected>Selecciona una carrera</option>
                    <!-- Las opciones se llenarán dinámicamente -->
                </select>


                <label for="Cuatrimestre">Cuatrimestre:</label>
                <select name="Cuatrimestre" id="Cuatrimestre">
                    <option value="">Selecciona una opción</option>
                    <option value="1">1er Cuatrimestre</option>
                    <option value="2">2do Cuatrimestre</option>
                    <option value="3">3er Cuatrimestre</option>
                    <option value="4">4to Cuatrimestre</option>
                    <option value="5">5to Cuatrimestre</option>
                    <!-- Añadir más opciones aquí -->
                </select>

                <label for="grupo">Grupo:</label>
                <select name="grupo" id="grupo">
                    <option value="">Selecciona una opción</option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="E">E</option>
                    <option value="F">F</option>
                    <option value="G">G</option>
                    <!-- Añadir más opciones aquí -->
                </select>

            </div>
            <button type="submit" id="submit-button" disabled>Siguiente</button>
        </form>

    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const divisionSelect = document.getElementById('division_aca');
        const carreraSelect = document.getElementById('carrera');

        // Definir las opciones dependiendo de la división académica
        const options = {
            'ingenieria': [
                { value: 'sistemas', text: 'Ingeniería en Sistemas' },
                { value: 'industrial', text: 'Ingeniería Industrial' }
            ],
            'ciencias': [
                { value: 'biologia', text: 'Biología' },
                { value: 'quimica', text: 'Química' }
            ],
            'humanidades': [
                { value: 'historia', text: 'Historia' },
                { value: 'filosofia', text: 'Filosofía' }
            ]
        };

        // Función para actualizar las opciones de "Carrera"
        function updateCarreraOptions() {
            const selectedDivision = divisionSelect.value;
            const carreras = options[selectedDivision] || [];

            // Limpiar las opciones actuales
            carreraSelect.innerHTML = '<option value="" disabled selected>Selecciona una carrera</option>';

            // Agregar las nuevas opciones
            carreras.forEach(carrera => {
                const option = document.createElement('option');
                option.value = carrera.value;
                option.textContent = carrera.text;
                carreraSelect.appendChild(option);
            });
        }

        // Añadir un evento para actualizar las opciones de carrera cuando cambia la división académica
        divisionSelect.addEventListener('change', updateCarreraOptions);
    });
</script>
<script>
    // Función para verificar si todos los campos están llenos y si el correo tiene la terminación correcta
    function checkForm() {
        const submitButton = document.getElementById('submit-button');
        const emailInput = document.getElementById('email');
        let allFilled = true;
        let validEmail = true;

        // Validación para Contraseña
        const contrasenaInput = document.getElementById('contrasena_registro');
        const contrasenaError = document.getElementById('password-error');
        if (!contrasenaInput.value.trim() || contrasenaInput.value.trim().length < 3) {
            allFilled = false;
            contrasenaError.style.display = 'block';
        } else {
            contrasenaError.style.display = 'none';
        }

        // Validación para Matrícula
        const matriculaInput = document.getElementById('matricula_registro');
        const matriculaError = document.getElementById('matricula-error');
        if (!matriculaInput.value.trim()) {
            allFilled = false;
            matriculaError.style.display = 'block';
        } else {
            matriculaError.style.display = 'none';
        }

        // Validación para Nombre (mínimo 3 letras, sin números, permite acentos)
        const nombreInput = document.getElementById('nombre');
        const nombreError = document.getElementById('nombre-error');
        const nombrePattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ]{3,}$/;
        if (!nombrePattern.test(nombreInput.value.trim())) {
            allFilled = false;
            nombreError.style.display = 'block';
        } else {
            nombreError.style.display = 'none';
        }

// Validación para Apellido (mínimo 5 letras por apellido, permite acentos, sin números)
        const apellidoInput = document.getElementById('apellido');
        const apellidoError = document.getElementById('apellido-error');
        const apellidoPattern = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,}(?:\s[a-zA-ZáéíóúÁÉÍÓÚñÑ]{5,})?$/;
        if (!apellidoPattern.test(apellidoInput.value.trim())) {
            allFilled = false;
            apellidoError.style.display = 'block';
        } else {
            apellidoError.style.display = 'none';
        }


        /*// Validar que el email termine en @utez.edu.mx
        const emailPattern = /^[a-zA-Z]{3,}[^\s@]*@utez\.edu\.mx$/;
        if (!emailInput.value.trim() || !emailPattern.test(emailInput.value.trim())) {
            allFilled = false;
            document.getElementById('email-error').style.display = 'block';
        } else {
            document.getElementById('email-error').style.display = 'none';
        }*/

        // Validación para campos desplegables
        const selectFields = document.querySelectorAll('#registro-form select');
        selectFields.forEach(select => {
            const value = select.value.trim();
            if (!value) {
                allFilled = false;
            }
        });

        // Habilitar o deshabilitar el botón de envío
        submitButton.disabled = !(allFilled && validEmail);
    }

    // Añadir eventos de escucha a los inputs y selects para verificar el formulario en tiempo real
    document.querySelectorAll('#registro-form input, #registro-form select').forEach(element => {
        element.addEventListener('input', checkForm);
        element.addEventListener('change', checkForm);
    });

    // Verificar el formulario cuando se carga la página
    checkForm();
</script>

</body>
</html>
