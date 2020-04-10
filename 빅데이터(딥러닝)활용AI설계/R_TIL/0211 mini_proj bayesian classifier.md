## mini_proj_R

### mushroom Bayesian classifier

```R
# factor -> string 변환 후 불러오기
> mush_raw<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/mushrooms.csv',stringsAsFactors=FALSE)

# chr -> factor로 변환
> mush_raw$type<-factor(mush_raw$type)

### text 전처리 & 표준화
install.packages('tm')
library(tm)
## data source 객체 생성  -> VectorSource()
> mush_corpus<-VectorSource(mush_raw[,-1])

## corpus 생성  -> VCorpus()
> mush_corpus<-VCorpus(VectorSource(mush_raw[,-1]))
                       
## corpus => token      -> DocumentTerMatix(corpus,control=list())
# row : message  / col : words
> mush_dtm<-DocumentTermMatrix(mush_corpus)
> mush_dtm                       
<<DocumentTermMatrix (documents: 22, terms: 67)>>
Non-/sparse entries: 116/1358
Sparsity           : 92%
Maximal term length: 10
Weighting          : term frequency (tf) 
                       
## documents 갯수에 따라 train / test 설정
> mush_dtm_train<-mush_dtm[1:15,]
> mush_dtm_test<-mush_dtm[16:22,]

> mush_train_labels<-mush_raw[1:15,]$type
> mush_test_labels<-mush_raw[16:22,]$type
                       
## wordcloud
install.packages('wordcloud')
> library(wordcloud)
> wordcloud(mush_corpus,min.freq=50,max.words=100,
          scale=c(5,0.2),
          rot.per=0.1, 
          random.color=T,
          colors=brewer.pal(5,'Paired'),
          random.order=FALSE)   
                       
## 최소 5번 이상 등장한 단어
> mush_freq_words<-findFreqTerms(mush_dtm_train,5)

> mush_dtm_freq_train<-mush_dtm_train[,mush_freq_words]
> mush_dtm_freq_test<-mush_dtm_test[,mush_freq_words]

> convert_counts<-function(x){
  x<-ifelse(x>0,'yes','no')}
# col 단위로 함수 적용
> mush_train<-apply(mush_dtm_freq_train,MARGIN=2,convert_counts)
> mush_test<-apply(mush_dtm_freq_test,MARGIN=2,convert_counts)
                       
-----------------------------------------------------------------
                       
## naive Bayesian 모델 생성
install.packages('e1071')
> library(e1071)

> mush_classifier<-naiveBayes(mush_train, mush_train_labels)

> mush_test_pred<-predict(mush_classifier,mush_test)
                       
                       
## 비교
library(gmodels)
> CrossTable(mush_test_pred,mush_test_labels,
             prop.t=FALSE,prop.r=FALSE,
             dnn=c('predicted','actual'))
                       
## lacpace 추정량 옵션 추가 후 비교
> mush_classifier2<-naiveBayes(mush_train,mush_train_labels,laplace=1)

> mush_test_pred2<-predict(mush_classifier2,mush_test)

> library(gmodels)
> CrossTable(mush_test_pred2,mush_test_labels,
             prop.t=FALSE,prop.r=FALSE,
             dnn=c('predicted','actual'))
```

