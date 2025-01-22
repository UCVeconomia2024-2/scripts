##########################################################################################
# usar paquete wbids
# Datos del Banco Mundial obtenidos desde la API de la institución
## wbids World Bank International Debt Statistics
# https://datacatalog.worldbank.org/search/dataset/0038015
# install.packages('wbids')
#https://cran.r-project.org/web/packages/wbids/wbids.pdf
##########################################################################################

##########################################################################################
######## Cargar librerías                                                          #######
##########################################################################################
library(tidyverse)
library(wbids)

##########################################################################################
######## Exporar Contenido                                                         #######
##########################################################################################
# Contrapartes (países)
View(ids_list_counterparts()) 

# Id Venezuela
ids_list_counterparts()%>%
  filter(str_detect(counterpart_name,'Vene'))%>%
  pull(counterpart_id)

# listar geografías (datos país y regiones)
View(ids_list_geographies())
names(ids_list_geographies())


latam <- ids_list_geographies()%>%
  filter(str_detect(region_name,'Latin'))

# obtener códigos países latinoamérica
latam_geographies <- ids_list_geographies()%>%
  filter(str_detect(region_name,'Latin'))%>%
  pull(geography_id)

# obtener códigos países 
codigos_paises_mundo <- ids_list_geographies()%>%
  filter(geography_type=='Country')%>%
  pull(geography_id)

# consultar listado de series disponibles
ids_list_series()#series disponibles

View(ids_list_series())

# Ver series relacionadas con deuda
View(ids_list_series()%>%
  filter(str_detect(series_name, 'debt|DEBT|Debt'))%>%
  select(series_id, series_name))

#  consultar el nombre de una serie en particular
ids_list_series()%>%
  filter(series_id=="FI.RES.TOTL.DT.ZS")%>%
  select(series_name)

 
##########################################################################################
######## Descarga de dos series en loop por país de latinoamérica (latam):        #######
# "FI.RES.TOTL.CD" Total reserves (includes gold, current US$)
# "FI.RES.TOTL.DT.ZS" Total reserves (% of total external debt)

# se usa la función ids_get() para la descarga de los datos
##########################################################################################



# Incializar las data frames
# df_reserva_int_latam <- tibble()
# df_res_perc_gdp_latam <- tibble()



for(i in 1:length(latam_geographies)){
  print(i)
  print('serie 1')
  df_reserva_int_latam <- bind_rows( df_reserva_int_latam,
                                     ids_get( geographies = latam_geographies[i],
                                              series = c("FI.RES.TOTL.CD"),
                                              start_date = 1970,
                                              end_date = 2025)%>%
                                       filter(!is.na(value)))
  print('serie 2')

  
  df_res_perc_gdp_latam <- bind_rows( df_res_perc_gdp_latam,
                                      ids_get( geographies = latam_geographies[i],#Total reserves (% of total external debt)
                                               series = c("FI.RES.TOTL.DT.ZS"),
                                               start_date = 1970,
                                               end_date = 2025)%>%
                                      filter(!is.na(value)))
  # Sys.sleep(2)
                          
}
  

df_reserva_int_latam <- df_reserva_int_latam%>%
  left_join(ids_list_geographies()%>%
              select(geography_id,
                     geography_name,
                     income_level_name,
                     lending_type_name))%>%
  select(-counterpart_id, 
         -series_id ) %>%
  select(geography_id,
         geography_name,
         year,
         value,
         income_level_name,
         lending_type_name)

df_res_perc_gdp_latam <- df_res_perc_gdp_latam%>%
  left_join(ids_list_geographies()%>%
              select(geography_id,
                     geography_name,
                     income_level_name,
                     lending_type_name))%>%
  select(-counterpart_id, 
         -series_id ) %>%
  select(geography_id,
         geography_name,
         year,
         value,
         income_level_name,
         lending_type_name)
  

saveRDS(df_reserva_int_latam,'conjuntos_datos/df_reserva_int_latam.rds')
saveRDS(df_res_perc_gdp_latam,'conjuntos_datos/df_res_perc_gdp_latam.rds')

# reserva_int_latan <- readRDS('conjuntos_datos/reserva_int_latan.rds')
# res_perc_gdp <- readRDS('conjuntos_datos/res_perc_gdp.rds')

##########################################################################################
######## Descarga de dos series en loop por país del mundo.              :        #######
# Reservas Internacionales Mundo

# "FI.RES.TOTL.CD" Total reserves (includes gold, current US$)
# "FI.RES.TOTL.DT.ZS" Total reserves (% of total external debt)

# se usa la función ids_get() para la descarga de los datos
##########################################################################################

# inicializar df's
df_reserva_int_mundo <- tibble()
df_res_perc_gdp_mundo <- tibble()

for(i in 1:length(codigos_paises_mundo)){
  print(i)
  print('serie 1')
  df_reserva_int_mundo <- bind_rows(df_reserva_int_mundo,
                                   ids_get( geographies = codigos_paises_mundo[i],
                                            series = c("FI.RES.TOTL.CD"),
                                            start_date = 1970,
                                            end_date = 2025)%>%
                                     filter(!is.na(value)))
  print('serie 2')

  res_perc_gdp_mundi <- bind_rows(df_res_perc_gdp_mundo,
                                  ids_get( geographies = codigos_paises_mundo[i],#Total reserves (% of total external debt)
                                           series = c("FI.RES.TOTL.DT.ZS"),
                                           start_date = 1970,
                                           end_date = 2025)%>%
                                    filter(!is.na(value)))

}
saveRDS(,'conjuntos_datos/')
saveRDS(,'conjuntos_datos/')


