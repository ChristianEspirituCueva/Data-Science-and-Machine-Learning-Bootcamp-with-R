#Primera Parte

#1
batting<- read.csv(file = "R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Capstone and Data Viz Projects/Capstone Project/Batting.csv",)
batting

#2
head(batting)

#3
str(batting)

#4
head(batting$AB,5)

#5
head(batting$X2B)

#6
batting$BA<- batting$H / batting$AB
colnames(batting)

#7
tail(batting$BA,5)

#8
batting$OBP<-((batting$H+batting$BB+batting$HBP)/(batting$AB+batting$BB+batting$HBP+batting$SF)) 

#9.1
batting$X1B<- (batting$H-batting$X2B-batting$X3B-batting$HR)
#9.2  
batting$SLG<- ((batting$X1B)+(2*batting$X2B)+(3*batting$X3B)+(4*batting$HR))/batting$AB

#10
str(batting)


#Segunda Parte

#1
salaries<- read.csv(file = "R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Capstone and Data Viz Projects/Capstone Project/Salaries.csv",)
salaries

#2
library(data.table)

summary(salaries)

summary(batting)

#3
battingv2<- subset(batting, yearID>=1985)

#4
summary(battingv2)

#5
df<- merge(salaries,battingv2, by=c("playerID","yearID"))
df

#6
summary(df)

#7
lost_players<-subset(df,playerID %in% c("giambja01","damonjo01","saenzol01"))
lost_players

#8
lost_players<-subset(lost_players, yearID==2001)
lost_players

#9
library(dplyr)
task<-subset(df,yearID==2001,!(playerID %in% c("giambja01","damonjo01","saenzol01")))
task<-arrange(task,playerID)

#Medio de los lost
mean(lost_players$OBP)

select(task,playerID,salary,AB,OBP)
#abreubo01  4983000 588 0.39346591
#colbrgr01  1600000  97 0.37272727
#cirilje01  4850000 528 0.36410256

new_players<-subset(df,playerID %in% c("abreubo01","colbrgr01","cirilje01"))
new_players

#10
library(ggplot2)
ggplot(new_players,aes(x=BA, y=SLG))+geom_point()
