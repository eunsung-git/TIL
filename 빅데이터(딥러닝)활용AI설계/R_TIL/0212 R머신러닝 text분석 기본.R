# text 분석
myvec<-c(1:6,'a')
mylist<-list(1:6,'a')
myvec
mylist

obj1<-1:4
obj1
obj2<-6:10
obj2
obj3<-list(obj1,obj2)
obj3

mylist<-list(obj1,obj2,obj3)
mylist
# vector:[] / list:[[]]

mylist[[3]][1]
mylist[[3]][[1]]

mylist[[3]][[1]][2]

# list -> vector  -> unlist()
mylist<-list(1:6,'a')
unlist(mylist)

# str data를 하나의 문자 형태로 합칠 때
name1<-'Donald'
myspace<-' '
name2<-'Trump'
unlist(list(name1,myspace,name2))

name<-c('갑','을','병','정')
gender<-c(2,1,1,2)
mydata<-data.frame(name,gender)
mydata
# attr()  -> metadata 저장/추출
attr(mydata$name,'what the variable means')<-'응답자 이름'
mydata$name
attr(mydata$gender,'what the variable means')<-'응답자 성별'
mydata$gender

myvalues<-gender
for(i in 1:length(gender)){
  myvalues[i]<-ifelse(gender[i]==1,'남성','여성')
}
myvalues

attr(mydata$gender,'what the value means')<-myvalues
mydata$gender

mydata$gender.cha<-attr(mydata$gender,'what the value means')
mydata




mylist<-list(1:4,6:10,list(1:4,6:10))
mylist
lapply(mylist[[3]],mean)


# tapply()   -> text data에 사용
wordlist<-c('the','is','a','the')
df1<-c(3,4,2,4)
df2<-rep(1,4)
tapply(df1,wordlist, length)
tapply(df1,wordlist, sum)
tapply(df2,wordlist, length)
tapply(df2,wordlist, sum)


# letters[]  알파벳 출력
letters[3]
LETTERS[3]

letters[1:5]
LETTERS[1:3]

#nchar()   ->문자 갯수 count
nchar('korea')
nchar('한국',type='bytes')
nchar('korea\t',type='bytes')
nchar('korea, \nRepublic of')


# strsplit()   -> 문장을 단어로 분리
mysentence<-'Learning R is so interesting'
strsplit(mysentence,split=' ')

# 단어를 문자로 분해
mywords<-strsplit(mysentence,split=' ')
strsplit(mywords[[1]][5],split='')

myletters<-list(rep(NA,5))
for(i in 1:5){
  myletters[i]<-strsplit(mywords[[1]][i],split='')
}
myletters

# paste()   -> 문자를 단어로 병합
paste(myletters[[1]],collapse='')

mywords2<-list(rep(NA,5))
for(i in 1:5){
  mywords2[i]<-paste(myletters[[i]],collapse='')
}
mywords2

paste(mywords2,collapse=' ')



rwiki<-"R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years.
R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available."
# 문서 -> 문단
rwikipara<-strsplit(rwiki,split='\n')
# 문단 -> 문장
rwikisent<-strsplit(rwikipara[[1]],split='\\.')

# 문장 -> 단어
rwikiword<-list(NA,NA)
for(i in 1:2){
  rwikiword[[i]]<-strsplit(rwikisent[[i]],split=' ')}
rwikiword

rwikiword[[1]][[2]][4]


# 단어 -> 문자
# regexpr()  -> 처음 등장하는 text의 위치 출력
mysentence<-'Learning R is so interesting'
as.vector(regexpr('ing',mysentence))
attr(regexpr('ing',mysentence),"match.length")

# gregexpr(mysentence)  -> pattern이 등장하는 모든 text 위치 출력
gregexpr('ing',mysentence)
gregexpr(mysentence)
length(gregexpr('ing',mysentence)[[1]])

as.vector(gregexpr('ing',mysentence)[[1]])
attr(gregexpr('ing',mysentence)[[1]],"match.length")

as.vector(regexpr('ing',mysentence))+attr(regexpr('ing',mysentence),"match.length")-1
as.vector(gregexpr('ing',mysentence)[[1]])+attr(gregexpr('ing',mysentence)[[1]],"match.length")-1

