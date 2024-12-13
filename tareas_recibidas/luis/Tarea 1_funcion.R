{r}
## función 
calculo_inflacion <- function(precios_anterior, precios_actual) { 
  
  # Calculamos la inflación para cada artículo
  inflacion <- ((precios_actual / precios_anterior) - 1) * 100

# Retornamos el valor
return(inflacion)
}
{r}
# Ejemplo de uso
# Si la función definida en el chunk anterior no se completó correctamente no se podrá ejecutar ninguno de los chunks siguientes
calculo_inflacion(10, 14) 
calculo_inflacion(12, 9)

{r}
calculo_inflacion(precios_anterior =10, 
                  precios_actual =14)
calculo_inflacion(precios_actual =20, 
                  precios_anterior= 21)
{r}
calcular_pib_per_capita <- function(pib_total,poblacion) {
  # Calculamos el PIB per cápita
  pib_per_capita <- (pib_total / poblacion)
  
  return(pib_per_capita)
}

{r}
# Ejemplo de uso
pib_total <- 123000043  # PIB total en millones de dólares
poblacion <- 24531    # Población en millones

calcular_pib_per_capita(pib_total, poblacion)

print(pib_per_capita_resultado)  # Imprimir el resultado

#tarea 
#Balanza Comercial
#formula de la balanza comercial, Balanza comercial = exportaciones - imoortaciones

calcular_balanza_comercia <- function(exportaciones,importaciones) {
  balanza_comercial<- (exportaciones-importaciones)
  return(balanza_comercial)
}
exportaciones <- 400000
importaciones <- 500050
calcular_balanza_comercia(exportaciones,importaciones)

# revisar correcciones anteriores que explican problemas presentados que se repiten en este scrip
# si estamos trabajando un script con la extención .R no aplica usar los 
# chunks de codigos {r} que colocas en la línea 1,11, etc