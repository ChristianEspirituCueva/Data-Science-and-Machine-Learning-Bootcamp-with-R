library(ISLR)
print(head(iris))

install.packages("e1071")
library("e1071")
help(svm)

set.seed(101)
#Realizamos un split para modelos de entrenamiento y testeo
#Donde los valores split = True (entrenamiento) y Split = False (testeo)
library(caTools)
split<-sample.split(iris$Species, SplitRatio=0.7)
install.packages("caret")
#library(caret)
#t.ids<-createDataPartition(iris$Species, p=0.7, list=FALSE)

#Creamos nuestro modelo y lo entrenamos
model<-svm(Species ~. ,data=iris[split==T,])
summary(model)
#Creamos la matriz de confusión
table(iris[split==T,"Species"], fitted(model))
#Diagramamos
plot(model, data=iris[split==T,],Sepal.Length ~ Sepal.Width)


#Personalizando Modelo SVM 
tune.results <- tune(svm,train.x = iris[split==T,1:4], train.y = iris[split==T,5], 
                     kernel="radial",ranges = list(cost=c(0.5,1,1.5),gamma=c(0.1,0.5,0.7)))
#Se agrega los parametros costo y gamma con las que el modelo 
#va a realizar una prueba por cada combinación Costo vs gamma
#esto se realiza con la finalidad de obtener un menor error
summary(tune.results)

#Nos muestra que la mejor combinación a sido
#cost   1 
#gamma 0.1

#Ahora con estos parametros creamos un nuevo modelo svm
tunned.svm<-svm(Species ~. , data=iris[split==T,], kernel="radial",cost=1,gamma=0.1)
summary(tunned.svm)
#Creamos la matriz de confusión
table(iris[split==T,"Species"], fitted(tunned.svm))

#Realizamos la predicción de nuestros datos de entrenamiento
pred<-predict(tunned.svm, iris[split==F,])
table(iris[split==F,"Species"], pred)
