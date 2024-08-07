<%String context = request.getContextPath();%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de materias</title>
    <style>
        /* Estilos para el área de contenido principal */
        .content {
            flex-grow: 1;
            padding: 20px;
        }

        /* Estilos para cada tarjeta */
        .card {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            cursor: pointer;
            width: calc(25% - 20px); /* Calculamos el ancho de cada tarjeta */
            margin-right: 20px; /* Espacio entre tarjetas */
            margin-bottom: 20px; /* Espacio entre filas */
            float: left; /* Para asegurar que cada tarjeta se coloque en la misma fila */
        }

        .card img {
            width: 50px;
            margin-bottom: 10px;
        }

        .card p {
            margin: 0;
            color: #141C32;
        }

        /* Limpiar los floats para evitar problemas de diseño */
        .clearfix::after {
            content: "";
            display: table;
            clear: both;
        }

        /*EMPIEZA MODAL DE INTERFAZ */
        .div-modal{
            width: 100%;
            height: 80px;
            margin-top: 20px;
            position: relative;
        }
        .div-boton{
            height: 60px;
            width: 300px;
            margin-left: 709px;
            position: relative;
        }
        .boton-modal {
            position: absolute; /* Botón absoluto */
            top: 10px;
            right: 20px;
            left: auto;
            padding: 8px 10px;
            width: 80px;
            /*background-color: #1D815A;*/
            background-color: orange;
            color: white;
            border: none;
            border-radius: 60px;
            font-size: 16px;
            cursor: pointer;
        }
        .boton-modal label {
            position: absolute; /* Etiqueta absoluta */
            top: 0;
            left: 0;
            padding: 8px 20px;
            background-color: #1D815A;
            color: white;
            border-radius: 15px;
            cursor: pointer;
            transition: all 300ms ease;
        }
        .boton-modal:hover {
            background-color: #145A42;
        }

        .boton-modal label:hover {
            background-color: #145A42;
        }

        /* Ventana modal */
        #btn-modal {
            display: none;
        }

        .container-modal {
            width: 100%;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: rgba(144, 148, 150, 0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 100;
        }

        #btn-modal:checked ~ .container-modal {
            display: flex;
        }

        .content-modal {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background-color: #141C32;
            border-radius: 22px;
            text-align: center;
        }

        .content-modal h2 {
            margin-bottom: 15px;
            color: white;
        }

        .content-modal p {
            padding: 15px 0px;
            border-top: 1px solid rgb(245, 231, 231);
            border-bottom: 1px solid rgb(245, 231, 231);
        }

        .btn-cerrar {
            width: 100%;
            margin-top: 15px;
            display: flex;
            justify-content: flex-end;
        }

        .btn-cerrar label {
            padding: 7px 10px;
            font-weight: bold;
            font-size:small;
            background-color: #1E8A82;
            color: #141C32;
            border-radius: 15px;
            cursor: pointer;
            transition: all 300ms ease;
        }

        .btn-cerrar label:hover {
            background-color: #0f6862;
        }

        .contenedor-supremo{
            margin-left: 0;
        }
        .content-superior{
            width: calc(100% - 250px); /* Resto del ancho de barra-lateral */
            height: 100px; /* Ajustar la altura según se necesite */
            overflow: hidden;
            background-color: white;
            padding: 32px 15px;
            margin-left: 80px;
            position: fixed;
        }
        .titulo-interfaz{
            width: 400px;
            height: 100px;
        }
        .titulo-interfaz span{
            font-size: xx-large;
            color: #141C32; /* Añadir color para que el texto sea visible */
            font-weight: bold;
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
    </style>
</head>
<body>
<div class="content-superior">
    <div class="titulo-interfaz">
        <span>Seleccion Materias</span>
    </div>
    <div class="rol-actual">
        <span class="rol" id="asigna_rol">Docente</span>
        <img src="imagenes/busqueda.png" alt="rol" />
    </div>
</div>
<div class="contenedor-supremo">

    <div class="contenido">
        <div class="content">
            <!-- Diseño de cuadrícula para las tarjetas de materias -->

            <div class="grid">
                <!-- Tarjeta para cada materia -->
                <div class="card">
                    <img src="imagenes/diseno_icon.png" alt="Diseño">
                    <p>DISEÑO</p>
                </div>
                <div class="card">
                    <img src="imagenes/funciones_icon.png" alt="Funciones">
                    <p>FUNCIONES</p>
                </div>
                <div class="card">
                    <img src="imagenes/algebra_icon.png" alt="Álgebra">
                    <p>ÁLGEBRA</p>
                </div>
                <div class="card">
                    <img src="imagenes/poo_icon.png" alt="POO">
                    <p>POO</p>
                </div>
                <!-- Filas adicionales de materias -->
                <div class="card">
                    <img src="imagenes/diseno_icon.png" alt="Diseño">
                    <p>DISEÑO</p>
                </div>
                <div class="card">
                    <img src="imagenes/funciones_icon.png" alt="Funciones">
                    <p>FUNCIONES</p>
                </div>
                <div class="card">
                    <img src="imagenes/algebra_icon.png" alt="Álgebra">
                    <p>ÁLGEBRA</p>
                </div>
                <div class="card">
                    <img src="imagenes/poo_icon.png" alt="POO">
                    <p>POO</p>
                </div>
                <div class="card">
                    <img src="imagenes/diseno_icon.png" alt="Diseño">
                    <p>DISEÑO</p>
                </div>
                <div class="card">
                    <img src="imagenes/funciones_icon.png" alt="Funciones">
                    <p>FUNCIONES</p>
                </div>
                <div class="card">
                    <img src="imagenes/algebra_icon.png" alt="Álgebra">
                    <p>ÁLGEBRA</p>
                </div>
                <div class="card">
                    <img src="imagenes/poo_icon.png" alt="POO">
                    <p>POO</p>
                </div>
            </div>
            <!-- Limpiar floats al final de la cuadrícula -->
            <div class="clearfix"></div>
            <!-- boton abre modal mensaje -->
            <div class="div-modal">
                <div class="div-boton">
                    <div class="boton-modal">
                        <a href="<%=context%>/vistas/Docente/LoginDocente.jsp"><label>Enviar</label></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>

