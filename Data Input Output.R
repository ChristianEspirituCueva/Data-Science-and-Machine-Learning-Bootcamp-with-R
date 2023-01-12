#CSV
#Guardar como csv
write.csv(mtcars, file = "my_sample.csv")
#Leer CSV
df<-read.csv("my_sample.csv")
class(df)

#XLSX
#Instalar paquete excel
install.packages("readxl")
#Llamar al paquete excel
library(readxl)
#Mostrar los sheets que existen en el excel
excel_sheets("R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Data Input and Output with R/Sample-Sales-Data.xlsx")
#Leer excel
df<-read_excel("R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Data Input and Output with R/Sample-Sales-Data.xlsx",sheet = "Sheet1")
head(df)
sum(df$Value)
summary(df)
#Cargar todo el archivo excel, con la cantidad de sheets que tenga
entire.workbook<-lapply(excel_sheets("R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Data Input and Output with R/Sample-Sales-Data.xlsx"),read_excel,path="R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Data Input and Output with R/Sample-Sales-Data.xlsx")
entire.workbook

#Guardar como xlsx
install.packages("xlsx")
library(xlsx)
head(mtcars)
write.xlsx(mtcars,"output_example.xlsx")

#Web Scrapping
install.packages("rvest")
library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

lego_movie %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()

lego_movie %>%
  html_nodes("table") %>%
  .[[3]] %>%
  html_table()
