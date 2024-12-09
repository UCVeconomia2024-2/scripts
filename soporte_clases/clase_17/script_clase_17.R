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


