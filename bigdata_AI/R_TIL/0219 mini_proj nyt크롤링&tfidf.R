library(rvest)
library(dplyr)

## 날짜별 신문기사 html 불러오기
html_nyt<-read_html('https://www.nytimes.com/',encoding='UTF-8')


## 날짜별 신문기사 소스의 text 추출
html_nyt_text<-html_nyt %>% html_nodes('.css-6p6lnl') %>% 
  html_text()


library(tm)
html_nyt_corpus<-VCorpus(VectorSource(html_nyt_text))



html_nyt_corpus<-tm_map(html_nyt_corpus,removePunctuation)
html_nyt_corpus<-tm_map(html_nyt_corpus,stripWhitespace)
html_nyt_corpus<-tm_map(html_nyt_corpus,removeNumbers)
html_nyt_corpus<-tm_map(html_nyt_corpus,content_transformer(tolower))


dtm<-DocumentTermMatrix(html_nyt_corpus)

dtm_tfidf<-DocumentTermMatrix(html_nyt_corpus,
                              control=list(weighting=function(x) weightTfIdf(x,normalize=FALSE)))

## TF&TF-IDF matrix 만들기
# tf vector / tfidf vector 생성
dtm_vector<-as.vector(as.matrix(dtm[,]))
dtm_tfidf_vector<-as.vector(as.matrix(dtm_tfidf[,]))

# word label / doc label 생성 
word_label_dtm<-rep(colnames(dtm),each=dim(dtm)[1])
doc_label_dtm<-rep(rownames(dtm),times=dim(dtm)[2])

# tf&tfidf df 생성
df<-data.frame(word_label_dtm,doc_label_dtm,dtm_vector,dtm_tfidf_vector)
colnames(df)<-c('word','doc','tf','tfidf')
df[120:125,]


## 상관계수 구하기
# cor.test(x,y,method='')
cor.test(df$tf,df$tfidf,method='kendall')
cor.test(df$tf[df$tf>0],df$tfidf[df$tfidf>0],method='kendall')


## tf 높지만 tfidf 낮은 단어 추출
# 1) tf>0 & tfidf>0 data 선별
# subset(data,조건)   -> 조건을 만족하는 df 추출
subdf<-subset(df,tf>0&tfidf>0)
# 2) tf>median & tfidf<median data 선별
subdf<-subset(subdf,tf<median(subdf$tf)&tfidf>median(subdf$tfidf))
table(subdf$word)[table(subdf$word)>0]

