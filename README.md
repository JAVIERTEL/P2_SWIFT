# Práctica 4.2 - Quiz con SwiftUI
*3 de Diciembre de 2023*

## Enunciado
Modifica la Práctica 4.1 - Quiz con Swift, añadiendo las dos tareas obligatorias y las mejoras opcionales que se describen a continuación.

### Tarea obligatoria 1: Descargar los quizzes de un servidor
Modifica la práctica para que los quizzes no se carguen del fichero quizzes.json, sino que se descarguen de la URL:

https://quiz.dit.upm.es/api/quizzes/random10?token=TOKEN

Añade en la barra del NavigationStack un botón que permita recargar otros 10 quizzes de forma aleatoria. El contador de los quizzes acertados debe reiniciarse a 0 cada vez que se descarguen nuevos quizzes. Es obligatorio hacer que la aplicación responda con suavidad y que no se bloquee cuando hay problemas de acceso al servidor para descargar las fotos o los quizzes.

### Tarea obligatoria 2: Comprobar respuestas
El JSON con los quizzes descargado del servidor no incluye las respuestas de los quizzes. Para comprobar si una respuesta es correcta, debe realizarse una petición HTTP de tipo GET a la siguiente URL:

https://quiz.dit.upm.es/api/quizzes/quizId/check?answer=RESPUESTA&token=TOKEN


En la query de la petición, se debe añadir la variable answer con el valor de la respuesta que se quiere comprobar. Este valor debe escaparse adecuadamente para no introducir caracteres no permitidos en las queries.

Si la respuesta introducida es incorrecta, la petición devuelve un código de respuesta 200 y un objeto con un campo result con el valor false:

{
  "quizId": 3,
  "answer": "mi_respuesta",
  "result": false
}

Si la respuesta es correcta, la petición devuelve un objeto con campo result con el valor true:
{
  "quizId": 3,
  "answer": "madrid",
  "result": true
}
### Mejora opcional 1: Actualizar Favoritos
Actualmente, la pantalla de jugar a un quiz muestra una imagen con una estrella iluminada o apagada para indicar si un quiz es favorito del usuario o no.

Esta tarea consiste en convertir esa imagen en un botón que cambie el valor de favorito de ese quiz en el servidor quiz.dit.upm.es y en la app.

Para marcar como favorito un quiz, dado su id, para el usuario asociado al token de la petición, hay que realizar una petición PUT a la ruta:


/users/tokenOwner/favourites/quizId?token=TOKEN
Y para desmarcarlo hay que realizar una petición DELETE a la ruta:

/users/tokenOwner/favourites/quizId?token=TOKEN
Si las peticiones se realizan con éxito, el código de la respuesta HTTP será 200, y se devuelve un JSON con el id del quiz y el estado final del valor favourite (true o false):

json
Copy code
{
  "id": 3,
  "favourite": true
}
Es obligatorio hacer que la aplicación responda con suavidad y no se bloquee cuando hay problemas de acceso al servidor para actualizar el campo favorito.

### Mejora opcional 2: Menú contextual
Modifica la pantalla de jugar a adivinar un quiz para añadir un menú contextual sobre la foto del autor.

Este menú debe ofrecer dos entradas, una para limpiar el contenido del TextField de la respuesta, y otra para rellenar ese TextField con la respuesta correcta. La respuesta correcta se puede descargar del servidor realizando una petición HTTP de tipo GET a la siguiente URL:

https://quiz.dit.upm.es/api/quizzes/quizId/answer?token=TOKEN
Devuelve un código HTTP 200 y objeto con un campo answer conteniendo la respuesta correcta:

{
  "quizId": 3,
  "answer": "respuesta_correcta"
}
### Mejora opcional 3: Gestos y Animaciones
Modifica la pantalla de jugar a adivinar un quiz para que al hacer un gesto doble Tap sobre la fotografía del adjunto se rellene el TextField de la respuesta con la respuesta correcta.

Añade también una animación cuando esto ocurra. Elige la animación que desees.

### Mejora opcional 4: Filtrar acertados
Añade en la pantalla inicial (la del listado de quizzes) un control (Toggle) para indicar si se desean ver todos los quizzes o solo los quizzes que no se han acertado aún.

### Mejora opcional 5: Record Persistente
Añade en la pantalla principal de la app un nuevo contador que muestre el número total de quizzes diferentes que se han acertado desde la primera vez que se lanzó la app.

Guarda esta información en las preferencias de usuario.
