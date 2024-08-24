install.packages("MASS")
library(MASS)
head(Boston)

data<-Boston
#Estructura de nuestro dataset
str(data)

#Validamos que no falten datos
any(is.na(data))
#False = todos los valores completos

#Normalización de nuestros datos
#Primero obtenermos los minimos y maximos de cada columna del data set
maxs<-apply(data,2,max)
maxs
mins<-apply(data,2,min)
mins

#La función scale() en R se utiliza para estandarizar o normalizar los datos,
#lo que significa ajustar los valores para que tengan una media de 0 y una 
#desviación estándar de 1.
'''
X_escalado= (X_original - X)/S
donde:

X_original es el valor original.
X es la media de los valores.
S es la desviación estándar de los valores.
'''
#Parámetros
#x: El objeto (vector, matriz o data frame) que deseas escalar.
#center: Si es TRUE, se resta la media de los valores. Por defecto es TRUE.
#scale: Si es TRUE, se divide por la desviación estándar de los valores. Por defecto es TRUE.

#Cuando usas los parámetros center=mins y scale=maxs-mins en la función scale()
#en R, estás aplicando una normalización conocida como min-max scaling.

'''
X_escalado= (X_original - min(X))/(max(X)-min(X))

donde:

X_original es el valor original.
min(x) es el valor mínimo de la columna.
max(x) es el valor máximo de la columna.
'''

scale.data<-scale(data,center=mins,scale=maxs-mins)
scaled<-as.data.frame(scale.data)
scaled

#Creando una red neuronal
#Realizamos el split para segmentar nuestros datos de entrenamiento y prueba
library(caTools)
split <- sample.split(scaled$medv,SplitRatio=0.7)
train <- subset(scaled,split==T)
test <- subset(scaled,split==F)

install.packages("neuralnet")
library(neuralnet)

#Para asignar las caracteristicas (features) en nuestro modelo
#de red neuronal necesita el nombre de cada una de ellas, por
#lo que usamos la siguiente función apoyandonos con names()

n <- names(train)
f <- as.formula(paste("medv ~",paste(n[!n %in% "medv"], collapse = " + ")))

#Lo que nos retorna la variable "f" lo usamos en la creación
#de nuestra red neuronal

nn <- neuralnet(f,data = train,hidden = c(5,3), linear.output = T)
'''
Donde:
f: Es la formula previamente definida, este especifica la relación 
   entre las variables de entrada y la variable de salida.
data: Representa a los datos de entrada. Aquí se está especificando 
      el conjunto de datos de entrenamiento que se utilizará para 
      entrenar la red neuronal.
hidden: Especifica el número de neuronas en cada capa oculta. 
        En este caso, tienes dos capas ocultas: la primera con 
        5 neuronas y la segunda con 3 neuronas.
linear.output: Si es TRUE, la salida es continua (regresión); 
               si es FALSE, la salida es categórica (clasificación).
'''
#Graficamos la estructura de nuestra red neuronal
plot(nn)

#Una vez entrenado nuestra red neuornal realizamos las predicciones
#Predicción
predicted.nn.values<-compute(x = nn,covariate = test[1:13])
str(predicted.nn.values)
#predicted.nn.values almacena nuestros resultados de la predicción
#pero como hemos realizado una normalización scale de nuestros datos (train y test),
#debemos de volver a la escala base los resultados obtenidos en la predicción.

#Recordemos que usamos la normalización Min-Max Scaler, lo implementamos de manera inversa
#con la finalidad de obtener de deshacernos de la normalización que tenía.
true.predictions <- predicted.nn.values$net.result*(max(data$medv)-min(data$medv))+(min(data$medv))

#hacemos lo mismo con los datos de test
test.r <- (test$medv)*(max(data$medv)-min(data$medv))+min(data$medv)

#Ahora queremos evaluar la presición del modelo predictivo así que usaremos MSE
'''
Error cuadratico medio
El MSE mide la diferencia promedio al cuadrado entre los valores predichos por 
un modelo y los valores reales observados en los datos. Es una forma de 
cuantificar cuán cerca están las predicciones del modelo de los valores reales.

MSE Bajo: Indica que las predicciones del modelo están muy cerca de los valores 
          reales, lo que sugiere un buen ajuste del modelo.
MSE Alto: Indica que las predicciones del modelo están lejos de los valores 
          reales, lo que sugiere un mal ajuste del modelo.
Sensibilidad a Valores Atípicos: El MSE es sensible a los valores atípicos 
                                 (outliers) porque los errores se elevan al 
                                 cuadrado, lo que amplifica el impacto de los 
                                 errores grandes.
'''
MSE.nn<-sum((test.r - true.predictions)^2)/nrow(test)
MSE.nn

#Graficamos el error obtenido de las predicciones
error.df <-data.frame(test.r,true.predictions)
head(error.df)
library(ggplot2)
ggplot(error.df,aes(x=test.r,y=true.predictions)) + geom_point()+stat_smooth()
