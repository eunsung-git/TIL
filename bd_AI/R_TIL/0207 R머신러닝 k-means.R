teens<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/snsdata.csv')
str(teens)
table(teens$gender,useNA='ifany')
summary(teens$age)

teens$age<-ifelse(teens$age>=13 & teens$age<20,teens$age,NA)
summary(teens$age)


teens$female<-ifelse(teens$gender=='F'& !is.na(teens$gender),1,0)
table(teens$female)


teens$no_gender<-ifelse(is.na(teens$gender),1,0)
table(teens$no_gender)

table(teens$gender,useNA='ifany')
table(teens$female)
table(teens$no_gender)


mean(teens$age,na.rm=TRUE)
myagg<-aggregate(data=teens,age~gradyear,mean)

avg_age<-ave(teens$age,teens$gradyear,FUN = function(x) mean(x,na.rm=TRUE))

teens$age<-ifelse(is.na(teens$age),avg_age,teens$age)
summary(teens$age)


interests<-teens[5:40]
set.seed(2345)
interests_z<-as.data.frame(lapply(interests,scale))
head(interests_z)


teen_clusters<-kmeans(interests_z,5)
teen_clusters$size
teen_clusters$centers
teens$cluster<-teen_clusters$cluster

teens[1:5,c('cluster','gender','age','friends')]

aggregate(data=teens,female~cluster,mean)