# regexec()   -> 
regexec('interestin(g)',mysentence)
regexec('so (interestin(g))',mysentence)


mysentences<-unlist(rwikisent)
regexpr('software',mysentences)
gregexpr('software',mysentences)


sub('ing','ING',mysentence)
gsub('ing','ING',mysentence)


mysentences<-unlist(rwikisent)

mytemp<-regexpr('software',mysentences)

my.begin<-as.vector(regexpr('software',mysentences))
my.begin[my.begin==-1]<-NA


my.end<-my.begin+attr(mytemp,'match.length')-1
my.end


length(my.begin)
mylocs<-matrix(NA,nrow=length(my.begin),ncol=2)
colnames(mylocs)<-c('begin','end')

rownames(mylocs)<-paste('sentence',1:length(my.begin),sep='.')
mylocs


for(i in 1:length(my.begin)){
  mylocs[i,]<-cbind(my.begin[i],my.end[i])}
mylocs




# grep()  -> 특정 pat의 위치 출력인
# grepl()   -> 특정 pat가 text에 있는지 확인
mysentences

grep('software',mysentences)
grepl('software',mysentences)


# 고유명사 처리
sent1<-rwikisent[[1]][1]
new.sent1<-gsub('R Foundation for Statistical Computing','R_Foundation_for_Statistical_Computing',sent1)
sum(table(strsplit(sent1,split=' ')))
sum(table(strsplit(new.sent1,split=' ')))


new.sent1


# 불필요한 단어 제거
drop.sent1<-gsub('and|by|for|the','',new.sent1)
drop.sent1
sum(table(strsplit(drop.sent1,split=' ')))

#
mypat<-regexpr('ing',mysentence)
regmatches(mysentence,mypat)

mypat<-gregexpr('ing',mysentence)
regmatches(mysentence,mypat)


# invert -> 반대표현
mypat<-regexpr('ing',mysentence)
regmatches(mysentence,mypat,invert=TRUE)

mypat<-gregexpr('ing',mysentence)
regmatches(mysentence,mypat,invert=TRUE)

strsplit(mysentence,split='ing')
gsub('ing','',mysentence)

substr(mysentence,1,20)
substr(mysentences,1,20)


my2sentences<-c('Learning R is so interesting',
                'He is a fascinating singer')
mypat0<-gregexpr('ing',my2sentences)
regmatches(my2sentences,mypat0)


#pat앞의 문자 확인
mypat1<-gregexpr('[[:alpha:]]+(ing)',my2sentences)
regmatches(my2sentences,mypat1)



mypat2<-gregexpr('[[:alpha:]]+(ing)\\b',my2sentences)
regmatches(my2sentences,mypat2)

# 모든 문장에 대해 pat로 끝나는 단어 추출
mypat3<-gregexpr('[[:alpha:]]+(ing)\\b',mysentences)
myings<-regmatches(mysentences,mypat3)
unlist(myings)
table(unlist(myings))


#
mypatall<-gregexpr('[[:alpha:]]+(ing)\\b',tolower(mysentences))
myings<-regmatches(tolower(mysentences),mypatall)
table(unlist(myings))





# 
mypatall<-gregexpr('(stat)[[:alpha:]]+',tolower(mysentences))
regmatches(tolower(mysentences),mypatall)

# 대문자만 출력
myuppat<-gregexpr('[[:upper:]]',mysentences)
my.up<-regmatches(mysentences,myuppat)
table(unlist(my.up))

# 소문자만 출력
mylowpat<-gregexpr('[[:lower:]]',mysentences)
my.low<-regmatches(mysentences,mylowpat)
table(unlist(my.low))

myalppat<-gregexpr('[[:upper:]]',toupper(mysentences))
my.alps<-regmatches(toupper(mysentences),myalppat)
maxalps<-table(unlist(my.alps))
maxalps[maxalps==max(maxalps)]
sum(maxalps)



library(ggplot2)
alpdata<-data.frame(maxalps)
ggplot(alpdata,aes(x=Var1,y=Freq,fill=Var1))+
  geom_bar(stat='identity')+
  geom_hline(aes(yintercept=median(maxalps)))+
  xlab('alphabet')+ylab('빈도수')
