### Pronostico tipo de cambio nominal semanal 

date = Sys.Date()


## Dataframe de los datos en nivel


path= "C:\\Users\\juanl\\Documents\\R\\tc_semanal\\TC_DATA.csv"


  
nivel =read.csv(path, sep = ";")

nivel$date[nrow(nivel)]

## Retener solamente los ultimos dos años aprox 104 semanal, 52 semanas al año
skip=nrow(nivel)-104

nivel = nivel[,-c(1,7)]
nivel=nivel[-c(1:skip),]
View(nivel)

### Modelo exploratorio ARDL 


###Modelo de largo plazo base 
library(ARDL)

#adjr2 <- function(x) { summary(x)$adj.r.squared }


model_nivel  <-  auto_ardl(TC ~ liqui ,
                                  data = nivel, 
                                  max_order = c(3,3),
                                  fixed_order = c(3,1),
                                  selection = "AIC",
                                  selection_minmax = "min",
                                  grid = TRUE)
summary(model_nivel$best_model)

###El modelo base es de TC y Liquidez TC (LAG 1 Y 3 ) Y liqui en nivel y lag 1 para los ultimos dos años

#Test de durbin watson y accuracy
library(lmtest)
library(forecast)

dwtest(model_nivel$best_model)
accuracy(model_nivel$best_model)

##Vizualizar estimados y observados sin las primeras 200 observacioes
dev.new()
observados = nivel$TC[-c(1,2,3)]
estimados = model_nivel$best_model$fitted.values
dates <- as.Date.character(nivel$date[c(4:104)],tryFormats = "%d/%m/%Y")
inicio <- 101-100


matplot( y = cbind(estimados[c(inicio:101)]/1000000,
                   observados[c(inicio:101)]/1000000), 
         x = dates[c(inicio:101)], 
         type = "l",
         lty = 1,
         col = c("red","blue"))

legend("bottomright", legend = c("Estimados", "Observado"), 
       col = c("red", "blue"), 
       lty = 1)

########### en formato ggplot2 con interactividad de plotly
library(ggplot2)
library(plotly)
library(tidyverse)

# Supongamos que 'estimados', 'observados' y 'dates' son tus datos
data <- data.frame(
  dates = dates[inicio:101],
  estimados = estimados[inicio:101] / 1000000,
  observados = observados[inicio:101] / 1000000
)

# Convertir a formato largo para ggplot
data_long <- pivot_longer(data, cols = c(estimados, observados), 
                          names_to = "tipo",
                          values_to = "valor")

# Crear el gráfico con ggplot
dev.new()

p <- ggplot(data_long, 
       aes(x = dates,
           y = valor,
           color = tipo)) +
  geom_line() +
  labs(title = "Comparación de Estimados y Observados",
       x = "Fecha",
       y = "Bs por Dolar")+ theme_minimal()
  
ggplotly(p)

  
#theme_minimal()%>%
#ggplotly()


## Creado data_frame para el modelo LM con los rezagos selecionados

nivel_t = nivel
nivel_lag1 = nivel_t[-1,]
nivel_lag2 =nivel_t[-c(1,2),]
nivel_lag3 = nivel_t[-c(1,2,3),]
nivel_t = nivel_t[-c(104,103,102),]
nivel_lag1 = nivel_lag1[-c(103,102),]
nivel_lag2 = nivel_lag2[-102,]
nivel_t = nivel_t[-c(104,103,102),]

lm_data_frame = cbind(nivel_lag3,nivel_lag2)
lm_data_frame = cbind(lm_data_frame,nivel_lag1)
lm_data_frame = cbind(lm_data_frame, nivel_t)
colnames(lm_data_frame) = c("date",
                            "liqui",
                            "TC",
                            "IC",
                            "reservas",
                            "date_1",
                            "lag1_liqui",
                            "lag1_TC",
                            "lag1_IC",
                            "lag1_reservas",
                            "date_2",
                            "lag2_liqui",
                            "lag2_TC",
                            "lag2_IC",
                            "lag2_reservas",
                            "date_3",
                            "lag3_liqui",
                            "lag3_TC",
                            "lag3_IC",
                            "lag3_reservas")

### modelo lm en nivele 
model_prueba = lm(formula = TC ~ lag1_TC + lag2_TC +lag3_TC +liqui +lag1_liqui, 
                  data = lm_data_frame)
