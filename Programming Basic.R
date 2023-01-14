10!=100
(10==100)
(10==100) & (100==100)
(100==100) & (100==100)
(10==100) | (10==10)
(10==10) | (10==10)

#Condiciones con corchetes en DF
mtcars[mtcars$mpg>20,]
mtcars[mtcars$mpg>20,"mpg"]
mtcars[mtcars$mpg>20 | mtcars$hp>100,]

#Condiciones con subset en DF
subset(mtcars, mpg>20)
subset(mtcars, mpg>20 & hp>100)

#IF ELSE
x<-13
if(x==10){
  print("hello world 10")
}else if(x == 12){
  print("hello world 12")
}else{
  print("hello world other")
}

temp<-runif(1, min = 10, max = 35)
if (temp<24){
  print("is fresh or cold")
}else{
  print("is hot hot hot")
}


temp<-runif(1, min = 10, max = 35)
if (temp<24 & temp>=20){
  print("is freeesh -.-")
}else if (temp<20){
  print("is so cold uwu")
}else{
  print("is hot hot hot o.o")
}

#While-loop
x<-0
while(x<10){
  print(paste("x is: ",x))
  x<-x+1
  if(x==6){
    print("Now, x is 6, break loop!")
    break  
  }
}

#For-loop

x<-c(1,2,3)
for (variable in x) {
  aux<-variable+1
  print(paste0("The number is ",aux))
}

x<-list(c(1,2,3,4),mtcars,12)
for(v in x){
  print(v)
}

mat <- matrix(1:25, nrow = 5)

for(row in 1:nrow(mat)){
  for (col in 1:ncol(mat)){
    print(paste0("row: ", row, " col: ", col, " mat[row,col] :",mat[row,col]))
  }
}

#Funciones
#void funcion
say.hello <-function(name="computer"){
  print(paste0("hello ",name))
}
say.hello()
say.hello("Becky")

#return funcion
hello <-function(var1,var2){
  return(var1+var2)
}
hello(1,2)
result<-hello(1,2)
result

#entendiendo variables globales y no globales
v<-"v global"
func<-function(){
  v<-"v no global"
  print(v)
}
func()

print(v)


#Exercices
#1
hello_you<-function(name){
  print(paste0("hello ",name))
}
hello_you("Sammy")

#2
hello_you<-function(name){
  aux<-paste0("hello ",name)
  return(aux)
}
a<-hello_you("Sammy")
a

#3
prod<-function(v1,v2){
  return(v1*v2)
}
prod(3,4)

#4
num_check<-function(v1,v2){
  for (variable in v2) {
    if(variable==v1){
      return(TRUE)
    }
  }
  return(FALSE)
}
num_check(2,c(1,2,3))
num_check(2,c(1,3,4))

#5
num_count<-function(v1,v2){
  aux<-0
  for (variable in v2) {
    if(variable==1){aux<-aux+1}
  }
  return(aux)
}
num_count(2,c(1,1,2,2,3,3))
num_count(1,c(1,1,2,2,3,1,4,5,5,2,2,1,3))

#6
bar_count<-function(v1){
  aux<-v1
  small<-1
  big<-5
  if(v1>big){
    result<-as.integer(v1/big)
    aux<-v1-(result*big)
    result<-result+aux
  }
  print(result)
}
bar_count(17)

#7
summer<-function(v1,v2,v3){
  vec<-c(v1,v2,v3)
  vec2<-c()
  for (variable in vec) {
    if(variable%%3!=0){
      vec2<-append(vec2,variable)
    }
  }
  return(sum(vec2))
}
summer(7,2,3)
summer(3,6,9)
summer(9,11,12)

#8
is.prime <- function(number) {
  if (number <= 1) {
    return (FALSE)
  } else if (number <= 3) {
    return (TRUE)
  }
  
  if (number %% 2 == 0 || number %% 3 == 0) {
    return (FALSE)
  }
  
  i <- 5
  while (i*i <= number) {
    if (number %% i == 0 || number %% (i+2) == 0) {
      return (FALSE)
    }
    i = i + 6
  }
  return (TRUE)
}

is.prime(2)
