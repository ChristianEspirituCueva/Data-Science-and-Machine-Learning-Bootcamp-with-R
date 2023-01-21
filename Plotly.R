#install.packages("plotly")
#https://plotly.com/ggplot2/
library(ggplot2)
library(plotly)

pl<-ggplot(mtcars, aes(mpg,wt))+geom_point()

print(pl)

gpl <- ggplotly(pl)

gpl
