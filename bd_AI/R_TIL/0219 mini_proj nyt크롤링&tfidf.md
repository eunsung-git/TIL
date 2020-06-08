## mini_proj_R

### nyt 크롤링 & TF-IDF



```R
## nyt html 불러오기
library(rvest)
library(dplyr)

> html_nyt<-read_html('https://www.nytimes.com/',encoding='UTF-8')

## nyt html을 통해 text 추출
> html_nyt_text<-html_nyt %>% html_nodes('.css-6p6lnl') %>% 
  html_text()

## corpus 생성
library(tm)
> html_nyt_corpus<-VCorpus(VectorSource(html_nyt_text))

## text 전처리
> html_nyt_corpus<-tm_map(html_nyt_corpus,removePunctuation)
> html_nyt_corpus<-tm_map(html_nyt_corpus,stripWhitespace)
> html_nyt_corpus<-tm_map(html_nyt_corpus,removeNumbers)
> html_nyt_corpus<-tm_map(html_nyt_corpus,content_transformer(tolower))

## corpus dtm 생성
> dtm<-DocumentTermMatrix(html_nyt_corpus)

## TF-IDF를 위한 corpus dtm 생성
> dtm_tfidf<-DocumentTermMatrix(html_nyt_corpus,
                              control=list(weighting=function(x) weightTfIdf(x,normalize=FALSE)))
                                           
## TF&TF-IDF matrix 만들기
# tf vector / tfidf vector 생성
> dtm_vector<-as.vector(as.matrix(dtm[,]))
> dtm_tfidf_vector<-as.vector(as.matrix(dtm_tfidf[,]))

# word label / doc label 생성 
> word_label_dtm<-rep(colnames(dtm),each=dim(dtm)[1])
> doc_label_dtm<-rep(rownames(dtm),times=dim(dtm)[2])
                                           
# TF & TF-IDF df 생성
> df<-data.frame(word_label_dtm,doc_label_dtm,dtm_vector,dtm_tfidf_vector)
colnames(df)<-c('word','doc','tf','tfidf') 
                                           

## 상관계수 구하기
> cor.test(df$tf,df$tfidf,method='kendall')  
	Kendall's rank correlation tau
data:  df$tf and df$tfidf
z = 65.501, p-value < 2.2e-16
alternative hypothesis: true tau is not equal to 0
sample estimates:
      tau 
0.9917689 

> cor.test(df$tf[df$tf>0],df$tfidf[df$tfidf>0],method='kendall')
	Kendall's rank correlation tau
data:  df$tf[df$tf > 0] and df$tfidf[df$tfidf > 0]
z = 0.53757, p-value = 0.5909
alternative hypothesis: true tau is not equal to 0
sample estimates:
       tau 
0.03105626 

                                           
## tf 높지만 tfidf 낮은 단어 추출
# 1) tf>0 & tfidf>0 data 선별
> subdf<-subset(df,tf>0&tfidf>0)
# 2) tf>median & tfidf<median data 선별
> subdf<-subset(subdf,tf>median(subdf$tf)&tfidf<median(subdf$tfidf))
> table(subdf$word)[table(subdf$word)>0]
and the 
  1   4 

```

