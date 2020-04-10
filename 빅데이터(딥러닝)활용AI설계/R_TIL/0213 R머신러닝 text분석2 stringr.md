### 'stringr' package 활용 text 분석

```R
install.packages('stringr')  #  -> list 출력
library(stringr)
rwiki<-"R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years.
R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available."

## 1) str_extract(data,'pat')  -> 특정 pat 추출
> str_extract(rwiki,'software environment')
[1] "software environment"
> str_extract_all(rwiki,'software environment')  # -> list 출력
[[1]]
[1] "software environment" "software environment"
> str_extract_all(rwiki,'software environment',simplify=TRUE)   # -> vector 출력
     [,1]                   [,2]                  
[1,] "software environment" "software environment"
> str_extract_all(rwiki,'software_environment|software|environment')
[[1]]
[1] "software"    "environment" "software"   
[4] "software"    "environment"



# 첫글자 대문자 + 0개 이상의 알파벳 추출
> myext<-str_extract_all(rwiki,'[[:upper:]]{1}[[:alpha:]]{0,}')
[[1]]
 [1] "R"           "R"           "Foundation" 
 [4] "Statistical" "Computing"   "The"        
 [7] "R"           "Polls"       "R"          
[10] "R"           "GNU"         "The"        
[13] "R"           "C"           "Fortran"    
[16] "R"           "R"           "GNU"        
[19] "General"     "Public"      "License"    
[22] "While"       "R"         
> table(myext)
myext
          C   Computing     Fortran  Foundation 
          1           1           1           1 
    General         GNU     License       Polls 
          1           2           1           1 
     Public           R Statistical         The 
          1           9           1           2 
      While 
          1 

## 2) str_locate(data,'pat')   ->  특정 pat의 위치 출력
> str_locate(rwiki,'software environment')
     start end
[1,]    33  52
> str_locate_all(rwiki,'software environment')
[[1]]
     start end
[1,]    33  52
[2,]   464 483

# 첫글자 대문자 + 0개 이상의 알파벳 위치
> myloc<-str_locate_all(rwiki,'[[:upper:]]{1}[[:alpha:]]{0,}')
[[1]]
      start end
 [1,]     1   1
 [2,]   110 110
 [3,]   112 121
 [4,]   127 137
 [5,]   139 147
 [6,]   150 152
 [7,]   154 154
 [8,]   271 275
 [9,]   358 358
[10,]   418 418
[11,]   425 427
[12,]   438 440
[13,]   462 462
[14,]   509 509
[15,]   512 518
[16,]   525 525
[17,]   528 528
[18,]   560 562
[19,]   564 570
[20,]   572 577
[21,]   579 585
[22,]   665 669
[23,]   671 671

> mydata<-data.frame(myloc[[1]])
> mydata$myword<-myext[[1]]
> head(mydata)
   start end      myword
1      1   1           R
2    110 110           R
3    112 121  Foundation
4    127 137 Statistical
5    139 147   Computing
6    150 152         The

# 단어의 길이 = 끝 위치-시작위치+1
> mydata$myword.length<-mydata$end-mydata$start+1
> head(mydata)
  start end      myword myword.length
1     1   1           R             1
2   110 110           R             1
3   112 121  Foundation            10
4   127 137 Statistical            11
5   139 147   Computing             9
6   150 152         The             3


## 3) str_replace(data,'oldpat','newpat')  -> 기존 pat를 특정 pat로 변경
> str_replace(rwiki,'software environment','software_environment')
> str_replace_all(rwiki,'software environment','software_environment')

-----------------------------------------

# 문서  ->  문단 
> rwikipara<-str_split(rwiki,'\n')
[[1]]
[1] "R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years."
[2] "R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available."   

## 문단  -> 문장
# '.' 기준 문장 구분
# '.'을 특수문자x, 자연어로 인식
> rwikisent<-str_split(rwikipara[[1]],'\\. ')
[[1]]
[1] "R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing"
[2] "The R language is widely used among statisticians and data miners for developing statistical software and data analysis"                            
[3] "Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years." 
[[2]]
[1] "R is a GNU package"                                      [2] "The source code for the R software environment is written primarily in C, Fortran, and R"                        [3] "R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems"
[4] "While R has a command line interface, there are several graphical front-ends available."


## 문장   ->  단어
> my2sent<-unlist(rwikisent)[c(4,7)]
> strsplit(my2sent[1],split=' ')  # -> 단어 출력
> str_split(my2sent[1],' ')
[[1]]
[1] "R"       "is"      "a"       "GNU"     "package"
> length(unlist(str_split(my2sent[1],' '))) # -> 단어 수 출력
[1] 5
> table(strsplit(my2sent[1],split=' '))  # -> 단어별 수 출력
	  a     GNU      is package       R 
      1       1       1       1       1 

> strsplit(my2sent[2],split=' ')
> str_split(my2sent[2],' ')
[[1]]
 [1] "While"      "R"          "has"       
 [4] "a"          "command"    "line"      
 [7] "interface," "there"      "are"       
[10] "several"    "graphical"  "front-ends"
[13] "available."
> length(unlist(str_split(my2sent[2],' ')))  # -> 단어 수 출력
[1] 13
> table(strsplit(my2sent[2],split=' '))   # -> 단어별 수 출력

         a        are available.    command 
         1          1          1          1 
front-ends  graphical        has interface, 
         1          1          1          1 
      line          R    several      there 
         1          1          1          1 
     While 
         1 


## 4) str_split_fixed(data,'기준',n)   -> 문장을 n개로 분리
> str_split_fixed(my2sent,' ',5)
     [,1]    [,2] [,3]  [,4] 
[1,] "R"     "is" "a"   "GNU"
[2,] "While" "R"  "has" "a"  
     [,5]                                                      [1,] "package"                                                [2,] "command line interface, there are several graphical front-ends available."
> str_split_fixed(my2sent,' ',13)
     [,1]    [,2] [,3]  [,4]  [,5]      [,6]  
[1,] "R"     "is" "a"   "GNU" "package" ""    
[2,] "While" "R"  "has" "a"   "command" "line"
     [,7]         [,8]    [,9]  [,10]    
[1,] ""           ""      ""    ""       
[2,] "interface," "there" "are" "several"
     [,11]       [,12]        [,13]       
[1,] ""          ""           ""          
[2,] "graphical" "front-ends" "available."


# sent * word matrix 만들기
> len.sent<-rep(NA,length(unlist(rwikisent)))

> for(i in 1:length(len.sent)){
  len.sent[i]<-length(unlist(str_split(unlist(rwikisent)[i],' ')))
}
> len.sent    # -> 각 문장 별 단어 갯수
[1] 21 18 21  5 16 20 13
> max.len.sent<-max(len.sent)  # 단어 갯수 중 max

> sent.word.matrix<-str_split_fixed(unlist(rwikisent),' ',max.len.sent)  # 문장을 벡터로 바꾸고 단어 갯수 중 최댓값으로 분리
> mydata<-data.frame(sent.word.matrix)  # df 생성

> rownames(mydata)<-paste('sent',1:length(unlist(rwikisent)),sep='.')
> colnames(mydata)<-paste('word',1:max.len.sent,sep='.')
> mydata
       word.1  word.2   word.3      word.4   word.5
sent.1      R      is        a programming language
sent.2    The       R language          is   widely
sent.3 Polls, surveys       of        data  miners,
sent.4      R      is        a         GNU  package
sent.5    The  source     code         for      the
sent.6      R      is   freely   available    under
sent.7  While       R      has           a  command
       word.6     word.7        word.8    word.9
sent.1    and   software   environment       for
sent.2   used      among statisticians       and
sent.3    and    studies            of scholarly
sent.4                                          
sent.5      R   software   environment        is
sent.6    the        GNU       General    Public
sent.7   line interface,         there       are
 


## 5) str_count(data,'pat')  -> 각 vector별로 특정 pat 갯수출력
> str_count(rwiki,'R')
[1] 9
> str_count(unlist(rwikipara),'R')
[1] 4 5
> str_count(unlist(rwikisent),'R')
[1] 2 1 1 1 2 1 1

# 'R'...'stat'  대소문자 구별 x 단어 갯수 
> str_count(unlist(rwikisent),'R.{1,}stat')
[1] 1 1 0 0 0 0 0

# 'R'과 'stat' 사이에 'R'이 없도록,대소문자 구별 x 단어 갯수
> str_count(unlist(rwikisent),'R[[:lower:][A-Q][S-Z][:digit:][:space:]]{1,}(s|S)tat[[:alpha:]]{1,}')
[1] 2 1 0 0 0 0 0
> str_count(unlist(rwikisent),'R{1}[^R]{1,}(s|S)tat[[:alpha:]]{1,}')
[1] 2 1 0 0 0 0 0


* 정규표현식 * 
 표현식 의미                            동등 표현식
"." 개행을 제외한 모든문자 (공백포함)       [^\n\r]
"\w" 영소문자, 영대문자, 숫자, _(언더바)  [A-Za-z0-9_]
"\d" 숫자, _(언더바)                      [0-9]
"\s" 공백, 탭, 개행
"^"  반대


## 6) str_sub(data,a,b)   ->  data를 a위치부터 b위치까지 출력
> str_sub(unlist(rwikisent),1,30)
[1] "R is a programming language an"
[2] "The R language is widely used "
[3] "Polls, surveys of data miners,"
[4] "R is a GNU package"            
[5] "The source code for the R soft"
[6] "R is freely available under th"
[7] "While R has a command line int"

## 7) str_dup(str,n)   -> str을 n번만큼 합친 후 출력
> str_dup('software',3)
[1] "softwaresoftwaresoftware"
> rep('software',3)
[1] "software" "software" "software"
> paste(rep('software',3),collapse='')
[1] "softwaresoftwaresoftware"


## 8) str_length(data)   ->  글자 수 count
> str_length(unlist(rwikisent))
[1] 147 119 146  18  88 135  87
> nchar(unlist(rwikisent))
[1] 147 119 146  18  88 135  87




## 9) str_pad(data,width= ,side= )    ->  공백 padding
> name<-c('Joe','Jack','Jackie','Jefferson')
> donation<-c('$1','$11','$111','$1111')
> df<-data.frame(name,donation)
> df
       name donation
1       Joe       $1
2      Jack      $11
3    Jackie     $111
4 Jefferson    $1111

# 공백문자를 오른쪽으로 이동
> str_pad(df$name,width=15,side='right')
[1] "Joe            " "Jack           "
[3] "Jackie         " "Jefferson      "

# 가운데정렬
> str_pad(df$name,width=15,side='both')
[1] "      Joe      " "     Jack      "
[3] "    Jackie     " "   Jefferson   "

# 공백 채우기
> str_pad(df$name,width=15,side='both',pad='~')
[1] "~~~~~~Joe~~~~~~" "~~~~~Jack~~~~~~"
[3] "~~~~Jackie~~~~~" "~~~Jefferson~~~"


> df2<-str_pad(df$name,width=15,side='right')
> df3<-str_pad(df$name,width=15,side='both',pad='~')
> df4<-data.frame(df2,df3)
> df4
              df2             df3
1 Joe             ~~~~~~Joe~~~~~~
2 Jack            ~~~~~Jack~~~~~~
3 Jackie          ~~~~Jackie~~~~~
4 Jefferson       ~~~Jefferson~~~
> str_length(df4$df2)
[1] 15 15 15 15



## 10) str_trim(data,side='')    -> side의 공백 제거
> str_trim(df4$df2,side='right')
[1] "Joe"       "Jack"      "Jackie"    "Jefferson"

#  '~' 제거
> str_replace_all(df4$df3,'~',' ')
[1] "      Joe      " "     Jack      "
[3] "    Jackie     " "   Jefferson   "
> df5<-str_trim(str_replace_all(df4$df3,'~',' '),side='both')
> df6<-data.frame(df2,df5)
> df6
              df2       df5
1 Joe                   Joe
2 Jack                 Jack
3 Jackie             Jackie
4 Jefferson       Jefferson

-----------------------------------------------------

mytext<-c('software environment','software  environment',
  'software\tenvironment')
# 공란 제거
> str_split(mytext,' ')
> sapply(str_split(mytext,' '),length)
[1] 2 3 1
> lapply(str_split(mytext,' '),length)
[[1]]
[1] 2
[[2]]
[1] 3
[[3]]
[1] 1

> mytext_nospace<-str_replace_all(mytext,'[[:space:]]{1,}',' ')
[1] "software environment" "software environment"
[3] "software environment"
> sapply(str_split(mytext_nospace,' '),length)
[1] 2 2 2
> lapply(str_split(mytext_nospace,' '),length)
[[1]]
[1] 2
[[2]]
[1] 2
[[3]]
[1] 2

-------------------------------------------------------

> text<-"The 45th President of the United States, Donald Trump, states that he knows how to play trump with the former president"
# 단어'만' 추출
> str_extract_all(text,boundary('word'))
[[1]]
 [1] "The"       "45th"      "President" "of"       
 [5] "the"       "United"    "States"    "Donald"   
 [9] "Trump"     "states"    "that"      "he"       
[13] "knows"     "how"       "to"        "play"     
[17] "trump"     "with"      "the"       "former"   
[21] "president"
> myword<-unlist(str_extract_all(text,boundary('word')))
# 고유명사 처리
> myword<-str_replace(myword,'Trump','Trump_unique_')
> myword<-str_replace(myword,'States','States_unique_')



> text2<-c("He is one of statisticians agreeing that R is the No. 1 statistical software.","He is one of statisticians agreeing that R is the No. one statistical software.")
# 숫자 제거 후 단어로 분리
> text3<-str_split(str_replace_all(text2,'[[:digit:]]{1,}[[:space:]]{1,}',''),' ')
[[1]]
 [1] "He"            "is"            "one"          
 [4] "of"            "statisticians" "agreeing"     
 [7] "that"          "R"             "is"           
[10] "the"           "No."           "statistical"  
[13] "software."    
[[2]]
 [1] "He"            "is"            "one"          
 [4] "of"            "statisticians" "agreeing"     
 [7] "that"          "R"             "is"           
[10] "the"           "No."           "one"          
[13] "statistical"   "software." 

# 다시 문장으로 병합
> str_c(text3[[1]],collapse=' ')
[1] "He is one of statisticians agreeing that R is the No. statistical software."
> str_c(text3[[2]],collapse=' ')
[1] "He is one of statisticians agreeing that R is the No. one statistical software."

# 숫자 자료임을 표시 후 대체
> str_split(str_replace_all(text2,'[[:digit:]]{1,}[[:space:]]{1,}','_number_'),' ')
[[1]]
 [1] "He"                  "is"                 
 [3] "one"                 "of"                 
 [5] "statisticians"       "agreeing"           
 [7] "that"                "R"                  
 [9] "is"                  "the"                
[11] "No."                 "_number_statistical"
[13] "software."          
[[2]]
 [1] "He"            "is"            "one"          
 [4] "of"            "statisticians" "agreeing"     
 [7] "that"          "R"             "is"           
[10] "the"           "No."           "one"          
[13] "statistical"   "software."



> text<-"kim et al. (2020) argued that the state of"
> str_replace(text,'[[:alpha:]]{1,}[[:space:]]et[[:space:]]al.[[:blank:]]{1}[[:punct:]]{1}[[:digit:]]{4}[[:punct:]]{1}','_reference_')
[1] "_reference_ argued that the state of"



## 불용어 처리
> text<-c('She is an actor','She is  the actor')
# 불용어 지정 후 공백까지 제거
> stopword<-'(\\ban )|(\\bthe )'
> str_replace_all(text,stopword,'')
[1] "She is actor"  "She is  actor"


# 어근동일화
> text<-c('I am a boy. He might be a boy.')
> stem.func<-function(textobj){
  text<-str_replace_all(text,'(am)|(are )|(is)|(was)|(were)|(be)','be\\b')
}
> stem.func(text)
> text
[1] "I bea boy. He might bea boy."


```







