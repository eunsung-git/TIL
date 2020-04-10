### script 감성분석
## 1) script 불러오기

parasite<-read.table("C:/Users/student/Desktop/parasite.txt",
                   header=FALSE,
                   sep=",",
                   stringsAsFactors = FALSE,
                   na.strings = "",
                   fill=TRUE)

## 2) 감성분석 함수 생성
library(tidyr)
library(tidytext)
library(textdata)
library(stringr)

emotion_analysis = function(data){
  
  nrc=data.frame(get_sentiments("nrc"))
  
  # 감성 카운트할 matrix 생성
  nrc_count=matrix(0, ncol=10, nrow=1)
  colnames(nrc_count)<-rownames(table(nrc$sentiment))
  
  # data의 감성 분석 결과 count
  words=unlist(str_extract_all(data, boundary(type='word')))
  for(s in words){
    for(emotion in nrc$sentiment[nrc$word==s]){
      nrc_count[, emotion]<-nrc_count[, emotion]+1
    }
  } 
  
  # 최대 count를 갖는 감정 찾기
  nrc_max=colnames(nrc_count)[nrc_count==max(nrc_count)]
  
  
  # 결과 출력
  print(c("nrc :", nrc_max))
}

## 3) script 감성분석기 실행
emotion_analysis(parasite)

## 4) 감성분석 graph
# graph 출력 함수 생성
emotion_analysis_graph = function(data){
  
  nrc=data.frame(get_sentiments("nrc"))
  
  # 감성 카운트할 matrix 생성
  nrc_count=matrix(0, ncol=10, nrow=1)
  colnames(nrc_count)<-rownames(table(nrc$sentiment))
  
  # data의 감성 분석 결과 count
  words=unlist(str_extract_all(data, boundary(type='word')))
  for(s in words){
    for(emotion in nrc$sentiment[nrc$word==s]){
      nrc_count[, emotion]<-nrc_count[, emotion]+1
    }
  } 
  
  # df 출력
  print(nrc_count)
}

emotion_analysis_graph(parasite)

# 감성분석 결과 graph 출력
graph<-emotion_analysis_graph(parasite)

graph<-data.frame(graph)
g_t<-t(graph)
colnames(g_t)<-'word_count'
sentiment<-c('anger','anticipation','disgust','fear','joy','negative','positive','sadness','surprise','trust')
gc<-cbind(g_t,sentiment)
gc<-as.data.frame(gc)
gc$word_count=as.integer(as.vector(gc$word_count))

library(ggplot2)
ggplot(gc,aes(sentiment,word_count))+geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('PARASITE sentiments')




### wordcloud
## 1) corpus 생성
library(tm)
parasite_corpus<-VCorpus(VectorSource(parasite))

## 2) text 전처리
parasite_corpus<-tm_map(parasite_corpus,removePunctuation)
parasite_corpus<-tm_map(parasite_corpus,stripWhitespace)
parasite_corpus<-tm_map(parasite_corpus,removeNumbers)
parasite_corpus<-tm_map(parasite_corpus,content_transformer(tolower))
parasite_corpus<-tm_map(parasite_corpus,removeWords,stopwords())
parasite_corpus<-tm_map(parasite_corpus,stemDocument)


## 3) wordcloud 생성
library(wordcloud)
wordcloud(parasite_corpus,min.freq=10,max.words=80,
          scale=c(3,0.2),
          rot.per=0.1, 
          random.color=T,
          colors=brewer.pal(5,'Paired'),
          random.order=FALSE) 


### script TF-IDF
## 1) corpus dtm 생성
dtm<-DocumentTermMatrix(parasite_corpus)
## 2) TF-IDF를 위한 corpus dtm 생성
dtm_tfidf<-DocumentTermMatrix(parasite_corpus,
                              control=list(weighting=function(x) weightTfIdf(x,normalize=FALSE)))

## 3) TF&TF-IDF matrix 만들기
# tf vector / tfidf vector 생성
dtm_vector<-as.vector(as.matrix(dtm[,]))
dtm_tfidf_vector<-as.vector(as.matrix(dtm_tfidf[,]))

# word label / doc label 생성 
word_label_dtm<-rep(colnames(dtm),each=dim(dtm)[1])
doc_label_dtm<-rep(rownames(dtm),times=dim(dtm)[2])

# TF & TF-IDF df 생성
df<-data.frame(word_label_dtm,doc_label_dtm,dtm_vector,dtm_tfidf_vector)
colnames(df)<-c('word','doc','tf','tfidf') 
df

## 4) 상관계수 구하기
cor.test(df$tf,df$tfidf,method='kendall')  
cor.test(df$tf[df$tf>1],df$tfidf[df$tfidf>1],method='kendall')

## 5) tf 높지만 tfidf 낮은 단어 추출
# tf>0 & tfidf>0 data 선별
subdf<-subset(df,tf>0&tfidf>0)
# tf>median & tfidf<median data 선별
subdf<-subset(subdf,tf>median(subdf$tf)&tfidf<median(subdf$tfidf))
table(subdf$word)[table(subdf$word)>0]

subdf
median(subdf$tf)
median(subdf$tfidf)
max(subdf$tf)
max(subdf$tfidf)
