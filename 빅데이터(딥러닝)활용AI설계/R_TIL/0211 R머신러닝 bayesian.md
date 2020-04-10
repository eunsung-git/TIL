><조건부 확률>
>
>- 서로 영향 X  (= 독립)
>
>  =>   P(A|B)  =  P(A)     /   P(B|A)  =  P(B)
>
>  ​        P(A∩B)  =  P(A)*P(B)
>
>- 서로 영향 O   
>
> =>   P(A∩B) = P(A) * P(B|A)   = P(A) *  (P(A∩B) / P(A))
>
> =>   P(A|B)  = P(A∩B) / P(B)
>
>----------------------------------------------------------------------------------------------------

> <베이즈 정리>
>
> if)  A1~Ai가 배반사건  //  A1∪A2∪...Ai  ⊆ U
>
> P(Ai|B)  = P(Ai∩B) / P(B)  
>
> ​               = P(Ai∩B)  /  [ P(A1∩B) + P(A2∩B) +...+P(Ai∩B) ]
>
> ​               = *P(Ai)*P(B|Ai)  /  [ P(A1)*P(B|A1) + P(A2)*P(B|A2) +...+ P(Ai)*P(B|Ai) ] 
>
> 
>
> 사후확률 = 우도 * 사전확률 / 주변우도
>
> 서로 ''독립''이라고 가정, 
>
> =>    P(y=c | X1=x1,.. Xj=xj) =  P(y=c) x P(X1=x1,.. Xj=xj | y=c) 
>
> ​                                               =  P(X1=x1 | y=c)xP(X2=x2 | y=c) x...x P(y=c)
>
> 
>
> cf) '라플라스 추정량'    ->  ''분자 + 1'' 하여 분자가 0이 되는 것을 방지



### Bayesian classification

