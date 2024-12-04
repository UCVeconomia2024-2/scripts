df_gapminder_csv <- read.csv('https://raw.githubusercontent.com/javendaXgh/datos/refs/heads/master/gapminder.csv')%>%
  select(-X)%>%
  as_tibble()

df_rl_gapminder <- df_gapminder_csv%>%
  nest_by(country) %>% # función clave ya que anida los datos
  mutate(lm_result= list(lm(gdpPercap ~ lifeExp, data = data)))



t <- df_rl_gapminder%>%
  .[1:2,]
t

t$data[1][[1]]
t$country[1]

lapply(t$data,`[`) 

lapply(t$data,`[`)%>%
  bind_cols(country=rep(t$country,each=12))

do.call(rbind,lapply(t$data,`[`))%>%
  mutate()

apply(t,1,unlist)