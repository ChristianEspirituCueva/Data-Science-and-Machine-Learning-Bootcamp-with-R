#Build in R features
#seq()
seq(0,10, by=2)
0:10
seq(0,100,by =10)
seq(10,50,by=5)

#sort
v<-c(5,6,3)
#ascendente
sort(v)
#descendente
sort(v,decreasing = TRUE)
#sort en letras
v<-c("b","r","c")
sort(v)
#Las minusculas son menores que sus mayusculas
v<-c("B","b","R","r","c")
sort(v)

#REV - inversa de elementos en un objeto
v<-1:10
rev(v)

#str - mostrará la estructura de un objeto
str(v)
str(mtcars)
summary(mtcars)

#append - fusionar dos objetos
v<-1:10
v2<-11:20
append(v,v2)

#checking tipos de datos
#verificar
v<-1:3
is.vector(v)
is.data.frame(mtcars)

#cambiar
v<-1:3
as.list(v)
as.matrix(v)

#apply
v<-1:5
time2<-function(n){
  return(n*2)
}
#apply-devuelve una lista
lapply(v, time2)
#apply-devuelve un vector simple
sapply(v,time2)
#sample - devuelve 1 o más valores aleatorios
sample(1:10,1)
#Funcición anonima
v<-1:5
result<-sapply(v, function(n){n*2})
result
#apply con multiples inputs
v<-1:5
result<-sapply(v, function(num,choice){return(num*choice)},choice=50)
#si colocas un vector en el segundo argumento lo tomará como un 
#vector completo y no lo hará por valor
result


#Funciones matematicas
abs(2)
abs(-2)
v<-(-2:5)
abs(v)

sum(v)

mean(v)

round(2.534,digits=2)
round(2.534,digits=5)
#https://cran.r-project.org/doc/contrib/Short-refcard.pdf
#https://iqss.github.io/dss-workshops/R/Rintro/base-r-cheat-sheet.pdf

#Regular Expressions
#grepl->buscar cadena de caracteres o un caracter en otra cadena de caracteres
a<- "Hi there, one two three"
grepl("Hi",a)
grepl("hi",a)
grepl("a",a)

#grepl->buscar valor de coincidencia en vector
v<-c("a","b","c","d","d")
grepl("d",v)

#grep->muestra el indice dentro del vector donde se encuentra ese valor
grep("b",v)
grep("d",v)

#grep-> no funciona dentro de una cadena de caracteres  
#       donde se quiere encontrar el indice del caracter
a<- "Hi there, one two three"
grep("o",a)

#DATE y TIMESTAMP
#Fecha actual del sistema
Sys.Date()
today<-Sys.Date()
class(today)

#Convertir caracter en date
d<-"2023-01-16"
class(d)
d<-as.Date(d)
class(d)

#as.Date con formato
dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
as.Date(dates, "%m/%d/%y")

## read in date info in format 'ddmmmyyyy'
## This will give NA(s) in some locales; setting the C locale
## as in the commented lines will overcome this on most systems.
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
Sys.setlocale("LC_TIME", lct)
z


#Code	Value
#%d	Day of the month (decimal number)
#%m	Month (decimal number)
#%b	Month (abbreviated)
#%B	Month (full name)
#%y	Year (2 digit)
#%Y	Year (4 digit)
as.Date("June-01-2002",format="%B-%d-%Y")

#Interfaz de sistema operativo portatil
as.POSIXct("11:02:02",format="%H:%M:%S")
help("strptime")

strptime("11:02:02",format="%H:%M:%S")
