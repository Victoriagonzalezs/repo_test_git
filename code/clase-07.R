## Eduard Martinez
## Update: 21-10-2022

## limpiar entonro
rm(list=ls())

## instalar/llamar pacman
require(pacman)

## usar la función p_load de pacman para instalar/llamar las librerías de la clase
p_load(tidyverse, ## manipular/limpiar conjuntos de datos.
       rio, ## para leer/escribir archivos desde diferentes formatos. 
       skimr, ## skim: describir un conjunto de datos
       janitor) ##  tabyl: frecuencias relativas


## **[1.] Operador pipe (%>%)**
##sirve para ahorrar las lineas de codigo, simplificar el código.

### Veamos un ejemplo:
df = as_tibble(x = women)

df = mutate(.data = df , height_cm = height*2.54,
            weight_hcm = weight/height_cm)

df = arrange(.data=df , desc(height_cm))

head(x=df , n=5)

## Otra forma de hacerlo es emplear el operador pipe `%>%`:  

df = as_tibble(x = women) %>% ##y ahora.
  mutate(height_cm = height*2.54, weight_hcm = weight/height_cm) %>% #genero dos variables
  arrange(desc(height_cm))

head(x=df , n=5)

## Con `%>%` no es necesario mencionar el objeto en cada nueva transformación. Además, las líneas de código se redujeron a la mitad.

### Veamos otro ejemplo:

## Intente reescribir el siguiente código usando el operador `%>%`:
df <- import("https://www.datos.gov.co/resource/epsv-yhtj.csv")
df <- as_tibble(df)
df <- select(df, -cod_ase_)
df <- mutate(df,ifelse(is.na(estrato),1,estrato))

#intente reescribir el código
df <- import("https://www.datos.gov.co/resource/epsv-yhtj.csv") %>%
      as_tibble() %>% ##y ahora.
      select(-cod_ase_) %>% 
      mutate(ifelse(is.na(estrato),1,estrato))

df <- df[-1:-10,]

## **[2.] Combinar conjuntos de datos (adicionar filas/columnas)**

### **2.1 Agregar observaciones**

## Generar conjuntos de datos para hacer la aplicación:
set.seed(0117) # Fijar semilla
obs_1 = tibble(id = 100:105 , 
             age = runif(6,18,25) %>% round() , 
             height = rnorm(6,170,10) %>% round())

obs_2 = tibble(id = 106:107 , 
             age = runif(2,40,50)  %>% round() , 
             height = rnorm(2,165,8) %>% round() , 
             name = c("Lee","Bo"))

## Inspeccionar los datos:


## Combinar el conjunto de datos (bind_rows): 

obs <- bind_rows(obs_1,obs_2)
#adicionar filas#

### **2.2 Adicionar variables a un conjunto de datos**
db_1 <- tibble(id = 102:105 , income = runif(4,1000,2000) %>% round())
db_2 <- tibble(id = 103:106 , age = runif(4,30,40)  %>% round())

## Inspeccionar los datos:
##adicionar columnas
db <- bind_cols(db_1,db_2)

## Combinar el conjunto de datos (bind_cols): 
print("Algo salió mal! la función bind_cols() no tiene en cuenta el identificador de cada observación.") 

### **2.3 Adicionar variables a un conjunto de datos:** `join()`

## Puede adicionar variables a un conjunto de datos usando la familia de funciones de `join()`:
data_1 <- tibble(Casa=c(101,201,201,301),
              Visita=c(2,1,2,1),
              Sexo=c("Mujer","Mujer","Hombre","Hombre"))
              year=2020
data_2 <- tibble(Casa=c(101,101,201,201),
              Visita=c(1,2,1,2),
              Edad=c(23,35,7,24),
              Ingresos=c(500000,1000000,NA,2000000))
              year=2020

data_1 = data_1 %>% mutate(year=2020)
data_2=data_2 %>% mutate(year=2020)


##intentar unir
df4=full_join(data_1, data_2, by=c("Casa","Visita"), suffix= c("data_1","data_2"))
#### **Ejemplo: left_join()**
###hay dos variables que son identificadores unicos, como la llave##

df_l <- left_join(x= data_1, y=data_2, by=c("Casa","Visita"))

#### **Ejemplo: right_join()**


#### **Ejemplo: inner_join()**
#los individuos que estan en x que estan en y#

#### **Ejemplo: full_join()**
df_L <- full_join(x=data_1,y=data_2, by=c("Casa","Visita"))
df_L <- full_join(x=data_1,y=data_2, by=c("Casa"))

#### **Ejemplo: Join sin identificador único**


### **3.4 Chequear valores unicos**
df_1 <- tibble(Hogar=1,Visita=1,Sexo=1)
df_2 <- tibble(Hogar=1,Visita=1,Edad=1,Ingresos=1)

## Coincidencia en variables:

## unique


