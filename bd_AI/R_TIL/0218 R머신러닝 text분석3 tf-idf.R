## corpus 생성
library(tm)
text_loc<-'C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/논문data/ymbaek_papers'
paper<-VCorpus(DirSource(text_loc))
summary(paper)
# meta()   -> metadata 구성
paper[[2]]$content

meta(paper[[2]],tag='author')<-'g.d.hong'
paper[[2]]$meta

tm_map(corpus,func)

# 특수문자 앞뒤의 단어 추출
library(stringr)
myfunc<-function(x){
  str_extract_all(x,'[[:alnum:]]{1,}[[:punct:]]{1}[[:alnum:]]{1,}')
}
punct<-lapply(paper,myfunc)
table(unlist(punct))


# 수치 data 확인
myfunc<-function(x){
  digit<-str_extract_all(x,'[[:digit:]]{1,}')
}
digit<-lapply(paper,myfunc)
table(unlist(digit))


# 고유명사 추출
myfunc<-function(x){
  uppers<-str_extract_all(x,'[[:upper:]]{1}[[:alpha:]]{1,}')
}
uppers<-lapply(paper,myfunc)
table(unlist(uppers))

# 숫자 제거
corpus<-tm_map(paper,removeNumbers)

# 특정 pat 대체하기
tempfunc<-function(obj,oldexp,newexp){
  newobj<-tm_map(obj,content_transformer(
    function(x,pat) gsub(pat,newexp,x)),oldexp)
  newobj
}
corpus<-tempfunc(paper,'e\\.g\\.','for example')
corpus<-tempfunc(paper,'and/or','and or')
corpus<-tempfunc(paper,'-collar','collar')

corpus<-tm_map(paper,removeNumbers)
corpus<-tm_map(corpus,removePunctuation)
corpus<-tm_map(corpus,stripWhitespace)
corpus<-tm_map(corpus,content_transformer(tolower))
corpus<-tm_map(corpus,removeWords,word=stopwords('SMART'))
corpus<-tm_map(corpus,stemDocument,language='en')
    

# 문자 갯수 계산
charfunc<-function(x){
  str_extract_all(x,'.')
}
char<-lapply(paper,charfunc)
length(table(unlist(char)))
uniquechar<-length(table(unlist(char)))
sum(table(unlist(char)))
totalchar<-sum(table(unlist(char)))
c(uniquechar,totalchar)

# 단어 갯수 계산
wordfunc<-function(x){
  str_extract_all(x,boundary('word'))
}
word<-lapply(paper,wordfunc)
uniqueword<-length(table(unlist(word)))
totalword<-sum(table(unlist(word)))
c(uniqueword,totalword)



# 전처리 후 와 비교
char<-lapply(corpus,charfunc)
uniquechar_new<-length(table(unlist(char)))
totalchar_new<-sum(table(unlist(char)))
c(uniquechar_new,totalchar_new)

word<-lapply(corpus,wordfunc)
uniqueword_new<-length(table(unlist(word)))
totalword_new<-sum(table(unlist(word)))
c(uniqueword_new,totalword_new)

result<-rbind(c(uniquechar,totalchar),
              c(uniqueword,totalword),
              c(uniquechar_new,totalchar_new),
              c(uniqueword_new,totalword_new))
colnames(result)<-c('before','after')
rownames(result)<-c('문자갯수','총문자갯수','단어갯수','총단어갯수')
result


dtm<-DocumentTermMatrix(corpus)
rownames(dtm[,])
colnames(dtm)
inspect(dtm[1:3,50:52])



## TF-IDF (토픽 모델링)
dtm_tfidf<-DocumentTermMatrix(corpus,
                   control=list(weighting=function(x) weightTfIdf(x,normalize=FALSE)))
inspect(dtm_tfidf)
inspect(dtm_tfidf[1:3,50:53])


## TF-IDF matrix 만들기
# tf vector / tfidf vector 생성
dtm_vector<-as.vector(as.matrix(dtm[,]))
dtm_tfidf_vector<-as.vector(as.matrix(dtm_tfidf[,]))

dim(dtm)[1]
colnames(dtm)

# word label / doc label 생성 
word_label_dtm<-rep(colnames(dtm),each=dim(dtm)[1])
doc_label_dtm<-rep(rownames(dtm),times=dim(dtm)[2])

# df 생성
df<-data.frame(word_label_dtm,doc_label_dtm,dtm_vector,dtm_tfidf_vector)
colnames(df)<-c('word','doc','tf','tfidf')
df[120:130,]

## 상관계수 구하기
# cor.test(x,y,method='')
cor.test(df$tf,df$tfidf,method='kendall')

cor.test(df$tf[df$tf>0],df$tfidf[df$tfidf>0],method='kendall')
# tf 순위가 높아도 tfidf 순위가 높지 않은 경우가 적지 않다


## tf 높지만 tfidf 낮은 단어 추출
# 1) tf>0, tfidf>0 data 선별
# subset(data,조건)   -> 조건을 만족하는 df 추출
subdf<-subset(df,tf>0&tfidf>0)
# 2) tf>m, tfidf<m data 선별
subdf<-subset(subdf,tf>median(subdf$tf)&tfidf>median(subdf$tfidf))
table(subdf$word)[table(subdf$word)>0]
