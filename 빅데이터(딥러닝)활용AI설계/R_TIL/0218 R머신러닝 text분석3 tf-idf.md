C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/논문data/ymback_papers/



```R
## corpus 생성

library(tm)
text_loc<-'C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/논문data/ymbaek_papers'
# DirSource('경로')   ->  경로 설정
paper<-VCorpus(DirSource(text_loc))
> paper[[2]]$content   # 내용 보기
> paper[[2]]$meta
 author       : character(0)
  datetimestamp: 2020-02-18 01:14:13
  description  : character(0)
  heading      : character(0)
  id           : p2009b.txt
  language     : en
  origin       : character(0)

# meta()   -> metadata 구성
> meta(paper[[2]],tag='author')<-'g.d.hong'
> paper[[2]]$meta
 author       : g.d.hong


# 특수문자 앞뒤의 단어 추출
library(stringr)
> myfunc<-function(x){
  str_extract_all(x,'[[:alnum:]]{1,}[[:punct:]]{1}[[:alnum:]]{1,}')
}
> punct<-lapply(paper,myfunc)
> table(unlist(punct))
             and/or  anxious-ambivalent 
                  2                   1 
        blue-collar       co-activation 
                  1                   1 
      co-constraint        co-emergence 
                  1                   1 
      
# 수치 data 추출
> myfunc<-function(x){
  digit<-str_extract_all(x,'[[:digit:]]{1,}')
}
> digit<-lapply(paper,myfunc)
> table(unlist(digit))
   1   11 1973    2 2002 2003 2004 2007 2008 2012 
   9    1    1    9    1    1    1    1    2    2 
2028    3   35    4  712  756   78   82    9 
   1    7    1    2    1    1    1    1    1 

# 고유명사 추출
> myfunc<-function(x){
  uppers<-str_extract_all(x,'[[:upper:]]{1}[[:alpha:]]{1,}')
}
> uppers<-lapply(paper,myfunc)
> table(unlist(uppers))
     Abstract        Action  Additionally 
            1             1             1 
    Affective   Affirmative       African 
            3             1             1 
         AIMS      Although   Ambivalence 
            1             2             1 


## 특정 pat 대체하기
tempfunc<-function(obj,oldexp,newexp){
  newobj<-tm_map(obj,content_transformer(
    function(x,pat) gsub(pat,newexp,x)),oldexp)
  newobj
}
corpus<-tempfunc(paper,'e\\.g\\.','for example')
corpus<-tempfunc(paper,'and/or','and or')
corpus<-tempfunc(paper,'-collar','collar')

## text 전처리
corpus<-tm_map(paper,removeNumbers)
corpus<-tm_map(corpus,removePunctuation)
corpus<-tm_map(corpus,stripWhitespace)
corpus<-tm_map(corpus,content_transformer(tolower))
corpus<-tm_map(corpus,removewords,words=stopwords('SMART'))
corpus<-tm_map(corpus,stemDocument,language='en')
      

# 전처리 전 문자 갯수 계산
> charfunc<-function(x){
  str_extract_all(x,'.')
}
> char<-lapply(paper,charfunc)
> uniquechar<-length(table(unlist(char)))
[1] 79
> totalchar<-sum(table(unlist(char)))
[1] 24765 
> c(uniquechar,totalchar)
[1]    79 24765
      

# 전처리 전 단어 갯수 계산
>  wordfunc<-function(x){
  str_extract_all(x,boundary('word'))
}
> word<-lapply(paper,wordfunc)
> uniqueword<-length(table(unlist(word)))
[1] 1151      
> totalword<-sum(table(unlist(word)))
[1] 3504
> c(uniqueword,totalword)
[1] 1151 3504
      

# 전처리 후와 비교
> char<-lapply(corpus,charfunc)
> uniquechar_new<-length(table(unlist(char)))
>  totalchar_new<-sum(table(unlist(char)))
> c(uniquechar_new,totalchar_new)
[1]  41 14872

> word<-lapply(corpus,wordfunc)
> uniqueword_new<-length(table(unlist(word)))
> totalword_new<-sum(table(unlist(word)))
> c(uniqueword_new,totalword_new)
[1]  725 2117
      
# 결과 비교 matrix 생성
> result<-rbind(c(uniquechar,totalchar),
              c(uniqueword,totalword),
              c(uniquechar_new,totalchar_new),
              c(uniqueword_new,totalword_new))
> colnames(result)<-c('before','after')
> rownames(result)<-c('문자갯수','총문자갯수','단어갯수','총단어갯수')
           before after
문자갯수       79 24765
총문자갯수   1151  3504
단어갯수       41 14872
총단어갯수    725  2117

      
## corpus dtm 생성
> dtm<-DocumentTermMatrix(corpus)
<<DocumentTermMatrix (documents: 24, terms: 717)>>
Non-/sparse entries: 1422/15786
Sparsity           : 92%
Maximal term length: 18
Weighting          : term frequency (tf)

> inspect(dtm[1:3,50:52])      
          Terms
Docs         andor anger annenberg
  p2009a.txt     0     0         0
  p2009b.txt     0     0         1
  p2010a.txt     0     0         0
      

```



