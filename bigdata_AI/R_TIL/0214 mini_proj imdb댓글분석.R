library(readr)

imdb_raw<-read_csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/IMDB Dataset.csv')
imdb_raw<-imdb_raw[1:10000,]
str(imdb_raw)

imdb_raw$sentiment<-factor(imdb_raw$sentiment)

table(imdb_raw$sentiment)

set.seed(123)
train_sample<-sample(10000,8000)
imdb_train<-imdb_raw[train_sample,]

imdb_test<-imdb_raw[-train_sample,]

library(tm)
imdb_corpus_train<-VCorpus(VectorSource(imdb_train$review))
imdb_corpus_test<-VCorpus(VectorSource(imdb_test$review))

imdb_dtm_train<-DocumentTermMatrix(imdb_corpus_train,
                                    control=list(tolower=TRUE,removeNumbers=TRUE,
                                                 stopwords=TRUE,removePunctuation=TRUE,
                                                 stemming=TRUE))

imdb_dtm_train

imdb_dtm_test<-DocumentTermMatrix(imdb_corpus_test,
                                   control=list(tolower=TRUE,removeNumbers=TRUE,
                                                stopwords=TRUE,removePunctuation=TRUE,
                                                stemming=TRUE))

imdb_dtm_test

imdb_train_labels<-imdb_train$sentiment
imdb_test_labels<-imdb_test$sentiment

imdb_freq_words<-findFreqTerms(imdb_dtm_train,100)
imdb_dtm_freq_train<-imdb_dtm_train[,imdb_freq_words]
imdb_dtm_freq_test<-imdb_dtm_test[,imdb_freq_words]

convert_counts<-function(x){
  x<-ifelse(x>0,'yes','no')
}

imdb_train<-apply(imdb_dtm_freq_train,MARGIN=2,convert_counts)
imdb_test<-apply(imdb_dtm_freq_test,MARGIN=2,convert_counts)


library(e1071)

imdb_classifier<-naiveBayes(imdb_train, imdb_train_labels)

imdb_test_pred<-predict(imdb_classifier,imdb_test)


library(gmodels)
CrossTable(imdb_test_pred,imdb_test_labels,
             prop.t=FALSE,prop.r=FALSE,
             dnn=c('predicted','actual'))



imdb_classifier2<-naiveBayes(imdb_train, imdb_train_labels,laplace=1)

imdb_test_pred2<-predict(imdb_classifier2,imdb_test)

CrossTable(imdb_test_pred2,imdb_test_labels,
           prop.t=FALSE,prop.r=FALSE,
           dnn=c('predicted','actual'))



imdb_review<-imdb_raw$review
str(imdb_review)
imdb_review[1]



library(tidyr)
library(tidytext)
library(textdata)

imdb_emotion<-function(imdb_review){
  bing<-data.frame(get_sentiments(lexicon='bing'))
  
  pos_words<-bing$word[bing$sentiment=='positive']
  neg_words<-bing$word[bing$sentiment=='negative']
  imdb_review<-imdb_review


  library(stringr)
  words<-unlist(str_extract_all(imdb_review, boundary(type='word')))

  pos_cnt <- 0
  neg_cnt <- 0

  for (i in 1:length(words)){
    ifelse(words[i]==pos_words,pos_cnt<-pos_cnt+1,
         ifelse(words[i]==neg_words,neg_cnt<-neg_cnt+1,neg_cnt<-neg_cnt))}
  
  myemotion<- ''
  ifelse(pos_cnt>neg_cnt, myemotion<-'POSITIVE', myemotion<-'NEGATIVE')
  return(myemotion)}

imdb_emotion(' after watching   rat race   last week   i noticed my cheeks were sore and realized that   when not laughing aloud   i had held a grin for virtually all of the film s 112 minutes    saturday night   i ')


emotion_pred<-sapply(imdb_test$review, imdb_emotion) 
emotion_pred

imdb_test$review[1]
imdb_emotion(imdb_test$review[1])

