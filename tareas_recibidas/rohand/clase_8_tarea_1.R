# ---
# title: "Clase_8"
# subtitle: "Tarea"
# format: html
# editor: visual
# author: "Rohand Rodriguez"
# date:  "Noviembre 20, 2024"
# ---

# 1) Vector con países que están en el primer cuartil de la DF según el PIB

# Cargar la librería necesaria para leer archivos CSV
library(readr)
ruta_archivo <- "C:\\Users\\usuario\\OneDrive\\Documentos\\Archivos R\\df_gapminder.xlsx
df_gapminder <- read_csv(ruta_archivo)

# Calcular el primer cuartil del PIB
primer_cuartil_pib <- quantile(df_gapminder$gdpPercap, 0.25)

# Filtrar los países que están en el primer cuartil
paises_primer_cuartil <- df_gapminder$country[df_gapminder$gdpPercap <= primer_cuartil_pib]

# Mostrar los países
print(paises_primer_cuartil)

# tienes un error en la línea 14 donde no cerraste comillas al final de la línea
# la primera parte del ejercicio es correcta pero falta el resto de lo solicitado
