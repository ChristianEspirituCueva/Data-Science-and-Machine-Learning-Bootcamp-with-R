#Pestaña con todos los conjuntos de datos disponibles
data()
#Mostrar las 6 primeras filas
head(state.x77)
#Mostrar las 6 ultimas filas
tail(state.x77)
#Muestra inforación acerca de la estructura
str(state.x77)
#Muestra el recumen de los resultados
summary(state.x77)

#Construimos un Data Frame
days<-c("Mon","Tue","Wed")
temp<-c(24,30,21)
rain<-c(T,T,F)
df<-data.frame(days,temp,rain)
str(df)
summary(df)


#Indexación y selección de data frames
df[1,]
df[,2]
df[,"rain"]
df[1:3,c(1,3)]
df[c(1,3),c("rain","days")]

df$days
df["days"]

#filtrado en data frame
subset(df, subset = days=="Mon")
subset(df, subset = temp>=24)

#ordenar valores ascendente por indice
sorted.temp <-order(df['temp'])
sorted.temp

#ordenar el data frame
df[sorted.temp,]

#ordenar valores descendente 
desc.temp<-order(-df['temp'])
desc.temp<-order(-df$temp)
desc.temp

df[desc.temp,]
