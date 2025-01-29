##########################################################################################
######## Script soporte clase 21 del 27-01-25                                     #######
# ggplot2
##########################################################################################
library(gapminder)
library(tidyverse)
library(ggalt)
# devtools::install_github('bbc/bbplot')
library(bbplot)
library(viridis)

##########################################################################################
########   Crear DF's a usar  
##########################################################################################

##########################################################################################
########   Crear DF's a usar  
##########################################################################################
gap_2007 <- gapminder%>%
  filter(year==2007)%>%
  arrange(country)

df_gapminder_2007_america <- gap_2007%>%
  filter(continent=='Americas')

gapminder_2007 <- gapminder%>%
  filter(year==2007)%>%
  arrange(country)

nrow(gapminder_2007)

head(gapminder_2007)

gapminder_anno <- gapminder%>%
  group_by(year)

gapminder_2007_afeu <- gapminder_2007%>%
  filter(continent %in% c('Africa','Europe'))%>%
  mutate(continent= as.character(continent))%>%
  arrange(country)

gapminder_afeu <- gapminder%>%
  filter(continent %in% c('Africa','Europe'))%>%
  mutate(continent= as.character(continent))

## Geom col
df_continente_2007 <- gapminder_2007%>%
  group_by(continent)%>%
  count(sort = TRUE, name='Total')

ggplot(data=df_continente_2007,
       aes(x= continent,
           y= Total))+
  geom_col()

ggplot(data=df_continente_2007,
       aes(x= continent,
           y= Total))+
  geom_col(fill= "#ffbe0b")

ggplot(data=df_continente_2007,
       aes(x=reorder(continent,-Total),
           y= Total))+
  geom_col(fill= "#ffbe0b")

gapminder_2007%>%
  group_by(continent)%>%
  count(sort = TRUE, name='Total')%>%
  ggplot() +
  geom_col(aes(x=reorder(continent,-Total),
               y= Total),
           fill= "#ffbe0b")

ggplot(data=df_continente_2007,
       aes(x= continent,
           y= Total,
           fill=continent))+
  stat_identity(geom='col')

ggplot(data=df_gapminder_2007_america,
       aes(x= pop,
           y= country))+
  geom_col()

# tema/ adjetivos

graf_gap_2007 <- ggplot(data=df_continente_2007,
                        aes(x= continent,
                            y= Total,
                            fill=continent))+
  geom_col()

graf_gap_2007

graf_gap_2007+
  theme_bw()

graf_gap_2007+
  theme_minimal()

graf_gap_2007+
  theme_grey()

graf_gap_2007+
  theme_linedraw()

graf_gap_2007+
  theme_dark()

graf_gap_2007+
  theme_light()





graf_gap_2007+
  theme_dark()+
  theme(text = element_text(family = "serif",
                            size = 20))

##guides
graf_gap_2007+
  guides (fill ='none')
#



# facetas
df_gapminder_2007_america <- gapminder_2007%>%
  filter(continent=='Americas')


graf_gap_2007+
  scale_y_continuous (name = NULL,
                      breaks = seq(0, 60, by = 5))+
  scale_fill_manual(values =  c('#fb8500','#ffb703','#023047','#219ebc','#8ecae6' )) +
  labs(x = NULL, title = "Gapminder año 2007: \nCantidad Países Representados por Continente")


ggplot(data=df_gapminder_2007_america,
       aes(x=country, y= gdpPercap))+
  geom_col()+
  scale_y_continuous (name = NULL,
                      breaks = seq(0, 45000, by = 5000),
                      labels = scales::label_dollar())+
  labs(x = NULL,
       title = "Gapminder año 2007: ",
       subtitle = "PIB Per Cápita por País América")

ggplot(data=df_gapminder_2007_america,
       aes(x=country, y= gdpPercap))+
  geom_col()+
  scale_y_continuous (name = NULL,
                      breaks = seq(0, 45000, by = 5000),
                      labels = scales::label_dollar())+
  labs(x = NULL,
       title = "Gapminder año 2007: ",
       subtitle = "PIB Per Cápita por País América")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



ggplot(data=df_gapminder_2007_america,
       aes(x=reorder(country, -gdpPercap),
           y= gdpPercap))+
  geom_col()+
  scale_y_continuous (name = NULL,
                      breaks = seq(0, 45000, by = 5000),
                      labels = scales::label_dollar())+
  labs(x = NULL,
       title = "Gapminder año 2007: ",
       subtitle = "TOP PIB Per Cápita por País América")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
#
ggplot(data=df_gapminder_2007_america,
       aes(x=reorder(country, -gdpPercap),
           y= gdpPercap,
           fill= country))+
  geom_col()+
  scale_y_continuous (breaks = seq(0, 45000, by = 5000),
                      labels = scales::label_dollar())+
  labs(x = NULL,
       y="PIB Per Cápita en USD",
       title = "Gapminder año 2007: ",
       subtitle = "PIB Per Cápita por País América")+
  theme_light()+
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   family = "serif",
                                   size = 8),
        legend.position = 'none')+
  scale_fill_viridis (discrete=TRUE)

