##########################################################################################
######## Script clase 20 del 22-01-25                                             #######
# Objetivo: Conocer librerías para soportar el Análisis Exploratorio de los Datos
##########################################################################################
library(ggplot2)
library(data.table)
library(dplyr)
library(gapminder)
##########################################################################################
########   Paquetes disponibles con distintas funcionalidades   
##########################################################################################


library(JWileymisc)

egltable( c("lifeExp",  
            "pop" ,   
            "gdpPercap"),
          data = gapminder_2007)


library(skimr)
skim(gapminder)

gapminder_2007%>%
  group_by(continent)%>%
  skim()

library(DataExplorer)
plot_str(gapminder)
introduce(gapminder)
create_report(gapminder)
plot_intro(gapminder)
plot_bar(gapminder)


library(summarytools)
freq(gapminder)
view(dfSummary(gapminder))


library(dataReporter)
makeDataReport(gapminder)
check(gapminder)
visualize(gapminder)