##########################################################################################
######## Script clase 22 del 29-01-25                                              #######
# Objetivo: descarga de datos desde distintas API's
##########################################################################################

##########################################################################################
######## Caso 1 Patria.                                                            #######
##########################################################################################
library(httr2)
library(jsonlite)
library(dplyr)
library(plotly)
library(apexcharter)

# caso 1
req_patria <- request("https://covid19.patria.org.ve/api/v1/timeline")

req_patria

req_patria |> 
  req_method("GET")

req_patria |> 
  req_dry_run()

respuesta_patria <- req_perform(req_patria)

respuesta_patria |> 
  resp_status_desc()

str(respuesta_patria)

respuesta_patria |> 
  resp_content_type()

datos_patria <- respuesta_patria$body%>%
  rawToChar()%>%
  fromJSON()

class(datos_patria)  

str(datos_patria)

# View(datos_patria)

df_datos_patria <- datos_patria%>%
  mutate(fecha=as.Date(Date))%>%
  mutate(Activos=as.integer(Active$Count))%>%
  mutate(conf_acu=as.integer(Confirmed$Count))%>%
  mutate(conf_nvos=as.integer(Confirmed$New))%>%
  mutate(recu_acu=as.integer(Recovered$Count))%>%
  mutate(recu_nvos=as.integer(Recovered$New))%>%
  mutate(falle_acu=as.integer(Deaths$Count))%>%
  mutate(falle_nvos=as.integer(Deaths$New))%>%
  select(-c(Confirmed,Recovered,Deaths,Active, Date, DateTS))


graf_activos <- plot_ly(datos_patria,
                        x = ~fecha, 
                        y = ~Activos,
                        type = 'bar',
                        name = 'COVID: Casos Activos Venezuela')
graf_activos
##########################################################################################
######## Caso 2 Empleate.                                                          #######
##########################################################################################
url_emplea <- 'https://www.empleate.com/venezuela/ofertas/empleos_encontrados/1/trabaios-en-venezuela-busqueda-por-economista'

req_emplea <- request(url_emplea)|>
  req_method("GET")|> 
  req_headers( Accept= "*/*",
               `Accept-Language`= "es,es-ES;q=0.9,en-US;q=0.8,en;q=0.7,gl;q=0.6",
               `User-Agent`= "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36")|>
  req_perform()

req_emplea|> 
  resp_content_type()

datos_html <- req_emplea$body|>
  rawToChar()

substr(datos_html,201000,202000)

rvest::read_html(datos_html)

##########################################################################################
######## Caso 3 Monitor Dolar                                                      #######
##########################################################################################

req_MonDol <- request('https://api.monitordolarvenezuela.com/historico')|>
  req_method("GET")|> 
  req_headers(Origin= "https://monitordolarvenezuela.com",
              Referer= "https://monitordolarvenezuela.com/") |>
  req_perform()


req_MonDol|> 
  resp_content_type()

datos_MonDol <- req_MonDol$body|>
  rawToChar()|>
  fromJSON()

names(datos_MonDol)
str(datos_MonDol)
library(dplyr)
library(tidyverse)

df_MonDol <- datos_MonDol$result|>
  as_tibble()|>
  mutate(fecha= as.Date(fecha,format='%d/%m/%Y')) |>
  arrange(fecha) %>%
  mutate(across(all_of(c('MdvMin','MdvMax',
                         'BcvMin','BcvMax')), 
                as.numeric),
         across(all_of(c('MdvMin','MdvMax',
                         'BcvMin','BcvMax')), ~round(.x, 2)))
head()

# https://cran.r-project.org/web/packages/apexcharter/vignettes/apexcharter.html
library(apexcharter)
apex(data = df_MonDol, 
     mapping = aes(x = fecha, 
                   ymin = MdvMin,
                   ymax= MdvMax),
     type = "rangeArea",
     serie_name = '$ Monitor',
     synchronize = "df_MonDol")|>
  ax_colors(c( "#ff595e"))

apex(data = df_MonDol, 
     mapping = aes(x = fecha, 
                   ymin = BcvMin,
                   ymax= MdvMax),
     type = "rangeArea",
     serie_name = '$ Monitor',
     synchronize = "df_MonDol") |>
  ax_colors( '#1982c4')


##########################################################################################
######## Caso 4 Google LM Studio                                                   #######
##########################################################################################
## obtener texto de una noticia en página web

dato_texto_ucab <- read_html('https://economia.ucab.edu.ve/perspectivas-economicas-de-2025-discutieron-especialistas-en-la-ucab/')|>
  html_nodes('p')|>
  html_text()|>
  paste(collapse = '. ')%>%
  str_squish()

# inspección texto descargado
substr(dato_texto_ucab, 200, 400)  


# definir el prompt
prompt <- 'Eres un experto en análisis de noticias económicas. Vas a extraer en formato json las ideas principales expuestas en el texto {idea_principal_nombre: descripcion} del texto delimitado por triple asterisco. Texto: ***'

post_texto <- '***.  Recuerda solo extraer el valor y no añadir información adicional. '