## geom_point
################################################## ggplot
# hacernos una pregunta. hipótesis
# cómo es la relación entre la expectativa de vida y el pibpercap
# comportamiento lineal, exponencia?
ggplot(data = gapminder_2007) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap))
#
# # relación de los datos positiva
#
ggplot(data = gapminder_2007,
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_point(color= "#9d0208")


# diferencia en posicion de color


## mapeo de una expresion
ggplot(data = gapminder_2007) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           color= lifeExp>mean(gapminder_2007$lifeExp)
  ))
ggplot(data = gapminder_2007) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           color= continent=='Americas'))

# mapeo al tamaño
ggplot(data = gapminder_2007) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           color= continent=='Americas',
                           size=gdpPercap),
             alpha=.8)

# mapeo a la forma
ggplot(data = gapminder_2007) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           size=pop,
                           shape= continent,
  ),
  color= '#386641',
  alpha=.8)+
  theme_bw()


# pregunta: color transimite información?

# mapeos estéticos
ggplot(data = gapminder_2007) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           color= continent))

ggplot(data= mtcars,
       aes(x=carb,
           y= disp,
           color=factor(cyl)))+
  geom_point()

ggplot(data = gapminder%>%
         filter(continent=='Europe')) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           color= year))

# color por variable categorica
ggplot(data = gapminder_2007%>%
         filter(continent=='Americas')) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           color= country))

ggplot(data = gapminder_2007%>%
         filter(continent=='Americas')) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           color= country))+
  theme_dark()+
  theme(legend.position = "bottom")



# color por variable continua

#
ggplot(data = gapminder%>%
         filter(continent=='Europe'),
       mapping = aes(x = lifeExp,
                     y = gdpPercap,
                     colour= year)) +
  geom_point() #colour y mapping


ggplot(data = gapminder%>%
         filter(continent=='Asia')) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           colour = country,
                           alpha = pop))+
  theme(legend.position = "bottom")

ggplot(data = gapminder_2007) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           colour= pop,
                           shape = continent))

### histogramas
# histograma

ggplot(data = gapminder_2007) +
  geom_histogram(aes(x= gdpPercap))

ggplot(data = gapminder_2007) +
  geom_histogram(aes(x= gdpPercap),
                 fill='red')

ggplot(data = gapminder_2007,
       aes(gdpPercap)) +
  geom_histogram(bins=20,
                 fill='#0a9396')

ggplot(data = gapminder_2007,
       aes(gdpPercap,
           color=continent)) +
  geom_histogram()

ggplot(data = gapminder_2007,
       aes(gdpPercap,
           fill=continent)) +
  geom_histogram(bins=20)

##
## geom_bar
# BarPlot

ggplot(data = gapminder_2007) +
  geom_bar(aes(x=continent),
           fill= "#ffbe0b")

gapminder_2007%>%
  group_by(continent)%>%
  count(sort = TRUE, name='Total')%>%
  ggplot() +
  geom_bar(aes(x=reorder(continent,-Total),
               y=Total ),
           stat='identity',
           fill= "#ffbe0b")


# equivalentes
gapminder_2007%>%
  group_by(continent)%>%
  count(sort = TRUE,
        name='Total')%>%
  ggplot() +
  geom_col(aes(x=reorder(continent,-Total),
               y= Total),
           fill= "#ffbe0b")

#geom_density

ggplot(data=gapminder_2007,
       aes(x=lifeExp))+
  geom_density()

ggplot(data=gapminder_2007,
       aes(x=lifeExp,
           color=continent))+
  geom_density(aes(fill=continent))

ggplot(data=gapminder_2007,
       aes(x=lifeExp,
           color=continent))+
  geom_density(aes(fill=continent),
               alpha = 0.5)



# otros

ggplot(data=gapminder_2007,
       aes(x=lifeExp))+
  geom_freqpoly()

ggplot(data=gapminder_2007,
       aes(x=lifeExp))+
  geom_dotplot()

ggplot(data=gapminder_2007,
       aes(x=lifeExp))+
  geom_histogram()+
  geom_rug()

## geom_lines
download.file('https://github.com/UCVeconomia2024-2/scripts/raw/refs/heads/main/data_in/valores_acciones.rds','precios_acciones_download.rds')
df_valores_acciones <- readRDS('precios_acciones_download.rds')
#
df_valores_acciones%>%
  filter(accion=='Nvidia'&
           tipo_valor=='close')%>%
  ggplot(aes(x=fecha,
             y=valor))+
  geom_line(color= '#06d6a0')

