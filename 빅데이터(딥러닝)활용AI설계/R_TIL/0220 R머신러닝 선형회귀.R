## 선형회귀
insurance<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/insurance.csv')
str(insurance)
table(insurance$region)
## 모델 생성 전, 종속변수의 정규성 확인
summary(insurance$expenses)
hist(insurance$expenses)

## 모델 생성 전, 변수 간 상관관계 확인
# cor()  -> 상관분석표 출력
cor(insurance[c('age','bmi','children','expenses')])

# pairs()  -> 산포도 graph 출력
pairs(insurance[c('age','bmi','children','expenses')])

install.packages('psych')
library(psych)
pairs.panels(insurance[c('age','bmi','children','expenses')])

## 선형회귀모델 생성
# lm()
ins_lm<-lm(expenses~ . ,data=insurance)
ins_lm

summary(ins_lm)


# p-value 작다 -> 회귀계수가 0이 아닐 가능성 높다 -> 종속변수에 영향

## 비선형관계  ->  높은 차수 항 추가
insurance$age2<-insurance$age^2
lm(expenses~age+age2)

insurance$bmi30<-ifelse(insurance$bmi>=30,1,0)

expenses~bmi30*smoker
ins_lm2<-lm(expenses~age+age2+children+bmi+sex+bmi30*smoker+region,data=insurance)
summary(ins_lm2)



### 미세먼지 data 선형회귀 분석
install.packages('readxl')
library(readxl)
air_0.2_<-read_excel(path='C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/air_0.2_.xlsx',sheet='air',col_names=TRUE)

## 모델 생성 전, 종속변수의 정규성 확인
summary(air_0.2_$pm2.5)
hist(air_0.2_$pm2.5)

## 모델 생성 전, 변수 간 상관관계 확인
cor(air_0.2_[c('o3','no2','co','so2','pm2.5')])

## 선형회귀모델 생성
air_lm<-lm(pm2.5~o3+no2+co+so2,data=air_0.2_)
summary(air_lm)
