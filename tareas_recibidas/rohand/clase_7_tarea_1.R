# ---
# title: "Clase_7"
# subtitle: "Tarea"
# format: html
# editor: visual
# author: "Rohand Rodriguez"
# date:  "Noviembre 20, 2024"
# ---


library(readxl)
library(dplyr)
install.packages("gapminder")
ruta <- 'data_in/gapminder.xlsx'#'C:\Users\usuario\OneDrive\Documentos\Archivos R'
# df_gapminder <- read_xlsx(C:\Users\usuario\OneDrive\Documentos\Archivos R)
glimpse(df_gapminder)
install.packages("tidyverse")

# Función para calcular el interés simple
calcular_interes_simple <- function(capital_inicial, tasa_interes_anual) {
  # Calculamos el interés simple
  interes_simple <- capital_inicial * (tasa_interes_anual / 100)
  
  # Retornamos el interés simple
  return(interes_simple)
}
# Ejemplo de uso
capital_inicial <- 1000
tasa_interes_anual <- 5

interes_simple <- calcular_interes_simple(capital_inicial, tasa_interes_anual)
print(paste("El interés simple es:", interes_simple))


## está bien pero no sé porque incluiste la lectura de gapminder que no es parte de este ejercicio
