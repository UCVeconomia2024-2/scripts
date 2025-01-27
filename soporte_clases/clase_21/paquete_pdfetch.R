##########################################################################################
# usar paquete pdfetch
# https://cran.r-project.org/web/packages/pdfetch/pdfetch.pdf
# install.packages('pdfetch')
# Fetch Economic and Financial Time Series Data from Public Sources

# paquete alternativo
#https://cran.r-project.org/web/packages/pedquant/pedquant.pdf
##########################################################################################

##########################################################################################
######## Cargar librerías                                                          #######
##########################################################################################
library(pdfetch)
library(tidyverse)
library(wbids)
library(xts)
##########################################################################################
######## Ejemplos Uso                                                             #######
# extraer códigos "iso2" de nombres de paises del paquete wbids
##########################################################################################


latam_geographies_iso2 <- ids_list_geographies()%>%
  filter(geography_type=='Country')%>%
  filter(region_name=="Latin America & Caribbean" )%>%
  pull(geography_iso2code)

# obtener datos del banco mundial con wb_test
wb_test <- pdfetch_WB("NY.GDP.MKTP.CD", #data from World Bank
                      latam_geographies_iso2)
dim(wb_test)
# View(wb_test)

##########################################################################################
# Obtener valores acciones con pdfetch_YAHOO                                       #######
##########################################################################################

# listado de identificadores (tickers) de acciones en el siguiente enlace
# https://www.nasdaq.com/market-activity/stocks/screener

# descarga valores en formato zoo
yahoo_acciones <- pdfetch_YAHOO(c("^gspc","^ixic"))
# procesamiento de datos descargados
valor_apple <- pdfetch_YAHOO(c("AAPL"))

valor_apple <- valor_apple%>%
  as_data_frame()%>%
  mutate(accion= 'Apple',
         codigo= 'AAPL')%>%
  bind_cols( fecha= index(valor_apple))

names(valor_apple) <- c('open','high','low',
                        'close','adjclose', 'volume',
                        'accion','codigo','fecha')

# descarga valores en formato zoo
valor_bitcoin <- pdfetch_YAHOO('BTC-USD')
# procesamiento de datos descargados
valor_bitcoin <- valor_bitcoin%>%
  as_data_frame()%>%
  mutate(accion= 'Bitcoin',
         codigo= 'BTC-USD')%>%
  bind_cols( fecha= index(valor_bitcoin))

names(valor_bitcoin) <- c('open','high','low',
                          'close','adjclose', 'volume',
                          'accion','codigo','fecha')

# descarga valores en formato zoo
valor_nvidia <- pdfetch_YAHOO('NVDA')
# procesamiento de datos descargados
valor_nvidia <- valor_nvidia%>%
  as_data_frame()%>%
  mutate(accion= 'Nvidia',
         codigo= 'NVDA')%>%
  bind_cols( fecha= index(valor_nvidia))

names(valor_nvidia) <- c('open','high','low',
                         'close','adjclose', 'volume',
                         'accion','codigo','fecha')

# descarga valores en formato zoo
valor_google <- pdfetch_YAHOO('GOOG')
# procesamiento de datos descargados
valor_google <- valor_google%>%
  as_data_frame()%>%
  mutate(accion= 'Google',
         codigo= 'GOOG')%>%
  bind_cols( fecha= index(valor_google))

names(valor_google) <- c('open','high','low',
                         'close','adjclose', 'volume',
                         'accion','codigo','fecha')

# descarga valores en formato zoo
valor_oracle <- pdfetch_YAHOO('ORCL')
# procesamiento de datos descargados
valor_oracle <- valor_oracle%>%
  as_data_frame()%>%
  mutate(accion= 'Oracle',
         codigo= 'ORCL')%>%
  bind_cols( fecha= index(valor_oracle))

names(valor_oracle) <- c('open','high','low',
                         'close','adjclose', 'volume',
                         'accion','codigo','fecha')

dim(valores_acciones)

# unificar en una data frame valores de las acciones descargados
valores_acciones <- bind_rows(valor_apple,
                              valor_bitcoin,
                              valor_nvidia,
                              valor_google,
                              valor_oracle)%>%
  select(9,1:7)%>%
  pivot_longer(cols = c('open','high','low',
                        'close','adjclose'),
               names_to = "tipo_valor",
               values_to = "valor")

# saveRDS(valores_acciones,'data_in/valores_acciones.rds')