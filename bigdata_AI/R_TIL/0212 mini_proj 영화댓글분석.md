## mini_proj_R

### 영화댓글 data

#### (1) Bayesian 분류기 & 교차분석

```R
# data 불러오기
> movie_raw<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/movie-pang02.csv')

> table(movie_raw$class)
 Neg  Pos 
1000 1000 

# 1800개의 train data 생성
> set.seed(123)
> train_sample<-sample(2000,1800)
> movie_train<-movie_raw[train_sample,]

# 200개의 test data 생성
> movie_test<-movie_raw[-train_sample,]

### text 전처리 & 표준화
install.packages('tm')
library(tm)

## data source 객체 생성  -> VectorSource()
> movie_corpus_train<-VectorSource(movie_train$text)
> movie_corpus_test<-VectorSource(movie_test$text)

## corpus 생성  -> VCorpus()
> movie_corpus_train<-VCorpus(VectorSource(movie_train$text))
> movie_corpus_test<-VCorpus(VectorSource(movie_test$text))

## corpus => token      -> DocumentTerMatix(corpus,control=list())
# row : message  / col : words
> movie_dtm_train<-DocumentTermMatrix(movie_corpus_train,
                                    control=list(removeNumbers=TRUE,
                                                 stopwords=TRUE,removePunctuation=TRUE,
                                                 stemming=TRUE))
<<DocumentTermMatrix (documents: 1800, terms: 23987)>>
Non-/sparse entries: 450859/42725741
Sparsity           : 99%
Maximal term length: 53
Weighting          : term frequency (tf)

> movie_dtm_test<-DocumentTermMatrix(movie_corpus_test,
                                    control=list(removeNumbers=TRUE,
                                                 stopwords=TRUE,removePunctuation=TRUE,
                                                 stemming=TRUE))
<<DocumentTermMatrix (documents: 200, terms: 9750)>>
Non-/sparse entries: 51080/1898920
Sparsity           : 97%
Maximal term length: 23
Weighting          : term frequency (tf)

## label 설정
> movie_train_labels<-movie_train$class
> movie_test_labels<-movie_test$class

## 최소 200번 이상 등장한 단어
> movie_freq_words<-findFreqTerms(movie_dtm_train,200)
> movie_dtm_freq_train<-movie_dtm_train[,movie_freq_words]
> movie_dtm_freq_test<-movie_dtm_test[,movie_freq_words]

> convert_counts<-function(x){
  x<-ifelse(x>0,'yes','no')
}

# col 단위로 함수 적용
> movie_train<-apply(movie_dtm_freq_train,MARGIN=2,convert_counts)
> movie_test<-apply(movie_dtm_freq_test,MARGIN=2,convert_counts)

------------------------------------------------------

## naive Bayesian 모델 생성
install.packages('e1071')
library(e1071)

> movie_classifier<-naiveBayes(movie_train, movie_train_labels)

> movie_test_pred<-predict(movie_classifier,movie_test)

## 비교
library(gmodels)
> CrossTable(movie_test_pred,movie_test_labels,
             prop.t=FALSE,prop.r=FALSE,
             dnn=c('predicted','actual'))

 Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Col Total |
|-------------------------|
Total Observations in Table:  200 
              | actual 
   predicted |       Neg |       Pos | Row Total | 
-------------|-----------|-----------|-----------|
         Neg |        85 |        27 |       112 | 
             |    12.940 |    13.740 |           | 
             |     0.825 |     0.278 |           | 
-------------|-----------|-----------|-----------|
         Pos |        18 |        70 |        88 | 
             |    16.469 |    17.488 |           | 
             |     0.175 |     0.722 |           | 
-------------|-----------|-----------|-----------|
Column Total |       103 |        97 |       200 | 
             |     0.515 |     0.485 |           | 
-------------|-----------|-----------|-----------|


## lacpace 추정량 옵션 추가 후 비교
> movie_classifier2<-naiveBayes(movie_train, movie_train_labels,laplace=1)

> movie_test_pred2<-predict(movie_classifier2,movie_test)

library(gmodels)
> CrossTable(movie_test_pred2,movie_test_labels,
             prop.t=FALSE,prop.r=FALSE,
             dnn=c('predicted','actual'))

	Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Col Total |
|-------------------------|
Total Observations in Table:  200 

              | actual 
   predicted |       Neg |       Pos | Row Total | 
-------------|-----------|-----------|-----------|
         Neg |        86 |        27 |       113 | 
             |    13.285 |    14.107 |           | 
             |     0.835 |     0.278 |           | 
-------------|-----------|-----------|-----------|
         Pos |        17 |        70 |        87 | 
             |    17.255 |    18.323 |           | 
             |     0.165 |     0.722 |           | 
-------------|-----------|-----------|-----------|
Column Total |       103 |        97 |       200 | 
             |     0.515 |     0.485 |           | 
-------------|-----------|-----------|-----------|

```



#### (2) text 분석

