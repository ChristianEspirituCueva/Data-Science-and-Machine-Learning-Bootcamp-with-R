library("ggplot2")
library("data.table")

dt<-fread(file = "R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Capstone and Data Viz Projects/Data Visualization Project/Economist_Assignment_Data.csv", drop=1)
head(dt)

#1
pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(aes(color=Region))
pl

#2
pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(size=3,shape=1,aes(color=Region))+geom_smooth(aes(group=1))
pl

#3
pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(size=3,shape=1,aes(color=Region))+geom_smooth(method="lm",formula = y ~ log(x), se=FALSE,color="red",aes(group=1))
pl

#4
pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(size=3,shape=1,aes(color=Region))+geom_smooth(method="lm",formula = y ~ log(x), se=FALSE,color="red",aes(group=1))+geom_text((aes(label=Country)))
pl

#5
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(size=3,shape=1,aes(color=Region))+geom_smooth(method="lm",formula = y ~ log(x), se=FALSE,color="red",aes(group=1))+ geom_text(aes(label = Country), color = "gray20", data = subset(dt, Country %in% pointsToLabel),check_overlap = TRUE)
pl

#6
pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(size=3,shape=1,aes(color=Region))+geom_smooth(method="lm",formula = y ~ log(x), se=FALSE,color="red",aes(group=1))+ geom_text(aes(label = Country), color = "gray20", data = subset(dt, Country %in% pointsToLabel),check_overlap = TRUE)+theme_bw()
pl

#7
library(ggplot2)
pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(size=3,shape=1,aes(color=Region))+geom_smooth(method="lm",formula = y ~ log(x), se=FALSE,color="red",aes(group=1))+ geom_text(aes(label = Country), color = "gray20", data = subset(dt, Country %in% pointsToLabel),check_overlap = TRUE)+theme_bw()+scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",limits = c(1,10), breaks=1:10)
pl

#8
library(ggplot2)
pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(size=3,shape=1,aes(color=Region))+geom_smooth(method="lm",formula = y ~ log(x), se=FALSE,color="red",aes(group=1))+ geom_text(aes(label = Country), color = "gray20", data = subset(dt, Country %in% pointsToLabel),check_overlap = TRUE)+theme_bw()+scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",limits = c(1,10), breaks=1:10)+scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",limits = c(0.2,1))
pl

#9
library(ggplot2)
pl<-ggplot(dt,aes(x=CPI, y=HDI))+geom_point(size=3,shape=1,aes(color=Region))+geom_smooth(method="lm",formula = y ~ log(x), se=FALSE,color="red",aes(group=1))+ geom_text(aes(label = Country), color = "gray20", data = subset(dt, Country %in% pointsToLabel),check_overlap = TRUE)+theme_bw()+scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",limits = c(1,10), breaks=1:10)+scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",limits = c(0.2,1))+ggtitle("Corruption and Human development")
pl

help(ggtitle)
