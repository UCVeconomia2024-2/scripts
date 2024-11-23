# ---
# title: "Clase_6"
# subtitle: "Practica_1"
# format: html
# editor: visual
# author: "Rohand Rodriguez"
# date:  "Noviembre 20, 2024"
# ---

install.packages('dplyr')
install.packages('stringr')
library(dplyr)
library(stringr)
numeros <- c(1,2,3,4,5)
dias_semana <- c("lunes", "martes", "miércoles", "jueves", "viernes", 
                 "sábado", "domingo")
mayores_edad <- c(TRUE, FALSE, TRUE)
fechas_nacimiento <- c('2010-01-01', "2005-06-10",'1999-10-31')
print(numeros)

print(mayores_edad)
print(dias_semana)
print(fechas_nacimiento)
numeros_pares <- c(2, 4, 6, , 10)
numeros_pares <- c(2, 4, 6, 8, 10)
mis_frutas <- c("manzana", "banana", "uva")
mayor_que_cinco < - c(6, 8, 10)
datos <- c(1, 3, 6, 2, 8, 4, 10, 5)
mayor_que_cinco <- datos[datos > 5]



# Números pares del 2 al 10
numeros_pares <- seq(2, 10, by = 2)
print(numeros_pares)

# Números impares del 1 al 9
numeros_impares <- seq(1, 9, by = 2)
print(numeros_impares)

# Vector con nombre de la Facultad y Universidad
facultad_universidad <- c("FACES", "Universidad Central de Venezuela")
print(facultad_universidad)

# Vector con los nombres de los tres primeros meses del año
meses_ano <- c("Enero", "Febrero", "Marzo")
print(meses_ano)

# Vector lógico para números mayores que 3
numeros <- 1:5
mayor_que_tres <- numeros > 3
print(mayor_que_tres)

# Vector lógico para letras "a" en "banana"
palabra <- "banana"
es_a <- strsplit(palabra, "")[[1]] == "a" 
print(es_a)

# Vector de fechas: Primer y último día de Enero, Febrero y Marzo de 2024
fechas <- c(
  as.Date("2024-01-01"), as.Date("2024-01-31"),
  as.Date("2024-02-01"), as.Date("2024-02-29"),
  as.Date("2024-03-01"), as.Date("2024-03-31")
)
print(fechas)

# Vector de fechas: Primer y último día de Enero, Febrero y Marzo de 2024
fechas <- c(
  as.Date("2024-01-01"), as.Date("2024-01-31"),
  as.Date("2024-02-01"), as.Date("2024-02-29"),
  as.Date("2024-03-01"), as.Date("2024-03-31"))
print(fechas)
