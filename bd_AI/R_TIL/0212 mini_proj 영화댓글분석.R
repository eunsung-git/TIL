# 1) bayesian classifier & 교차분석

# factor -> string 변환 후 불러오기
movie_raw<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/movie-pang02.csv')
str(movie_raw)

table(movie_raw$class)

# 1800개의 train data 생성
set.seed(123)
train_sample<-sample(2000,1800)
movie_train<-movie_raw[train_sample,]

# 200개의 test data 생성
movie_test<-movie_raw[-train_sample,]

### text 전처리 & 표준화
install.packages('tm')
library(tm)
## data source 객체 생성  -> VectorSource()
movie_corpus_train<-VectorSource(movie_train$text)
movie_corpus_test<-VectorSource(movie_test$text)

## corpus 생성  -> VCorpus()
movie_corpus_train<-VCorpus(VectorSource(movie_train$text))
movie_corpus_test<-VCorpus(VectorSource(movie_test$text))


## corpus => token      -> DocumentTerMatix(corpus,control=list())
# row : message  / col : words
movie_dtm_train<-DocumentTermMatrix(movie_corpus_train,
                                    control=list(removeNumbers=TRUE,
                                                 stopwords=TRUE,removePunctuation=TRUE,
                                                 stemming=TRUE))
movie_dtm_test<-DocumentTermMatrix(movie_corpus_test,
                                    control=list(removeNumbers=TRUE,
                                                 stopwords=TRUE,removePunctuation=TRUE,
                                                 stemming=TRUE))


## label 설정
movie_train_labels<-movie_train$class
movie_test_labels<-movie_test$class

## 최소 200번 이상 등장한 단어
movie_freq_words<-findFreqTerms(movie_dtm_train,200)

movie_dtm_freq_train<-movie_dtm_train[,movie_freq_words]
movie_dtm_freq_test<-movie_dtm_test[,movie_freq_words]

movie_freq_words

convert_counts<-function(x){
  x<-ifelse(x>0,'yes','no')
}

# col 단위로 함수 적용
movie_train<-apply(movie_dtm_freq_train,MARGIN=2,convert_counts)
movie_test<-apply(movie_dtm_freq_test,MARGIN=2,convert_counts)


## naive Bayesian 모델 생성
install.packages('e1071')
library(e1071)

movie_classifier<-naiveBayes(movie_train, movie_train_labels)

movie_test_pred<-predict(movie_classifier,movie_test)

## 비교
library(gmodels)
CrossTable(movie_test_pred,movie_test_labels,
             prop.t=FALSE,prop.r=FALSE,
             dnn=c('predicted','actual'))


## lacpace 추정량 옵션 추가 후 비교
movie_classifier2<-naiveBayes(movie_train, movie_train_labels,laplace=1)

movie_test_pred2<-predict(movie_classifier2,movie_test)

library(gmodels)
CrossTable(movie_test_pred2,movie_test_labels,
             prop.t=FALSE,prop.r=FALSE,
             dnn=c('predicted','actual'))





# 2) text 분석

# data 불러오기
movie_raw<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/movie-pang02.csv')
str(movie_raw)
# pos/neg data 분할
mpos<-movie_raw[1:1000,]$text
mneg<-movie_raw[1001:2000,]$text

# corpus 생성
library(tm)
mpos_corpus<-VCorpus(VectorSource(mpos))
mneg_corpus<-VCorpus(VectorSource(mneg))

# 특수문자 제거
replacePunct<-function(x){
  gsub('[[:punct:]]+',' ',x)
} 

mpos_corpus<-replacePunct(mpos_corpus)
mneg_corpus<-replacePunct(mneg_corpus)

# 숫자 제거
replaceNum<-function(x){
  gsub('[[:digit:]]+',' ',x)
}
mpos_corpus<-replaceNum(mpos_corpus)
mneg_corpus<-replaceNum(mneg_corpus)

# 공백 제거
replaceBlank<-function(x){
  gsub('[[:blank:]]+',' ',x)
}
mpos_corpus<-replaceBlank(mpos_corpus)
mneg_corpus<-replaceBlank(mneg_corpus)


# 모든 문서에서 알파벳별 사용 횟수
mpos_alpha<-gregexpr('[[:upper:]]',toupper(mpos_corpus))
mpos_alpha_num<-regmatches(toupper(mpos_corpus),mpos_alpha)
table(unlist(mpos_alpha_num))

mneg_alpha<-gregexpr('[[:upper:]]',toupper(mneg_corpus))
mneg_alpha_num<-regmatches(toupper(mneg_corpus),mneg_alpha)
table(unlist(mneg_alpha_num))


# 모든 문서에서 가장 많이 사용된 알파벳
mpos_alpha_max<-table(unlist(mpos_alpha_num))
mpos_alpha_max[mpos_alpha_max==max(mpos_alpha_max)]

mneg_alpha_max<-table(unlist(mneg_alpha_num))
mneg_alpha_max[mneg_alpha_max==max(mneg_alpha_max)]


# 모든 문서에서 사용된 알파벳의 총 갯수
sum(mpos_alpha_max)
sum(mneg_alpha_max)

# 시각화
library(ggplot2)
mpos_data<-data.frame(mpos_alpha_max)
ggplot(mpos_data,aes(x=Var1,y=Freq,fill=Var1))+
  geom_bar(stat='identity')+
  guides(fill=FALSE)+
  geom_hline(aes(yintercept=median(mpos_alpha_max)))+
  xlab('alphabet')+ylab('빈도수')


mneg_data<-data.frame(mneg_alpha_max)
ggplot(mneg_data,aes(x=Var1,y=Freq,fill=Var1))+
  geom_bar(stat='identity')+
  guides(fill=FALSE)+
  geom_hline(aes(yintercept=median(mneg_alpha_max)))+
  xlab('alphabet')+ylab('빈도수')




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
movie_emotion(' after watching   rat race   last week   i noticed my cheeks were sore and realized that   when not laughing aloud   i had held a grin for virtually all of the film s 112 minutes    saturday night   i ')

# movie review 감정분석
movie_emotion(movie_test$text)


