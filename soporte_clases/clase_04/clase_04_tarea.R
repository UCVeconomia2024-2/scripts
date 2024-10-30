##########################################################################################
#Clase 4
# 1) Ejercicio Instalación paquetes.
# Instalar los paquetes indicados en la sección posterior a los comentarios del script
# con el comando install.packages()
# 
# Luego de instalar cada paquetedebe verificar que puede cargar el paquete recién 
# instalado ejecutando el comando library (nombre de paquete recién instalado)
# Para determinar si el paquete se pudo instalar correctamente, luego de ejecutar,
# por ejemplo library (dplyr) ,en la Consola no debe aparecer ningún mensaje de error.
# Si llega a aparecer un mensaje de error deberá reportarlo en el Discord en el canal
# errores de códigos (recordar que mensajes que dicen warning no son errores, ni otros
# mensajes que sólo estén arrojando información al usuario, es decir, los mensajes que son
# errores dicen claramente "Error.....")
#
#
# Importante: cuando se instala el paquete es necesario colocar el nombre del mismo entre 
# comillas, no obstante, cuando se carga el paquete con el comando library no es necesario
# colocar el nombre dentro de comillas.
#
# Ejemplo:
# install.packages ('tidyverse') # instala el paquete
# library (tidyverse) # se verifica que se pudo instalar

# ----------------------------------------------------------------------------------------
# Para el caso del último paquete que se llama tinytext, luego de instalarlo y cargarlo en
# su "Environment", van a ejecutar la siguiente instrucción
# tinytex::install_tinytex()
# La instalación puede tardar algúnos minutos dependiendo de la velocidad del internet
##########################################################################################


# previo a instalar se cambiará el siguiente parametro para prevenir algo que se 
# llama timeout cuando el internet es un poco lento y se necesitan realizar descargas un 
# tanto pesadas
options(timeout=200) # ejecutar esta línea

# paquetes a instalar
tidyverse
plotly
DT
knitr
rvest
bookdown
tinytex