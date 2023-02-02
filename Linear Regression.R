#LIMPIAR DATOS Y BUSCAR CORRELACIÓN

df<-read.csv(file="R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Machine Learning with R/student-mat.csv",sep=";")
#getwd()
summary(df)
any(is.na(df))
str(df)

library(ggplot2)
library(ggthemes)
library(dplyr)
#averiguamos si cada columna del data set es numerico o no
num.cols <- sapply(df, is.numeric)

#averigaumos la correlación entre esas columnas
cor.data <- cor(df[,num.cols])

#install.packages("corrgram")
#install.packages("corrplot")
library(corrplot)
library(corrgram)

corrplot(cor.data, method = "color")
corrgram(df,order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.conf, text.panel=panel.txt)
ggplot(df,aes(x=G3))+geom_histogram(bins = 20, alpha=0.5,fill="blue")


#CREACIÓN DEL MODELO
#install.packages("caTools")
library(caTools)

set.seed(101)
#Hacemos un split de cualquier columna del df
#para poder tener un nuevo vector donde
#el 70% de las filas sea para el entrenamineto (TRUE)
#el 30% de las filas sea para el prueba (FALSE)
#En este caso tomaremos como referencia la columna
#donde queremos predecir el valor 
sample <- sample.split(df$G3,SplitRatio = 0.7)
#Entrenamiento 70% - asignamos a 
train <- subset(df,sample == TRUE)
#Entrenamiento 30%
test <- subset(df,sample == FALSE)
#Generamos el modelo
model <- lm(G3 ~ .,train)
summary(model)

#Conceptos de summary:
#https://towardsdatascience.com/understanding-linear-regression-output-in-r-7a9cbda948b3
#https://www.learnbymarketing.com/tutorials/linear-regression-in-r/

'''
Residuos:
Los residuos son la diferencia entre los valores reales y 
los valores predecidos. Se desea que esos valores sigan 
un padron de distribución normal o gaussiana, por ello 
desea que esa distribución sea cerrada para mayor precisión,
esto quiere decir que el Q3 y Q1 deben estar cerca el uno del
otro en magnitud.
La mediana y la media de la distribción normal deber estar 
cerca de cero para que sea de un buen resultado.

Estrellas de significancia (al lado de cada fila):
Las estrellas nos indican que coeficientes son significativos
para el modelo, siendo (***) el más signficativo y ( ) cuando
no es significativo para el modelo.

Intercept:
Es la constante en la formula de la recta y=mx+b, en este caso
el intercept sería la variable "b", esta variable nos ayuda  a 
medir la interseción de los puntos, ya que si "x" es cero "y" 
tendría que ser igual a "b"; en el caso de que "y" sea cero 
sería -mx=b, recordemos que m es la pendiente de la recta.

Coeficiente estimado:


'''