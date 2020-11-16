# TP Objetos: Barrilete Cósmico - Entrega 1 

La famosísima agencia de turismo Barrilete Cósmico nos ha pedido que le desarrollemos un pequeño sistema para poder hacer más eficiente su operatoria. 
Barrilete Cósmico vende vuelos a distintos destinos que tiene a su disposición a los usuarios de su plataforma, y cada usuario tiene un historial de los destinos que visitó.

## Destinos

De cada Destino, conocemos su nombre, distintas sugerencias de viaje y el precio de volar a ese lugar. Dentro de los destinos que ofrece, por el momento podemos encontrar:

![destinos](https://raw.githubusercontent.com/pdep-noche-mavi/tp-grupal-objetos/master/destinos.png "Destinos")


## Barrilete Cósmico

Para la primera versión de nuestro sistema, Barrilete Cósmico debe poder:

1. Obtener los destinos más importantes: Son todos los destinos destacados. Un destino destacado es aquel que tiene un precio mayor a $2000.
2. Aplicar descuentos a los destinos: Aunque no lo crean, a veces se quiere aplicar un descuento específico a los precios de todos los destinos (sí, ¡descuentos a todos los destinos!). Aplicar un descuento implica, además de cambiar el precio del destino, agregar en el equipaje imprescindible el “Certificado de descuento”.
3. Saber si es una empresa extrema: La empresa es extrema si alguno de sus destinos destacados es peligroso, es decir, requiere que llevemos alguna vacuna.
4. Conocer su carta de destinos: De esta forma, la agencia va a poder mostrar el nombre de todos los destinos que ofrece.

## Usuarios

Como Barrilete Cósmico está recién migrando a un sistema realizado por nuestro equipo sólo cuenta con un usuario: Pablo Hari.

Pablo Hari tiene un nombre de usuario (PHari) y sabemos que conoce Last Toninas y Good Airs, y que cuenta con $1500 en su cuenta de Barrilete Cósmico. También tiene a la lista de usuarios a los cuales sigue, pero aún está vacía por ser el único dentro de la plataforma.

Tanto PHari, como los usuarios que luego tenga la plataforma deben ser capaces de:

* **Volar a un destino:** Al volar a un destino, éste es agregado al historial del usuario de lugares visitados y se le descuenta el costo del mismo. Obviamente hay que contemplar que el usuario pueda viajar a ese destino.

* **Obtener los kilómetros de un usuario:** los usuarios poseen una cantidad de kilómetros disponibles en su perfil. Las mismas se calculan como el 10%  de la suma de los precios de los destinos que visitó.

* **Seguir Usuario:** Un usuario podrá seguir a otro para saber de sus actividades recientes. Cuando un usuario sigue a otro el otro le devuelve la seguida.


## Tests

Como toda agencia de turismo, queremos probar que nuestro sistema funcione de la manera intencionada. Para eso, ¡vamos a utilizar tests!
Asegúrense de tener un test por cada clase de equivalencia en todos los métodos que les resulten interesantes de testear. Especial atención con los nombres de los tests!

# Entrega 2

¡Barrilete Cósmico no para de crecer! Y todo gracias al sistema que estuvimos realizando. Aunque no siempre todo va viento en popa… Tenemos que cumplir los nuevos requisitos que van surgiendo, aunque eso signifique cambiar el código que ya estaba hecho. Pero, ¡a no preocuparse! Cada vez contamos con más herramientas (gracias a los temas que estuvimos viendo) que van a mejorar nuestra solución, al mismo tiempo que agregamos nuevas funcionalidades. ¡Empecemos!

## Medios de transporte

Si bien antes Barrilete Cósmico sólo realizaba vuelos, se dieron cuenta que de esa forma no puede llegar a todos los destinos ya que hay varios lugares sin aeropuertos. Así que ahora cuenta con distintos medios de transporte de los cuales, por ahora, sólo sabemos cuánto tardan y cuánto cuesta cada kilómetro que recorren. 

## Localidades

En las épocas en que Barrilete Cósmico sólo realizaba vuelos, hablábamos de destinos. 
Pero, lo que es un destino para un usuario, puede ser el origen de otro… Nos dimos cuenta tarde de eso. Por eso hablar de destinos es confuso si queremos seguir extendiendo nuestro sistema, así que ahora vamos a hablar de localidades.

Cada localidad va a contar con los mismos atributos y el mismo comportamiento con el que contaban nuestros destinos pero también vamos a sumar algunas cosas nuevas.

Las localidades deberán saber en qué kilómetro se ubican y deberán poder calcular la distancia a otra localidad.

Por ejemplo:

Si General Las Heras se encuentra en el kilómetro 87 y CABA en el kilómetro 187. La distancia entre General Las Heras y CABA es de 100 kilómetros. (También es esa la distancia entre CABA Y General Las Heras).

## Viajes

En nuestra primera versión el precio que un usuario pagaba estaba determinado por el destino pero ahora sabemos que esto no esto no es del todo correcto, ya que además del precio del destino, también debemos cobrar el transporte… Un usuario va a hacer un viaje desde una localidad de origen a otra de destino, a través de un medio de transporte. De esta manera, el precio del viaje va a estar determinado por la cantidad de kilómetros a recorrer en ese transporte más el precio del destino en cuestión.

## Usuarios 

¡Cada vez más gente utiliza a Barrilete Cósmico! Así que ahora Pablo Hari no es nuestro único usuario y tenemos que adaptarnos a este crecimiento. Pero ¡ojo!, tenemos que ver cómo hacerlo sin repetir lógica entre todos ellos y teniendo en cuenta que van a haber unos cambios:

Cada usuario contará con su localidad de origen. 
Antes cada usuario tenía destinos, ahora tendrá viajes.
Los kilómetros de cada usuario estarán determinados por la suma de las distancias entre los orígenes y destinos de cada viaje que realizó.
Los usuarios ya no solamente vuelan a destinos a través de Barrilete Cósmico sino que la empresa ahora arma viajes para ellos en otros medios de transporte. Tener en cuenta que una vez que un usuario viaja, su localidad de origen será el destino al que viajó.


## Barrilete Cósmico

Cuando Barrilete Cósmico arma un viaje para un usuario establece como localidad de origen la del mismo, como localidad de destino la especificada y como medio de transporte, elige uno al azar de entre todos los que posee.

## Tests

Tener en cuenta que quizás sea necesario actualizar los tests de la entrega anterior para que sigan funcionando.
Y nuevamente, asegúrense de tener un test por cada clase de equivalencia en todos los métodos que les resulten interesantes de testear y mantener especial atención con los nombres de los tests!
