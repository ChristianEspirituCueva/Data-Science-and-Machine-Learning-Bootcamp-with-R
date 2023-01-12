#crear lista
v<-c(1,2,3)
mat<-matrix(1:20,nrow = 2)
df<-data.frame(c1=1:10)
ls<-list(v,mat,df)

#nombrar columnas
ls<-list(vector=v,matriz=mat,dataframe=df)
ls$dataframe

#indexar y seleccionar lista
#obtener sección como lista
ls["vector"]
class(ls["vector"])
ls[1]
class(ls[1])

#obtener sección como su clase original
ls[["vector"]]
class(ls[["vector"]])
ls$vector
class(ls$vector)

#concatenar 2 listas
double.ls<-c(ls,ls)
double.ls$matriz

#Detalles de la estructura
str(ls)
