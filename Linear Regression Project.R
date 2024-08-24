library(ggplot2)

#Leer CSV
df<-read.csv(file="Data Kaggle/train.csv",sep=",")

#Mostrar 6 primeras filas
head(df,6)

#Diagrama de dispersión o scatter plot en la que hacemos un versus entre la temperatura
#y la cantidad, dos valores que aparecen en el dataframe, asu vez se muestra una leyenga
#donde especificamos que tome los colores de las burbujas basandose en la cantidad de 
#la temperatura
ggplot(df,aes(temp,count))+geom_point(alpha=0.2,aes(color=temp))+theme_minimal()

#Cambiar variable datetime que por defecto es un tipo de dato CHARACTER a POSIXct para que
#sea como un tipo de dato horario
df$datetime<-as.POSIXct(df$datetime)
class(df$datetime)


#Diagrama de dispersión o scatter plot en la que hacemos un versus entre las fechas
#y la cantidad, dos valores que aparecen en el dataframe, asu vez se muestra una leyenga
#donde especificamos que tome los colores de las burbujas basandose en la cantidad de 
#la temperatura
ggplot(df,aes(datetime,count))+geom_point(alpha=0.2 ,aes(color=temp))+ scale_color_continuous(low='#55D9CE',high='#FF6E2E')+theme_bw()

#COR calculará la correlación entre las dos columnas seleccionadas y 
#te devolverá un único valor que representa la correlación entre esas dos variables
cor(df$temp,df$count)

#Si necesitas la matriz de correlación entre más de 2 columnas o lo quieres ver como
#una tabla de correlación entre 2 columnas, simplemente agrega esas columnas al 
#argumento de la función cor(), de la siguiente manera
cor(df[,c('temp','count','humidity')])
cor(df[,c('temp','count')])


ggplot(df,aes(x=factor(season),y=count))+geom_boxplot(aes(color=factor(season)))+theme_bw()

#Agregamos una nueva columna con las horas de cada registro. Esto se ha obtenido de
#la columna datetime, la cual se ha cambiado de formato con la función FORMAT  
df$hour <- format(df$datetime, "%H")
df

#Seleccionamos aquellos datos donde workingday es 1
df_wd<-df[df$workingday==1,]

#restablecemos los indices
rownames(df_wd)<-NULL

pt1<-ggplot(df_wd,aes(hour,count))+geom_point(alpha=0.2,position = position_jitter(width = 1, height = 0),aes(color=temp))
pt2<-pt1+scale_color_gradientn(colors=c('blue','green','yellow','red'))
pt3<-pt2+theme_bw()
pt3


df_nwd<-df[df$workingday==0,]

rownames(df_wd)<-NULL

pt1<-ggplot(df_nwd,aes(hour,count))+geom_point(alpha=0.2,position = position_jitter(width = 1, height = 0),aes(color=temp))
pt2<-pt1+scale_color_gradientn(colors=c('blue','green','yellow','red'))
pt3<-pt2+theme_bw()
pt3

#Creamos un modelo de regresión lineal
temp.model<-lm(count ~ temp, df)

#resumen del modelo
summary(temp.model)
predict(temp.model,data.frame(temp = 25))

df$hour<-sapply(df$hour, as.numeric)

class(df$hour)

#Creamos un modelo de regresión lineal teniendo en cuenta las variables
#count vs season holiday workingday weather temp humidity windspeed hour (factor)

df$hour<-factor(df$hour)

var.model<-lm(count ~ season + holiday + workingday + weather + temp + humidity + windspeed + hour,df)
var.model<-lm(count ~ . -datetime - casual - registered -atemp,df)

df_pre<-data.frame(
  season = 1,
  holiday = 0,
  workingday = 0,
  weather = 1,
  temp= 9.84,
  humidity = 81,
  windspeed = 0,
  hour = 0)

df_pre$hour<-factor(df_pre$hour)
predict(var.model,df_pre)

#Muestra el resumen del modelo lm
summary(var.model)