#### TF-IDF

> TF-IDF (토픽모델링)  :  dtm 단어들의 중요도를 가중치로 표기
>
> 
>
> 문서 : d  / 단어 : t  / 문서 갯수 : n
>
> * TF-IDF   = TF x IDF
>
> * TF(d,t)    ->  문서 d의 특정 단어 t 등장 횟수
>
> * DF(t)   ->  특정 단어 t가 등장한 문서의 갯수
>
> * IDF(d,t)   =   log( n / (1+df(t)) )
>
> TF-IDF ~ 중요도



```R
## TF-IDF (토픽 모델링)
> dtm_tfidf<-DocumentTermMatrix(corpus,
                   control=list(weighting=function(x) weightTfIdf(x,normalize=FALSE)))
> inspect(dtm_tfidf[1:3,50:53])
<<DocumentTermMatrix (documents: 3, terms: 4)>>
Non-/sparse entries: 1/11
Sparsity           : 92%
Maximal term length: 9
Weighting          : term frequency - inverse document frequency (tf-idf)
Sample             :
            Terms
Docs         andor anger annenberg anteced
  p2009a.txt     0     0  0.000000       0
  p2009b.txt     0     0  4.584963       0
  p2010a.txt     0     0  0.000000       0
            

## TF&TF-IDF matrix 만들기
# tf vector / tfidf vector 생성
> dtm_vector<-as.vector(as.matrix(dtm[,]))
> dtm_tfidf_vector<-as.vector(as.matrix(dtm_tfidf[,]))

# word label / doc label 생성 
> word_label_dtm<-rep(colnames(dtm),each=dim(dtm)[1])
> doc_label_dtm<-rep(rownames(dtm),times=dim(dtm)[2])
                                
# tf&tfidf df 생성
> df<-data.frame(word_label_dtm,doc_label_dtm,dtm_vector,dtm_tfidf_vector)
> colnames(df)<-c('word','doc','tf','tfidf')
> df[120:125,]
        word        doc tf    tfidf
120 abstract p2015d.txt  0 0.000000
121   academ p2009a.txt  0 0.000000
122   academ p2009b.txt  0 0.000000
123   academ p2010a.txt  0 0.000000
124   academ p2010b.txt  0 0.000000
125   academ p2010c.txt  1 4.584963

                               
```



#### cov & 상관계수

> cov(공분산)
>
> 1. data 표준화
>
>    ​	x' = xi-mean(x) / Sx
>
>    ​	y' = yi-mean(y) / Sy
>
> 2. cov(x',y') = {1/(n-1)} * {sigma (x'-mean(x')) *(y'-mean(y')) (1 to n )}




> 상관계수 (표준화된 공분산값)
>
> - 연속형~연속형  <모수적>  & 정규분포     ->  피어슨   
>
> - 연속형~연속형  <비모수적> & 정규분포 X     ->  스피어만 순위

```R
## 상관계수 구하기
# cor.test(x,y,method='')
> cor.test(df$tf,df$tfidf,method='kendall')
	Kendall's rank correlation tau
data:  df$tf and df$tfidf
z = 130.44, p-value < 2.2e-16
alternative hypothesis: true tau is not equal to 0
sample estimates:
      tau 
0.9838538

> cor.test(df$tf[df$tf>0],df$tfidf[df$tfidf>0],method='kendall')
	Kendall's rank correlation tau
data:  df$tf[df$tf > 0] and df$tfidf[df$tfidf > 0]
z = 20.994, p-value < 2.2e-16
alternative hypothesis: true tau is not equal to 0
sample estimates:
      tau 
0.4656143      # -> tf 순위가 높아도 tfidf 순위가 높지 않은 경우가 적지 않다

## tf 높지만 tfidf 낮은 단어 추출
# 1) tf>0 & tfidf>0 data 선별
# subset(data,조건)   -> 조건을 만족하는 df 추출
> subdf<-subset(df,tf>0&tfidf>0)
# 2) tf>median & tfidf<median data 선별
> subdf<-subset(subdf,tf>median(subdf$tf)&tfidf<median(subdf$tfidf))
> table(subdf$word)[table(subdf$word)>0]
		account          action          addict 
              1               1               1 
          adopt           adult          affect 
              1               1               3 
         affili           agenc         ambival 
              1               1               2 
          anger        approach          attach 
              1               1               1 ...

```



