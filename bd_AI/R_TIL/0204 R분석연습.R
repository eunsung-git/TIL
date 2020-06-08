exam<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/csv_exam.csv')
exam
library(dplyr)

exam %>% summarise(mean_math=mean(math))
exam %>% summarise(mean_math=sum(math))

# 반별 수학 점수 평균
exam %>% 
  group_by(class) %>%
  summarise(mean_math=mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mm=mean(math),
            sm=sum(math),
            md=median(math),
            cnt=n())

library(ggplot2)
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mc=mean(cty)) %>% 
  head()
mpg %>% 
  group_by(manufacturer,drv) %>% 
  summarise(mc=mean(cty))


mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=='suv') %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mt=mean(tot)) %>% 
  arrange(desc(mt)) %>% 
  head(5)


test1<-data.frame(id=c(1,2,3,4,5),
                 midterm=c(60,80,70,90,55))
test2<-data.frame(id=c(1,2,3,4,5),
                 final=c(70,80,40,80,75))

# join
total<-left_join(test1,test2,by='id')
total
name<-data.frame(class=c(1,2,3,4,5),
                 teacher=c('kim','lee','park','choi','cho'))
left_join(exam,name,by='class')


## bind
test1<-data.frame(id=c(1,2,3,4,5),
                  midterm=c(60,80,70,90,55))
test2<-data.frame(id=c(6,7,8,9,10),
                  midterm=c(70,80,40,80,75))

bind_rows(test1,test2)


exam %>% filter(class==1 & math>=50)
exam %>% filter(class %in% c(1,3,5))
exam %>% select(id,math)

exam$test<-ifelse(exam$english>=60,'pass','fail')
exam %>% mutate(test=ifelse(english>=60,'pass','fail')) %>% 
  arrange(test)

test1<-data.frame(id=c(1,2,3,4,5),
                  midterm=c(60,80,70,90,55))
test2<-data.frame(id=c(1,2,3,4,5),
                  final=c(70,80,40,80,75))
left_join(test1,test2,by='id')


## 결측값  처리
df<-data.frame(sex=c('M','F',NA,'M','F'),score=c(5,4,3,5,NA))
is.na(df)

table(is.na(df))

table(is.na(df$score))

mean(df$score)
sum(df$score)

df %>% filter(is.na(score))
df_nomiss<-df %>% filter(!is.na(score))
mean(df_nomiss$score)


df_nomiss<-df %>% filter(!is.na(score)&!is.na(sex))
df_nomiss

df
df_nomiss2<-na.omit(df)


mean(df$score,na.rm = T)
sum(df$score,na.rm = T)


exam<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/csv_exam.csv')
exam[c(3,5,15),'math']<-NA
exam %>% 
  summarise(mm=mean(math,na.rm = T),
            sm=sum(math,na.rm = T),
            med=median(math,na.rm = T))
exam$math<-ifelse(is.na(exam$math),55,exam$math)
exam$math

mean(exam$math)



df<-data.frame(sex=c(1,2,1,3,2,1),score=c(5,4,3,4,2,6))
table(df$sex)
table(df$score)
df$sex<-ifelse(df$sex==3,NA,df$sex)
df$score<-ifelse(df$score>5,NA,df$score)

df %>% 
  filter(!is.na(sex)&!is.na(score)) %>% 
  group_by((sex)) %>% 
  summarise(ms=mean(score))



boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats

mpg$hwy<-ifelse(mpg$hwy<12 | mpg$hwy>37,NA,mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy,na.rm=T))


table(is.na(df$score))



##시각화

#배경설정
ggplot(data=mpg,aes(x=displ,y=hwy))

#산점도 graph
ggplot(data=mpg,aes(x=displ,y=hwy))+
  geom_point()+
  xlim(3,6)+
  ylim(10,30)


df_mpg<-mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy=mean(hwy))
ggplot(data=df_mpg,aes(x=drv,y=mean_hwy))+geom_col()


economics
ggplot(data=economics,aes(x=date,y=unemploy))+geom_line()
ggplot(data=economics,aes(x=date,y=unemploy))+geom_point()

