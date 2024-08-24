#install.packages("rpart")
library(rpart)
help(rpart)
str(kyphosis)
head(kyphosis)

##
#Arbol de desición
#Para el caso dataset Iris:
#modelo <- rpart(Species ~ ., data = iris, method = "class")
#rpart(): Esta es la función que construye el árbol de decisión.
#Species ~ .: Esta es la fórmula del modelo. Indica que Species es 
#             la variable dependiente o la que se quiere predecir 
#             (también llamada la variable de respuesta). El ~ separa 
#             la variable dependiente de las independientes. El . después 
#             del ~ significa que se van a utilizar todas las demás columnas 
#             del conjunto de datos iris como predictores 
#             (variables independientes).
#data = iris: Aquí se especifica el conjunto de datos que se va a utilizar
#             para construir el modelo. En este caso, es el famoso conjunto
#             de datos iris, que contiene información sobre diferentes
#             especies de flores, incluyendo variables como Sepal.Length, 
#             Sepal.Width, Petal.Length, y Petal.Width.
#method = "class": Este parámetro indica que el modelo a construir es un 
#                  árbol de clasificación. Esto se usa cuando la variable de 
#                  respuesta es categórica, como es el caso de Species, que 
#                  tiene tres posibles valores: "setosa", "versicolor", y 
#                  "virginica".
##
decTree<-rpart(Kyphosis  ~ .,method = "class", data=kyphosis)

##
#Impresión de la tabla de costos de complejidad
#La función printcp() en R se utiliza para mostrar la tabla de 
#costos de complejidad del modelo generado con rpart(). Esta tabla 
#es muy útil para analizar la calidad del modelo y decidir si es 
#necesario podar el árbol para evitar el sobreajuste.

#¿Qué es la tabla de costos de complejidad?
#La tabla de costos de complejidad (CP table) proporciona información 
#sobre los diferentes puntos donde se pueden podar ramas del árbol para 
#simplificar el modelo, basándose en el parámetro de complejidad (CP). 
#Este parámetro controla la cantidad mínima por la cual el error de 
#ajuste debe disminuir para que se considere la división en el árbol.
##

printcp(decTree)
'''
1. Variables actually used in tree construction:
[1] Age Start: Indica que en la construcción del árbol solo se han utilizado dos variables: Age y Start. Esto significa que, aunque el conjunto de datos podría haber tenido más variables, solo estas dos fueron útiles para las divisiones en el árbol.
2. Root node error: 17/81 = 0.20988
Root node error: Este valor representa el error en el nodo raíz (el nodo sin divisiones). Aquí, 17 de 81 observaciones se clasificarían incorrectamente si no se hiciera ninguna división en el árbol.
17/81 = 0.20988: El error relativo del nodo raíz es de aproximadamente 0.20988, lo que significa que el 20.988% de las observaciones serían incorrectamente clasificadas sin ningún nodo dividido.
3. n = 81
n = 81: Este valor indica que hay un total de 81 observaciones en el conjunto de datos utilizado para construir el árbol.
'''
#CP (Complexity Parameter): Muestra los diferentes valores del parámetro
#                           de complejidad. Un valor de CP más alto 
#                           significa un árbol más simple (con menos ramas).
#nsplit: Indica el número de divisiones o nodos que el árbol tiene 
#        después de aplicar el valor correspondiente de CP.
#rel error: Es el error relativo del modelo en cada nivel de poda. 
#           Al principio, es igual a 1, ya que el error se mide en 
#           relación al árbol no podado.
#xerror: Es el error de validación cruzada, una estimación de cómo 
#        el modelo se comportará con datos nuevos.
#xstd: Es la desviación estándar del error de validación cruzada.


#Grafica el arbol de desición
plot(decTree, uniform = T, main="Kyphosis Tree")

#Agrega las etiquetas a la grafica
text(decTree, use.n=T,all=T)

