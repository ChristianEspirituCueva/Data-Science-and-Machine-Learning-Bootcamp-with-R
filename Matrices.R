v<-c(1,2,3,4,5,6)
v<-1:6
matrix(v)
#Para especificar el número de filas
#de una matriz creada
matrix(v,nrow = 2)
#Para especificar el orden sea por 
#filas, porque por defecto llena
#nuestra matriz por columnas
#O sea comienza el llenado de la 
#matriz de arriba hacia abajo (byrow=F)
#y cuando queremos que ordene por fila
#el orden del llenado debe ser de 
#izquierda a derecha dependiendo del
#numero de filas que le pongas
#A continuación veremos un ejemplo de esto:

#Cuando el llenado no es por filas
#con numero de filas:2
matrix(v,byrow = F,nrow = 2)

#Cuando el llenado es por filas
#con número de filas:3
matrix(1:12, byrow = T, nrow=3)

#En el caso de que no espefiques el
#numero de filas es como si fuera un 
#matrix(v)
matrix(v,byrow = F)

#

gugul<-c(450,460,440)
misof<-c(350,360,340)

stocks<- c(gugul,misof)
stocks.matrix<-matrix(stocks,byrow = T, nrow = 2)
stocks.matrix

days <- c("mon","tue","wed")
company.names <- c("Gugul","Misof")

colnames(stocks.matrix)<-days
rownames(stocks.matrix)<-company.names

stocks.matrix

#Operación con matrices
mat<-matrix(1:25,byrow = T, nrow = 5)
mat+5
mat-5
mat*5
mat/5
1/mat
mat>20
mat[mat>15]
mat*mat
mat/mat
mat+mat
#Algebra Lineal
mat %*% mat

#operación de matrices
colSums(stocks.matrix)
rowSums(stocks.matrix)
colMeans(stocks.matrix)
rowMeans(stocks.matrix)

#append row matriz 
FB<-c(150,130,160)
tech.stocks<-rbind(stocks.matrix,FB)
tech.stocks

#append column matriz
avr<-rowMeans(tech.stocks)
tech.stocks<-cbind(tech.stocks,avr)
tech.stocks

#Indexación y seleccion de una matriz
mat<-matrix(1:25,byrow = T, nrow = 5)
mat[1:2,]
mat[1:2,1:3]
mat[1,3]
mat[,1:2]

#Factores y matrices categoricas
#nominal->sin orden
animal<-c("d","c","d","d","c")
fact.animal<-factor(animal)
#ordinal->con orden
temp<-c("cold","med","hot","hot","hot","cold","med")
fact.temp<-factor(temp,ordered = T, levels = c("cold","med","hot"))
#summary
summary(fact.temp)
summary(temp)

#EJERCICIOS
#1
a<-c(1,2,3)
b<-c(4,5,6)
mat<-rbind(a,b)
mat

#2
mat<-matrix(1:9,nrow = 3)
mat

#3
is.matrix(mat)

#4
mat2<-matrix(1:25,byrow=T,nrow=5)
mat2

#5
mat2[2,2:3]
mat2[3,2:3]

#6
mat2[4:5,4:5]

#7
mat2+mat2

#8
matrix(runif(20), ncol = 5)
matrix(runif(20), nrow = 4)

help(runif)