summary(model_prueba)


### Modelo ARDL selecionado, puede cambiar dependiendo de calibracioens y nuevas observaciones de las variables
model_lm_1 = lm(formula = TC ~ lag1_TC + lag3_TC+ liqui +lag1_liqui, 
                data = lm_data_frame)
summary(model_lm_1)

#Test de durbin watson y accuracy
dwtest(model_lm_1)
accuracy(model_lm_1)


observados = nivel$TC[-c(1,2,3)]
estimados = model_lm_1$fitted.values
dates <- as.Date.character(nivel$date[c(4:104)],tryFormats = "%d/%m/%Y")
inicio <- 101-24

# Supongamos que 'estimados', 'observados' y 'dates' son tus datos
data <- data.frame(
  dates = dates[inicio:101],
  estimados = estimados[inicio:101] / 1000000,
  observados = observados[inicio:101] / 1000000
)

# Convertir a formato largo para ggplot
data_long <- pivot_longer(data, cols = c(estimados, observados), 
                          names_to = "tipo",
                          values_to = "valor")

### grafico 2
p <- ggplot(data_long, 
            aes(x = dates,
                y = valor,
                color = tipo)) +
  geom_line() +
  labs(title = "Comparación de Estimados y Observados",
       x = "Fecha",
       y = "Bs por Dolar")+ theme_minimal()

ggplotly(p)

### 

estimados =  ts(model_lm_1$fitted.values, start = 1,end =101,frequency = 1)
residuos = model_lm_1$residuals
dev.new()
plot(residuos)


dummy_2 <- ifelse(abs(residuos) >= 500000, 1, 0)
dummy_2 = ts(dummy_2, start = 1, end = 101, frequency = 1)
dummy_2
lm_data_frame$dummy_2 = dummy_2
plot(dummy_2)

#model_lm_1 con variable dummy_2


model_lm_1 = lm(formula = TC ~ lag1_TC + lag3_TC+ liqui +lag1_liqui + dummy_2, 
                data = lm_data_frame)
summary(model_lm_1)

#Test de durbin watson y accuracy

dwtest(model_lm_1)
accuracy(model_lm_1)

###Proostico del tipo de cambio nominal exporta a csv la data usada para el model asi como el pornostico.
h_fore <- 8

estimados = model_lm_1$fitted.values
FORE_TC = forecast(model_lm_1$fitted.values, h =h_fore)
FORE_TC

plot(FORE_TC)

### exportar

write.csv(FORE_TC, paste0("C:\\Users\\juanl\\Documents\\R\\tc_semanal\\","pronostico_tc","_",date,".csv"))

FORE_TC = read.csv( paste0("C:\\Users\\juanl\\Documents\\R\\tc_semanal\\","pronostico_tc","_",date,".csv"))
FORE_TC$Lo.80 = FORE_TC$Lo.80/1000000
FORE_TC$Hi.80=FORE_TC$Hi.80/1000000
FORE_TC$Lo.95=FORE_TC$Lo.95/1000000
FORE_TC$Hi.95= FORE_TC$Hi.95/1000000
FORE_TC$Point.Forecast=FORE_TC$Point.Forecast/1000000


date_fore <- as.Date.character(nivel$date[nrow(nivel)],tryFormats = "%d/%m/%Y")
dates_fore <- c()

for (i in 1:h_fore) {
  dta <- date_fore + (7*i)
  dates_fore <- append(dates_fore,dta)
  
}

FORE_TC$DATES <- dates_fore

library(dplyr)

FORE_TC <- FORE_TC%>%
  select(DATES,everything())


write.csv(FORE_TC, paste0("C:\\Users\\juanl\\Documents\\R\\tc_semanal\\","pronostico_tc","_",date,".csv"))
write.csv(lm_data_frame, paste0("C:\\Users\\juanl\\Documents\\R\\tc_semanal\\","data_model_TC","_",date,".csv"))

#### vizualizando los resultados

matplot( y = cbind(FORE_TC$Point.Forecast,FORE_TC$Lo.95,FORE_TC$Hi.95), 
         x = FORE_TC$DATES, 
         type = "l",
         lty = 1,
         col = c("black","blue","red"))
legend("bottomright", legend = c("Point", "low95","high95"), 
       col = c("black", "blue","red"), 
       lty = 1)


