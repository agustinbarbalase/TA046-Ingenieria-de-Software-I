# Números

## Primera parte

Hacer file-in del archivo Numeros-Parte1-Ejercicio.st.

Como se observa, contamos con una clase Numero que representa un modelo de números. En particular soporta operaciones de enteros y de fracciones.
Contamos con una suite de tests que verifica una serie de operaciones básicas que soporta nuestro modelo.

El objetivo de esta primera parte es quitar los ifs utilizando polimorfismo, aplicando el algoritmo que vimos en clase. 

Los tests deben seguir pasando (sin modificarlos).

## Segunda parte

Para esta segunda parte, deben previamente quitar la categoría Numeros-Parte1-Ejercicio, y luego hacer file-in de Numeros-Parte2-Ejercicio.st.

Este segundo modelo presentado es una posible solución de la primera parte, pero agregando nuevas operaciones: resta, división y fibonacci.

Como podrán ver cuando corran los tests, hay varios que funcionan y son los correspondientes a cuando se opera aritméticamente entre números del mismo tipo, o sea entre enteros o entre fracciones. Los test que fallan son los relacionados a las operaciones entre números de distinto tipo, es decir, entre enteros y fracciones y viceversa.

El objetivo de este ejercicio es que implementen la suma, la resta, la multiplicación y la división entre números enteros y fraccionarios.

La solución final no debe tener if en los métodos que deben implementar y todos los test deben funcionar (sin ser modificados!).

### Fibonacci

Una vez finalizado todo lo anterior, se pide llevar al extremo el reemplazo de if por polimorfismo: Deben quitar los ifs de #fibonacci. 

Las soluciones a este desafío son muy interesantes y distintas para lenguajes de prototipación (ej. javascript) vs clasificación.

**Pasos a seguir para resolver la parte 2:**

1. Antes de empezar a resolver el problema, debuggeen los tests que funcionan para entender cómo es el modelo que se está presentando. Analicen las clases Numero, Entero y Fraccion.
2. Una vez que se sientan cómodos con el modelo, hagan pasar todos los tests implementando lo necesario utilizando ifs. 
3. Una vez que los tests pasen, apliquen el algoritmo que vimos en clase para reemplazar if por polimorfismo.
4. Por último, apliquen el algoritmo y las técnicas vistas en clase para quitar los ifs de #fibonacci.

Para la entrega, deben hacer file-out de la solución a esta segunda parte. No es necesario entregar la solución a la primera parte.

**Algunas aclaraciones:**

- Las fracciones no pueden tener denominador 1. Fracciones con denominador 1 se asumen enteros.
- Los enteros no pueden responder los mensajes #numerador y #denominador ya que no son fracciones.
- Cuando se opera aritméticamente con enteros, verán que se utilizan las operaciones aritméticas provistas por el sistema. Esto es para que sea más performante.

## Desafío Adicional (opcional, no resta, sólo otorga puntos extra)

Aquellos que estén interesados en seguir llevando al extremo el reemplazo de if por polimorfismo (y practicar para el parcial), traten de sacar el resto los ifs que ya venían en el ejercicio inicialmente: Los tienen que ver con que no se puede dividir por cero, que el denominador no puede ser uno, etc... Los van a encontrar en #with:over:


## Preguntas teóricas

### Aporte de los mensajes de DD
En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

```
En los dos llamados pertenecientes a un double dispatch el primero, en el cual, el primer de los objetos que colabora y conoce su "tipo" le indica la accion a realizar el colaborador externo, el segundo es la implementacion en si, donde el colaborador externo posee la implementacion (metodo) de la accion a realizar 
```

### Lógica de instanciado
Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

```
El mejor lugar para tener la logica de instanciar a un objeto, es en la clase, ya que esta todo en un mismo lugar centralizado. Lo que permite mas facil, añadir logica. Si el objeto se crea de diferentes formas, se podria resolver con un switch dinamico, es decir, subclasificar y preguntarle a las diferentes clases si son o no de su categoria e instanciarlas. Y si se crean en diferentes lugares, no importa porque la clase principal sabra encontrar la clase que le corresponde con el switch dinam
```

### Nombres de las categorías de métodos
Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

```
Para definir un conjunto de comportamientos parecidos entre si. Ejemplo de esto, un numero puede operar aritmeticamente, por lo tanto, existe la categoria "arithmetic methods", una categoria que engloba la creacion de instancias de numeros "initialization". Esto tambien permite categorizar e identificar mejor la teoria que se esta modelando.   
```

### Subclass Responsibility
Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

```
Ese mensaje sirve para poder indicar explicitamente a una clase que posee un mensaje que cumple con determinado contrato, pero que, por si sola no es capaz de responder, permitiendo asi, a las subclasses ser las responsables de modelar el comportamiento de dicho mensaje (metodo) y dando paso al uso de polimorfismo 
```

### No rompas
¿Por qué está mal/qué problemas trae romper encapsulamiento?
```
Acceder a los colaboradores internos de un objeto rompe toda la abstraccion que podria tener aportar a un diseño. En caso de necesitar algo de un colaborador interno, siempre el objeto que lo posee puede realizar la accion de mediador e intervenir entre dos instancias de objetos que necesiten colaborar. Tambien esto elimina el acoplamiento que hay entre los dos objetos, por ejemplo, si se tiene un objeto que almacena numeros mediante un colaborador que sea alguna especie de coleccion, realizar un futuro cambio sobre el diseño en caso de que este roto el encapsulamiento traeria problemas ya que hay que cambiar 2 las implementaciones de los dos objetos que intervengan, por otro lado, si el encapsulamiento se mantiene y el objeto que realiza la colaboracion es agnostico al tipo de coleccion que se esta utilizando el cambio a realizar es mucho menor 
```