df_valores_acciones%>%
  filter(accion!='Bitcoin'& tipo_valor=='close')%>%
  ggplot(aes(x=fecha,
             y=valor,
             color=accion))+
  geom_line()+
  scale_y_continuous(labels = scales::label_dollar())+
  scale_color_manual(values =  c('#fb8500','#ffb703','#023047','#219ebc'))

df_valores_acciones%>%
  filter(accion=='Apple'&
           tipo_valor %in% c('high','low') &
           fecha>'2024/01/01')%>%
  ggplot(aes(x=fecha,
             y=valor,
             linetype = tipo_valor,
             color=tipo_valor))+
  geom_line()+
  scale_y_continuous(labels = scales::label_dollar())+
  scale_color_manual(values =  c('#fb8500','#023047'))

library(scales)
df_valores_acciones%>%
  filter(accion=='Apple'&
           tipo_valor %in% c('high','low') &
           fecha>'2024/01/01')%>%
  ggplot(aes(x=fecha,
             y=valor,
             linetype = tipo_valor,
             color=tipo_valor))+
  geom_line()+
  scale_y_continuous(labels = scales::label_dollar())+
  scale_color_manual(values =  c('#fb8500','#023047'))+
  scale_x_date(date_labels = "%m/%Y", date_breaks = "month")+
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   family = "serif",
                                   size = 8),
        legend.position = 'none')

Sys.setlocale("LC_TIME", "es_ES.UTF-8")
df_valores_acciones%>%
  filter(accion=='Apple'&
           tipo_valor %in% c('high','low') &
           fecha>'2024/01/01')%>%
  ggplot(aes(x=fecha,
             y=valor,
             linetype = tipo_valor,
             color=tipo_valor))+
  geom_line()+
  scale_y_continuous(labels = scales::label_dollar())+
  scale_color_manual(values =  c('#fb8500','#023047'))+
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1,
                                   family = "serif",
                                   size = 8),
        legend.position = 'none')


## geom_boxplot
ggplot(data = gapminder_2007) +
  geom_boxplot(aes(y=lifeExp),
               fill= "#fb8b24")

ggplot(data = gapminder_2007,
       mapping = aes(x=continent,
                     y= gdpPercap)) +
  geom_boxplot(fill= "#fb8b24",
               color='#00a6fb')

ggplot(data = gapminder_2007,
       mapping = aes(x=continent,
                     y= gdpPercap)) +
  geom_boxplot(fill= "#fb8b24",
               outlier.colour = 'red',
               color='#00a6fb')

# # composiciones
#
ggplot(data = gapminder_2007,
       mapping = aes(x=continent,
                     y= gdpPercap)) +
  geom_point()+
  geom_boxplot(fill= "#fb8b24")+
  geom_hline(yintercept = mean(gapminder_2007$gdpPercap),
             size = 1,
             colour="#c1121f")

ggplot(data = gapminder_2007,
       mapping = aes(x=continent,
                     y= gdpPercap)) +
  geom_boxplot(fill= "#fb8b24")+
  geom_point()

# determinar quienes son los puntos de arriba

ggplot(data = gapminder_2007,
       mapping = aes(x=continent,
                     y= gdpPercap)) +
  geom_boxplot(fill= "#fb8b24")+
  coord_flip()




# dos variables categoricas
gapminder%>%
  filter(continent=='Americas')%>%
  ggplot(aes(x=year,
             y=reorder(country,lifeExp),
             fill=lifeExp))+
  geom_tile(color='grey40')+
  scale_fill_gradient(low = "white", high = "#147df5")


## geom_smooth

mapeos geométricos
ggplot(data = gapminder,
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_smooth()

# # añadir más capas
ggplot(data = gapminder) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           alpha = 1/5))+
  geom_smooth(mapping = aes(x = lifeExp,
                            y = gdpPercap))

