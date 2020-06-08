str(iris)
head(iris)

colSums(is.na(iris))

panel.fun<-function(x,y,...){
  horizontal<-(par('usr')[1]+par('usr')[2])/2;
  vertical=(par('usr')[3]+par('usr')[4])/2;
  text(horizontal,vertical,format(abs(cor(x,y)),digits=2))
}
pairs(iris[1:4],pch=21,bg=(c('red','green','blue')[unclass(iris$Species)]
                           upper.panel=panel.fun,main='Scatter')
      
      panel.fun <-function(x,y,...){
        horizontal<-(par("usr")[1]+
                       par("usr")[2])/2;
        vertical<-(par("usr")[3]+
                     par("usr")[4])/2;
        text(horizontal, vertical, 
             format(abs(cor(x,y)),digits=2))
      }
pairs(iris[1:4],
      pch=21, bg=c("red","green","blue")[unclass(iris$Species)],
      upper.panel=panel.fun,
      main="Scatter")
      
      
      #ggplotgeom_point(): 변수 1개로 산점도 그리기
      #corrplot package: 상관계수 행렬 그리기
      
str(airquality)
airquality_1<-airquality[,c(1:4)]
airquality_1    
colSums((is.na(airquality_1)))
sum((is.na(airquality_1$Ozone)))
cor(airquality_1)
airquality_2<-na.omit(airquality_1)
str(airquality_2)
colSums((is.na(airquality_2)))

panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.7, 0.7, txt, cex = cex.cor * r)
}


panel.lm<-function(x,y,col=par('col'),
                   bg=NA,pch=par('pch'),
                   cex=1,col.smooth='black',...){
  points(x,y,pch=pch,col=col,
         bg=bg,cex=cex)
  abline(stats::lm(y~x),
         col=col.smooth,...)
}

pairs(airquality_2,pch='*',main='scatter plot',lower.panel=panel.lm,
      upper.panel=panel.cor,diag.panel=panel.hist)


 pairs(iris[1:4], main = "Anderson's Iris Data -- 3 species",
      pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)])

 
library(ggplot2)
iris_plot<-ggplot(iris,aes(x=Petal.Length,y=Petal.Width,colour=Species))+
  geom_point(shape=19,size=4)
iris_plot2<-iris_plot+
  annotate('text',x=1.5,y=0.7,label='Setosa')+
  annotate('text',x=3.5,y=1.5,label='Versicolor')+
  annotate('text',x=6,y=2.7,label='Virginica')
iris_plot2+
  annotate('rect',xmin=0,xmax=2.6,ymin=0,ymax=0.8,alpha=0.1,fill='red')+
  annotate('rect',xmin=2.6,xmax=4.9,ymin=0.8,ymax=1.5,alpha=0.1,fill='green')+
  annotate('rect',xmin=4.8,xmax=7.2,ymin=1.5,ymax=2.7,alpha=0.1,fill='blue')


iris_kmeans<-kmeans(iris[,c('Petal.Length','Petal.Width')],3)
iris_kmeans

names(iris_kmeans)
iris_kmeans$size

table(iris_kmeans$cluster)





curve(-x*log2(x)-(1-x)*log2(1-x),
      col='red',xlab='x',ylab='entropy',lwd=4)



credit<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/credit.csv')
str(credit)
summary(credit)
table(credit$default)

#900개의 train data 생성
set.seed(123)
train_sample<-sample(1000,900)
str(train_sample)
credit_train<-credit[train_sample,]

#100개의 test data 생성
credit_test<-credit[-train_sample,]

prop.table(table(credit_train$default))
prop.table(table(credit_test$default))


install.packages('C50')
library(C50)

credit_model<-C5.0(credit_train[-17],credit_train$default)
credit_model
summary(credit_model)


credit_pred<-predict(credit_model,credit_test)

library(gmodels)
CrossTable(credit_test$default,credit_pred,
           prop.c=FALSE,prop.r=FALSE,
           dnn=c('actual','predicted'))
           


# boosting : decision tree를 여러 개 작성하여, 각 tree의 결과값을 투표
credit_boost10<-C5.0(credit_train[-17],credit_train$default,trials=10)
summary(credit_boost10)    

credit_boost_pred10<-predict(credit_boost10,credit_test)
CrossTable(credit_test$default,credit_boost_pred10,
           prop.c=FALSE,prop.r=FALSE,
           dnn=c('actual','predicted'))




# titanic
train<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/train.csv')
str(train)
test<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/test.csv')
str(test)

install.packages('readr')
install.packages('rpart')
install.packages('rpart.plot')
library(readr)
library(rpart)
library(rpart.plot)
library(dplyr)
library(ggplot2)

Survived<-train$Survived

dataset<-bind_rows(train,test)
str(dataset)
summary(dataset)

dataset$Fare[dataset$PassengerId==1044]<-median(dataset$Fare,na.rm=TRUE)

dataset$PassengerId[is.na(dataset$Fare)==TRUE]


dataset$Age<-sapply(dataset$Age,FUN=function(x){
  ifelse(is.na(x),median(dataset$Age,na.rm=TRUE),x)})
summary(dataset$Age)

table(dataset$Embarked)/sum(dataset$Embarked!="")


dataset$PassengerId[dataset$Embarked==""]
dataset$Embarked[c(62,830)]<-'S'

nrow(dataset)

1-sum(dataset$Cabin!="")/nrow(dataset)
dataset$Cabin<-substr(dataset$Cabin,1,1)
dataset$Cabin[dataset$Cabin==""]<-'H'
table(dataset$Cabin)


str(dataset)
factor_vars<-c('PassengerId','Pclass','Sex','Embarked','Cabin')  
dataset[factor_vars]<-lapply(dataset[factor_vars],function(x) as.factor(x))
str(dataset)


train_cleaned<-dataset[1:891,]
test_cleaned<-dataset[892:1309,]
train_cleaned$Survived<-Survived


dt<-rpart(Survived~Pclass+Sex+Embarked+Cabin,train_cleaned,method='class')
pred_dt<-predict(dt,test_cleaned,type='class')
res<-data.frame(PassengerId=test_cleaned$PassengerId,
           Survived=pred_dt)
write.csv(res,file='result.csv',row.names=FALSE)





mushrooms<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/mushrooms.csv')
mushrooms<-mushrooms[-6]
mushrooms
#6000개의 train data 생성
mushrooms_train<-mushrooms[1:6000,]

# 2125개의 test data 생성
mushrooms_test<-mushrooms[6001:8125,]


library(C50)
# decision tree 모델 생성
mushrooms_model<-C5.0(mushrooms_train[-1],mushrooms_train$type)
mushrooms_model

# 예측 모델 생성
mushrooms_pred<-predict(mushrooms_model,mushrooms_test)


is.na(mushrooms)
str(mushrooms)


dt<-rpart(Survived~Pclass+Sex+Embarked+Cabin,train_cleaned,method='class')
pred_dt<-predict(dt,test_cleaned,type='class')
res<-data.frame(PassengerId=test_cleaned$PassengerId,
                  Survived=pred_dt)
write.csv(res,file='result.csv',row.names=FALSE)



