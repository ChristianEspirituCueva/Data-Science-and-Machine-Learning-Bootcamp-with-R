library(ISLR)
print(head(iris))

set.seed(101)

library(ggplot2)
#Grafiacmos como se ve la clasificación usando solo dos caracteristicas (features) del dataset
ggplot(iris,aes(Petal.Length,Petal.Width,color = Species))+geom_point(size=4)

#Creamos nuestro modelo KMEAS
#asginamos las caracteristicas (features) del dataset y obviamos la de clasificación
#asginamos cuantos K deseamos, en este caso serán solo 3
#asignamos el numero de inicios aleatorios que le daremos, en este caso probará con 20 diferentes puntos de inicio
iris.cluster<-kmeans(iris[,1:4],centers = 3,nstart = 20)
print(iris.cluster)

#Comaparamos la clasificación resultante de Kmeans contra 
#la clasificación origianl del dataset
table(iris.cluster$cluster, iris$Species)
library(cluster)
clusplot(iris, iris.cluster$cluster, color = T,shade = T,labels=0, lines=0)
