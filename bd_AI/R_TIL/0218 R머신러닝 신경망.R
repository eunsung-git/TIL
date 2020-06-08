## concrete data 분석
concrete<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/concrete.csv')
str(concrete)

# 정규화
normalize<-function(x){
  return((x-min(x))/(max(x)-min(x)))
}
concrete_norm<-as.data.frame(lapply(concrete,normalize))
summary(concrete_norm)

## train set / test set 분리
concrete_train<-concrete_norm[1:773,]
concrete_test<-concrete_norm[774:1030,]

## 신경망 model 생성
install.packages('neuralnet')
library(neuralnet)
# neuralnet(formula=출력변수~입력변수,data)
concrete_neu<-neuralnet(formula=strength~cement+slag+ash+water+superplastic+coarseagg+fineagg+age,
                        data=concrete_train)
plot(concrete_neu)


## test set 예측
# compute(model, data)
concrete_test[1:8]
concrete_result<-compute(concrete_neu,concrete_test[1:8])
str(concrete_result)
predict_result<-concrete_result$net.result

## 상관계수 구하기
# cor(data1,data2)
cor(predict_result,concrete_test$strength)


## hidden=5일 때의 상관계수
concrete_neu2<-neuralnet(formula=strength~cement+slag+ash+water+superplastic+coarseagg+fineagg+age,
                         data=concrete_train,hidden=5)
plot(concrete_neu2)


concrete_result2<-compute(concrete_neu2,concrete_test[1:8])

predict_result2<-concrete_result2$net.result

cor(predict_result2,concrete_test$strength)
