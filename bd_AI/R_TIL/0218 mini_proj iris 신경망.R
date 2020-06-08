### iris data 신경망 model

## "Sepal.Length" "Sepal.Width"  "Petal.Length"로 "Petal.Width" 예측

# species col 뺀 dataset 준비
irisset<-iris[,c(1:4)]

# 정규화
normalize<-function(x){
  return((x-min(x))/(max(x)-min(x)))
}
irisset<-lapply(irisset,normalize)

# random training set / test set 생성
set.seed(123)
train_sample<-sample(150,105)
iris_train<-irisset[train_sample,]
iris_test<-irisset[-train_sample,]

# 신경망 model 생성
library(neuralnet)
iris_neu<-neuralnet(formula=Petal.Width~Sepal.Length+Sepal.Width+Petal.Length,
                    data=iris_train)
plot(iris_neu)

# test set 예측
iris_result<-compute(iris_neu,iris_test)
iris_result$net.result
predict_result<-iris_result$net.result

# 상관계수 구하기
cor(predict_result,iris_test)


# hidden=8일때의 상관계수
iris_neu2<-neuralnet(formula=Petal.Width~Sepal.Length+Sepal.Width+Petal.Length,
                    data=iris_train,hidden=8)
plot(iris_neu2)

iris_result2<-compute(iris_neu2,iris_test)
iris_result2$net.result
predict_result2<-iris_result2$net.result

cor(predict_result2,iris_test)

