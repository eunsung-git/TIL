### script 감성분석
## 1) script 불러오기

bafta_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/bafta"

library(tm)
bafta_corpus<-VCorpus(DirSource(bafta_path))

## 2) text 전처리
bafta_corpus<-tm_map(bafta_corpus,removePunctuation)
bafta_corpus<-tm_map(bafta_corpus,stripWhitespace)
bafta_corpus<-tm_map(bafta_corpus,removeNumbers)
bafta_corpus<-tm_map(bafta_corpus,content_transformer(tolower))
bafta_corpus<-tm_map(bafta_corpus,removeWords,stopwords())
bafta_corpus<-tm_map(bafta_corpus,stemDocument)


## 2) 감성분석 graph
library(tidyr)
library(tidytext)
library(textdata)
library(stringr)

# graph 출력 함수 생성
emotion_analysis_graph=function(data){
  
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

# 감성분석 graph 함수 실행
emotion_analysis_graph(bafta_corpus)

# 감성분석 결과 graph 출력
graph<-emotion_analysis_graph(bafta_corpus)

graph<-data.frame(graph)
g_t<-t(graph)
colnames(g_t)<-'word_count'
sentiment<-c('anger','anticipation','disgust','fear','joy','negative','positive','sadness','surprise','trust')
gc<-cbind(g_t,sentiment)
gc<-as.data.frame(gc)
gc$word_count=as.integer(as.vector(gc$word_count))

library(ggplot2)
ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))+geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('bafta sentiments')



### wordcloud

## 3) wordcloud 생성
library(wordcloud)
wordcloud(bafta_corpus,min.freq=10,max.words=80,
          scale=c(3,0.2),
          rot.per=0.1, 
          random.color=T,
          colors=brewer.pal(5,'Paired'),
          random.order=FALSE) 
