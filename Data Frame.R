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

#Crear un dataframe
empty<-data.frame()
c1<-1:10
letters
c2<-letters[1:10]
df<-data.frame(column.name.1=c1, column.name.2=c2)

#Importar y exportar un dataframe
write.csv(df,file = "saved_file.csv")
df2<-read.csv("saved_file.csv")
df2
#obtener información de un dataframe
nrow(df)
ncol(df)
colnames(df)
rownames(df)
str(df)
summary(df)

#referenciar celdas en particular(una sola celda)
    #formato vector
df[5,2]
df[[5,2]]
df[[5,'column.name.2']]
    #Cambiar valores en un dataframe
df[2,'column.name.1']<-999
df[[2,'column.name.1']]<-999
df[[1,1]]

#referenciar filas
    #Formato data frame
df[2,]

#referenciar columnas
    #formato vector
mtcars[,2]
mtcars$mpg
mtcars[,"mpg"]
mtcars[["mpg"]]
    #formato matriz
mtcars[c("mpg")]
mtcars[c("mpg","cyl")]
mtcars[1]
#Añadir filas
df2<-data.frame(column.name.1=200,column.name.2="new")
dfnew<-rbind(df,df2)

#Añadir columnas
df$newcol<-2*df$column.name.1
df[,"newcol.copy"]<-df$newcol

#Modificar nombre de columnas
colnames(df)<-c("1","2","3","4")
    #Modificar el nombre de una columna en especifico
colnames(df)[1]<-c("new column")
colnames(df)[1]<-"new column!"

#Seleccionar multiples filas
head(df)
head(df,4)
df[1:3,]
    #Excluir de la selección
df[-2,]
    #Obtener resultados en filas por condición
mtcars[(mtcars$mpg > 20) & (mtcars$cyl ==6) ,]
    #Obtener resultados en filas por condición, restringiendo las columnas
mtcars[(mtcars$mpg > 20) & (mtcars$cyl ==6) ,c("mpg","cyl","hp")]
    #Obtener resultados por condición usando subset 
subset(mtcars, mpg > 20 & cyl == 6)

#Seleccionar multiples columnas
mtcars[,c(1,2,3)]
mtcars[,c("mpg","cyl")]

#Lidiando con data perdida
    #Filtrar por filas donde halla valores vacios
subset(mtcars, is.na(mpg))
    #Filtrar por filas donde no halla valores vacios
subset(mtcars, !is.na(mpg))
    #Mostrar los valores vacio en el df como true y false
is.na(mtcars)
    #Verificar si existe algún valor vacio
any(is.na(mtcars))
    #Verificar si existe algún valor vacio en una columna en especifico
any(is.na(mtcars$mpg))
    #Reemplazar números vacios por cero de todo el df
df[is.na(df)]<-0
    #Reemplazar números vacios por cero de una columna
mtcars$mpg[is.na(mtcars$mpg)]<-0
    #Reemplazar números vacios por cero de una columna
mtcars$mpg[is.na(mtcars$mpg)]<-mean(mtcars$mpg)



#EJERCICIOS
#1
Edad<-c(22,25,26)
Peso<-c(150,165,120)
Sexo<-c("M","M","F")
df<-data.frame(Edad,Peso,Sexo)
rownames(df)<-c("Sam","Franco","Amy")
df

Edad<-c(22,25,26)
Peso<-c(150,165,120)
Sexo<-c("M","M","F")
Nombre<-c("Sam","Franco","Amy")
df<-data.frame(row.names =Nombre , Edad,Peso,Sexo)
df

#2
is.data.frame(mtcars)

#3
mat<-matrix(1:25,nrow = 5)
mat<-as.data.frame(mat)

#4
df<-mtcars

#5
head(df)
df[1:6,]

#6
df.mean<-mean(df$mpg)

#7
df[df$cyl==6,]
subset(df, cyl==6)

#8
df[,c("am","gear","carb")]

#9
df$performance<-df$hp/df$wt

#10
help(round)
df$performance<-round(df$performance,2)

#11
df.mpg.mean<-mean(df[(df$hp>100) & (df$wt>2.5),c("mpg")])
     
#12
df[c("Hornet Sportabout"),c("mpg")]
