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


#Residuos:
#Los residuos son la diferencia entre los valores reales y 
#los valores predecidos. Se desea que esos valores sigan 
#un padron de distribución normal o gaussiana, por ello 
#desea que esa distribución sea cerrada para mayor precisión,
#esto quiere decir que el Q3 y Q1 deben estar cerca el uno del
#otro en magnitud.
#La mediana y la media de la distribción normal deber estar 
#cerca de cero para que sea de un buen resultado.
#
#Estrellas de significancia (al lado de cada fila):
#Las estrellas nos indican que coeficientes son significativos
#para el modelo, siendo (***) el más signficativo y ( ) cuando
#no es significativo para el modelo.
#
#Intercept:
#Es la constante en la formula de la recta y=mx+b, en este caso
#el intercept sería la variable b, esta variable nos ayuda  a 
#medir la interseción de los puntos, ya que si x es cero y 
#tendría que ser igual a b; en el caso de que y sea cero 
#sería -mx=b, recordemos que m es la pendiente de la recta.
#OJO: cuando existen varias entradas la formula cambia a y = m1x1+m2x2+...+b
#
#Coeficientes:
#Estos son el coeficiente estimado (pendiente) y el intercept (constante) 
#en la formula de la recta.
#
#Coeficiente estimado:
#Es la pendiente de la recta para cada entrada(input ó x) en
#el caso de la ecuación de la recta es la variable m, recordemos como
#se ve esa ecuación para una sola entrada y=mx+b y para varias
#entradas y=m1x1+m2x2+..+b
#El siguiente link ayuda mejor su comprensión https://www.statology.org/interpret-regression-output-in-r/
#
#Error estandar de la estimación del coeficiente:
#Esta es una estimación de la desviación estandar, de variabilidad 
#o de incertidumbre del coeficiente. Se puede utilizar para poder
#hallar los intervalos de confianza. Desea que este valor sea al menos
#un orden de magnitud menor que la estimación del coeficiente.
#Intervalo de confianza = media + error de la estimación
#
#T-value de la estimación del coeficient:
#Este valor es calculado mediante el coeficiente estimado dividido por 
#el error estandar. Por ello, si el resultado es significativamente 
#diferente de cero (lo más alejado de cero), podemos decir que esta
#variable es significativo o no para el modelo.
#También, se puede decir que este valor nos ayuda a probar si existe o no
#una relación estadisticamente significativa entre la variable predictora 
#y la variable que nos resulta de dicha predicción. 
#
#Hipotesis nula( H0 ) cuando los coeficientes son iguales a cero
#                            ninguna relación entre X e Y
#Hipotesis alternativa( Ha ) cuando los coeficientes no son iguales a cero
#                            hay alguna relación entre X e Y
#
#Variable P-value: 
#Este valor es el nivel de significación. Mientras T-value sea mayor y P-value 
#sea menor, más significativo será el predictor. De esta manera, si esta 
#probabilidad es suficientemente baja podemos refuetar la Hipotesis Nula donde 
#decimos que el coeficiente estimado es cero. 
#
#Error estandar residual:
#Este valor nos proporciona la desviación estandar de los residuos. Nos dice que
#tan grande es la separación promedio entre los valores reales(puntos en la 
#grafica de reegresión) y predecidos (la linea en la grafica de regresión). Lo que
#queremos es obtener el menor error estandar residual, lo que significa que 
#visualmente que nuestra linea de predicción está cerca a nuestros valores reales,
#en promedio.
#
#Grados de libertad:
#Este valor se calcula mediante la diferencia entre el número de observaciones 
#(#filas) incluidas en su muestra de entrenamiento y el número de variables 
#predictoras utilizadas en su modelo (la intercepción cuenta como variable).
#Por ejemplo si utilizariamos el dataset mtcars(32 filas) y como variables 
#predictoras a hp, drat y wt. Tendriamos 32 observaciones, 3 predictores en el
#modelo de regresión y 1 intercept, entonces los grados de libertad serían 32-3-1=28.
#
#Multiples R^2:
#Muestra la cantidad de varianza explicada por el modelo. Nos dice que tan bien
#nuestro modelo se ajusta a los datos. También, nos dice que porcentaje de la 
#variación dentro de nuestra variable dependiente esta siendo explicada por la 
#variable independiente. Este valor oscila entre 0 y 1, siendo el más cercano a 
#1 el mejor, ya que nos dice que las variables predictoras podrán predecir mejor 
#el valor de la variable de respuesta.
#
#R^2 ajustado:
#Este valor es usado más para regresionaes lineales multiples, ya que tiene en 
#cuenta el número de variables predictoras. También, 
#funciona muy bien para regresión lineal simple. Este muestra el porcentaje de
#variación para el número de predictores en el modelo, este va a ser más bajo 
#que el R-cuadrado. Se podría decir que es un R^2 modificado para el número de 
#variables predictoras.
#
#Estadistica F(F-test): 
#Es una prueba global que nos ayuda a comprobar que almenos una de las variables 
#predictores tiene un coeficiente distinto de cero. La F-test no es tan relevante
#en regresiones simples, ya que duplica la información dada por 
#la T-test(o T-value). La F-test es relevante en regresiones multiples, aunque 
#puede ser engañosa por es mejor apoyarse en el valor P.
#
#Valor P: 
#Este valor nos indica que tan utilies son nuestras variables predictoras, ya que 
#si nos otorga un valor menor a 0.05 quiere decir que tiene al menos un 
#coeficiente en su modelo que no es cero.
#
#
#
#
#
#
#RECORDEMOS:
#Desviación estandar (sigma para muestra y S para población):
#Es una medida del grado de separación o disperción de los datos con 
#respecto al valor promedio. En resumen es el grado de separación de
#los datos teniendo como punto de partida el promedio de ellos, siendo
#la separación a la izquierda y a la derecha del punto promedio.
#
#Varianza:  
#Es la medida de dispersión que representa la variabilidad de una serie 
#de datos respecto a su media o promedio. Se utiliza para representar la 
#variabilidad de un conjunto de datos respecto a la media de los mismos. 
#Tambien es representado como el cuadrado de la desviación estandar.
#
#Variable dependiente (efecto):
#Es la variable que depende de una independiente, ya que se trata de
#encontrar el efecto que proboca la variable independiente en la 
#variable dependiente de esta. Ejemplo:
#y=x+2 => la variable dependiente(y) y independiente(x)
#
#
#Variable independiente (causa):
#Es la variable que independiente es aquella que realiza un efecto
#en una variable dependiente, ya que esta es la causa que proboca 
#que la variable dependiente cambie su valor. Ejemplo:
#y=x+2 => la variable dependiente(y) y independiente(x)
#
#Nivel de confianza: 
#Es la probabilidad maxima con la que podemos decir que nuestra
#estimación es acertada o que se encuentra dentro de nuestro
#intervalo de confianza. Los niveles habitualmente son de 95% y 99%
#
#Intervalo de confianza:
#Nos permité delimitar con dos valores (superior e inferior) de 
#nuestro nivel de confianza, teniendo en cuenta de que es hallado
#con la suma de la medía y el margen de error de la estimación.
#
#Hipotesis Nula:
#Es una hipotesis que el investigador trata de refutar, rechazar 
#o anular. Es una afirmación de que no hay diferencia entre las variables
#Esta pretende demostrar lo contrario a la hipotesis 
#alternativa, exponiendo que no es cierto.
#
#Hipotesis Alternativa:
#Es la hipotesis que el investigador realmente piensa que es la 
#causa de un fenomeno. Esta intenta demostrar la falcedad de la 
#hipotesis nula.
#
#Bibliografia:
#https://economipedia.com/definiciones/intervalo-de-confianza.html
#http://asignatura.us.es/dadpsico/apuntes/EstimacionEstadistica.pdf
#https://economipedia.com/definiciones/nivel-de-confianza.html
#http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/#:~:text=The%20mathematical%20formula%20of%20the,slope%20of%20the%20regression%20line.
#https://openstax.org/books/introducci%C3%B3n-estad%C3%ADstica/pages/9-1-hipotesis-nula-y-alternativa
#https://towardsdatascience.com/understanding-linear-regression-output-in-r-7a9cbda948b3
#https://boostedml.com/2019/06/linear-regression-in-r-interpreting-summarylm.html
#https://www.statology.org/interpret-regression-output-in-r/
#https://www.learnbymarketing.com/tutorials/linear-regression-in-r/
#https://www.learnbymarketing.com/tutorials/explaining-the-lm-summary-in-r/
#http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/#:~:text=The%20mathematical%20formula%20of%20the,slope%20of%20the%20regression%20line.
#https://blog.minitab.com/es/analisis-de-regresion-como-puedo-interpretar-el-r-cuadrado-y-evaluar-la-bondad-de-ajuste#:~:text=El%20R%2Dcuadrado%20es%20una,se%20trata%20de%20regresi%C3%B3n%20m%C3%BAltiple.
#https://es.wikipedia.org/wiki/Varianza


