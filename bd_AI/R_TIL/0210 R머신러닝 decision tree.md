##  decision tree


>
> 해석 용이, 직관적, 분류 및 회긔 분석에 범용적으로 사용
>
> 변동성 높음
>
> Entropy : 복잡도
>
> I.G = Entropy before - Entropy after



#### credit data 연습

```R
credit<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/credit.csv')

# 900개의 train data 생성
> set.seed(123)
> train_sample<-sample(1000,900)
> credit_train<-credit[train_sample,]

# 100개의 test data 생성
> credit_test<-credit[-train_sample,]

# decision tree package 설치
> install.packages('C50')
> library(C50)

# decision tree 모델 생성
> credit_model<-C5.0(credit_train[-17],credit_train$default)
> credit_model
Call:
C5.0.default(x = credit_train[-17], y
 = credit_train$default)
Classification Tree
Number of samples: 900 
Number of predictors: 16 
Tree size: 69 
Non-standard options: attempt to group attributes

# 예측 모델 생성
> credit_pred<-predict(credit_model,credit_test)

# 교차테이블 생성 후 비교
> library(gmodels)
> CrossTable(credit_test$default,credit_pred,prop.c=FALSE,prop.r=FALSE,dnn=c('actual','predicted'))

-----------------------------------------------------------

# boosting : decision tree를 여러 개 작성하여, 각 tree의 결과값 투표   -> 성능이 약한 model들을 모아 성능 개선 목적
> credit_boost10<-C5.0(credit_train[-17],credit_train$default,trials=10)
> summary(credit_boost10)
> credit_boost_pred10<-predict(credit_boost10,credit_test)
> CrossTable(credit_test$default,credit_boost_pred10,prop.c=FALSE,prop.r=FALSE,dnn=c('actual','predicted'))
```



#### titanic data 연습

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