```R
# data 불러오기
movie_raw<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/movie-pang02.csv')

# pos/neg data 분할
mpos<-movie_raw[1:1000,]$text
mneg<-movie_raw[1001:2000,]$text

# corpus 생성
library(tm)
> mpos_corpus<-VCorpus(VectorSource(mpos))
> mneg_corpus<-VCorpus(VectorSource(mneg))

# 특수문자 제거
replacePunct<-function(x){
  gsub('[[:punct:]]+',' ',x)
} 
> mpos_corpus<-replacePunct(mpos_corpus)
> mneg_corpus<-replacePunct(mneg_corpus)

# 숫자 제거
replaceNum<-function(x){
  gsub('[[:digit:]]+',' ',x)
}
> mpos_corpus<-replaceNum(mpos_corpus)
> mneg_corpus<-replaceNum(mneg_corpus)

# 공백 제거
replaceBlank<-function(x){
  gsub('[[:blank:]]+',' ',x)
}
> mpos_corpus<-replaceBlank(mpos_corpus)
> mneg_corpus<-replaceBlank(mneg_corpus)

# 모든 문서에서 알파벳별 사용 횟수
> mpos_alpha<-gregexpr('[[:upper:]]',toupper(mpos_corpus))
> mpos_alpha_num<-regmatches(toupper(mpos_corpus),mpos_alpha)
> table(unlist(mpos_alpha_num))
     A      B      C      D      E      F 
276030  50316 107508 114545 398360  73883 
     G      H      I      J      K      L 
 71057 176969 253674   7611  26962 147820 
     M      N      O      P      Q      R 
 93534 225771 235597  59059   3180 201651 
     S      T      U      V      W      X 
230107 303910  86403  36258  58276   5758 
     Y      Z 
 66904   3318 

> mneg_alpha<-gregexpr('[[:upper:]]',toupper(mneg_corpus))
> mneg_alpha_num<-regmatches(toupper(mneg_corpus),mneg_alpha)
> table(unlist(mneg_alpha_num))
     A      B      C      D      E      F 
242499  46694  94606 103302 352479  62165 
     G      H      I      J      K      L 
 64172 157770 221473   7172  25390 130741 
     M      N      O      P      Q      R 
 82512 199446 213447  54282   2562 175031 
     S      T      U      V      W      X 
201351 272614  79181  32849  52563   5032 
     Y      Z 
 60447   2918 

# 모든 문서에서 가장 많이 사용된 알파벳
> mpos_alpha_max<-table(unlist(mpos_alpha_num))
> mpos_alpha_max[mpos_alpha_max==max(mpos_alpha_max)]
     E 
398360 

> mneg_alpha_max<-table(unlist(mneg_alpha_num))
> mneg_alpha_max[mneg_alpha_max==max(mneg_alpha_max)]
     E 
352479 


# 모든 문서에서 사용된 알파벳의 총 갯수
> sum(mpos_alpha_max)
[1] 3314461
> sum(mneg_alpha_max)
[1] 2942698


# 시각화
library(ggplot2)
> mpos_data<-data.frame(mpos_alpha_max)
> ggplot(mpos_data,aes(x=Var1,y=Freq,fill=Var1))+
  geom_bar(stat='identity')+
  guides(fill=FALSE)+
  geom_hline(aes(yintercept=median(mpos_alpha_max)))+
  xlab('alphabet')+ylab('빈도수')

> mneg_data<-data.frame(mneg_alpha_max)
> ggplot(mneg_data,aes(x=Var1,y=Freq,fill=Var1))+
  geom_bar(stat='identity')+
  guides(fill=FALSE)+
  geom_hline(aes(yintercept=median(mneg_alpha_max)))+
  xlab('alphabet')+ylab('빈도수')

```





#### (3) 감성분석사전 기반 clustering

```R
### 감성분석 함수 생성
library(tidyr)
library(tidytext)
library(textdata)

movie_emotion<-function(data){
  bing<-data.frame(get_sentiments(lexicon='bing'))
  
  pos_words<-bing$word[bing$sentiment=='positive']
  neg_words<-bing$word[bing$sentiment=='negative']
  data<-data

  # 감성분석 대상 text를 단어 단위로 저장
  library(stringr)
  words<-unlist(str_extract_all(data, boundary(type='word')))

  # 출현 단어 count 변수 생성  
  pos_cnt <- 0
  neg_cnt <- 0
  
  # 입력받은 단어가 어떤 감정에 속하는지 조사
  for (i in 1:length(words)){
    ifelse(words[i]==pos_words,pos_cnt<-pos_cnt+1,
         ifelse(words[i]==neg_words,neg_cnt<-neg_cnt+1,neg_cnt<-neg_cnt))}
  
  # 많이 나온 감정 출력 
  emotion<- ''
  ifelse(pos_cnt>neg_cnt, emotion<-'POSITIVE', emotion<-'NEGATIVE')
  return(emotion)
}

## 감성분석 test
> movie_emotion(' after watching   rat race   last week   i noticed my cheeks were sore and realized that   when not laughing aloud   i had held a grin for virtually all of the film s 112 minutes    saturday night   i ')
[1] "NEGATIVE"

## movie text 감정분석
> movie_emotion(movie_test$text[1])
[1] "POSITIVE"
> movie_emotion(movie_test$text)
[1] "NEGATIVE"


## 실제 값과 감정분석값 비교
emotion_pred<-sapply(movie_test$text, movie_emotion)
library(gmodels)
CrossTable(movie_test$text,emotion_pred,
           prop.t=F, prop.r=F,dnn=c('actual','predicted'))

```