ggplot(data = gapminder,
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_point( alpha = 1/5)+
  geom_smooth()
#
#
ggplot(data = gapminder,
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_point()+
  geom_smooth()


## global vs local encoding
# global color encodding
ggplot(data = gapminder,
       mapping = aes(x = lifeExp,
                     y = gdpPercap,
                     color= continent)) +
  geom_point()+
  geom_smooth()

# local color encodding
ggplot(data = gapminder,
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_point(aes(color=continent))+
  geom_smooth()
#
ggplot(data = gapminder,
       mapping = aes(x = lifeExp,
                     y = gdpPercap,
                     color= continent)) +
  geom_point()+
  geom_smooth(aes(group=year,
                  color=factor(year)),
              method='lm')


ggplot(data = gapminder_2007,
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_smooth()


ggplot(data = gapminder_2007%>%
         filter(continent=='Europe'),
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_smooth() #c


ggplot(data = gapminder) +
  geom_smooth( mapping = aes(x = lifeExp,
                             y = gdpPercap,
                             linetype= continent,
                             color=continent))
# #c
ggplot(data = gapminder) +
  geom_smooth( mapping = aes(x = lifeExp,
                             y = gdpPercap,
                             group = continent,
                             color=continent))

ggplot(data = gapminder) +
  geom_smooth( mapping = aes(x = lifeExp,
                             y = gdpPercap,
                             group = continent,
                             color=continent),
               method = "lm",
               size = 2)

## interactividad
library(plotly)
gap_2007_amer_le_gp <- ggplot(data = gapminder_2007%>%
                                filter(continent=='Americas')) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           size = pop,
                           colour = country))+
  theme_light()+
  theme(legend.position = "bottom")+
  labs(title = "Gapminder 2007 Américas: lifeExp ~  gdpPercap",
       x = "Expectativa de Vida",
       y = "PIB Percápita",
       caption='conjunto de datos: Gapminder por Hans Roslig',
       tag='Fig. 1')



gap_2007_amer_le_gp

gap_2007_amer_le_gp%>%
  ggplotly()

# guardar grafico
ggsave(gap_2007_amer_le_gp,
       filename= 'gap_2007_amer_le_gp.png')

ggsave(gap_2007_amer_le_gp,
       width= 8,
       height = 5,
       dpi=2400,
       filename='gap_2007_amer_le_gp_ajustado.png')



ggplot(data = gapminder_2007,
       mapping = aes(x=continent,
                     y= gdpPercap)) +
  geom_boxplot(fill= "#fb8b24",
               color='#00a6fb')

# ## otros
library("ggalt")
library("tidyr")

#Prepare data
mancuerna_df <- gapminder %>%
  filter(year == 1967 | year == 2007) %>%
  select(country, year, lifeExp) %>%
  pivot_wider(names_from= year, values_from=lifeExp) %>%
  mutate(gap = `2007` - `1967`) %>%
  arrange(desc(gap)) %>%
  head(10)



ggplot(mancuerna_df,
       aes(x = `1967`,
           xend = `2007`,
           y = reorder(country, gap),
           group = country)) +
  geom_dumbbell(colour = "#dddddd",
                size = 3,
                colour_x = "#FAAB18",
                colour_xend = "#1380A1") +
  bbc_style() +
  labs(title="Vivimos más Tiempo",
       subtitle="Mayor crecimiento en la expectativa de vida, 1967-2007",
       x=NULL,
       y=NULL)

##### facetas

ggplot(data = gapminder,
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_smooth(color='#c9184a')+
  facet_wrap(~continent, nrow=1)+
  theme_dark()

ggplot(data = gapminder,
       mapping = aes(x = lifeExp,
                     y = gdpPercap)) +
  geom_smooth(color='#ca6702')+
  facet_wrap(~year)+
  theme_grey()

ggplot(data = gapminder_2007) +
  geom_boxplot(aes(y=lifeExp,
                   color= continent))+
  facet_grid(~continent)

ggplot(data = gapminder_2007) +
  geom_boxplot(aes(y=lifeExp,
                   color= continent))+
  facet_wrap(~continent)

# facetas
ggplot(data = gapminder) +
  geom_histogram(aes(gdpPercap,
                     color=continent))+
  facet_wrap(~continent)

ggplot(data = gapminder_2007) +
  geom_histogram(aes(lifeExp),
                 bins = 10)+
  facet_wrap(~continent)
#
# facetas cont
# # método para agregar variables categóricas. wrap= envoltorio
ggplot(data = gapminder) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           colour= pop))+
  facet_wrap(~ continent, nrow = 1)

ggplot(data = gapminder_2007) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           colour= pop))+
  facet_wrap(~ continent, nrow = 2)


gapminder_af_am <- gapminder%>%
  filter(continent %in% c('Americas','Europe'))

ggplot(data = gapminder_af_am) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           colour= pop))+
  facet_wrap(country ~ continent)

ggplot(data = gapminder_af_am) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           colour= pop))+
  facet_wrap(. ~ continent)

ggplot(data = gapminder_af_am) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           colour= pop))+
  facet_wrap(. ~ country)

ggplot(data = gapminder_af_am) +
  geom_point(mapping = aes(x = lifeExp,
                           y = gdpPercap,
                           colour= pop))+
  facet_wrap( country ~ .)


## ajuste de valores en ejes
set.seed(1)
df <- data.frame(
  x = rnorm(10) * 100000,
  y = seq(0, 1, length.out = 10))

p2 <- ggplot(df, aes(x, y)) + 
  geom_point()

p2 +
  scale_y_continuous(labels = scales::label_percent())

p2 + 
  scale_y_continuous(labels = scales::label_dollar())

p2 + 
  scale_x_continuous(labels = scales::label_comma())