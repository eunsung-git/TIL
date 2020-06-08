sms_raw<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/sms_spam_ansi.txt',stringsAsFactors=FALSE)
str(sms_raw)

sms_raw$type<-factor(sms_raw$type)
str(sms_raw)

table(sms_raw$type)

# text 전처리 & 표준화
install.packages('tm')
library(tm)
# 1) data source 객체 생성  -> VectorSource()
sms_corpus<-VectorSource(sms_raw$text)

# 2) corpus 생성  -> VCorpus()
sms_corpus<-VCorpus(VectorSource(sms_raw$text))
inspect(sms_corpus[1])
as.character(sms_corpus[[1]])
lapply(sms_corpus[1:3],as.character)

sms_corpus_lower<-tm_map(sms_corpus,content_transformer(tolower))
as.character(sms_corpus_lower[[1]])

#tm_map(sms_corpus,content_transformer(tolower))

# 숫자 제거
sms_corpus_low_nonum<-tm_map(sms_corpus_lower,removeNumbers)
inspect(sms_corpus_low_nonum[1:3])

# 구두점 제거
sms_corpus_clean<-tm_map(sms_corpus_low_nonum,removePunctuation)
inspect(sms_corpus_clean[1:3])

# stop words 제거  ex) 전치사
sms_corpus_clean<-tm_map(sms_corpus_clean,removeWords,stopwords())
inspect(sms_corpus_clean[1:3])

# 특수문자 제거
# 함수 설정 & 정규표현식
replacePunct<-function(x){
  gsub('[[:punct:]]+',' ',x)
} # x에 전달된 문자열에 대해, punct을 ' ' 로 변경
replacePunct('hi+.{hello<;')

# gsub(대상text,바꿀text,data)
x='대한민국 대한 민국 대한민국'
gsub('대한민국','코리아',x)

# 형태소 분석
install.packages('SnowballC')
library(SnowballC)
# 어근 추출  -> wordStem()
wordStem(c('learn','learned','learning','learns'))

## corpus 전체 어근 추출
sms_corpus_clean<-tm_map(sms_corpus_clean,stemDocument)
inspect(sms_corpus_clean[1:3])

## 추가 공백 제거 
sms_corpus_clean<-tm_map(sms_corpus_clean,stripWhitespace)
inspect(sms_corpus_clean[1:5])


lapply(sms_corpus[1:3],as.character)
inspect(sms_corpus_clean[1:3])

# corpus => token      -> DocumentTerMatix(corpus,control=list())
# row : message  / col : words
sms_dtm2<-DocumentTermMatrix(sms_corpus,
                   control=list(tolower=TRUE,removeNumbers=TRUE,
                                stopwords=TRUE,removePunctuation=TRUE,
                                stemming=TRUE))
sms_dtm<-DocumentTermMatrix(sms_corpus_clean,
                            control=list(tolower=TRUE,removeNumbers=TRUE,
                                         stopwords=TRUE,removePunctuation=TRUE,
                                         stemming=TRUE))

sms_dtm_train<-sms_dtm2[1:4169,]
sms_dtm_test<-sms_dtm2[4170:5559,]

sms_train_labels<-sms_raw[1:4169,]$type
sms_test_labels<-sms_raw[4170:5559,]$type

# wordcloud
install.packages('wordcloud')
library(wordcloud)
wordcloud(sms_corpus_clean,min.freq=50,max.words=100,
          scale=c(5,0.2),
          rot.per=0.1, 
          random.color=T,
          colors=brewer.pal(5,'Paired'),
          random.order=FALSE)

spam<-subset(sms_raw,type=='spam')
ham<-subset(sms_raw,type=='ham')
wordcloud(spam$text,max.word=40,scale=c(3,0.5),random.order=FALSE)
wordcloud(ham$text,max.word=40,scale=c(3,0.5),random.order=FALSE)

# 최소 5번 이상 등장한 단어
sms_freq_words<-findFreqTerms(sms_dtm_train,5)

sms_dtm_freq_train<-sms_dtm_train[,sms_freq_words]
sms_dtm_freq_test<-sms_dtm_test[,sms_freq_words]

convert_counts<-function(x){
  x<-ifelse(x>0,'yes','no')}
# col 단위로 함수 적용
sms_train<-apply(sms_dtm_freq_train,MARGIN=2,convert_counts)
sms_test<-apply(sms_dtm_freq_test,MARGIN=2,convert_counts)

dim(sms_train)


## naive Bayesian 모델 생성
install.packages('e1071')
library(e1071)

sms_classifier<-naiveBayes(sms_train, sms_train_labels)


sms_test_pred<-predict(sms_classifier,sms_test)

library(gmodels)
CrossTable(sms_test_pred,sms_test_labels,
           prop.t=FALSE,prop.r=FALSE,
           dnn=c('predicted','actual'))

# lacpace 추정량 옵션 추가
sms_classifier2<-naiveBayes(sms_train, sms_train_labels,laplace=1)
sms_test_pred2<-predict(sms_classifier2,sms_test)

library(gmodels)
CrossTable(sms_test_pred2,sms_test_labels,
           prop.t=FALSE,prop.r=FALSE,
           dnn=c('predicted','actual'))