install.packages("rpart.plot")
library(rpart.plot)
#Grafica el arbol de desición de una manera más entendible
prp(decTree)




##
#Random Forest
install.packages("randomForest")
library(randomForest)

rf.model<-randomForest(Kyphosis  ~ ., data = kyphosis)
print(rf.model)

'''
Type of random forest: classification:
Indica que este es un modelo de clasificación, ya que Kyphosis es una variable categórica (con posibles valores present y absent).

Number of trees: 500:
Por defecto, el modelo ha construido 500 árboles de decisión para formar el bosque aleatorio.

No. of variables tried at each split: 2:
En cada nodo de los árboles, se seleccionaron aleatoriamente 2 variables de las disponibles para intentar la división. Esta es una característica clave del bosque aleatorio para reducir la correlación entre los árboles.

OOB estimate of error rate: X%:
El error estimado fuera de la bolsa (Out-Of-Bag o OOB) es una estimación del error de clasificación del modelo, calculado utilizando las observaciones que no se incluyeron en la construcción de un árbol particular.

Confusion matrix:
Matriz de confusión: Proporciona una visión detallada de cómo el modelo clasifica las observaciones. Aquí se muestra cuántas observaciones fueron correctamente e incorrectamente clasificadas en cada categoría (absent y present).
class.error: Indica la tasa de error por clase. Por ejemplo, en la clase present, el error es relativamente alto (0.40000), lo que sugiere que el modelo podría tener dificultades para predecir correctamente esta clase.
'''
rf.model$predicted
#$predicted: Este componente del objeto rf.model contiene las predicciones del modelo para cada observación en el conjunto de datos de entrenamiento.
#Al ejecutar rf.model$predicted, obtienes un vector que contiene la clase predicha (absent o present en tu caso) para cada una de las observaciones en el conjunto de datos de entrenamiento.

'''
Pero...¿que datos a predicho? Si no he enviado ninguna dato para que realice la predicción
La confusión puede surgir porque rf.model$predicted devuelve las predicciones del modelo, pero estas predicciones se realizan sobre el conjunto de datos de entrenamiento, no sobre datos nuevos que tú hayas pasado explícitamente.

¿Cómo funciona?
Cuando ajustas un modelo de bosque aleatorio usando randomForest() como hiciste con el código:

r
Copiar código
rf.model <- randomForest(Kyphosis ~ ., data = kyphosis)
El modelo realiza predicciones automáticamente para cada observación en el conjunto de datos que utilizaste para entrenar el modelo (en este caso, kyphosis). Estas predicciones se guardan en rf.model$predicted.

Resumen de lo que sucede
Entrenamiento: Cuando ajustas el modelo (randomForest(Kyphosis ~ ., data = kyphosis)), el modelo se entrena utilizando el conjunto de datos kyphosis.

Predicciones internas: Como parte del proceso de ajuste, el modelo también hace predicciones para cada observación en kyphosis (el conjunto de datos de entrenamiento).

Guardar predicciones: Estas predicciones se almacenan automáticamente en rf.model$predicted.

Por lo tanto, cuando accedes a rf.model$predicted, estás viendo las predicciones que el modelo hizo para las mismas observaciones que utilizó para entrenarse.

¿Por qué hace esto?
El modelo de bosque aleatorio realiza estas predicciones para que puedas evaluar cómo de bien se ajustó a los datos de entrenamiento. Es útil para:

Analizar el ajuste del modelo: Ver cómo de bien el modelo se ajusta a los datos que ya conoce.
Calcular métricas de error: Calcular tasas de error, precisión, y otras métricas utilizando las predicciones sobre el conjunto de entrenamiento.

Predicción en nuevos datos
Si deseas hacer predicciones en un nuevo conjunto de datos que no fue utilizado para entrenar el modelo, puedes hacerlo con la función predict().
'''
#Número de arboles
rf.model$ntree

#Matriz de confusión
rf.model$confusion
