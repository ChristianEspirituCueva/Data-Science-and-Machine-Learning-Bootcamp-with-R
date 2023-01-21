#GGPLOT2 se conforma basicamente por 3 capas
#1.Data 
#2.Aesthetics(especificar las columnas o caracteristicas que realmente quieras trazar) 
#3.Geometries(especificar como queremos visualizar los datos)
#ggplot(data=mtcars,aes(x=mpg,y=hp))+geom_point()

install.packages("ggplot2")
library(ggplot2)
ggplot(data=mtcars,aes(x=mpg,y=hp))+geom_point()

#conozcamos las 3 siguientes capas
#4.Facets(especificar como se deberían de divir los datos con respecto a otra columna)
ggplot(data=mtcars,aes(x=mpg,y=hp))+geom_point()
+facet_grid(cyl ~.)

#5.Statistics(especificar ...)
ggplot(data=mtcars,aes(x=mpg,y=hp))+geom_point()+facet_grid(cyl ~.)
+stat_smooth()

#6.Coordinates(especificar el limite cartesiano)
ggplot(data=mtcars,aes(x=mpg,y=hp))+geom_point()+facet_grid(cyl ~.)+stat_smooth()
+coord_cartesian(xlim=c(15,25))


##########HISTOGRAMA##########-Datos continuos
#install.packages("ggplot2movies")
library(ggplot2)
library(ggplot2movies)

#binwidth
#El ancho de los contenedores. Se puede especificar como un valor numérico 
#o una función que calcula el ancho a partir de x. El valor predeterminado 
#es utilizar bandejas que cubran el rango de los datos. Siempre debe anular 
#este valor, explorando varios anchos para encontrar el mejor para ilustrar 
#las historias en sus datos. El ancho de contenedor de una variable de fecha 
#es el número de días en cada vez; El ancho de contenedor de una variable de 
#tiempo es el número de segundos.
#https://stackoverflow.com/questions/55734043/helping-finding-definition-of-binwidth-in-ggplot2#:~:text=answering%20my%20question%3A-,binwidth,the%20stories%20in%20your%20data.'

#Data y Estetica
p1<- ggplot(movies, aes(x=rating))
#Geometria

#binwidth-> ancho de los contenedores
#color-> color de los contenedores
#fill-> color del relleno de los contenedores
#alpha-> transparecia de los contenedores
#aes(fill=..count..))-> rellenado de contenedores según la cantidad

#p2<- p1 + geom_histogram(binwidth = 0.1,color="red",fill="pink",alpha=0.4)
p2<- p1 + geom_histogram(binwidth = 0.1,aes(fill=..count..))
p3<- p2 + xlab("Movie Rating")+ylab("Count")
p4<- p3 + ggtitle("MY TITLE")
print(p4)

##########SCATTERPLOT##########-Datos continuos
df<-mtcars

#Data y Estetica
p1<-ggplot(data=df,aes(x=wt,y=mpg))

#Geometria
#alpha-> transparecia de los puntos
#size-> el tamaño de los puntos
#aes(size=hp)-> el tamaño de los puntos según los hp
#aes(color=factor(cyl))-> el color de los puntos según los factores de cyl
#                         que son 4,6 y 8, pero se autocompletan 5 y 7 si es
#                         que no especificamos que queremos solo los factores
#aes(shape=factor(cyl))-> la forma de los puntos según los factores de cyl
#color="blue"-> colorea los puntos de color azul

#p2<-p1 + geom_point(alpha=0.5,size=5)
#p2<-p1 + geom_point(aes(color=factor(cyl)))
p2<-p1 + geom_point(aes(shape=factor(cyl)), size=5, color="blue")
print(p2)

library(dplyr)
distinct(mtcars,cyl)

#color hexagecimal
p2<-p1 + geom_point(size=5, color="#a435f0")
print(p2)

#aes(color=factor(cyl)) y scale_color_gradient
p2<-p1 + geom_point(aes(color=hp),size=5,)
p3<-p2 + scale_color_gradient(low = "blue",high = "red")
print(p3)


##########BARPLOT########## - Datos Continuo Factor
#position = "dodge" -> cambia de barras apiladas a que esten separadas
#position = "fill" -> cambia de barras apiladas a mostrar por medio de un total (porcentaje)
df<-mpg
pl<-ggplot(df,aes(x=class))
#pl+geom_bar(aes(fill=drv), position = "dodge")
pl+geom_bar(aes(fill=drv), position = "fill")



