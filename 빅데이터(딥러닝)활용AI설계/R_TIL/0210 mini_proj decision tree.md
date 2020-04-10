## mini_proj_R

### decision tree titanic

```R
train<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/train.csv')
test<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/test.csv')

install.packages('readr')
install.packages('rpart')
install.packages('rpart.plot')
library(readr)
library(rpart)
library(rpart.plot)
library(dplyr)
library(ggplot2)

# train, test 병합
> Survived<-train$Survived
> train$Survived<-NULL
> dim(bind_rows(train,test))
[1] 1309   11
> dataset<-bind_rows(train,test)

# na 제거
> dataset$Fare[dataset$PassengerId==1044]<-median(dataset$Fare,na.rm=TRUE)
> dataset$PassengerId[is.na(dataset$Fare)==TRUE]
integer(0)

> dataset$Age<-sapply(dataset$Age,FUN=function(x){
  ifelse(is.na(x),median(dataset$Age,na.rm=TRUE),x)})

> substr(dataset$Cabin,1,2)  # 특정 문자열 추출 subset(data,a,b) data의 a부터 b만큼 출력
> dataset$Cabin[dataset$Cabin==""]<-'H'


# data type을 factor로 변경
factor_vars<-c('PassengerId','Pclass','Sex','Embarked','Cabin')  
dataset[factor_vars]<-lapply(dataset[factor_vars],function(x) as.factor(x))
                             

 # decision tree model 생성
> train_cleaned<-dataset[1:891,]
> test_cleaned<-dataset[892:1309,]
> train_cleaned$Survived<-Survived

> dt<-rpart(Survived~Pclass+Sex+Embarked+Cabin,train_cleaned,method='class')
> pred_dt<-predict(dt,test_cleaned,type='class')
> res<-data.frame(PassengerId=test_cleaned$PassengerId,
           Survived=pred_dt)
> write.csv(res,file='result.csv',row.names=FALSE)
                             
```

