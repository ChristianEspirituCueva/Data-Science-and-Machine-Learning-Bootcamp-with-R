#Class 
var<-3
class(var)
#Vectors
temp<-c(1,2,3,4,5)
a<-c("m","t","w","t","f")
names(temp)<-a
temp
#Vectors Operation
veca<-c(1,2,3)
vecb<-c(5,6,7)
veca+vecb
veca*vecb
veca/vecb
veca-vecb
veca%%vecb

#media
mean(veca)
#mediana
median(veca)
#desviación estandar
sd(veca)
#maximo
max(veca)
#minimo
min(veca)

#producto
prod(veca)

#operadores de comparación
2>3
4!=3
a<-3
b<-4
a>b
a==4
v1<-c(1,2,3)
v2<-c(10,20,30)
v1>v2
v1<v2
v1> -(v2)


#indexaciòn 
v1<-c(1,2,3)
v2<-c("a","b","c")
v1[c(1,2)]
v2[c(1,3)]

#segmentaciòn
v<-c(1,2,3,4)
names(v)<-c("a","b","c","d")

v[2:4]
v[c("c","a","d")]
