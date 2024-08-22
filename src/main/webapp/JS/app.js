document.addEventListener('DOMContentLoaded', () => {
    const stars = document.querySelectorAll(".star");
    const ratingInput = document.getElementById("calificacion");
    const asesoriaIdInput = document.getElementById("asesoriaId");
    const estudianteIdInput = document.getElementById("estudianteId");
    const ratingForm = document.getElementById("ratingForm");

    let currentRating = 0;

    // Evento clic para cada estrella
    stars.forEach((star, index) => {
        star.addEventListener("click", () => {
            currentRating = index + 1;
            updateStarRating(currentRating);
            ratingInput.value = currentRating; // Asigna la calificación seleccionada
        });
    });

    // Función para actualizar la interfaz de usuario
    function updateStarRating(rating) {
        stars.forEach((star, index) => {
            star.classList.toggle("checked", index < rating);
        });
    }

    window.putId = function(idAsesoria, idEstudiante) {
        asesoriaIdInput.value = idAsesoria;
        estudianteIdInput.value = idEstudiante;
    };

    // Enviar la calificación al servidor cuando se envía el formulario
    ratingForm.addEventListener('submit', (event) => {
        event.preventDefault(); // Evita el comportamiento por defecto del formulario

        fetch('http://localhost:8081/SGAA_war_exploded/CalificarEstuditeS', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams(new FormData(ratingForm)).toString(), // Envía los datos del formulario como URL encoded
        })
            .then(response => response.text())
            .then(result => {
                console.log(result);
                // Cerrar el modal después de enviar la calificación
                const modal = bootstrap.Modal.getInstance(document.getElementById('exampleModal'));
                modal.hide();
            })
            .catch(error => {
                console.error('Error:', error);
            });
    });

    // Resetea las estrellas cuando se cierra el modal
    const modalElement = document.getElementById('exampleModal');
    modalElement.addEventListener('hidden.bs.modal', () => {
        currentRating = 0;
        updateStarRating(currentRating);
        ratingInput.value = ''; // Limpia el valor del input de calificación
        asesoriaIdInput.value = ''; // Limpia el valor del input de id de asesoría
        estudianteIdInput.value = ''; // Limpia el valor del input de id de estudiante
        document.getElementById("calificacion").value = 0;
    });


});
