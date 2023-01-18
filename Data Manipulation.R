#Dplyr
install.packages("dplyr")

#bonus-vuelos 2013 nueva york
install.packages("nycflights13")

library(dplyr)
library(nycflights13)

#dplyr - filter -Obtiene valores por condición
#nycflights13 su dataset es flights
head(filter(flights, month==11,day==3,carrier=="AA"))
#forma clasica
head(flights[flights$month==11 & flights$day==3 & flights$carrier=="AA",])
#dplyr - slice -Obtiene por rango o numero de fila
slice(flights, 1:10)
#dplyr - arrange -Ordena los valores por columna, es como un ORDER BY
head(arrange(flights,year,month,day,arr_time))
#Descendente
head(arrange(flights,year,month,day,desc(arr_time)))
#dplyr - select -Selecciona por columna de df
head(select(flights,month))
head(select(flights,month,carrier,arr_time))
#dplyr - rename -Cambiar el nombre de una columna
head(rename(flights,airline_carrier=carrier))
#dplyr - distinct -Selecciona los valores que son distintos o unicos en la columna
distinct(flights,carrier)
#con ayuda de select puedes dar un orden de visaulización
distinct(select(flights,carrier,month))
#dplyr - mutate -agrega una nueva columna y puede hacerlo en base a las otras del df
colnames(mutate(flights, new_col=arr_delay-dep_delay))
#dplyr - transmutate -devuelve solo la nueva columna que estas creando en base a las otras del df
head(transmute(flights, new_col=arr_delay*dep_delay))
#dplyr - summarise -sirve más ara agregar una columna en base a un total de otra
summarise(flights, avr_air_time=mean(air_time,na.rm = TRUE))
summarise(flights, total_time=sum(air_time,na.rm = TRUE))
#dplyr - sample_n -devuelve un aleatorio de n filas
sample_n(flights,5)
#dplyr - sample_frac -devuelve un aleatorio de n porcentaje filas
sample_frac(flights,0.00001)

#pipe
library(dplyr)
df<-mtcars
#Nesting
result<-arrange(sample_n(filter(df,mpg>20),size=5),desc(mpg))

#Multiple Assigments
a<-filter(df,mpg>20)
b<-sample_n(a,size=5)
result<-arrange(b,desc(mpg))
result

#pipe
result<-df%>%
  filter(mpg>20)%>%
  sample_n(size=5)%>%
  arrange(desc(mpg))
result

#Exercises
library(dplyr)
df<-mtcars
#1
filter(df, mpg>20, cyl==6)

#2
arrange(df, cyl,desc(wt))

#3
select(df,mpg,hp)

#4
distinct(df,gear)

#5
mutate(df,render=hp/wt)

#6
summarise(df, mean(mpg))

#7
df%>%
  filter(cyl==6)%>%
  summarise(mean(hp))

#Tidyr
install.packages("data.table")
install.packages("tidyr")

library(data.table)
library(tidyr)

#gather - junta en una sola columna el KEY o nombre de otras columnas, 
#y su valor los coloca en otra, para que apartir de 1-n columnas solo tengamos
#1 columna de keys y otra de valore
comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)

df <- data.frame(comp=comp,year=yr,Qtr1 = q1,Qtr2 = q2,Qtr3 = q3,Qtr4 = q4)

gather(df,key="Quarter",value="Revenue",Qtr1:Qtr4)
df%>%
  gather(key="Quater",value="Revenue",Qtr1:Qtr4)
help(gather)


#spread - Es todo lo contrario de gather
stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
stocks

stocks.gathered<-stocks%>%
  gather(key="stock",value="price",X:Z)
stocks.gathered

#spread
stocks.spreaded<-stocks.gathered %>%
  spread(stock,price)
stocks.spreaded

stocks.spreaded<-spread(stocks.gathered,stock,price)
stocks.spreaded

stocks.spreaded<-spread(stocks.gathered,time,price)
stocks.spreaded

#separate -separa los valores de una columna segun el usuario indique el 
#nombre de las nuevas columnas, su separador por defecto es cualquier caracter
#que no sea alfanumerico
df<-data.frame(new.col=c(NA, "a.x","b.y","c.z"))
df

separate(df, new.col, c("ABC","XYZ"))
help(separate)

df<-data.frame(new.col=c(NA, "a-x","b-y","c-z"))
df
separate(data=df, col=new.col, into = c("abc","xyz"),sep = "-")

df.sep=separate(data=df, col=new.col, into = c("abc","xyz"),sep = "-")

unite(df.sep, new.joined.col,abc,xyz,sep = "-")