# spss file 불러오기
install.packages('foreign')
library(foreign)
library(dplyr)   # data 전처리
library(ggplot2) # 시각화
library(readxl)  # excel 불러오기
raw_welfare<-read.spss('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/Koweps_hpc10_2015_beta1.sav',to.data.frame=T)
welfare<-raw_welfare

str(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

welfare<-rename(welfare,
       sex=h10_g3,birth=h10_g4,marriage=h10_g10,
       religion=h10_g11,code_job=h10_eco9,
       income=p1002_8aq1,region=h10_reg7)
welfare
class(welfare$sex)
table(welfare$sex)

welfare$sex=ifelse(welfare$sex==9,NA,welfare$sex)
table(is.na(welfare$sex))


welfare$sex<-ifelse(welfare$sex==1,'male','female')
table(welfare$sex)
qplot(welfare$sex)

class(welfare$income)
summary(welfare$income)
qplot(welfare$income)+xlim(0,1000)

welfare$income<-ifelse(welfare$income %in% c(0,9999),NA,welfare$income)
table(is.na(welfare$income))

sex_income<-welfare %>% filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mi=mean(income))


ggplot(data=sex_income,aes(x=sex,y=mi))+geom_col()


summary(welfare$birth)
table(is.na(welfare$birth))

welfare$birth<-ifelse(welfare$birth==9999,NA,welfare$birth)
table(is.na(welfare$birth))

welfare$age<-2015-welfare$birth+1
summary(welfare$age)
qplot(welfare$age)



welfare$birth<-ifelse(welfare$birth==9999,NA,welfare$birth)
table(is.na(welfare$birth))



age_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mi=mean(income))
ggplot(age_income,
       aes(x=age,y=mi))+geom_line()


welfare<-welfare %>% 
  mutate(ageg=ifelse(age<30,'young',ifelse(age<=59,'middle','old')))
welfare$ageg
table(welfare$ageg)
qplot(welfare$ageg)

ageg_income<-welfare %>% filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mi=mean(income))
ggplot(ageg_income,aes(x=ageg,y=mi))+
  geom_col()+
  scale_x_discrete(limits=c('young','middle','old'))



# 성별 연령대별 월급 차이
sex_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(mi=mean(income))
ggplot(sex_income,aes(x=ageg,y=mi,fill=sex))+
  geom_col()+
  scale_x_discrete(limits=c('young','middle','old'))

ggplot(sex_income,aes(x=ageg,y=mi,fill=sex))+
  geom_col(position = 'dodge')+
  scale_x_discrete(limits=c('young','middle','old'))


# 성별 연령별 
sex_age<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age,sex) %>% 
  summarise(mi=mean(income))
ggplot(sex_age,aes(x=age,y=mi,col=sex))+geom_line()



# 직업별 월급 차이
library(readxl)
list_job<-read_excel('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/r데이터분석_Data/Data/Koweps_Codebook.xlsx',sheet=2,col_names=T)

welfare<-left_join(welfare,list_job,id='code_job')
welfare$job
welfare$code_job

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job,job) %>% head(10)

job_income<-welfare %>% 
  filter(!is.na(job)&!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mi=mean(income))
top10<-job_income %>% arrange(desc(mi)) %>% head(10)
ggplot(top10,aes(x=reorder(job,mi),y=mi))+
  geom_col()+coord_flip()

top10<-job_income %>% arrange(desc(mi)) %>% head(10)
ggplot(top10,aes(x=reorder(job,-mi),y=mi))+
  geom_col()+coord_flip()


#성별에 따라 어떤 직업이 가장 많은지
welfare$sex<-ifelse(welfare$sex==1,'male','female')

sex_job<-welfare %>% 
  filter(!is.na(job)&!is.na(code_job)) %>% 
  group_by(sex) %>% 
  count(job) %>% arrange(desc(n))
  

femalejob<-sex_job %>% 
  filter(sex=='female')%>% head(10)  
femalejob

malejob<-sex_job %>% 
  filter(sex=='male') %>% head(10)         
malejob

ggplot(femalejob,aes(x=reorder(job,n),y=n))+geom_col()+coord_flip()

ggplot(malejob,aes(x=reorder(job,n),y=n))+geom_col()+coord_flip()





                     