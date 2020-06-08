### text 분석

```R
## vector:[] / list:[[]]
> obj1<-1:4
> obj1
[1] 1 2 3 4
> obj2<-6:10
> obj2
[1]  6  7  8  9 10
> obj3<-list(obj1,obj2)
> obj3
[[1]]
[1] 1 2 3 4
[[2]]
[1]  6  7  8  9 10

> mylist<-list(obj1,obj2,obj3)
> mylist
[[1]]
[1] 1 2 3 4
[[2]]
[1]  6  7  8  9 10
[[3]]
[[3]][[1]]
[1] 1 2 3 4
[[3]][[2]]
[1]  6  7  8  9 10

## list 추출 시, []  -> list 추출   / [[]]   -> vector 추출
> mylist[[3]][1]
[[1]]
[1] 1 2 3 4
> mylist[[3]][[1]]
[1] 1 2 3 4
> mylist[[3]][[1]][2]
[1] 2

## unlist()  ->  list를 str type vector로 출력
> mylist<-list(1:6,'a')
> unlist(mylist)
[1] "1" "2" "3" "4" "5" "6" "a"

## unlist()  ->  str data를 하나의 문자 형태로 합칠 때
> name1<-'Donald'
> myspace<-' '
> name2<-'Trump'
> list(name1,myspace,name2)
[[1]]
[1] "Donald"
[[2]]
[1] " "
[[3]]
[1] "Trump"
> unlist(list(name1,myspace,name2))
[1] "Donald" " "      "Trump"

-----------------------------------------------------------

name<-c('갑','을','병','정')
gender<-c(2,1,1,2)
mydata<-data.frame(name,gender)

## attr()  -> metadata 저장/추출
> attr(mydata$name,'what the variable means')<-'응답자 이름'
>  mydata$name
[1] 갑 을 병 정
attr(,"what the variable means")
[1] 응답자 이름
Levels: 갑 병 을 정
> attr(mydata$gender,'what the variable means')<-'응답자 성별'
> mydata$gender
[1] 2 1 1 2
attr(,"what the variable means")
[1] "응답자 성별"

> myvalues<-gender
> for(i in 1:length(gender)){
  myvalues[i]<-ifelse(gender[i]==1,'남성','여성')}
>  myvalues
[1] "여성" "남성" "남성" "여성"

> attr(mydata$gender,'what the value means')<-myvalues
> mydata$gender
[1] 2 1 1 2
attr(,"what the variable means")
[1] "응답자 성별"
attr(,"what the value means")
[1] "여성" "남성" "남성" "여성"



> mydata$gender.cha<-attr(mydata$gender,'what the value means')
> mydata
 name gender gender.cha
1   갑      2       여성
2   을      1       남성
3   병      1       남성
4   정      2       여성


## tapply() 
> wordlist<-c('the','is','a','the')
> df1<-c(3,4,2,4)
> df2<-rep(1,4)
> tapply(df1,wordlist, length)  #df1에서 wordlist에 속한 단어가 등장한 횟수
  a  is the 
  1   1   2 
> tapply(df1,wordlist, sum)  # 가중치 계산
  a  is the 
  2   4   7 
> tapply(df2,wordlist, length) #df2에서 wordlist에 속한 단어가 등장한 횟수
  a  is the 
  1   1   2 
> tapply(df2,wordlist, sum)
  a  is the 
  1   1   2 

## letters[] ->  알파벳 출력
> letters[1:5]
[1] "a" "b" "c" "d" "e"
> LETTERS[1:3]
[1] "A" "B" "C"


## nchar()   ->문자 갯수 count
> nchar('korea')
[1] 5
> nchar('korea',type='bytes')
[1] 5
> nchar('한국')
[1] 2
> nchar('한국',type='bytes')
[1] 4
> nchar('korea ')
[1] 6
> nchar('korea\t')
[1] 6
> nchar('korea\t',type='bytes')
[1] 6
> nchar('korea, 
      Republic of')


### text 분석
> myvec<-c(1:6,'a')
> mylist<-list(1:6,'a')
> myvec
[1] "1" "2" "3" "4" "5" "6" "a"
> mylist
[[1]]
[1] 1 2 3 4 5 6
[[2]]
[1] "a"

> obj1<-1:4
> obj1
[1] 1 2 3 4
> obj2<-6:10
> obj3<-list(obj1,obj2)
> obj3
[[1]]
[1] 1 2 3 4
[[2]]
[1]  6  7  8  9 10

> mylist<-list(obj1,obj2,obj3)
> mylist
[[1]]
[1] 1 2 3 4
[[2]]
[1]  6  7  8  9 10
[[3]]
[[3]][[1]]
[1] 1 2 3 4
[[3]][[2]]
[1]  6  7  8  9 10


> mylist[[3]][1]
[[1]]
[1] 1 2 3 4

> mylist[[3]][[1]]
[1] 1 2 3 4
> obj2
[1]  6  7  8  9 10
> mylist[[3]]
[[1]]
[1] 1 2 3 4
[[2]]
[1]  6  7  8  9 10

> mylist[[3]][[1]][2]
[1] 2
## unlist()   ->  list를  vector로 출력
> mylist<-list(1:6,'a')
> unlist(mylist)
[1] "1" "2" "3" "4" "5" "6" "a"
> mylist[[1]]
[1] 1 2 3 4 5 6
> mylist[[1]][1:6]
[1] 1 2 3 4 5 6
> mean(mylist[[1]][1:6])
[1] 3.5
> unlist(mylist)[1:6]
[1] "1" "2" "3" "4" "5" "6"
> name1<-'Donald'
> myspace<-' '
> name2<-'Trump'
> list(name1,myspace,name2)
[[1]]
[1] "Donald"
[[2]]
[1] " "
[[3]]
[1] "Trump"

> unlist(list(name1,myspace,name2))
[1] "Donald" " "      "Trump" 
> name<-c('갑','을','병','정')
> gender<-c(2,1,1,2)
> mydata<-data.frame(name,gender)
> mydata
  name gender
1   갑      2
2   을      1
3   병      1
4   정      2
> # attr()  -> 속성 저장/추출
> attr(mydata$name,'what the variable means')<-'응답자 이름름'
> # attr()  -> 속성 저장/추출
> attr(mydata$name,'what the variable means')<-'응답자 이름'
> mydata$name
[1] 갑 을 병 정
attr(,"what the variable means")
[1] 응답자 이름
Levels: 갑 병 을 정
> attr(mydata$gender,'what the variable means')<-'응답자 성별별'
> attr(mydata$gender,'what the variable means')<-'응답자 성별'
> mydata$gender
[1] 2 1 1 2
attr(,"what the variable means")
[1] "응답자 성별"
> myvalues<-gender
> for(i in 1:length(gender)){
+   myvalues[i]<-ifelse(gender[i]==1,'남성','여성')
+ }
> myvalues
[1] "여성" "남성" "남성" "여성"
> attr(mydata$gender,'what the value means')<-myvalues
> mydata$gender
[1] 2 1 1 2
attr(,"what the variable means")
[1] "응답자 성별"
attr(,"what the value means")
[1] "여성" "남성" "남성" "여성"
> mydata$gender.cha<-attr(mydata$gender,'what the value means')
> mydata
  name gender gender.cha
1   갑      2       여성
2   을      1       남성
3   병      1       남성
4   정      2       여성
> mylist<-list(1:4,6:10,list(1:4,6:10))
> mylist
[[1]]
[1] 1 2 3 4
[[2]]
[1]  6  7  8  9 10
[[3]]
[[3]][[1]]
[1] 1 2 3 4
[[3]][[2]]
[1]  6  7  8  9 10


> lapply(mylist[[3]],mean)
[[1]]
[1] 2.5
[[2]]
[1] 8

> df1<-c(3,4,5,6)
경고메시지(들): 
In mget(objectNames, envir = ns, inherits = TRUE) :
  strings not representable in native encoding will be translated to UTF-8


## tapply()   -> text data에 사용
> wordlist<-c('the','is','a','the')
> df2<-rep(1,4)
> df1<-c(3,4,2,4)
> tapply(df1,wordlist, length)
  a  is the 
  1   1   2 
> tapply(df2,wordlist, length)
  a  is the 
  1   1   2 
> tapply(df2,wordlist, sum)
  a  is the 
  1   1   2 
> tapply(df1,wordlist, sum)
  a  is the 
  2   4   7 
> tapply(df2,wordlist, length)
  a  is the 
  1   1   2 
> tapply(df2,wordlist, sum)
  a  is the 
  1   1   2 
> tapply(df1,wordlist, sum)
  a  is the 
  2   4   7 
> tapply(df2,wordlist, length)
  a  is the 
  1   1   2 
> tapply(df2,wordlist, sum)
  a  is the 
  1   1   2 
> df1<-c(3,4,2,4)
> df2<-rep(1,4)
> tapply(df2,wordlist, length)
  a  is the 
  1   1   2 


## letters[] / LETTERS[]   -> 알파벳 출력 함수
> letters[3]
[1] "c"
> LETTERS[3]
[1] "C"
> letters[1:5]
[1] "a" "b" "c" "d" "e"
> LETTERS[1:3]
[1] "A" "B" "C"



## nchar()   -> 문자 갯수 count
> nchar('korea')
[1] 5
> nchar('korea\t',type='bytes')
[1] 6
> nchar('한국')
[1] 2
> nchar('한국',type='bytes')
[1] 4
> nchar('korea, Republic of')
[1] 18
> nchar('korea, 
+       Republic of')
[1] 25
> nchar('korea, \nRepublic of')
[1] 19
> nchar('korea ')
[1] 6
> nchar('korea\t')
[1] 6

-----------------------------------------------------------

## strsplit(data,split='기준')   -> 문장을 단어로 분리 / 단어를 문자로 분해
> mysentence<-'Learning R is so interesting'
> strsplit(mysentence,split=' ')
[[1]]
[1] "Learning"    "R"           "is"         
[4] "so"          "interesting"

> mywords<-strsplit(mysentence,split=' ')
> strsplit(mywords[[1]][5],split='')
[[1]]
 [1] "i" "n" "t" "e" "r" "e" "s" "t" "i" "n"
[11] "g"

> myletters<-list(rep(NA,5))
> for(i in 1:5){
  myletters[i]<-strsplit(mywords[[1]][i],split='')}
> myletters
[[1]]
[1] "L" "e" "a" "r" "n" "i" "n" "g"
[[2]]
[1] "R"
[[3]]
[1] "i" "s"
[[4]]
[1] "s" "o"
[[5]]
 [1] "i" "n" "t" "e" "r" "e" "s" "t" "i" "n"
[11] "g"

## paste(data,collapse='기준')   -> 문자를 단어로 병합 / 단어를 문장으로 병합
> paste(myletters[[1]],collapse='#')
[1] "L#e#a#r#n#i#n#g"
> paste(myletters[[1]],collapse='')
[1] "Learning"

> mywords2<-list(rep(NA,5))
> for(i in 1:5){
+   mywords2[i]<-paste(myletters[[i]],collapse='')
+ }
> mywords2
[[1]]
[1] "Learning"
[[2]]
[1] "R"
[[3]]
[1] "is"
[[4]]
[1] "so"
[[5]]
[1] "interesting"

> paste(mywords2,collapse=' ')
[1] "Learning R is so interesting"

-----------------------------------------------------------

> rwiki<-"R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years.
+ R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available."

## 문서 -> 문단
> rwikipara<-strsplit(rwiki,split='\n')
[[1]]
[1] "R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years."
[2] "R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available." 

## 문단 -> 문장
> rwikisent<-strsplit(rwikipara[[1]],split='\\.')
# '.'을 특수문자x, 자연어로 인식
[[1]]
[1] "R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing"
[2] " The R language is widely used among statisticians and data miners for developing statistical software and data analysis"                           
[3] " Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years" 

[[2]]
[1] "R is a GNU package"                                    [2] " The source code for the R software environment is written primarily in C, Fortran, and R"                      [3] " R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems"
[4] " While R has a command line interface, there are several graphical front-ends available" 

## 문장 -> 단어
> rwikiword<-list(NA,NA)
> for(i in 1:2){
+   rwikiword[[i]]<-strsplit(rwikisent[[i]],split=' ')}
> rwikiword
[[1]]
[[1]][[1]]
 [1] "R"           "is"          "a"          
 [4] "programming" "language"    "and"        
 [7] "software"    "environment" "for"        
[10] "statistical" "computing"   "and"        
[13] "graphics"    "supported"   "by"         
[16] "the"         "R"           "Foundation" 
[19] "for"         "Statistical" "Computing"  
[[1]][[2]]
 [1] ""              "The"          
 [3] "R"             "language"     
 [5] "is"            "widely"       
 [7] "used"          "among"        
 [9] "statisticians" "and"          
[11] "data"          "miners"       
[13] "for"           "developing"   
[15] "statistical"   "software"     
[17] "and"           "data"         
[19] "analysis"     
[[1]][[3]]
 [1] ""              "Polls,"       
 [3] "surveys"       "of"           
 [5] "data"          "miners,"      
 [7] "and"           "studies"      
 [9] "of"            "scholarly"    
[11] "literature"    "databases"    
[13] "show"          "that"         
[15] "R's"           "popularity"   
[17] "has"           "increased"    
[19] "substantially" "in"           
[21] "recent"        "years"        

[[2]]
[[2]][[1]]
[1] "R"       "is"      "a"       "GNU"    
[5] "package"
[[2]][[2]]
 [1] ""            "The"         "source"     
 [4] "code"        "for"         "the"        
 [7] "R"           "software"    "environment"
[10] "is"          "written"     "primarily"  
[13] "in"          "C,"          "Fortran,"   
[16] "and"         "R"          
[[2]][[3]]
 [1] ""             "R"           
 [3] "is"           "freely"      
 [5] "available"    "under"       
 [7] "the"          "GNU"         
 [9] "General"      "Public"      
[11] "License,"     "and"         
[13] "pre-compiled" "binary"      
[15] "versions"     "are"         
[17] "provided"     "for"         
[19] "various"      "operating"   
[21] "systems"     
[[2]][[4]]
 [1] ""           "While"      "R"         
 [4] "has"        "a"          "command"   
 [7] "line"       "interface," "there"     
[10] "are"        "several"    "graphical" 
[13] "front-ends" "available"

> rwikiword[[1]][[2]][4]
[1] "language"

----------------------------------------------------------

### 특정 pattern 찾기 & 위치 출력

## 1) regexpr('pattern',data)  -> pat이 처음 등장하는 위치 출력
mysentence<-'Learning R is so interesting'
> regexpr('ing',mysentence)
[1] 6
attr(,"match.length")
[1] 3
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE

> as.vector(regexpr('ing',mysentence))
[1] 6    # pattern이 처음 등장하는 위치
> attr(regexpr('ing',mysentence),"match.length")
[1] 3    # pattern의 길이
> as.vector(regexpr('ing',mysentence))+attr(regexpr('ing',mysentence),"match.length")-1   # pattern이 끝나는 위치
[1] 8


mysentences<-unlist(rwikisent)
> regexpr('software',mysentences)
[1] 33 95 -1 -1 28 -1 -1    # -1 : 해당 pattern 없음
attr(,"match.length")
[1]  8  8 -1 -1  8 -1 -1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE



## 2) gregexpr()  -> pat이 등장하는 모든 위치 출력
> gregexpr('ing',mysentence)
[[1]]
[1]  6 26    # pattern이 등장하는 모든 위치
attr(,"match.length")
[1] 3 3      # pattern의 길이
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE

> as.vector(gregexpr('ing',mysentence)[[1]])
[1]  6 26    # pattern이 등장하는 모든 위치
> attr(gregexpr('ing',mysentence)[[1]],"match.length")
[1] 3 3      # pattern의 길이
> length(gregexpr('ing',mysentence)[[1]])
[1] 2   # pattern 등장 횟수
> as.vector(gregexpr('ing',mysentence)[[1]])+attr(gregexpr('ing',mysentence)[[1]],"match.length")-1
[1]  8 28      # pattern이 끝나는 위치

mysentences<-unlist(rwikisent)
> gregexpr('software',mysentences)
[[1]]
[1] 33
attr(,"match.length")
[1] 8
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
[[2]]
[1] 95
attr(,"match.length")
[1] 8
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
[[3]]
[1] -1
attr(,"match.length")
[1] -1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
[[4]]
[1] -1
attr(,"match.length")
[1] -1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
[[5]]
[1] 28
attr(,"match.length")
[1] 8
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
[[6]]
[1] -1
attr(,"match.length")
[1] -1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
[[7]]
[1] -1
attr(,"match.length")
[1] -1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE



## 3) regexec()   -> 'pattern',()로 지정한 pat의 모든 위치출력
> regexec('interestin(g)',mysentence)
[[1]]
[1] 18 28   # 'pattern',()로 지정한 pattern이 등장하는 모든 위치
attr(,"match.length")
[1] 11  1     # 'pattern',()로 지정한 pattern의 길이
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE

> regexec('so (interestin(g))',mysentence)
[[1]]
[1] 15 18 28   # 'pattern',()로 지정한 pattern이 등장하는 모든 위치
attr(,"match.length")
[1] 14 11  1    # 'pattern',()로 지정한 pattern의 길이
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE


## 4) grep('pat',data)    -> 특정 pat의 위치 출력
##    grepl('pat',data)   -> 특정 pat가 text에 있는지 확인
> grep('software',mysentences)
[1] 1 2 5
> grepl('software',mysentences)
[1]  TRUE  TRUE FALSE FALSE  TRUE FALSE FALSE


## 5) substr(data,a,b)    -> data에서 a위치~b위치까지 출력
> substr(mysentence,1,20)
[1] "Learning R is so int"
> substr(mysentences,1,20)
[1] "R is a programming l"
[2] " The R language is w"
[3] " Polls, surveys of d"
[4] "R is a GNU package"  
[5] " The source code for"
[6] " R is freely availab"
[7] " While R has a comma"

## 6) regmatches(data, 'pat')   -> 특정 pat 출력
> mypat<-regexpr('ing',mysentence)
> regmatches(mysentence,mypat)
[1] "ing"
> mypat<-gregexpr('ing',mysentence)
> regmatches(mysentence,mypat)
[[1]]
[1] "ing" "ing"

# invert   ->  반대로
> mypat<-regexpr('ing',mysentence)
> regmatches(mysentence,mypat,invert=TRUE)
[[1]]
[1] "Learn"               
[2] " R is so interesting"

> mypat<-gregexpr('ing',mysentence)
> regmatches(mysentence,mypat,invert=TRUE)
[[1]]
[1] "Learn"             " R is so interest"
[3] ""    

# "" 없애고 출력
> strsplit(mysentence,split='ing')
[[1]]
[1] "Learn"             " R is so interest"



# matrix 만들기
> mytemp<-regexpr('software',mysentences)
[1] 33 95 -1 -1 28 -1 -1

> my.begin<-as.vector(mytemp)
> my.begin[my.begin==-1]<-NA
> my.begin
[1] 33 95 NA NA 28 NA NA

> my.end<-my.begin+attr(mytemp,'match.length')-1
> my.end
[1]  40 102  NA  NA  35  NA  NA


> mylocs<-matrix(NA,nrow=length(my.begin),ncol=2)
> colnames(mylocs)<-c('begin','end')
> rownames(mylocs)<-paste('sentence',1:length(my.begin),sep='.')

> for(i in 1:length(my.begin)){
+   mylocs[i,]<-cbind(my.begin[i],my.end[i])
+ }
> mylocs
           begin end
sentence.1    33  40
sentence.2    95 102
sentence.3    NA  NA
sentence.4    NA  NA
sentence.5    28  35
sentence.6    NA  NA
sentence.7    NA  NA

----------------------------------------------------------
### 문자열 대체 함수

## 1) sub(oldpat,newpat,data)  -> 처음 위치의 특정 문자열 대체
> sub('ing','ING',mysentence)
[1] "LearnING R is so interesting"

## 2) gsub(oldpat,newpat,data)  ->  data 전체에서 특정 문자열 대체
> gsub('ing','ING',mysentence)
[1] "LearnING R is so interestING"

## 2-1)gsub('pat','',data)   -> 특정 pat 제거
> gsub('ing','',mysentence)
[1] "Learn R is so interest"

----------------------------------------------------------

### 고유명사 처리
> sent1<-rwikisent[[1]][1]
> new.sent1<-gsub('R Foundation for Statistical Computing','R_Foundation_for_Statistical_Computing',sent1)
> new.sent1
[1] "R is a programming language and software environment for statistical computing and graphics supported by the R_Foundation_for_Statistical_Computing"

# 각 단어의 횟수 출력
> table(strsplit(sent1,split=' ')))  
> table(strsplit(new.sent1,split=' '))

# 단어의 총 갯수 출력
> sum(table(strsplit(sent1,split=' ')))
[1] 21
> sum(table(strsplit(new.sent1,split=' ')))
[1] 17


### 불용어 제거
> drop.sent1<-gsub('and|by|for|the','',new.sent1)
> drop.sent1
[1] "R is a programming language  software environment  statistical computing  graphics supported   R_Foundation__Statistical_Computing"
> sum(table(strsplit(drop.sent1,split=' ')))
[1] 17

-----------------------------------------------------------

> my2sentences<-c('Learning R is so interesting',
+                 'He is a fascinating singer')
> gregexpr('ing',my2sentences)
[[1]]
[1]  6 26
attr(,"match.length")
[1] 3 3
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE

[[2]]
[1] 17 22
attr(,"match.length")
[1] 3 3
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE


> mypat0<-gregexpr('ing',my2sentences)
> regmatches(my2sentences,mypat0)
[[1]]
[1] "ing" "ing"

[[2]]
[1] "ing" "ing"


# pat이 포함된 문자의 앞의 문자 확인
> mypat1<-gregexpr('[[:alpha:]]+(ing)',my2sentences)
> regmatches(my2sentences,mypat1)
[[1]]
[1] "Learning"    "interesting"
[[2]]
[1] "fascinating" "sing"  


# '\\b'     ->   pat로 끝나는 단어 추출
> mypat2<-gregexpr('[[:alpha:]]+(ing)\\b',my2sentences)
> regmatches(my2sentences,mypat2)
[[1]]
[1] "Learning"    "interesting"

[[2]]
[1] "fascinating"


# 모든 문장에 대해 pat로 끝나는 단어 추출
> mypat3<-gregexpr('[[:alpha:]]+(ing)\\b',mysentences)
> myings<-regmatches(mysentences,mypat3)
[[1]]
[1] "programming" "computing"   "Computing"  
[[2]]
[1] "developing"
[[3]]
character(0)
[[4]]
character(0)
[[5]]
character(0)
[[6]]
[1] "operating"
[[7]]
character(0)

> unlist(myings)
[1] "programming" "computing"   "Computing"  
[4] "developing"  "operating"  


# 모든 문서에 대해 pat로 끝나는 단어 추출/빈도 수
> table(unlist(myings))   # computing 2개-> 소문자 전환 필요

  computing   Computing  developing 
          1           1           1 
  operating programming 
          1           1

> mypatall<-gregexpr('[[:alpha:]]+(ing)\\b',tolower(mysentences))
> myings<-regmatches(tolower(mysentences),mypatall)
> table(unlist(myings))

  computing  developing   operating 
          2           1           1 
programming 
          1 



# 모든 문서에 대해 stat로 시작하는 단어 추출/빈도 수
> mypatall<-gregexpr('(stat)[[:alpha:]]+',tolower(mysentences))
> regmatches(tolower(mysentences),mypatall)
[[1]]
[1] "statistical" "statistical"
[[2]]
[1] "statisticians" "statistical"  
[[3]]
character(0)
[[4]]
character(0)
[[5]]
character(0)
[[6]]
character(0)
[[7]]
character(0)

> mystats<-regmatches(tolower(mysentences),mypatall)
> table(unlist(mystats))

  statistical statisticians 
            3             1 


# 모든 문서에서 대문자만 추출/빈도 수
myuppat<-gregexpr('[[:upper:]]',mysentences)
my.up<-regmatches(mysentences,myuppat)
table(unlist(my.up))
C F G L N P R S T U W 
2 2 3 1 2 2 9 1 2 2 1 

# 모든 문서에서 소문자만 추출/빈도 수
> mylowpat<-gregexpr('[[:lower:]]',mysentences)
> my.low<-regmatches(mysentences,mylowpat)
> table(unlist(my.low))
 a  b  c  d  e  f  g  h  i  k  l  m  n  o  p 
71  7 18 25 61 13 14 14 50  1 29 14 44 34 16 
 r  s  t  u  v  w  y 
46 49 45 16 10  6 12 


# 모든 문서에서 알파벳별 사용 횟수
> myalppat<-gregexpr('[[:upper:]]',toupper(mysentences))
> my.alps<-regmatches(toupper(mysentences),myalppat)
> table(unlist(my.alps))

 A  B  C  D  E  F  G  H  I  K  L  M  N  O  P 
71  7 20 25 61 15 17 14 50  1 30 14 46 34 18 
 R  S  T  U  V  W  Y 
55 50 47 18 10  7 12

# 모든 문서에서 가장 많이 사용된 알파벳
maxalps<-table(unlist(my.alps))
maxalps[maxalps==max(maxalps)]
 A 
71 

# 모든 문서에서 사용된 알파벳의 총 갯수
> sum(maxalps)
[1] 622

# 시각화
> library(ggplot2)
> alpdata<-data.frame(maxalps)
> ggplot(alpdata,aes(x=Var1,y=Freq,fill=Var1))+
  geom_bar(stat='identity')+
  guides(fill=FALSE)+
  geom_hline(aes(yintercept=median(maxalps)))+
  xlab('alphabet')+ylab('빈도수')

```

