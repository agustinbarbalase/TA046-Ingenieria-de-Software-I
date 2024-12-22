[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/ESU_h1xF)
# Código Repetido

Este ejercicio tiene por objetivo que saquen el código repetido que encuentren en el modelo y en los tests. Por ej. entre el test01 y test02.

Los tests provistos ya funcionan, simplemente hay que sacar el código repetido y los tests deben seguir funcionando.

Se pueden modificar las clases provistas, sólo para eliminar código repetido. No se puede modificar lo que verifican los tests. O sea, sólo se puede hacer un cambio de diseño de tal manera que siga testeando lo mismo, que la funcionalidad sea la misma, pero que no haya código repetido.

Aclaración: Para hacer este ejercicio más sencillo se modela a un Customer utilizando un String en vez de una clase Customer. No es el objetivo del ejercicio que ustedes corrijan esta decisión, ni las consecuencias que trae consigo (por ej. que no se pueda agregar al CustomerBook dos Customers diferentes con el mismo nombre).


# Preguntas

## Abstracción de los tests 01 y 02 

En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

```
Lo que creamos es un mensaje, que permite medir cuanto tiempo le toma a un bloque de codigo
(closure) ejecutarse. En la realidad, estariamos modelando un cronómetro, que mida cuanto
tiempo tomo una accion en llevarse a cabo.
```

## Cómo representar en Smalltalk

¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

```
Las formas en que podemos representar entes de la realidad, es a traves de clases, objetos e
instancias. Los objetos son entidades concretas de la realidad que tiene caracteristicas especificas. 

Las clases son idealizaciones de la realidad, es decir, si modelamos la clase "Silla" entendemos por 
esta como: "Un objeto de cuatro patas en el que nos podemos sentar", sin embargo el concepto de silla varia, 
porque una silla puede ser de un determinado color o tamaño. Dicho de otra forma, cada silla tiene propiedades
accidentales diferentes. Las instancias son entidades concretas de un clase.
```

## Teoría de Naur

¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

```
En su paper, Naur nos explica la programacion como la construccion de una teoria, al quitar codigo repetido o crear abstracciones
lo que estamos haciendo es simplificar nuestra teoria y hacerla mas entendible para el humano. Al igual que los fisicos, 
simplifican o abstraen cierta realidad. 

Construir una teoria requiere la representacion y entenderla con el codigo que estamos desarrollando. La construccion de buenas
teorias nos permiten construir modelos reutiblizables, ya que cada teoria modela una parte de realidad lo que nos permitira en un
futuro reutilizarla y asi evitar el codigo repetido.
```
