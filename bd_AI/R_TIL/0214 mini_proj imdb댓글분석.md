## mini_proj_R

### IMDB data text분석

#### (1) Bayesian 분류기 & 교차분석

```R
# data 불러오기
> library(readr)
> imdb_raw<-read_csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/IMDB Dataset.csv')

# 10000개의 data만 추출
> imdb_raw<-imdb_raw[1:10000,]

# chr type의 sentiment col을 factor type으로 변환 후 저장
> imdb_raw$sentiment<-factor(imdb_raw$sentiment)

> table(imdb_raw$sentiment)
negative positive 
    4972     5028 

# 8000개의 train set, 2000개의 test set으로 data 분리
> set.seed(123)
> train_sample<-sample(10000,8000)
> imdb_train<-imdb_raw[train_sample,]
> imdb_test<-imdb_raw[-train_sample,]

# corpus 생성
> library(tm)
> imdb_corpus_train<-VCorpus(VectorSource(imdb_train$review))
> imdb_corpus_test<-VCorpus(VectorSource(imdb_test$review))

# token화 및 text 전처리
> imdb_dtm_train<-DocumentTermMatrix(imdb_corpus_train,
                                    control=list(tolower=TRUE,removeNumbers=TRUE,
                                                 stopwords=TRUE,removePunctuation=TRUE,
                                                 stemming=TRUE))
> imdb_dtm_test<-DocumentTermMatrix(imdb_corpus_test,
                                   control=list(tolower=TRUE,removeNumbers=TRUE,
                                                stopwords=TRUE,removePunctuation=TRUE,
                                                stemming=TRUE))

# label 생성
> imdb_train_labels<-imdb_train$sentiment
> imdb_test_labels<-imdb_test$sentiment

# 최소 100번 이상 등장한 단어 찾기
> imdb_freq_words<-findFreqTerms(imdb_dtm_train,100)
> imdb_dtm_freq_train<-imdb_dtm_train[,imdb_freq_words]
> imdb_dtm_freq_test<-imdb_dtm_test[,imdb_freq_words]

> convert_counts<-function(x){
  x<-ifelse(x>0,'yes','no')
}

# column 단위로 함수 적용
> imdb_train<-apply(imdb_dtm_freq_train,MARGIN=2,convert_counts)
> imdb_test<-apply(imdb_dtm_freq_test,MARGIN=2,convert_counts)

# Naive Bayesian 모델 생성 
> library(e1071)
> imdb_classifier<-naiveBayes(imdb_train, imdb_train_labels)
> imdb_test_pred<-predict(imdb_classifier,imdb_test)

# 교차분석
> library(gmodels)
> CrossTable(imdb_test_pred,imdb_test_labels,
             prop.t=FALSE,prop.r=FALSE,
             dnn=c('predicted','actual'))
   Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Col Total |
|-------------------------|
Total Observations in Table:  2000 

             | actual 
   predicted |  negative |  positive | Row Total | 
-------------|-----------|-----------|-----------|
    negative |       787 |       142 |       929 | 
             |   236.340 |   229.814 |           | 
             |     0.798 |     0.140 |           | 
-------------|-----------|-----------|-----------|
    positive |       199 |       872 |      1071 | 
             |   205.004 |   199.344 |           | 
             |     0.202 |     0.860 |           | 
-------------|-----------|-----------|-----------|
Column Total |       986 |      1014 |      2000 | 
             |     0.493 |     0.507 |           | 
-------------|-----------|-----------|-----------|

# lacpace 추정량 옵션 추가 후 교차분석
> imdb_classifier2<-naiveBayes(imdb_train, imdb_train_labels,laplace=1)
> imdb_test_pred2<-predict(imdb_classifier2,imdb_test)
> CrossTable(imdb_test_pred2,imdb_test_labels,
           prop.t=FALSE,prop.r=FALSE,
           dnn=c('predicted','actual'))
   Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Col Total |
|-------------------------|
Total Observations in Table:  2000 

             | actual 
   predicted |  negative |  positive | Row Total | 
-------------|-----------|-----------|-----------|
    negative |       788 |       142 |       930 | 
             |   236.814 |   230.275 |           | 
             |     0.799 |     0.140 |           | 
-------------|-----------|-----------|-----------|
    positive |       198 |       872 |      1070 | 
             |   205.829 |   200.145 |           | 
             |     0.201 |     0.860 |           | 
-------------|-----------|-----------|-----------|
Column Total |       986 |      1014 |      2000 | 
             |     0.493 |     0.507 |           | 
-------------|-----------|-----------|-----------|

```



#### (2) 감성분석사전  기반 clustering

```R
### 감성분석 함수 생성
> library(tidyr)
> library(tidytext)
> library(textdata)

imdb_emotion<-function(data){
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

## imdb review 감정분석
> imdb_emotion(imdb_test$review[1])
[1] "POSITIVE"


## 실제 값과 감정분석값 비교
> emotion_pred<-sapply(imdb_raw$review, imdb_emotion)
> library(gmodels)
> CrossTable(imdb_raw$review,emotion_pred,
           prop.t=F, prop.r=F,dnn=c('actual','predicted'))

```

