##########################################################################################
######## Script clase 17 del 09-12-24                                              #######
# Objetivo: trabajar con fechas y horas
##########################################################################################

##########################################################################################
######## Limpiar ambiente de trabajo                                               #######
##########################################################################################
rm(list= ls())

##########################################################################################
######## Cargar librerías                                                          #######
##########################################################################################
library(tidyverse)
library(lubridate)
##########################################################################################
########cheat sheets
# https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_lubridate.pdf
# https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_strings.pdf
##########################################################################################

path_ruta_descarga <- 'data_in'

# crear directorio para descarga de datos
if(!dir.exists('data_in')){
  dir.create(path_ruta_descarga)
}

nombre_archivo_descarga <- 'tuits_bcv.rds'

download.file('https://github.com/UCVeconomia2024-2/scripts/raw/refs/heads/main/data_in/bcv.rds',
              paste(path_ruta_descarga,nombre_archivo_descarga, sep = '/' )) 

df_bcv_tw <- readRDS(paste(path_ruta_descarga,
                           nombre_archivo_descarga, 
                           sep = '/' )) 

dim(df_bcv_tw)
View(df_bcv_tw%>%
       sample_n(100))

summary(df_bcv_tw)
df_bcv_tw1 <- df_bcv_tw%>%
  mutate(created_at_date=as.POSIXct(created_at))%>%
  # mutate(created_at2= ymd_hms(created_at))%>%
  mutate(mes=month(created_at_date))%>%
  mutate(dia_semana=wday(created_at_date))

View(df_bcv_tw1)
df_bcv_tw1$created_at[1]
df_bcv_tw1$created_at_date[1]
#### crear secuencia de fechas

# Ejemplo promedio acciones
precio_acciones <- tibble(
  fecha = as.Date("2024-01-01") + 0:9,
  precio_x = rnorm(n=10, mean= 0, sd= 1),
  precio_y = rnorm(n=10, mean= 0, sd= 2),
  precio_z = rnorm(n=10, mean= 0, sd= 4)
)

