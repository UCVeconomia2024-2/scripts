library(tidyverse)
library(sf)
library(spData)
library(gganimate)
library(viridis)
data(world)

# see also: https://proj.org/operations/projections/index.html
projs <- list(
  "Mercator" = "+proj=merc",
  "WGS 84" = "+proj=longlat",
  "Robinson" = "+proj=robin",
  "Compact Miller" = "+proj=comill",
  "Eckert I" = "+proj=eck1",
  "Eckert II" = "+proj=eck2",
  "Eckert III" = "+proj=eck3",
  "Eckert IV" = "+proj=eck4",
  "Mollweide" = "+proj=moll", 
  "Azimuth Equidistant" = "+proj=aeqd",
  "Lambert Equal Area" = "+proj=laea",
  "Adams World in a Square 2" = "+proj=adams_ws2",
  "Sinusoidal (Sanson-Flamsteed)" = "+proj=sinu",
  "Interrupted Goode Homolosine" = "+proj=igh"
)

##########
dd <- map_dfr(projs, function(p) {
  d <- world %>% 
    select(iso_a2, name_long, continent, geom) %>% 
    mutate(projection = p, L1 = 1:n()) %>% 
    st_transform(p)
  
  dd <- left_join(
    st_coordinates(d) %>% as_tibble(), 
    d %>% as_tibble() %>% select(-geom), 
    by = "L1"
  )
  
  res <- dd %>% 
    mutate(name_long=as.character(name_long))%>%
    select(x = X, y = Y, everything(),name_long )%>% 
    mutate(id = paste0(L1, L2, L3)) %>% 
    mutate(x_orig = x, y_orig = y,
           x = (x - min(x)) / (max(x) - min(x)),
           y = (y - min(y)) / (max(y) - min(y)))
  
  res
})%>% 
  mutate(projection = factor(projection, levels = unlist(projs)))


anim <- ggplot(dd, aes(x = x, y = y,  group = id)) + # group = id,
  geom_polygon(fill="black") + #fill="black"
  transition_states(projection) +
  ease_aes("cubic-in-out") +
  labs(title = "El mundo proyectado en sistema: '{names(projs)[projs == closest_state]}' Projektion",
       subtitle = "Proyección: '{closest_state}'") +
  
  theme(axis.title=element_blank(),
        #axis.text=element_blank(),
        axis.ticks=element_blank(), 
        panel.grid=element_blank(),
        plot.background=element_rect(fill = "grey60"))+
  theme_dark()

anim

anim_save("projections_word.gif", anim, res = 200, width = 1000, height = 1000, fps=6)



#########
world1 <- world%>%
  filter(name_long %in% c('Colombia', 'Venezuela','Guyana'))%>%
  mutate(name_long = replace(name_long, name_long == "Guyana", "Venezuela"))%>%
  mutate(iso_a2 = replace(iso_a2, iso_a2 == "GY", "VE"))%>%
  mutate(color=case_when(iso_a2=='VE'~'red',
                         iso_a2=='CO'~'blue'))

unique(world1$iso_a2)

dd1 <- map_dfr(projs, function(p) {
  d <- world1 %>% 
    select(iso_a2, name_long,geom) %>% 
    mutate(projection = p, L1 = 1:n()) %>% 
    st_transform(p)
  
  dd <- left_join(
    st_coordinates(d) %>% as_tibble(),
    d %>% as_tibble() %>% select(-geom),
    by = "L1"
  )
  #
  res <- dd %>%
    mutate(name_long=as.character(name_long))%>%
    select(x = X, y = Y, everything(),name_long )%>%
    mutate(id = paste0(L1, L2, L3)) %>%
    mutate(id = replace(id, id == 114,113)) %>%
    mutate(x_orig = x, y_orig = y,
           x = (x - min(x)) / (max(x) - min(x)),
           y = (y - min(y)) / (max(y) - min(y)))
  
  res
})%>% 
  mutate(projection = factor(projection, levels = unlist(projs)))#%>%
mutate(color=case_when(id=='111'~'red',
                       id=='112'~'blue',
                       id=='113'~'orange'))




unique(dd1$id)
cols <- c("#FACD2D","#0011AD","#0011AD")

anim_ve <- ggplot(dd1, aes(x = x, y = y,fill = id,colour='black')) + # group = id,
  geom_polygon() + #fill="black"
  transition_states(projection) +
  scale_fill_manual(values = cols)+
  # scale_fill_viridis(discrete = TRUE) +
  ease_aes("cubic-in-out") +
  labs(title = "Colombia y Venezuela proyectados en: '{names(projs)[projs == closest_state]}' Projektion",
       subtitle = "Proyección: '{closest_state}'") +
  theme_dark() +
  theme(axis.title=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(), 
        panel.grid=element_blank(),
        plot.background=element_rect(fill = "#5D737E"),
        legend.title = element_blank(),
        legend.position = 'none')
anim_ve
xclass(anim_ve)
anim_save("projections_ve_col.gif", anim_ve, res = 400, width = 1000, height = 1000, fps=6)
