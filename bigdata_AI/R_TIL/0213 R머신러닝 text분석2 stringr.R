install.packages('stringr')
library(stringr)
rwiki<-"R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years.
R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available."

# str_extract(data,'pat')  -> 특정 pat 추출
str_extract(rwiki,'software environment')
str_extract_all(rwiki,'software environment')
str_extract_all(rwiki,'software environment',simplify=TRUE)


myext<-str_extract_all(rwiki,'[[:upper:]]{1}[[:alpha:]]{0,}')
table(myext)


# str_locate()   -> 특정 pat의 위치 출력
str_locate(rwiki,'software environment')
str_locate_all(rwiki,'software environment')

myloc<-str_locate_all(rwiki,'[[:upper:]]{1}[[:alpha:]]{0,}')
class(myloc[[1]])
dim(myloc[[1]])

mydata<-data.frame(myloc[[1]])
mydata
mydata$myword<-myext[[1]]
mydata

mydata$myword.length<-mydata$end-mydata$start+1
head(mydata)

# str_replace(data,'oldpat','newpat')
str_replace(rwiki,'software environment','software_environment')
temp<-str_replace_all(rwiki,'software environment','software_environment')

str_extract_all(temp,'software_environment|software|environment')
str_extract_all(rwiki,'software_environment|software|environment')
table(str_extract_all(rwiki,'software_environment|software|environment'))

temp<-str_replace_all(rwiki,'R','R_computer.language')
temp<-str_replace_all(temp,'C','C_computer.language')
temp

str_extract_all(temp,'[[:alpha:]]{1}_computer.language')
table(str_extract_all(temp,'[[:alpha:]]{1}_computer.language'))

strsplit()
rwikipara<-str_split(rwiki,'\n')
str_split(rwikipara[[1]])

## 문단별 문장 구분
# '.' 기준 문장 구분
rwikisent<-str_split(rwikipara[[1]],'\\. ')

#str_split_fixed()
my2sent<-unlist(rwikisent)[c(4,7)]
strsplit(my2sent[1],split=' ')
table(strsplit(my2sent[1],split=' '))
strsplit(my2sent[2],split=' ')
table(strsplit(my2sent[2],split=' '))

table(str_split(my2sent[1],' '))
table(str_split(my2sent[2],' '))
 
length(unlist(str_split(my2sent[2],' ')))


# 문장을 n개로 분리
str_split_fixed(my2sent,' ',5)
str_split_fixed(my2sent,' ',13)


# sent * word matrix 만들기
len.sent<-rep(NA,length(unlist(rwikisent)))

for(i in 1:length(len.sent)){
  len.sent[i]<-length(unlist(str_split(unlist(rwikisent)[i],' ')))
}
len.sent

max.len.sent<-max(len.sent)

sent.word.matrix<-str_split_fixed(unlist(rwikisent),' ',max.len.sent)
mydata<-data.frame(sent.word.matrix)
rownames(mydata)<-paste('sent',1:length(unlist(rwikisent)),sep='.')
colnames(mydata)<-paste('word',1:max.len.sent,sep='.')
mydata

## str_count(data,'pat')  -> 특정 pat 갯수출력
str_count(rwiki,'R')
str_count(unlist(rwikipara),'R')
str_count(unlist(rwikisent),'R')

str_count(unlist(rwikisent),'R[[:blank:]]{0,}[[:alpha:]]{0,}[[:blank:]]{0,}stat[[:alpha:]]+')
str_count(str_split(unlist(rwikisent),'\\. '),'R[[:blank:]]{0,}[[:alpha:]]{0,}[[:blank:]]{0,}stat[[:alpha:]]+')

str_extract_all(unlist(rwikisent)[c(1,2)],'R.{1,}(s|S)tat')

str_count(unlist(rwikisent),'R[[:lower:][A-Q][S-Z][:digit:][:space:]]{1,}(s|S)tat[[:alpha:]]{1,}')
str_count(unlist(rwikisent),'R{1}[^R]{1,}(s|S)tat[[:alpha:]]{1,}')


## str_sub()  ->  data를 a위치부터 b위치까지 출력
str_sub(unlist(rwikisent),1,30)


## str_dup(str,n)   -> str을 n번만큼 합친 후 출력
str_dup('software',3)
paste(rep('software',3),collapse='')

## 글자 수 출력
str_length(unlist(rwikisent))
nchar(unlist(rwikisent))

## str_pad()
name<-c('Joe','Jack','Jackie','Jefferson')
donation<-c('$1','$11','$111','$1111')
df<-data.frame(name,donation)
df
df2<-str_pad(df$name,width=15,side='right')
df3<-str_pad(df$name,width=15,side='both',pad='~')
df4<-data.frame(df2,df3)
df4
str_length(df4$df2)

str_trim(df4$df2,side='right')

str_replace_all(df4$df3,'~',' ')
df5<-str_trim(str_replace_all(df4$df3,'~',' '),side='both')
df6<-data.frame(df2,df5)
df6


## n-gram
mytext<-c('software environment','software  environment',
  'software\tenvironment')
# 공란 제거
sapply(str_split(mytext,' '),length)
lapply(str_split(mytext,' '),length)
mytext_nospace<-str_replace_all(mytext,'[[:space:]]{1,}',' ')
mytext_nospace

sapply(str_split(mytext_nospace,' '),length)
lapply(str_split(mytext_nospace,' '),length)


text<-"The 45th President of the United States, Donald Trump, states that he knows how to play trump with the former president"
myword<-unlist(str_extract_all(text,boundary('word')))
table(myword)
table(tolower(myword))

myword<-str_replace(myword,'Trump','Trump_unique_')
myword<-str_replace(myword,'States','States_unique_')
table(myword)


text2<-c("He is one of statisticians agreeing that R is the No. 1 statistical software.","He is one of statisticians agreeing that R is the No. one statistical software.")
text2
# 숫자 제거 후 단어로 분리
text3<-str_split(str_replace_all(text2,'[[:digit:]]{1,}[[:space:]]{1,}',''),' ')

str_c(text3[[1]],collapse=' ')
str_c(text3[[2]],collapse=' ')
# 숫자 자료임을 표시
str_split(str_replace_all(text2,'[[:digit:]]{1,}[[:space:]]{1,}','_number_'),' ')


text<-c('She is an actor','She is  the actor')
stopword<-'(\\ban )|(\\bthe )'
str_replace_all(text,stopword,'')

library(tm)
length(stopwords('en'))
length(stopwords('SMART'))

# 어근동일화
text<-c('I am a boy. He might be a boy.')
stem.func<-function(textobj){
  text<-str_replace_all(text,'(am)|(are )|(is)|(was)|(were)|(be)','be\\b')
}
stem.func(text)
text



text1<-c('오늘 강남에서 맛있는 스파게티를 먹었다.')
text2<-c('강남에서 먹었던 오늘의 스파게티는 맛있었다.')

str_extract_all(text1,boundary('word'))




text<-"kim et al. (2020) argued that the state of"
str_replace(text,'[[:alpha:]]{1,}[[:space:]]et[[:space:]]al.[[:blank:]]{1}[[:punct:]]{1}[[:digit:]]{4}[[:punct:]]{1}','_reference_')


str_sub(unlist(rwikisent),1,30)
