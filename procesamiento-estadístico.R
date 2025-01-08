library(dplyr) 
library(readr)

# datos

#https://portal-transparencia.demre.cl/portal-base-datos

# Cargar base de datos


data <- read_delim("bbdd/data.csv", delim = ";", 
                   escape_double = FALSE, trim_ws = TRUE)


# Filtramos por región metropolitana

data_rm <-data |> filter(CODIGO_REGION == 13) 

# Descriptivos


tabla_rm <- data_rm |> 
  group_by(CODIGO_COMUNA) |> 
  summarise(promedio_nem = round(mean(PTJE_NEM, na.rm = TRUE), 0),
            promedio_mate = round(mean(MATE1_REG_ACTUAL, na.rm = TRUE), 0),
            promedio_lenguaje = round(mean(CLEC_REG_ACTUAL, na.rm = TRUE), 0)) |> 
  mutate(promedio_ambas = round((promedio_lenguaje + promedio_mate) / 2, 0))|> 
  drop_na(CODIGO_COMUNA)  |> 
  rename(codigo_comuna = CODIGO_COMUNA)

