### script 감성분석
## 1) script 불러오기

oscar_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/oscar"
bafta_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/bafta"
cannes_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/cannes"
berlin_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/berlin"
venezia_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/venezia"
sundance_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/sundance"

library(tm)
oscar_corpus<-VCorpus(DirSource(oscar_path))
bafta_corpus<-VCorpus(DirSource(bafta_path))
cannes_corpus<-VCorpus(DirSource(cannes_path))
berlin_corpus<-VCorpus(DirSource(berlin_path))
venezia_corpus<-VCorpus(DirSource(venezia_path))
sundance_corpus<-VCorpus(DirSource(sundance_path))


oscar_corpus<-tm_map(oscar_corpus,removePunctuation)
oscar_corpus<-tm_map(oscar_corpus,stripWhitespace)
oscar_corpus<-tm_map(oscar_corpus,removeNumbers)
oscar_corpus<-tm_map(oscar_corpus,content_transformer(tolower))
oscar_corpus<-tm_map(oscar_corpus,removeWords,stopwords())
oscar_corpus<-tm_map(oscar_corpus,stemDocument)

bafta_corpus<-tm_map(bafta_corpus,removePunctuation)
bafta_corpus<-tm_map(bafta_corpus,stripWhitespace)
bafta_corpus<-tm_map(bafta_corpus,removeNumbers)
bafta_corpus<-tm_map(bafta_corpus,content_transformer(tolower))
bafta_corpus<-tm_map(bafta_corpus,removeWords,stopwords())
bafta_corpus<-tm_map(bafta_corpus,stemDocument)

cannes_corpus<-tm_map(cannes_corpus,removePunctuation)
cannes_corpus<-tm_map(cannes_corpus,stripWhitespace)
cannes_corpus<-tm_map(cannes_corpus,removeNumbers)
cannes_corpus<-tm_map(cannes_corpus,content_transformer(tolower))
cannes_corpus<-tm_map(cannes_corpus,removeWords,stopwords())
cannes_corpus<-tm_map(cannes_corpus,stemDocument)

berlin_corpus<-tm_map(berlin_corpus,removePunctuation)
berlin_corpus<-tm_map(berlin_corpus,stripWhitespace)
berlin_corpus<-tm_map(berlin_corpus,removeNumbers)
berlin_corpus<-tm_map(berlin_corpus,content_transformer(tolower))
berlin_corpus<-tm_map(berlin_corpus,removeWords,stopwords())
berlin_corpus<-tm_map(berlin_corpus,stemDocument)

venezia_corpus<-tm_map(venezia_corpus,removePunctuation)
venezia_corpus<-tm_map(venezia_corpus,stripWhitespace)
venezia_corpus<-tm_map(venezia_corpus,removeNumbers)
venezia_corpus<-tm_map(venezia_corpus,content_transformer(tolower))
venezia_corpus<-tm_map(venezia_corpus,removeWords,stopwords())
venezia_corpus<-tm_map(venezia_corpus,stemDocument)

sundance_corpus<-tm_map(sundance_corpus,removePunctuation)
sundance_corpus<-tm_map(sundance_corpus,stripWhitespace)
sundance_corpus<-tm_map(sundance_corpus,removeNumbers)
sundance_corpus<-tm_map(sundance_corpus,content_transformer(tolower))
sundance_corpus<-tm_map(sundance_corpus,removeWords,stopwords())
sundance_corpus<-tm_map(sundance_corpus,stemDocument)



library(tidyr)
library(tidytext)
library(textdata)
library(stringr)


emotion_analysis_graph = function(data){
  
  nrc=data.frame(get_sentiments("nrc"))
  
  nrc_count=matrix(0, ncol=10, nrow=1)
  colnames(nrc_count)<-rownames(table(nrc$sentiment))
  
  words=unlist(str_extract_all(data, boundary(type='word')))
  for(s in words){
    for(emotion in nrc$sentiment[nrc$word==s]){
      nrc_count[, emotion]<-nrc_count[, emotion]+1
    }
  } 
  
  print(nrc_count)
}


emotion_analysis_graph(oscar_corpus)
emotion_analysis_graph(bafta_corpus)
emotion_analysis_graph(cannes_corpus)
emotion_analysis_graph(berlin_corpus)
emotion_analysis_graph(venezia_corpus)
emotion_analysis_graph(sundance_corpus)



graph<-emotion_analysis_graph(oscar_corpus)

graph<-data.frame(graph)
g_t<-t(graph)
colnames(g_t)<-'word_count'
sentiment<-c('anger','anticipation','disgust','fear','joy','negative','positive',
             'sadness','surprise','trust')
gc<-cbind(g_t,sentiment)
gc<-as.data.frame(gc)
gc$word_count=as.integer(as.vector(gc$word_count))


library(ggplot2)
ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('oscar sentiments')
ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('bafta sentiments')
ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('cannes sentiments')
ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('berlin sentiments')
ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('venezia sentiments')
ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('sundance sentiments')




library(wordcloud)
wordcloud(oscar_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
wordcloud(bafta_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
wordcloud(cannes_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
wordcloud(berlin_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
wordcloud(venezia_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
wordcloud(sundance_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
