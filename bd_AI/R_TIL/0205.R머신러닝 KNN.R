install.packages('rJava')
install.packages('memoise')
install.packages('KoNLP')
Sys.setenv(JAVA_HOME='C:/Program Files (x86)/Java/jre1.8.0_241')
library(rJava)
library(KoNLP)


install.packages('ggiraphExtra')
library(ggiraphExtra)
USArrests

library(tibble)
crime<-rownames_to_column(USArrests,var='state')
head(crime)
crime$state<-tolower(crime$state)

# 미국 지도 data 준비
library(ggplot2)
install.packages('maps')
library(maps)
states_map<-map_data('state')
str(states_map)

install.packages('mapproj')
library(mapproj)
ggChoropleth(data=crime,  # 지도에 표 시할  data
             aes(fill=Murder, # 색으로 표시할 변수
                 map_id=state), # 지역 기준 변수
             map=states_map) # 지도 위에 표시할 data

ggChoropleth(data=crime,  
             aes(fill=Murder, 
                 map_id=state), 
             map=states_map,
             interactive=T) 



# 대한민국 지도 data
install.packages('stringi')
install.packages('devtools')
devtools::install_github('cardiomoon/kormaps2014')
library(kormaps2014)
library(dplyr)
library(ggiraphExtra)
library(ggplot2)
library(maps)
library(mapproj)
korpop1<-rename(korpop1,pop='총인구_명',name='행정구역별_읍면동')
korpop1<-changeCode(korpop1)
str(changeCode(korpop1))
ggChoropleth(data=korpop1,  # 지도에 표시할 data
             aes(fill=pop,  # 색으로 나타낼 변수
                 map_id=code,  # 지역 기준 변수
                 tooltip=name),
             map=kormap1) # 지도 위에 표시할 data

ggChoropleth(data=korpop1,
             aes(fill=pop,  
                 map_id=code, 
                 tooltip=name),
             map=kormap1,   
             interactive = T) 

devtools::install_github('cardiomoon/moonBook2')
ggplot(korpop1,aes(map_id=code,fill='총인구_명'))+
  geom_map(map=kormap1,colour='black',size=0.1)+
  expand_limits(x=kormap1$long,y=kormap1$lat)+
  #scale_fill_gradientn(colours = c('white','orange','red'))+
  ggtitle('2015 인구분포도')+
  coord_map()


ggChoropleth(korpop2,kormap2,fillvar='남자_명')
  






subject_name<-c('John','Jane','Steve')
temp<-c(37,35,33)
flu_status<-c(TRUE,FALSE,FALSE)
temp[2]
temp[2:3]
temp[-2]
temp[c(TRUE,FALSE,TRUE)]


#factor() - 범주형 data 표현
gender<-factor(c('M','F','M'))
gender

blood<-factor(c('O','AB','A'),levels=c('O','AB','A','B'))
blood

factor(c('A','F','C'),
       levels=c('A','B','C','D','F'),
       ordered=TRUE)


sb1<-list(fn=subject_name[1],temp=temp[1],flu=flu_status[1])

sb1$fn
sb1[1] 

sb1[[1]] # list 요소 출력 시 [[]]

sb1[c('temp','flu')]

# stringsAsFactors - str을 factor로 읽기
df<-data.frame(sb1,stringsAsFactors = FALSE)
str(df)


## apply 함수
iris_num<-NULL
class(iris)
str(iris)

ncol(iris)

for(x in 1:ncol(iris)){
  if(is.numeric(iris[,x]))
    iris_num<-cbind(iris_num,iris[,x])
  #print(iris[,x])
}
iris_num 

for(x in 1:ncol(iris)){ # R에서는 {}기호로 묶는다. python은 :
  if(is.numeric(iris[,x]))
    iris_num<-cbind(iris_num,iris[,x])
  #  print(iris[,x])
}
class(iris_num)


iris_num<-iris[,sapply(iris, is.numeric)]
class(iris_num)
iris_num<-data.frame(iris_num)
class(iris_num)



iris_num<-iris[1:10,1:4]
set.seed(123)
idx_r<-sample(1:10,2)
idx_c<-sample(1:4,2)
idx_r
idx_c

