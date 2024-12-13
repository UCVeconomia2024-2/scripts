library(dplyr)
library(stringr)
numeros <- c(1,2,3,4,5)
dias_semana <- c("lunes", "martes", "miercoles", "jueves", "viernes", "sabado", "domingo")
mayores_edad <- c(TRUE, FALSE, TRUE)
fechas_nacimiento <- c('2010-01-01', "2005-06-10",'1999-10-31')
print(numeros)
print(mayores_edad)
print(dias_semana)
print(fechas_nacimiento)
# lo anterior no fue solicitado

numeros_pares <- c(2, 4, 6, 8, 10) #ok
numeros_impares <- c(1, 3, 5, 7, 9) #ok

nombre_universidad <- c("Universidad Central de Venezuela", "Facultad de Ciencias Economicas y Sociales")#ok
primer_trimestre <-c("enero", "febrero", "marzo")#ok
resultado <- numeros > 3 #ok
banana <- vocal == a # el nombre de la variable no se corresponde con la asignación
palabra <- "banana"
letra_a_buscar <- "a"
letras <- strsplit(palabra, "")[[1]] # esta función no se ha visto en clase. El subsetting 
# aplicado tampoco se corresponde a lo que se había visto al momento de plantear el 
# ejercicio
resultado_letra <- letras == letra_a_buscar
fechas_aleatorias <- c("1999-09-15", "2006-02-22", "2015-06-30") # esto no se solicitó, ni
# tampoco son fechas aleatorias si se están definiendo mediante una asignación