##########BOXPLOT##########

df<-mtcars
#advice, en un grafico de cajas el eje X debe ser continuo pero de factor
#        en este caso cyl si es categorico pero tenemos que especificarlo
#        colocando factor porque sino lo tomará como una continua culaquiera

#coord_flip(), invierte las coordenadas

#aes(fill=factor(cyl)), utilizamos fill=cyl para que las cajas se coloreen según 
#                el cyl que representen

#theme_dark(), utilizamos esto para darle un tema al fondo del lienzo
pl <- ggplot(data=df, aes(x=factor(cyl), y=mpg))
pl + geom_boxplot(aes(fill=factor(cyl)))+coord_flip()+theme_dark()

distinct(df,mpg)



##########2 variable plotting##########
#binwidth=c(3,1) -> Este argumento controla el ancho de cada barra sobre el eje X.
#scale_fill_gradient(high = "red",low = "blue") -> Este argumento nos permite 
#                                                  modificar los colores de la gradiente
#geom_hex() -> Este argumento cambia los bin cuadriculador por hexagonos
library(ggplot2movies)

pl <- ggplot(movies,aes(x=year,y=rating))
pl2 <- pl + geom_bin2d(binwidth=c(3,1))
pl2 + scale_fill_gradient(high = "red",low = "blue")

##########DIAGRAMA DE HEXAGONOS##########
#install.packages("hexbin")
pl <- ggplot(movies,aes(x=year,y=rating))
pl2 <- pl + geom_density()
pl2 + scale_fill_gradient(high = "red",low = "blue")


##########DIAGRAMA DE DENSIDAD##########
pl <- ggplot(movies,aes(x=year,y=rating))
pl + geom_density2d()




##########CORDENADAS Y FACETADO##########
#coord_cartesian(xlim=c(1,4),ylim=c(15,30)) -> hace un enfoque según los 

#CORDENADAS                                              vectores en xlim y ylim

pl <- ggplot(mpg, aes(x=displ,y=hwy)) 
pl2<- pl + geom_point()
pl2 + coord_cartesian(xlim=c(1,4),ylim=c(15,30))


#coord_fixed -> permite tener un tamaño fijo del eje de cordenadas, donde 
#               es medido mediante un ratio el cual determina el tamaño  
#               espacio del blanco en el eje X
pl <- ggplot(mpg, aes(x=displ,y=hwy)) 
pl2<- pl + geom_point()
pl2 + coord_fixed(ratio = 1/4)


#FACETAS
#facet_grid(. ~ cyl) -> divide en facetas según el campo continuo que 
#                       le asignes
# . ~ -> estos simbolos nos ayudan a dar la orientación de las facetas
#        dependiendo de los ejes

# . ~ (columna)-> eje X     (columna) ~ . -> eje Y
pl <- ggplot(mpg, aes(x=displ,y=hwy)) 
pl2<- pl + geom_point()
pl2 + facet_grid(. ~ cyl)

# (columna 1) ~ (columna 2) ->  los datos continuos de la columna 2 van 
#                               a ser orientados hacia el eje X
#                               los datos continuos de la columna 1 van 
#                               a ser orientados hacia el eje Y





##########Theme##########
#Existen dos tipos de temas: Para todas las tramas y otro para cada trama

#Para todas las tramas
theme_set(theme_minimal())
pl <- ggplot(mtcars, aes(x=wt,y=mpg)) 
pl2<- pl + geom_point()
pl2

#Para cada trama
pl <- ggplot(mtcars, aes(x=wt,y=mpg)) 
pl2<- pl + geom_point()
pl2 + theme_dark()

#para más temas instale ggthemes
install.packages("ggthemes")


#Exercices
#1
df<-mpg
ggplot(data=df,aes(x=hwy))+geom_histogram()
head(df)

#2
ggplot(data=df,aes(x=manufacturer))+geom_bar(aes(fill=factor(cyl)))

#3
head(txhousing)
df<-txhousing
ggplot(data=df, aes(x=sales,y=volume)) + geom_point(color="blue") 

#4 
# LOESS SMOOTH LINE geom_smooth()
# LINEAR MODEL geom_smooth(method = 'lm')
# SMOOTHNESS/ROUGHNESS geom_smooth(span = .2)
ggplot(data=df, aes(x=sales,y=volume)) + geom_point(color="blue") + geom_smooth(color="red") 