##########################################################################################
######## Descarga de siete series en loop por país del mundo:        
# DT.DOD.DECT.PC.CD Total external debt per capita (US$)
# BM.GSR.TOTL.CD Imports of goods, services and primary income (current US$)
# BX.GSR.TOTL.CD Exports of goods, services and primary income (current US$)
# DT.TDS.DECT.CD Debt service on external debt, total (TDS, current US$)
# DT.TDS.DECT.EX.ZS Total debt service (% of exports of goods, services and primary income)
# NY.GNP.MKTP.CD GNI (current US$)
# SP.POP.TOTL Population, total

# se usa la función ids_get() para la descarga de los datos
##########################################################################################

# inicializar df's
df_DebtExt_PerCap_mundo <- tibble() # DT.DOD.DECT.PC.CD Total external debt per capita (US$)
df_Importaciones <- tibble()#  BM.GSR.TOTL.CD Imports of goods, services and primary income (current US$)
df_Exportaciones <- tibble()# BX.GSR.TOTL.CD Exports of goods, services and primary income (current US$)
df_ServicioDeuda <- tibble()# DT.TDS.DECT.CD Debt service on external debt, total (TDS, current US$)
df_ServicioDeudaPercExport <- tibble()# DT.TDS.DECT.EX.ZS Total debt service (% of exports of goods, services and primary income)
df_gni <- tibble() # NY.GNP.MKTP.CD GNI (current US$)
df_pop <- tibble() # SP.POP.TOTL Population, total

for(i in 1:length(codigos_paises_mundo)){
  print(i)
  print('serie 1')
  df_DebtExt_PerCap_mundo <- bind_rows(  df_DebtExt_PerCap_mundo,
                                         ids_get( geographies = codigos_paises_mundo[i],
                                                  series = c("DT.DOD.DECT.PC.CD"),
                                                  start_date = 1970,
                                                  end_date = 2025)%>%
                                           filter(!is.na(value)))
  print('serie 2')
  Sys.sleep(2)
  df_Importaciones <- bind_rows(  df_Importaciones,
                                  ids_get( geographies = codigos_paises_mundo[i],#Total reserves (% of total external debt)
                                           series = c("BM.GSR.TOTL.CD"),
                                           start_date = 1970,
                                           end_date = 2025)%>%
                                    filter(!is.na(value)))
  # Sys.sleep(2)
  print('serie 3')
  df_Exportaciones <- bind_rows( df_Exportaciones,
                                 ids_get( geographies = codigos_paises_mundo[i],
                                          series = c("BX.GSR.TOTL.CD"),
                                          start_date = 1970,
                                          end_date = 2025)%>%
                                   filter(!is.na(value)))
  
  print('serie 4')
  df_ServicioDeuda <- bind_rows( df_ServicioDeuda,
                                 ids_get( geographies = codigos_paises_mundo[i],
                                          series = c("DT.TDS.DECT.CD"),
                                          start_date = 1970,
                                          end_date = 2025)%>%
                                   filter(!is.na(value)))
  print('serie 5')
  df_ServicioDeudaPercExport <- bind_rows( df_ServicioDeudaPercExport,
                                           ids_get( geographies = codigos_paises_mundo[i],
                                                    series = c("DT.TDS.DECT.EX.ZS"),
                                                    start_date = 1970,
                                                    end_date = 2025)%>%
                                             filter(!is.na(value)))
  print('serie 6')
  df_gni <- bind_rows( df_gni,
                       ids_get( geographies = codigos_paises_mundo[i],
                                series = c("NY.GNP.MKTP.CD"),
                                start_date = 1970,
                                end_date = 2025)%>%
                         filter(!is.na(value)))
  print('serie 7')
  df_pop <- bind_rows( df_pop,
                       ids_get( geographies = codigos_paises_mundo[i],
                                series = c("SP.POP.TOTL"),
                                start_date = 1970,
                                end_date = 2025)%>%
                         filter(!is.na(value)))
  
}

# guardar resultados

saveRDS(df_DebtExt_PerCap_mundo,'conjuntos_datos/df_DebtExt_PerCap_mundo.rds')
saveRDS(df_Importaciones,'conjuntos_datos/df_Importaciones.rds')
saveRDS(df_Exportaciones,'conjuntos_datos/df_Exportaciones.rds')
saveRDS(df_ServicioDeuda,'conjuntos_datos/df_ServicioDeuda.rds')
saveRDS(df_ServicioDeudaPercExport,'conjuntos_datos/df_ServicioDeudaPercExport.rds')
saveRDS(df_gni,'conjuntos_datos/df_gni.rds')
saveRDS(df_pop,'conjuntos_datos/df_pop.rds')

##########################################################################################

##########################################################################################

View(reserva_int_latan%>%
       group_by(geography_id)%>%
       count())
#
arg_res_perc_gdp <- res_perc_gdp%>%
  filter(geography_id=='ARG')
nrow(arg_res_perc_gdp)

plot(x=arg_res_perc_gdp$year,
     y=arg_res_perc_gdp$value)
ggplot(data= arg_res_perc_gdp, aes(x= year, y= value))+
  geom_line()

reserva_int_arg <- reserva_int_latan%>%
  filter(geography_id=='ARG')

ggplot(data= reserva_int_arg, 
       aes(x= year, y= value))+
  geom_line()



########
# install.packages('pedquant')
# https://cran.r-project.org/web/packages/pedquant/index.html
library(pedquant)
# sym = ed_nbs_symbol()
bond_vene <- md_bond(symbol = 'USP97475AP55', 
                     type = "history", 
                     date_range = "3y")