```R
# factor -> string 변환 후 불러오기
sms_raw<-read.csv('C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/sms_spam_ansi.txt',stringsAsFactors=FALSE)

# chr  -> factor로 변환
> sms_raw$type<-factor(sms_raw$type)


> table(sms_raw$type)
 ham spam 
4812  747 


### text 전처리 & 표준화
install.packages('tm')
library(tm)
## data source 객체 생성  -> VectorSource()
> sms_corpus<-VectorSource(sms_raw$text)

## corpus 생성  -> VCorpus()
> sms_corpus<-VCorpus(VectorSource(sms_raw$text))
> inspect(sms_corpus[1])
<<VCorpus>>
Metadata:  corpus specific: 0, document level (indexed): 0
Content:  documents: 1
[[1]]
<<PlainTextDocument>>
Metadata:  7
Content:  chars: 49

# corpus 안의 문자열 출력
> as.character(sms_corpus[[1]])
[1] "Hope you are having a good week. Just checking in"

# 여러 개의 corpus 문자열 출력
> lapply(sms_corpus[1:3],as.character)
$`1`
[1] "Hope you are having a good week. Just checking in"
$`2`
[1] "K..give back my thanks."
$`3`
[1] "Am also doing in cbe only. But have to pay."

## corpus를 소문자로 변환
> tm_map(sms_corpus,tolower)
<<VCorpus>>
Metadata:  corpus specific: 0, document level (indexed): 0
Content:  documents: 5559
> sms_corpus_lower<-tm_map(sms_corpus,content_transformer(tolower))
> as.character(sms_corpus_lower[[1]])
[1] "hope you are having a good week. just checking in"

## 숫자 제거
> sms_corpus_low_nonum<-tm_map(sms_corpus_lower,removeNumbers)
> inspect(sms_corpus_low_nonum[1:3])
<<VCorpus>>
Metadata:  corpus specific: 0, document level (indexed): 0
Content:  documents: 3
[[1]]
[1] hope you are having a good week. just checking in
[[2]]
[1] k..give back my thanks.
[[3]]
[1] am also doing in cbe only. but have to pay.

## 구두점 제거  -> removePunctuation
> sms_corpus_clean<-tm_map(sms_corpus_low_nonum,removePunctuation)
> inspect(sms_corpus_clean[1:3])
<<VCorpus>>
Metadata:  corpus specific: 0, document level (indexed): 0
Content:  documents: 3
[[1]]
[1] hope you are having a good week just checking in
[[2]]
[1] kgive back my thanks
[[3]]
[1] am also doing in cbe only but have to pay

## stop words 제거  -> removeWords, stopwords
> sms_corpus_clean<-tm_map(sms_corpus_clean,removeWords,stopwords())
> inspect(sms_corpus_clean[1:3])
<<VCorpus>>
Metadata:  corpus specific: 0, document level (indexed): 0
Content:  documents: 3
[[1]]
[1] hope     good week just checking 
[[2]]
[1] kgive back  thanks
[[3]]
[1]  also   cbe     pay


# 특수문자 제거  -> 함수 설정 & 정규표현식
# x에 전달된 문자열에 대해, punct을 ' ' 로 변경
> replacePunct<-function(x){
  gsub('[[:punct:]]+',' ',x)} 
> replacePunct('hi+.{hello<;')
[1] "hi hello "

# gsub(대상text,바꿀text,data)
> x='대한민국 대한 민국 대한민국'
> gsub('대한민국','코리아',x)
[1] "코리아 대한 민국 코리아"

# 형태소 분석
install.packages('SnowballC')
library(SnowballC)
# 단어 vector 어근 추출  -> wordStem()
> wordStem(c('learn','learned','learning','learns'))
[1] "learn" "learn" "learn" "learn"

## corpus 전체 어근 추출   ->  stemDocument
> sms_corpus_clean<-tm_map(sms_corpus_clean,stemDocument)
> inspect(sms_corpus_clean[1:3])
<<VCorpus>>
Metadata:  corpus specific: 0, document level (indexed): 0
Content:  documents: 3
[[1]]
[1] hope good week just check
[[2]]
[1] kgive back thank
[[3]]
[1] also cbe pay

## 추가 공백 제거   ->  stripWhitespace
> sms_corpus_clean<-tm_map(sms_corpus_clean,stripWhitespace)
> inspect(sms_corpus_clean[1:3])
<<VCorpus>>
Metadata:  corpus specific: 0, document level (indexed): 0
Content:  documents: 3
[[1]]
[1] hope good week just check
[[2]]
[1] kgive back thank
[[3]]
[1] also cbe pay

## corpus => token      -> DocumentTerMatix(corpus,control=list())
# row : message  / col : words
> sms_dtm<-DocumentTermMatrix(sms_corpus_clean,
                            control=list(tolower=TRUE,removeNumbers=TRUE,
                                         stopwords=TRUE,removePunctuation=TRUE,
                                         stemming=TRUE))
> sms_dtm2<-DocumentTermMatrix(sms_corpus,
                   control=list(tolower=TRUE,removeNumbers=TRUE,
                                stopwords=TRUE,removePunctuation=TRUE,
                                stemming=TRUE))

<<DocumentTermMatrix (documents: 5559, terms: 6961)>>
Non-/sparse entries: 43221/38652978   # 1 갯수/0 갯수
Sparsity           : 100%    # 거의 다 0
Maximal term length: 40      # 가장 긴 term의 길이
Weighting          : term frequency (tf)

## documents 갯수에 따라 train / test 설정
> sms_dtm_train<-sms_dtm2[1:4169,]
> sms_dtm_test<-sms_dtm2[4170:5559,]

> sms_train_labels<-sms_raw[1:4169,]$type
> sms_test_labels<-sms_raw[4170:5559,]$type

## wordcloud
install.packages('wordcloud')
library(wordcloud)
> wordcloud(sms_corpus_clean,min.freq=50,random.order=FALSE)
> wordcloud(sms_corpus_clean,min.freq=50,
          max.words=100,
          random.color=T,
          colors=brewer.pal(10,'Paired'),
          random.order=FALSE)
> wordcloud(sms_corpus_clean,min.freq=50,max.words=100,
          scale=c(5,0.2),
          rot.per=0.1, 
          random.color=T,
          colors=brewer.pal(5,'Paired'),
          random.order=FALSE)

> spam<-subset(sms_raw,type=='spam')
> ham<-subset(sms_raw,type=='ham')
> wordcloud(spam$text,max.word=40,scale=c(3,0.5),random.order=FALSE)
> wordcloud(ham$text,max.word=40,scale=c(3,0.5),random.order=FALSE)


## 최소 5번 이상 등장한 단어
> sms_freq_words<-findFreqTerms(sms_dtm_train,5)

> sms_dtm_freq_train<-sms_dtm_train[,sms_freq_words]
> sms_dtm_freq_test<-sms_dtm_test[,sms_freq_words]

> convert_counts<-function(x){
  x<-ifelse(x>0,'yes','no')
}
# col 단위로 함수 적용
> sms_train<-apply(sms_dtm_freq_train,MARGIN=2,convert_counts)
> sms_test<-apply(sms_dtm_freq_test,MARGIN=2,convert_counts)

--------------------------------------------------------------

## naive Bayesian 모델 생성
install.packages('e1071')
library(e1071)

> sms_classifier<-naiveBayes(sms_train, sms_train_labels)

> sms_test_pred<-predict(sms_classifier,sms_test)

## 비교
library(gmodels)
> CrossTable(sms_test_pred,sms_test_labels,
           prop.t=FALSE,prop.r=FALSE,
           dnn=c('predicted','actual'))

## lacpace 추정량 옵션 추가 후 비교
> sms_classifier2<-naiveBayes(sms_train, sms_train_labels,laplace=1)

> sms_test_pred2<-predict(sms_classifier2,sms_test)

library(gmodels)
> CrossTable(sms_test_pred2,sms_test_labels,
           prop.t=FALSE,prop.r=FALSE,
           dnn=c('predicted','actual'))

```





​            