plot(model)
#Covarianza:
#Es un valor que nos permite determinar si existe una relación 
#entre dos variables. En el caso de que la covarianza sea positiva
#significa que hay una relación directa. En el caso de que la 
#covarianza sea negativa significa que hay una relación indirecta.
#En el caso de que la covarianza de un valor entorno a cero significa
#que no hay una relación. Este valor no es tan preciso se recomienda 
#el coeficiente de correlación de Pearson.

#Coeficiente de correlación de Pearson
#Este valor nos permite determinar con más precisión si existe una
#relación entre dos variables. Este valor resulta de la división 
#entre la covarianza(númerador) y la multiplicación de la desviación
#estandar de la variable independiente y dependiente(denominador).
#Este valor se encuentra entre -1 y 1:
#r es próxima a 1 es coeficiente de corelación directa fuerte.
#r es próxima a -1 es coeficiente de corelación indirecta.
#r es igual a 1 ó -1 es coeficiente de corelación funcional, o sea que
#                       las variables dependiente e independiente se 
#                       basan en una formula matematica que dan una 
#                       predicción exacta.
#r es próximo a 0, no existe una correlación lineal (no forma una linea),
#                 puede que los puntos esten dispersos, puede que tengan 
#                 una correlación cuadratica, logaritmica, etc.

