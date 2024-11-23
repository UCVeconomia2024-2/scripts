# ---
# title: "Clase_6"
# subtitle: "Practica_2"
# format: html
# editor: visual
# author: "Rohand Rodriguez"
# date:  "Noviembre 20, 2024"
# ---


# Definimos una función llamada 'suma' que recibe dos argumentos: 'numero1' y 'numero2'
suma <- function(numero1, numero2 = 0) {
  # Realizamos la suma de los dos números
  resultado <- numero1 + numero2
  
  # Devolvemos el resultado
  return(resultado)
}

# Llamamos a la función 'suma' con dos argumentos
resultado1 <- suma(5, 3)
print(resultado1)

# Llamamos a la función 'suma' con solo un argumento (se usará el valor 
predeterminado de 'numero2')
resultado2 <- suma(5)
print(resultado2)

# Función para calcular la inflación (corregida)
calculo_inflacion <- function(precios_anterior, precios_actual) {
  # Calculamos la inflación para cada artículo
  inflacion <- ((precios_actual / precios_anterior) - 1) * 100  
  
  # Retornamos el valor
  return(inflacion) 
}

# Si la función definida en el chunk anterior no se completó correctamente no 
se podrá ejecutar ninguno de los chunks siguientes
calculo_inflacion(10, 14)
calculo_inflacion(12, 9)


# Función para calcular el PIB per cápita (corregida)
calcular_pib_per_capita <- function(pib_total, poblacion) {  
  # Error corregido: Se agregó el argumento "poblacion"
  # Calculamos el PIB per cápita
  pib_per_capita <- pib_total / poblacion  
  # Error corregido: Se agregó "pib_total" en el cálculo
  
  return(pib_per_capita)
}

#Para corregir estos errores, se debe modificar la definición de la función 
#para incluir poblacion como argumento y usar pib_total en el cálculo.

pib_total <- 123000043   # PIB total en millones de dólares
poblacion <- 24531        # Población en millones

# Llamar a la función y asignar el resultado a la variable
pib_per_capita_resultado <- calcular_pib_per_capita(pib_total, poblacion) 

# Imprimir el resultado
print(pib_per_capita_resultado) 

