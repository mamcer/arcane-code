# Trabajo especial 99

Trabajo especial de Análisis y Diseño de Algoritmos I - 1999
Codificador y decodificador de código Morse
Los espías de la Facultad de Ciencias Exactas a menudo se enfrentan al problema de
transmitir información codificada en Morse (u otro sistema en formato de raya punto) y,
análogamente, recibir mensajes en tal formato.  Les resulta sumamente costoso en tiempo la
operación manual con el Morse.  Por  tal motivo, la DEA (Departamento de Espías
Académicos) recurrió a la cátedra de Algoritmos, a efectos de que esta les provea de una
herramienta informática que les facilite la tarea de transmitir tales mensajes.
A partir de esta grave problemática surgió la idea de utilizar como trabajo de cátedra la
construcción de esta aplicación.
La funcionalidad del programa consistiría en tomar como entrada un archivo de textos, ya
sea un mensaje a codificar o uno codificado, y un código Morse (también en forma de
archivo de texto) y devolver el correspondiente mensaje codificado o decodificado según
corresponda.
Proceso de codificación:
Proceso de decodificación:
El programa deberá leer de la línea de comandos la orden de la operación a efectuar
(mediante un modificador), la ubicación y el nombre de los archivos con el código Morse y
el mensaje a codificar o decodificar según corresponda.  Por ejemplo:
C:\>morse –c codigos.txt mensaje.txt
o bien
C:\>morse –d codigos.txt mensaje.mor
La salida de la primera acción debe ser el archivo “mensaje.mor” con la codificación,
mientras que la del segundo debe ser el archivo  “mensaje.txt” con el texto plano.Mensaje a
codificarCodificación Mensaje
codificado
Código Morse
Mensaje a
decodificarDecodificación Mensaje
decodificado
Código Morse

El archivo con el código morse tendrá el siguiente formato:
<letra>:<código>
por ejemplo:
A:.-
B:-...
C:-.-.
D:-..
La presentación del trabajo deberá contar con el código C++ escrito para resolver el
problema, el ejecutable correspondiente y un informe que contenga al menos los siguientes
puntos:
• Introducción al problema;
• Especificación algebraica de los tipos de datos abstractos utilizados;
• Detalles de las decisiones de diseño;
• Análisis de complejidad temporal de los algoritmos de codificación  y
decodificación;
• Conclusiones.
La presentación del trabajo es de carácter obligatorio.  La fecha de entrega final del mismo
queda fijada para el 28 de junio de 1999.  El trabajo podrá ser entregado en grupos de una o
dos personas, quienes deberán anotarse en las teorías o prácticas hasta el 24 / 05.  A partir
de esa fecha la cátedra asignará un ayudante a cada grupo, ante quién deberán presentar el
trabajo.