for(i in 1:2){
  iris_num[idx_r[i],idx_c[i]]<-NA
}
iris_num



apply(iris_num,1,mean)
apply(iris_num,2,mean,na.rm=T)

apply(iris_num,2,function(x){x*2+1})

apply(iris_num,2,function(x){median(x*2+1)})

apply(iris_num,2,function(x){median(x*2+1,na.rm=T)})

lapply(iris_num,mean,na.rm=T)


sapply(iris_num,mean,na.rm=T)
sapply(iris_num,mean,na.rm=T,simplify=F)


vapply()

vapply(iris_num,fivenum,c('Min.'=0,'1st.'=0,'med.'=0,'3rd.'=0,'max.'=0))



usedcars<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/usedcars.csv',stringsAsFactors=FALSE)
str(usedcars)
summary(usedcars$year)
summary(usedcars[c('price','mileage')])
diff(range(usedcars$price))
IQR(usedcars$price)
quantile(usedcars$price)
quantile(usedcars$price,seq(from=0,to=1,by=0.1))

boxplot(usedcars$price,main='car prices',ylab='price($)')
boxplot(usedcars$mileage,main='car mileage',ylab='odometer')


hist(usedcars$price,main='car prices',xlab='price($)')
hist(usedcars$mileage,main='car mileage',xlab='odometer')


var(usedcars$price)
sd(usedcars$price)


table(usedcars$year)
table(usedcars$model)
table(usedcars$color)

c_table<-table(usedcars$color)
prop.table(c_table)
round(prop.table(c_table)*100,1)


# 이변량 함수 -  산포도
plot(x=usedcars$mileage,y=usedcars$price)


usedcars$conservative<-usedcars$color %in% c('Black','Gray','Silver','White')
table(usedcars$conservative)



install.packages('gmodels')
library(gmodels)
CrossTable(x=usedcars$model,y=usedcars$conservative)





wbcd<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/wisc_bc_data.csv',stringsAsFactors=FALSE)
str(wbcd)

wbcd<-wbcd[-1]
str(wbcd)

wbcd$diagnosis<-factor(wbcd$diagnosis,levels=c('B','M'),
       labels = c('Benign','Malignant'))
table(wbcd$diagnosis)

round(prop.table(table(wbcd$diagnosis))*100,1)


summary(wbcd[c('radius_mean','area_mean','smoothness_mean')])


# 정규화
# 함수 정의
normalize<-function(x){
  return((x-min(x))/(max(x)-min(x)))
}
normalize(c(1,2,3,4,5))

wbcd_n<-as.data.frame(lapply(wbcd[2:31],normalize))
class(wbcd_n)

summary(wbcd_n$area_mean)

#train data / test data  나누기
wbcd_train<-wbcd_n[1:469,]
wbcd_test<-wbcd_n[470:569,]

wbcd_train_labels<-wbcd[1:469,1]
wbcd_test_labels<-wbcd[470:569,1]


library(class)
wbcd_test_pred<-knn(train = wbcd_train,test = wbcd_test,
    cl=wbcd_train_labels,k=21)
wbcd_test_pred

library(gmodels)
CrossTable(x=wbcd_test_labels,y=wbcd_test_pred,
           prop.chisq = FALSE)


# 표준화
wbcd_z<-as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)

wbcd_train<-wbcd_z[1:469,]
wbcd_test<-wbcd_z[470:569,]
wbcd_train_labels<-wbcd[1:469,1]
wbcd_test_labels<-wbcd[470:569,1]


library(class)
wbcd_test2_pred<-knn(train = wbcd_train,test = wbcd_test,
                    cl=wbcd_train_labels,k=21)


library(gmodels)
CrossTable(x=wbcd_test_labels,y=wbcd_test2_pred,
           prop.chisq = FALSE)




iris_train<-iris[c(1:35,51:85,101:135),]
iris_test<-iris[c(36:50,86:100,136:150),]
iris_train_labels<-iris[c(1:35,51:85,101:135),1]
iris_test_labels<-iris[c(36:50,86:100,136:150),1]


library(class)
iris_test_pred<-knn(train = iris_train,test = iris_test,
                    cl=iris_train_labels,k=21)
iris_test_pred

iris_train
iris_test
iris_train_labels
