df<-read.csv(file="R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Machine Learning with R/titanic_train.csv")
print(head(df))
print('    ')
print(str(df))

library(Amelia)
help("missmap")

#Identifica los valores que están vacios en cada fila del dataframe
missmap(df, main = "Missing Map", col = c("yellow","black"),legend = FALSE)

library(ggplot2)

ggplot(df,aes(Survived))+geom_bar()

ggplot(df,aes(Pclass))+geom_bar(aes(fill=factor(Pclass)))

ggplot(df,aes(Sex))+geom_bar(aes(fill=factor(Sex)))

ggplot(df,aes(Age))+geom_histogram(bins = 20,alpha=0.5,fill="blue")

ggplot(df,aes(SibSp))+geom_bar() 

ggplot(df,aes(Fare))+geom_histogram(bins = 30)

ggplot(df,aes(Fare))+geom_histogram(fill="green",color="black",alpha=0.5)

ggplot(df,aes(Pclass,Age))+geom_boxplot(aes(group=Pclass,fill=factor(Pclass),alpha=0.5))+scale_y_continuous(breaks = seq(min(0),max(80),by=2))

#Changes empty values of Age based on class
impute_age <- function(age,class){
  out<-age
  for(i in 1:length(age)){
    if(is.na(age[i])){
      if(class[i] == 1){
        out[i]<-37
      }
      else if(class[i]==2){
        out[i]<-29
      }else{
        out[i]<-24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

#Usamos la función creada para reemplazar 
#los valores vacion en la columna Age
fixed.ages<-impute_age(df$Age,df$Pclass)
df$Age<-fixed.ages

#Identifica los valores que están vacios en cada fila del dataframe
missmap(df, main = "Imputation Check", col = c("yellow","black"),legend = FALSE)

library(dplyr)
df.train<-select(df,-PassengerId,-Name,-Ticket,-Cabin)
head(df.train)
str(df.train)

df.train$Survived<-factor(df.train$Survived)
df.train$Pclass<-factor(df.train$Pclass)
df.train$Parch<-factor(df.train$Parch)
df.train$SibSp<-factor(df.train$SibSp)

str(df.train)

#Creando el modelo de regresión logistica
#glm(formula, family = family_type, data = dataset)
#formula: Una fórmula que describe el modelo a ajustar (por ejemplo, y ~ x1 + x2).
#family: Especifica la distribución de la variable de respuesta y el enlace (link function) entre la media de la respuesta y los predictores. Algunos ejemplos comunes son:
  #binomial: Para regresión logística (cuando la respuesta es binaria).
    #link = 'logit': Especifica la función de enlace (link function) que relaciona la media de la variable de respuesta con la combinación lineal de las variables predictoras. En este caso, la función de enlace es la función logit, que es la más común en regresión logística.
  #poisson: Para datos de conteo (número de eventos que ocurren en un intervalo de tiempo o espacio).
  #gaussian: Para modelos lineales estándar (equivalente a lm()).
  #Gamma: Para modelos con distribución gamma (útil cuando la variable de respuesta es continua y positiva).
  #inverse.gaussian: Para modelos con distribución inversa gaussiana.
#data: El data frame que contiene las variables en la fórmula.
log.model <- glm(Survived ~ . ,family = binomial(link = 'logit'), data = df.train)
summary(log.model)

library(caTools)
set.seed(101)

#En la función sample.split(Y, SplitRatio = 0.7), 
#no es recomendable usar cualquier columna como referencia 
#para Y. La columna Y debe ser representativa de lo que 
#estás tratando de modelar o predecir, típicamente la 
#variable de respuesta en un problema de clasificación o 
#regresión.

#si Y es una columna con valores aleatorios o sin relación 
#con la variable de respuesta, sample.split no garantizará 
#que la proporción de clases se mantenga en los conjuntos 
#de entrenamiento y prueba.
split<-sample.split(df.train$Survived,SplitRatio = 0.7)
final.train<-subset(df.train,split == TRUE)
final.test<-subset(df.train,split == FALSE)

#Creando el modelo de regresión logistica (con split)
final.log.model<-glm(Survived ~ . , family = binomial(link = 'logit'),data=final.train)
summary(final.log.model)

#Predecir valores usando el modelo logaritmico
#predict(object, newdata, type, ...)
#object: El modelo ajustado previamente, como el resultado de lm(), glm(), rpart(), etc.
#newdata: Un data frame que contiene las nuevas observaciones para las cuales 
#         deseas hacer predicciones. Si se omite, predict() generalmente hará predicciones para los datos utilizados en el ajuste del modelo.
#type: Especifica el tipo de predicción que deseas. Los valores comunes para type dependen del modelo ajustado. Algunos ejemplos incluyen:
  #Regresión lineal (lm):
    #"response" (predicción en la escala de la respuesta).
  #Regresión logística (glm con family = binomial):
    #"link" (valor en la escala del enlace, es decir, log-odds).
    #"response" (probabilidades predichas).
    #"terms" (componentes lineales predichos).
  #Modelos de árboles (rpart):
    #"vector" (valor pronosticado).
    #"prob" (probabilidades para cada clase en la clasificación).
    #"class" (clase pronosticada).
fitted.probabilities <- predict(final.log.model, final.test,type="response")
#Umbral de clasificación: Si necesitas clasificar las probabilidades en 
#clases (0 o 1), puedes usar un umbral (por ejemplo, 0.5)
#ifelse(test, yes, no)
#test: Una condición lógica (o un vector de condiciones lógicas) que se 
#      evaluará. Puede ser una expresión que genere un valor TRUE o FALSE
#      para cada elemento del vector.
#yes: El valor a devolver si la condición en test es TRUE.
#no: El valor a devolver si la condición en test es FALSE.
fitted.results <- ifelse(fitted.probabilities>0.5,1,0)
misClassError <- mean(fitted.results != final.test$Survived)
print(1-misClassError)

#Matriz de confusión
#table (Original Test, Predicted Test)
table(final.test$Survived,fitted.probabilities>0.5)

