## mini_proj_python

### SVD (특이값 분석)_news20



```python
# news20 data 불러오기
from sklearn.datasets import fetch_20newsgroups
dataset=fetch_20newsgroups(shuffle=True, random_state=1, remove=('headers','footers','quotes'))

documents=dataset.data
type(documents)
> List

# 20개 topic 출력
dataset.target_names
> ['alt.atheism', 'comp.graphics', 'comp.os.ms-windows.misc', 'comp.sys.ibm.pc.hardware', 'comp.sys.mac.hardware', 'comp.windows.x', 'misc.forsale', 'rec.autos', 'rec.motorcycles', 'rec.sport.baseball', 'rec.sport.hockey', 'sci.crypt', 'sci.electronics', 'sci.med', 'sci.space', 'soc.religion.christian', 'talk.politics.guns', 'talk.politics.mideast', 'talk.politics.misc', 'talk.religion.misc']

--------------------------------------------------------

## text 전처리
import pandas as pd
newsdf=pd.DataFrame({'document':documents})

# 알파벳 제외하고 모두 제거
newsdf['clean_doc']=newsdf['document'].str.replace("[^a-zA-Z]"," ")

# 3글자 이하 단어 제거
newsdf['clean_doc']=newsdf['clean_doc'].apply(lambda x: ' '.join([w for w in x.split() if len(w)>3]))

# 대문자 -> 소문자
newsdf['clean_doc']=newsdf['clean_doc'].apply(lambda x: x.lower())

# 단어 토큰화 후 불용어 제거
from nltk.corpus import stopwords
stopwords=stopwords.words('english')

news_tk=newsdf['clean_doc'].apply(lambda x:x.split())
news_tk=news_tk.apply(lambda x: [item for item in x if item not in stopwords])

--------------------------------------------------------

## tf-idf

# tf-idf matrix 생성을  위해 역토큰화
news_detk=[]
for i in range(len(newsdf)):
    temp=' '.join(news_tk[i])
    news_detk.append(temp)
newsdf['clean_doc']=news_detk

#  tf_idf 만들기
from sklearn.feature_extraction.text import TfidfVectorizer
tfidf=TfidfVectorizer(stop_words='english', max_features=1000)
tfidf_matrix=tfidf.fit_transform(newsdf['clean_doc'])

-------------------------------------------------------

## 특이값 분해 (SVD)
from sklearn.decomposition import TruncatedSVD

#  topic 갯수 지정 후 fit
svd=TruncatedSVD(n_components=20)
svd.fit(tfidf_matrix)

# VT 구하기
import numpy as np
np.shape(svd.components_)
> (20, 1000)

# 1000개의 feature 추출
terms=tfidf.get_feature_names()

# 각 topic과 가장 관련성 높은 단어 10개씩 출력
def get_topic(c, fname, n=10):
    for  i,t  in enumerate(c):
        print('topic %d : ' % (i+1),[(fname[i], t[i].round(5)) for i in t.argsort()[:-n-1:-1]])
 
get_topic(svd.components_, terms)
> topic 1 :  [('like', 0.21386), ('know', 0.20046), ('people', 0.19293), ('think', 0.17805), ('good', 0.15128), ('time', 0.14446), ('thanks', 0.11628), ('make', 0.10882), ('right', 0.10738), ('want', 0.10442)]
> topic 2 :  [('thanks', 0.32907), ('windows', 0.29098), ('card', 0.18065), ('drive', 0.17455), ('mail', 0.15092), ('file', 0.14641), ('advance', 0.12512), ('files', 0.1148), ('software', 0.1136), ('program', 0.10514)]
> topic 3 :  [('game', 0.37179), ('team', 0.32375), ('year', 0.28009), ('games', 0.25468), ('season', 0.18427), ('players', 0.16), ('good', 0.15789), ('play', 0.15102), ('hockey', 0.13759), ('league', 0.11976)] .......

```



