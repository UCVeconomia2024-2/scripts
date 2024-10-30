##########################################################################################
# códigos ejecutados en la Consola en la clase 4. La idea es conocer la Command Line
# o Consola, previo a escribir los códigos en el editor, que es donde están anotadas las 
# instrucciones. Para poder reproducir la actividad, se colocan nuevamente lo que se hizo
# acompañada de algunos comentarios que ilustren el objetivo del ejercicio
##########################################################################################


# la siguiente instrucción no la ejecutamos, pero sirve para limpiar nuestros espacio de 
# trabajo
rm(list=ls())

##########################################################################################
# operación suma
3+5+8

##########################################################################################
# Funciones precargadas: estas son una muestra muy pequeña de algunas de las funciones que
# el lenguaje R trae precargadas

##########################################################################################
# seq: secuencia numérica
seq(50:120)
seq(from=50, to=120)
# es importante notar la indicación que aparece en la Consola al inicio de cada línea
# por ejemplo  [1] [37] (cambia según el ancho en pantalla y la resolución de pantalla
# que tenga la Consola, teniendo como elemento importante que nos indica de toda la
# secuencia cuál es el índice del primer elemento que se imprime en cada una de las filas)

##########################################################################################
# generar valores aleatorios que corresponden a una distribución normal
# el argumento indicado corresponde a la cantidad de valores que conformarán la 
# distribución normal rnorm()
rnorm(123)

##########################################################################################
# La función mean permite obtener la media de un conjunto de valores. En este caso 
# la media de 100 valores que conforman una distribución normal
mean(abs(rnorm(100))) 
# Recordar que la distribución normal tiene una media que tiende a cero y varianza de 1
# Un elemento a observar es que estamos usando dos funciones de forma "anidada", es decir,
# una dentro de otra. La ejecución se da desde la función más anidada, hacia la externa, 
# siendo en este caso que primero se generan los 100 valores aleatórios y una vez que R los
# tiene generados, procede a calcular la media, cuestión que no se aprecia para el usuario
# ya que se ve es el resultado final del valor promedio

##########################################################################################

# función para representar un histograma hist() .
# (representación gráfica de una variable en forma de barras, donde la superficie de 
# cada barra es proporcional a la frecuencia de los valores representados). 
# Al ejecutar esta función en la sección derecha inferior de RStudio, en la pestaña "Plots"
# aparecerá el gráfico con la representación
hist(rnorm(100))

# hacer el ejercicio de ir incrementando de 100, 1000, 10000 los valores a generar para 
# ver en la simulación el comportamiento de la gráfica de representación de la normal

# Igualmente ejecutar
?hist
# que lleva al menú de "Help" (ayuda) en la sección derecha-inferior. Ahí podrá obtener el
# la descripción de la función y cuáles son los argumentos. Puede incluir otros argumentos,
# como por ejemplo, variar el argumento breaks para experimentar qué ocurre con la gráfica
hist(rnorm(100), breaks = 10)

##########################################################################################
# Para los siguientes códigos, que no se ejecutan correctamente, apoyarse con las páginas 
# 5 y 6 del libro Hands On Programming de G Grotlemund. Las coloco con comentario ya que 
# van a dar error y el editor de código (RStudio) al detectar que están mal escritas, 
# genera una serie de advertencias. Debe descomentar cada línea para ver errores que 
# aparecen

#5 - 
#3 % 5
# 2+’p’
# Uso # al inicio

##########################################################################################
# Volvemos a las funciones precargadas


# Suma: a diferencia del uso del signo +, también se cuenta con la función sum donde se 
# suman todos los valores que estén dentro de los paréntesis
sum(1,2,6,8)

##########################################################################################
# Raíz cuadrada: sqrt()
sqrt(16)

sqrt(c(1,2,4,9))

# es importante notar que se introdujo de argumento un vector con cuatro elementos. 
# Los vectoresvienen definidos por la letra c seguida de paréntesis c(). 
# En la próxima clase abordaremos la definición de vectores. Sin embargo, lo importante es 
# observar que se generó la raíz cuadrada de cada elemento del vector.


##########################################################################################
# Sección 2 clase. Salimos de la Consola y retornamos al editor de código
##########################################################################################
# La siguiente sección se encuentra en el archivo "clase_04_parte2.qmd" en un 
# formato más "amable"

# Se inspecciona un conjunto de datos (dataset) que trae pregargado R

##########################################################################################
View(cars) # visualizar conjunto de datos
?cars # investigar cuál información contiene el conjunto
sum(cars$speed) # sumar todos los valores presentes en la columna speed. Luego se explicará
# el papel que juega el signo $ presente en la expresión anterior
mean(cars$dist) # obtener valor promedio de la columna distancia


# Visualización valores del conjunto de datos
# En cada gráfico que generemos mejoraremos la visualización representada
plot(cars) # función plot para representar puntos generados por speed y dist

# Añadir etiquetas en los ejes
plot(cars,
     xlab = "Velocidad (mph)", 
     ylab = "Distancia detenido (ft) ")

# Observar que a nivel de código, en la línea 117 y 118 queda un espacio al inicio de la 
# cada línea. Ese espacio lo coloca automáticamente el editor de código, si estamos 
# escribiendo el código de una función que inicia en la línea 116 y luego apretamos enter.
# Esos espacios que aparecen, se llaman indentado, y son de ayuda para leer el código de 
# una forma más legible. Al avanzar en las otras clases, se comprenderá mejor de qué va esto



# Gráfico de dispersión
# Los gráficos de dispersión pueden ayudar a visualizar cualquier relación lineal entre la
# variable dependiente (respuesta) y las variables independientes (predictoras). 
# Lo ideal es que, si se dispone de múltiples variables predictoras, 
# se dibuje un gráfico de dispersión para cada una de ellas frente a la respuesta
scatter.smooth(x=cars$dist,
               y=cars$speed, 
               main="Distancia ~ Velocidad")  
# Analizar cuál es la relación que pueden presentar las dos variables


# si el gráfico lo represento de esta forma, tiene el mismo significado?
# cuál puede ser la relación que presuponemos que tienen las variables?
scatter.smooth(y=cars$dist,
               x=cars$speed, 
               main="Distancia ~ Velocidad")  

# Si el comportamiento de dependencia cumple determinados supuestos, se puede predecir?
# Se puede modelar?

# La siguiente sección usa una librería llamada ggplot2 para crear el gráfico que tiene #
# mucho mejor aspecto. Luego, en clases venideras, se explicará línea a línea, cómo se 
# creó el gráfico pero se coloca para crear entusiasmo hacia el aprendizaje del lenguaje

library(ggplot2) # debemos tener instalados los paquetes
ggplot(cars,
       mapping= aes(x=speed,y=dist))+
  geom_point(colour = 'red', size = 3)

# mismos valores pero con puntos en color rojo, líneas en ambos ejes para crear una grilla



# y ahora el mismo gráfico con la línea de tendencia y lo asignamos a una variable que se 
# llama grafico

grafico <- ggplot(cars,
       mapping= aes(x=speed,y=dist))+
  geom_point(colour = 'red', size = 3)+
  geom_smooth(aes(x=speed,y=dist))


# ahora llamamos a la variable grafico para ver la nueva versión


# Finalmente, mediante un paquete de nombre plotly lo convertimos en interactivo
library(plotly)# cargamos la librería

grafico%>%
  ggplotly()