## k-means

> clustering
>
> 고객 data에서 유사한 구매 패턴을 가진 고객들을 그룹화



#### sns data 연습

```R
teens<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/snsdata.csv')
> str(teens)

# 범주형 data의 na 갯수 출력   -> table(  ,useNA='ifany')
> table(teens$gender,useNA='ifany') 
	F     M  <NA> 
22054  5222  2724

# 수치형 data의 na 갯수 출력    -> summary()
> summary(teens$age)
 Min. 1st Qu.  Median    Mean 3rd Qu.    Max. NA's
3.086  16.312  17.287  17.994  18.259 106.927 5086

# teens$age 이상치 제거
> teens$age<-ifelse(teens$age>=13 & teens$age<20,teens$age,NA)
> summary(teens$age)
 Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   NA's 
  13.03   16.30   17.27   17.25   18.22   20.00 5523 

# female==1, male&na==0으로 원핫인코딩
> teens$female<-ifelse(teens$gender=='F' & !is.na(teens$gender),1,0)
> table(teens$female)
	0     1 
 7946 22054 

# na==1로 원핫인코딩
> teens$no_gender<-ifelse(is.na(teens$gender),1,0)
> table(teens$no_gender)
   0     1 
27276  2724 


## 그룹통계 계산   -> aggregate(data,계산해당그룹~기준그룹, 연산함수), df로 출력
# 졸업년도 별 나이의 평균
> aggregate(data=teens,age~gradyear,mean)
  gradyear      age
1     2006 18.65586
2     2007 17.70617
3     2008 16.76770
4     2009 15.81957

## 그룹통계 계산을 모든 data에 적용  ->  ave(계산해당그룹,기준그룹,연산함수), vector로 출력
# 졸업년도 별 나이의 평균을 모든 data에 적용
> avg_age<-ave(teens$age,teens$gradyear,FUN = function(x) mean(x,na.rm=TRUE))
      
# teens$age na를 졸업년도별 나이의 평균으로 대체
> teens$age<-ifelse(is.na(teens$age),avg_age,teens$age)
> summary(teens$age)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  13.03   16.28   17.24   17.24   18.21   20.00
               
### 표준화
> interests<-teens[5:40]
> set.seed(2345)
> interests_z<-as.data.frame(lapply(interests,scale))
> head(interests_z)
               
               
### clustering
> kmeans(interests_z,5)

# 각 cluster의 크기
> teen_clusters$size
[1]  1038   601  4066  2696 21599

# 각 cluster의 중심 좌표 출력 / 수치가 높을 수록 많이 언급
> teen_clusters$centers
   

# 학생들의 cluster 소속
> teen_clusters$cluster
> teens$cluster<-teen_clusters$cluster
> teens[1:5,c('cluster','gender','age','friends')]
  cluster gender    age friends
1       5      M 18.982       7
2       3      F 18.801       0
3       5      M 18.335      69
4       5      F 18.875       0
5       1   <NA> 18.995      10
               
# cluster별 평균 나이
> aggregate(data=teens,age~cluster,mean)
  cluster      age
1       1 17.09319
2       2 17.38488
3       3 17.03773
4       4 17.03759
5       5 17.30265
               
# cluster별 여성 비율                
> aggregate(data=teens,female~cluster,mean)
  cluster    female
1       1 0.8025048
2       2 0.7237937
3       3 0.8866208
4       4 0.6984421
5       5 0.7082735  

```

