# personal_project 

##  영화제 각본상 수상작 감성분석



### [1] 스크립트 txt 파일 불러오기

```R
> oscar_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/oscar"
> bafta_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/bafta"
> cannes_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/cannes"
> berlin_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/berlin"
> venezia_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/venezia"
> sundance_path<-"C:/Users/student/Desktop/personal_proj_각본상_감성분석/dataset/sundance"
```



### [2] nrc 감성분석 사전을 활용한 감성분석 graph

#### (1) tm package를 활용하여 각 영화제 별 script의 corpus 생성

```R
> library(tm)
> oscar_corpus<-VCorpus(DirSource(oscar_path))
> bafta_corpus<-VCorpus(DirSource(bafta_path))
> cannes_corpus<-VCorpus(DirSource(cannes_path))
> berlin_corpus<-VCorpus(DirSource(berlin_path))
> venezia_corpus<-VCorpus(DirSource(venezia_path))
> sundance_corpus<-VCorpus(DirSource(sundance_path))
```



#### (2) 생성된 corpus 전처리

```R
> oscar_corpus<-tm_map(oscar_corpus,removePunctuation)
> oscar_corpus<-tm_map(oscar_corpus,stripWhitespace)
> oscar_corpus<-tm_map(oscar_corpus,removeNumbers)
> oscar_corpus<-tm_map(oscar_corpus,content_transformer(tolower))
> oscar_corpus<-tm_map(oscar_corpus,removeWords,stopwords())
> oscar_corpus<-tm_map(oscar_corpus,stemDocument)

> bafta_corpus<-tm_map(bafta_corpus,removePunctuation)
> bafta_corpus<-tm_map(bafta_corpus,stripWhitespace)
> bafta_corpus<-tm_map(bafta_corpus,removeNumbers)
> bafta_corpus<-tm_map(bafta_corpus,content_transformer(tolower))
> bafta_corpus<-tm_map(bafta_corpus,removeWords,stopwords())
> bafta_corpus<-tm_map(bafta_corpus,stemDocument)

> cannes_corpus<-tm_map(cannes_corpus,removePunctuation)
> cannes_corpus<-tm_map(cannes_corpus,stripWhitespace)
> cannes_corpus<-tm_map(cannes_corpus,removeNumbers)
> cannes_corpus<-tm_map(cannes_corpus,content_transformer(tolower))
> cannes_corpus<-tm_map(cannes_corpus,removeWords,stopwords())
> cannes_corpus<-tm_map(cannes_corpus,stemDocument)

> berlin_corpus<-tm_map(berlin_corpus,removePunctuation)
> berlin_corpus<-tm_map(berlin_corpus,stripWhitespace)
> berlin_corpus<-tm_map(berlin_corpus,removeNumbers)
> berlin_corpus<-tm_map(berlin_corpus,content_transformer(tolower))
> berlin_corpus<-tm_map(berlin_corpus,removeWords,stopwords())
> berlin_corpus<-tm_map(berlin_corpus,stemDocument)

> venezia_corpus<-tm_map(venezia_corpus,removePunctuation)
> venezia_corpus<-tm_map(venezia_corpus,stripWhitespace)
> venezia_corpus<-tm_map(venezia_corpus,removeNumbers)
> venezia_corpus<-tm_map(venezia_corpus,content_transformer(tolower))
> venezia_corpus<-tm_map(venezia_corpus,removeWords,stopwords())
> venezia_corpus<-tm_map(venezia_corpus,stemDocument)

> sundance_corpus<-tm_map(sundance_corpus,removePunctuation)
> sundance_corpus<-tm_map(sundance_corpus,stripWhitespace)
> sundance_corpus<-tm_map(sundance_corpus,removeNumbers)
> sundance_corpus<-tm_map(sundance_corpus,content_transformer(tolower))
> sundance_corpus<-tm_map(sundance_corpus,removeWords,stopwords())
> sundance_corpus<-tm_map(sundance_corpus,stemDocument)
```



#### (3) 감성분석 함수 생성

```R
> library(tidyr)
> library(tidytext)
> library(textdata)
> library(stringr)

## 함수 생성
emotion_analysis_graph = function(data){
  
  # nrc 감성분석 사전 불러오기
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
```

#### (4) 각 corpus 별로 감성분석 함수 실행

```R
> emotion_analysis_graph(oscar_corpus)
> emotion_analysis_graph(bafta_corpus)
> emotion_analysis_graph(sundance_corpus)
> emotion_analysis_graph(cannes_corpus)
> emotion_analysis_graph(berlin_corpus)
> emotion_analysis_graph(venezia_corpus)
```



#### (5) graph 출력 전, 함수 결과값 전처리

##### 1) 함수 결과값을 'graph' 변수에 담은 후, data frame으로 변환

```R
> graph<-emotion_analysis_graph(oscar_corpus)

> graph<-data.frame(graph)
```

##### 2) 'graph'를 전치함수 t를 이용하여 전치한 후, 'g_t'에 저장

```R
> g_t<-t(graph)
```

##### 3) 'g_t'의 column명을 'word_count'로 설정

```R
> colnames(g_t)<-'word_count'
```

##### 4) nrc의 10개 감성의 이름을 'sentiment' 변수에 저장

```R
> sentiment<-c('anger','anticipation','disgust','fear','joy','negative','positive','sadness','surprise','trust')
```

##### 5) 'g_t'와 'sentiment' 를 cbind 함수로 결합한 후, 'gc'에 저장하여 data frame으로 변환

```R
> gc<-cbind(g_t,sentiment)
> gc<-as.data.frame(gc)
```

##### 6) 'gc'의 'word_count' column값을 vector로 전환 후, 다시 integer로 전환

```R
> gc$word_count=as.integer(as.vector(gc$word_count))
```



#### (6) 각 corpus 별 감성분석 함수값을 graph로 출력

```R

> library(ggplot2)
> ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('oscar sentiments')
> ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('bafta sentiments')
> ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('cannes sentiments')
> ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('berlin sentiments')
> ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('venezia sentiments')
> ggplot(gc,aes(x=reorder(sentiment,word_count),y=word_count))
  +geom_bar(stat='identity',fill='blue')+coord_flip()+ggtitle('sundance sentiments')
```



### [3] 영화제 각본상 수상작 별 wordcloud

```R
> library(wordcloud)
> wordcloud(oscar_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
> wordcloud(bafta_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
> wordcloud(cannes_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
> wordcloud(berlin_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
> wordcloud(venezia_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
> wordcloud(sundance_corpus,min.freq=10,max.words=80,scale=c(3,0.2),rot.per=0.1, 
          random.color=T,colors=brewer.pal(5,'Paired'),random.order=FALSE) 
```

