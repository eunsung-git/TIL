## 웹 스크래핑
install.packages('rvest')
library(rvest)
library(dplyr)

url_tvcast='https://tv.naver.com/jtbc.youth'
# read_html()
html_tvcast<-read_html(url_tvcast,encoding='UTF-8')

# html_node()   -> 해당되는 요소 하나 추출
# html_nodes()   -> 해당되는 모든 모든 요소 추출
html_tvcast %>% html_nodes('.title a')



# html_text()   -> 해당 요소의 text를 vector로 출력
tvcast_res<-html_tvcast %>% html_nodes('.title a') %>%
  html_text() 

tvcast_df<-html_tvcast %>% html_nodes('.title a') %>%
  html_text() %>% data.frame()





### 표 크롤링
html_wiki<-read_html('https://en.wikipedia.org/wiki/Student%27s_t-distribution',encoding='UTF-8')

html_wiki %>% html_nodes('.wikitable')

# html_table()  -> 소스코드 속 data 추출
html_wiki %>% html_nodes('.wikitable') %>%
  html_table()


# html_name()  -> attribute 이름 추출
# html_children()  -> 하위 요소 추출
# html_tag()  -> 태그명 추출
# html_attrs()  -> 속성 추출



### 한국어 자연어처리
install.packages("Sejong")
install.packages("hash")
install.packages("tau")
install.packages("RSQLite")
install.packages("rgdal")
install.packages("geojsonio")
install.packages("rgeos")

library(Sejong)
library(hash)
library(tau)
library(RSQLite)
library(rgdal)
library(geojsonio)
library(rgeos)

install.packages('KoNLP')
library(KoNLP)


text_loc<-'C:/Users/student/Desktop/공부/멀캠TIL/dataset/R/dataset_for_ml/dataset_for_ml/논문data/ymbaek_논문'
paper<-VCorpus(DirSource(text_loc))
korean<-paper[[19]]$content

## text 전처리
library(stringr)
# 영단어 제거
korean<-str_replace_all(korean,'[[:lower:]]','')
# 괄호 제거
korean<-str_replace_all(korean,'\\(','')
korean<-str_replace_all(korean,'\\)','')
# '' 제거
korean<-str_replace_all(korean,"‘",'')
korean<-str_replace_all(korean,"’",'')
# '·' 를 comma로 변경
korean<-str_replace_all(korean,"·",', ')

## 명사만 추출
noun_kor<-extractNoun(korean)
table(noun_kor)
