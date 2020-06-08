a<-1
a
b<-2
(a+b)/2

# vector 생성
v1<-c(1,2,5,8,9)
v1
v2<-c(1:5)
v2
v3<-seq(1,5)
v3
v4<-seq(1,10,by=3)
v4
#벡터화 연산
v4+1

s1<-'a'
s2<-'text'
s3<-'hi'
s4<-c(s1,s2,s3)
s4
s4+1


mean(v1)
max(v1)
min(v1)

#paste(   ,collapse='')   -> join
paste(s4,collapse=',')



install.packages('ggplot2')
library(ggplot2)
x<-c('a','a','b','c')
#빈도graph
qplot(x)

mpg
qplot(data=mpg,x=hwy)
qplot(data=mpg,x=drv,y=hwy)
qplot(data=mpg,x=drv,y=hwy,geom='line')
qplot(data=mpg,x=drv,y=hwy,geom='boxplot')
qplot(data=mpg,x=drv,y=hwy,geom='boxplot',color=drv)


#df 만들기
eng<-c(90,80,60,70)
math<-c(50,10,20,90)
df_mid<-data.frame(eng,math)
df_mid

#data.frame(eng=c(90,80,60,70),math=c(50,10,20,90),class=c(1,1,2,2))

#str()  -> 객체 구조 파악
str(df_mid)

# column 추가
class<-c(1,1,2,2)
df_mid<-data.frame(eng,math,class)
df_mid

# df$'col_name'   -> 특정 col 출력
df_mid$eng

mean(df_mid$eng)


eng<-c(90,80,60,70)
math<-c(50,10,20,90)
class<-c(1,1,2,2)
df<-data.frame(eng=c(90,80,60,70),math=c(50,10,20,90),class=c(1,1,2,2))
df




# file 불러오기
install.packages('readxl')
library(readxl)

df_excel<-read_excel('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/excel_exam.xlsx')
df_excel
df_excel$english

df_novar<-read_excel('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/excel_exam_novar.xlsx',col_names=F)
df_novar

df_csv<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/csv_exam.csv')
df_csv
str(df_csv)

#file 저장하기
write.csv(df_csv,file='mydf.csv')



exam<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/csv_exam.csv')
head(exam,10)
tail(exam,10)

view(exam)

#shape
dim(exam)

str(exam)

# 기술통계  .describe()
summary(exam)






str(mpg)
head(mpg)
View(mpg)
summary(mpg)




df<-data.frame(v1=c(1,2,1),v2=c(2,3,2))
df

# rename(df,변경값=변경대상값)  -> column 이름 변경
install.packages("dplyr")
library(dplyr)
df<-rename(df,var1=v1)
df

df$vsum<-df$var1+df$v2
df



mpg$total<-(mpg$cty+mpg$hwy)/2
mpg
View(mpg)
summary(mpg$total)

# as.'바꿀 type'(data)  -> data type 변경
as.data.frame(mpg)


mpg<-as.data.frame(mpg)
mpg$test<-ifelse(mpg$total>=20,'pass','fail')
head(mpg,10)

# table()   -> 범주형 data 갯수 출력
table(mpg$test)

qplot(mpg$test)


mpg$grade<-ifelse(mpg$total>=30,'A',ifelse(mpg$total>=20,'B','C'))
mpg
table(mpg$grade)
qplot(mpg$grade)


# '~에서' ctrl+shift+m
exam<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/csv_exam.csv')
exam %>% filter(class==1) %>% filter(math>=50)
exam %>% filter(class!=1) %>% filter(math>=50)
exam %>% filter(class==2) %>% filter(english>=80)
exam %>% filter(class==2 & english>=80)
exam %>% filter(class==2 | english>=80)
exam %>% filter(class==1 | class==3 | class==5)
exam %>% filter(class %in% c(1,3,5))

exam %>% select(math)
exam %>% select(math, class)
exam %>% select(math, class)

str(exam %>% filter(class %in% c(1,3,5)))
exam %>% select(-math, -class)

exam %>% 
  filter(class==1) %>% 
  select(english)
head(exam %>% select(id,math))

exam %>% select(id,math) %>% head


# arrange(colname)  -> 특정 column 기준 오름차순 정렬
exam %>% arrange(math)
exam %>% arrange(desc(math))

# arrange(기준1,기준2)
exam %>% arrange(class,desc(math))  



# mutate()  -> 파생변수
exam %>% 
  mutate(total=math+english+science) %>% 
  head

exam$test<-ifelse(exam$science>=60,'pass','fail')
exam %>% 
  mutate(test=ifelse(exam$science>=60,'pass','fail')) %>% 
  head

exam %>%
  mutate(total=math+english+science) %>% 
  arrange(total) %>% 
  head