#Fitted Value:
#Este es valor de respuesta de nuestra predicción apartir de la evaluación
#hecha por las variables predictoras.

#Residuo:
#Este es el valor que resulta de la resta del valor real menos el valor 
#predecido.

#Residuals vs Fitted
#El mejor resultado que se puede tener es que los puntos dibujen una linea
#cercana a la linea media de los residuos (cero), ya que de esta manera 
# nos decir que los valores predecidos están cerca de los valores reales.

#Cuantiles Teoricos: 
#Son los valores que se esperarían si una variable sigue una distribución 
#de probabilidad teorica determinado(forma en que se espera que ocurran los 
#eventos aleatorios), la más comunmente utilizada es una distribución normal.

#Q-Q Normal:
#Se utiliza en regresión lineal para evaluar si los errores de la regresión
#siguen una distribución normal. Donde se comparan los cuantiles de los residuos
#de la regresión con los cuantiles teóricos de una distribución normal.
#Se espera que los puntos en la grafica estén lo más alineados a la linea 
#diagonal para decir que los residuos se distribuyen normalmente, pues si hay 
#desviaciones significativas de esa linea, se dice que los residuos no sigue una 
#distribución normal. 



#La homocedasticidad 
#Se refiere a la propiedad de que la variabilidad de los errores de la regresión
#es constante en todo el rango de valores de la variable independiente. Esto 
#significa que los errores tienen la misma magnitud de variación y distribución 
#en todos los niveles de la variable independiente.

#La heterocedasticidad 
#Se refiere a la propiedad de que la variabilidad de los errores de la regresión
#no es constante en todo el rango de valores de la variable independiente. Esto 
#significa que los errores pueden tener una magnitud de variación y distribución 
#diferente en diferentes niveles de la variable independiente.

#En la práctica, la homocedasticidad es deseable porque indica que la relación 
#entre las variables es estable y se mantiene constante en todo el rango de valores 
#de la variable independiente. La heterocedasticidad, por otro lado, puede indicar 
#que la relación entre las variables cambia a medida que la variable independiente 
#cambia y puede dar lugar a estimaciones sesgadas o poco precisas de los parámetros 
#de la regresión lineal.

#En resumen, la homocedasticidad se refiere a una variabilidad constante de los errores de la regresión, mientras que la heterocedasticidad se refiere a una variabilidad no constante de los errores de la regresión. La homocedasticidad es deseable en la regresión lineal porque indica una relación estable y confiable entre las variables.



#Scale Location:
#Es una herramienta utilizada para evaluar si la variabilidad de los residuos 
#es constante en todo el rango de valores ajustados (eje x). 
#En esta gráfica, los residuos estandarizados (residuos divididos por su 
#desviación estándar) se grafican en el eje vertical y la raíz cuadrada del 
#valor absoluto de los residuos estandarizados se grafica en el eje horizontal.
#Si la varianza de los residuos es constante en todo el rango de valores ajustados, 
#los puntos en la gráfica deberían distribuirse aleatoriamente alrededor de una 
#línea horizontal, lo que indica una homocedasticidad de los residuos. 
#Si los puntos en la gráfica se agrupan en algún patrón o siguen una forma de 
#embudo, esto indica una heterocedasticidad, lo que sugiere que la variabilidad 
#de los residuos no es constante en todo el rango de valores ajustados.

#Bilbiografía:
#https://www.varsitytutors.com/hotmath/hotmath_help/spanish/topics/joint-variation
#https://www.youtube.com/watch?v=eTuGHN53kJQ
#https://www.youtube.com/watch?v=XW-yuLXX4PY
#https://es.wikipedia.org/wiki/Covarianza
#https://www.youtube.com/watch?v=XW-yuLXX4PY


#Predicción
G3.prediccion <- predict(model,test)
#Almacenamos los valores predichos obtenidos
#de los datos de test y los datos originales 
#de test
results <- cbind(G3.prediccion,test$G3)

colnames(results)<-c("predecido","actual")
results <- as.data.frame(results)
results

#Convertimos nuestras predicciones 
#de negativo a cero
to_zero <- function(x){
  if(x<0){
    return (0)
  }else{
    return(x)
  }
}

results$predecido<-sapply(results$predecido, to_zero)

#Mean Squeared error - error medio cuadrado
mse<-mean((results$actual - results$predecido)^2)
mse
#Root mean Squeared error - Raíz del Error Cuadrático Medio
rmse<-(mse^0.5)
rmse
#Sum Squared Error - suma de cuadrados de estimación de errores
sse <- sum((results$predecido - results$actual)^2)
sst <- sum((mean(df$G3) - results$actual)^2)

R2<-1- sse/sst
R2
