## json 불러오기
install.packages("jsonlite")
library(jsonlite)
data<-fromJSON("sample.json")
str(data)
data<-data.frame(data)

names(data)<-c("id","like","share","comment","unique","msg","time")

# df -> json
dataJson<-toJSON(data)
dataJson
write(dataJson,"data.json")


## excel 불러오기
install.packages("readxl")
library(readxl)
cust_profile<-read_excel("cust_profile.xlsx",
                         sheet = "cust_profile",
                         #range="B3:E8",
                         col_names = TRUE,
                         na="NA",
                         skip=2)


## txt 불러오기
dataset_1<-read.table("dataset_1.txt",
                      header=TRUE,
                      sep=",",
                      stringsAsFactors = FALSE,
                      na.strings = "")


## XML 불러오기
install.packages("XML")
library(XML)
res<-xmlToDataFrame("test.xml")

or

res2<-xmlParse(file="test.xml")
res2
rt<-xmlRoot(res2)
rt[[1]]
rt[[2]]
rt[[1]][[2]]