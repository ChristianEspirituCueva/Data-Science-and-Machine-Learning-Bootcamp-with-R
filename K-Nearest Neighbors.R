install.packages("ISLR")
library(ISLR)
str(Caravan)

purchase <- Caravan[,86]

#Realizamos una estandarización y normalización de datos

#La estandarización es útil para poner variables en 
#una escala común, especialmente cuando tienen diferentes 
#unidades o magnitudes.

standardized.Caravan <- scale(Caravan[,-86])

#Veamos la varianza, si es 1 es porque está correctamente
#estandarizado
print(var(standardized.Caravan[,1]))
print(var(standardized.Caravan[,2]))

#Train test split
test.index <- 1:1000

#Hacemos un split manual para nuestros datos de test
test.data <- standardized.Caravan[test.index,]
test.purchase <- purchase[test.index]

#Hacemos un split manual para nuestros datos de train
train.data <- standardized.Caravan[-test.index,]
train.purchase <- purchase[-test.index]

###########
#KNN MODEL#
###########

library(class)
set.seed(101)

#knn(train, test, cl, k = 1)
#train: Un data frame o matriz que contiene los datos de entrenamiento.
#test: Un data frame o matriz que contiene los datos para los que se 
#      quieren hacer predicciones.
#cl: Un vector que contiene las etiquetas de las clases para los datos 
#      de entrenamiento.
#k: El número de vecinos más cercanos a considerar. Por defecto es 1.
predicted.purchase <- knn(train.data, test.data, train.purchase,k=1)
misclass.error <- mean(test.purchase != predicted.purchase)
print(1-misclass.error)

###
# Escogiendo un valor para K
###
predicted.purchase<-NULL
error.rate<-NULL

for (i in 1:20){
  set.seed(101)
  predicted.purchase <- knn(train.data, test.data, train.purchase,k=i)
  error.rate[i] <- mean(test.purchase != predicted.purchase)
}

###
# Visualización de los resultados KNN
###

library(ggplot2)
k.values<-1:20
error.df <- data.frame(error.rate,k.values)
#Nos muestra el error de la clasificación por cada valor K determinado en el for
#En el eje Y se puede observar el porcentaje de error
#En el eje X se puede observar el valor K
ggplot(error.df,aes(k.values,error.rate)) + geom_point() + geom_line(lty='dotted',color='red')