dato_texto_prompt_gooaistudio <- paste(prompt,
                                       dato_texto_ucab,
                                       post_texto)

# modificar url por el de la ip donde se aloja ollama en red local
gooai_studio_url <- 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent'

api_key <- ''


llm_resultado_google <- request(gooai_studio_url) %>%
  req_headers("Content-Type" = "application/json") %>%
  req_body_json(
    list(
      contents = list(
        list(
          parts = list(
            list(text = dato_texto_prompt_gooaistudio)
          )
        )
      )
    )
  ) %>% 
  req_url_query(key = api_key) %>% 
  req_method("POST")|>
  req_perform()

datos_goo_respuesta <- llm_resultado_google$body |>
  rawToChar() |>
  fromJSON()%>%
  .$candidates %>%
  .$content%>%
  .$parts%>%
  .[[1]]%>%
  str_squish(.)%>%
  str_remove_all(.,'```json | ```')%>%
  fromJSON()


##########################################################################################
######## Caso 5 LLM vía Ollama                                                     #######
##########################################################################################
library(rvest)
library(stringr)

## obtener texto de una noticia en página web
dato_texto <- read_html('https://www.swissinfo.ch/spa/el-precio-del-dólar-en-venezuela-supera-los-57-bolívares-y-la-moneda-local-sigue-en-caída/88794237')|>
  html_nodes('p')|>
  html_text()|>
  paste(collapse = '. ')%>%
  str_squish()

# inspección texto descargado
substr(dato_texto, 200, 400)  


# definir el prompt
prompt <- 'Eres un experto en extraer en formato json el valor del dolar {dolar: valor} del texto delimitado por triple asterisco. Texto: ***'

post_texto <- '***.  Recuerda solo extraer el valor y no añadir información adicional. '

dato_texto_prompt <- paste(prompt,
                           dato_texto,
                           post_texto)

# modificar url por el de la ip donde se aloja ollama en red local
url_ollama <- 'http://localhost:11434'

endpoint <- paste0(url_ollama, '/api/generate')

llm_resultado <- request(endpoint)|>
  req_method("POST")|> 
  req_body_json(list(  model='llama3.2:1b',
                       prompt = dato_texto_prompt,
                       raw=FALSE,
                       format = "json",
                       options=list(
                         temperature= 0.1),
                       stream = FALSE,
                       keep_alive='3m'))|>
  req_perform()|>
  resp_body_json()

fromJSON(llm_resultado$response)|>
  as_tibble()




##########################################################################################
######## Caso 6 Cepal.                                                            #######
##########################################################################################

# apis
# https://statistics.cepal.org/portal/cepalstat/open-data.html?lang=en#/Indicator/get_cepalstat_api_v1_indicator__indicator_id__dimensions
# https://statistics.cepal.org/portal/cepalstat/dashboard.html?theme=2&lang=en

# https://themockup.blog/posts/2020-05-22-parsing-json-in-r-with-jsonlite/

library(httr2)
library(jsonlite)


datos_cepal <- request("https://api-cepalstat.cepal.org/cepalstat/api/v1/thematic-tree?lang=es&format=json")|>
  req_headers("Accept" = "application/json")|>
  req_perform()|>
  resp_body_json()

cepal <- datos_cepal
datos_cepal$body$name
# length(cepal$body$children)

cepal2 <- datos_cepal$body$children
# View(cepal2)

obtener_temas <- function(datos){
  # generar desanidado
  datos[[1]][1]|>
    unlist()
}
obtener_temas(cepal2[[2]])

lapply(cepal2, obtener_temas)|>
  unlist()


# install.packages('listviewer')
library(listviewer)
listviewer(cepal2)
jsonedit(cepal2)


indicador <- 2203
pre_enlace <- "https://api-cepalstat.cepal.org/cepalstat/api/v1/indicator/"
post_enlace <- "/data?lang=es&format=json&in=0&path=0"

enlace <- paste0(pre_enlace, indicador, post_enlace)

#request de pib
pib_data <- request(enlace)|>
  req_headers("Accept" = "application/json")|>
  req_perform()|>
  resp_body_json()

View(pib_data$body)


length( pib_data$body$data)

pib_data$body$data

extraer_valores <- function(datos){
  # función para cambiar valores ausentes por NA
  nulos <- lapply(datos, is.null)%>%
    unlist()|>
    which()
  
  if(length(nulos)>0){
    datos[nulos] <- NA
  }
  
  datos%>%
    as.data.frame()
}

pib_data$body$metadata
pib_data$body$sources
pib_data$body$dimensions


pib_data$body$data[[1]][4]%>%
  as.data.frame()



pibs_region <- do.call(rbind, 
                       lapply(pib_data$body$data,extraer_valores))#%>%
mutate(value=as.numeric(value))%>%
  select(-source_id,- notes_ids,- dim_208)

dim(pibs_region)

unique(pibs_region$iso3)
unique(pibs_region$source_id)

View(pibs_region%>%
       filter(iso3=='VEN'))

View(pibs_region)
