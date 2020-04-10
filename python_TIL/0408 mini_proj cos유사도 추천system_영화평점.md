## mini_proj_python

### cos 유사도 추천system_영화평점



```python
import pandas as pd
path=r'C:\\Users\\student\\Desktop\\공부\\멀캠TIL\\dataset\\python\\the-movies-dataset'

data=pd.read_csv(path+'\\movies_metadata.csv')

data=data.head(20000)

# 결측값 처리
data['overview'].isnull().sum()
> 135

data['overview'] = data['overview'].fillna('')


## 불용어 처리 후 tf-idf
from sklearn.feature_extraction.text import TfidfVectorizer
tfidf=TfidfVectorizer(stop_words='english')
tfidf_matrix=tfidf.fit_transform(data['overview'])

tfidf_matrix.shape
> (20000, 47487)  # (20000 영화, 47487 단어)


## cos 유사도 구하기
from sklearn.metrics.pairwise import linear_kernel
cos_sim=linear_kernel(tfidf_matrix, tfidf_matrix)


# 영화제목&index df 생성
title_index=pd.Series(data.index, index=data['title']).drop_duplicates()
title_index.head()


## 'Toy Story'와 가장 유사한 10개 영화 추천
def movie_recommendations(title, cos_sim=cos_sim):
    # 해당 영화의 index 추출
    idx=title_index[title]

    # 모든 영화에 대해서 해당 영화와의 유사도 추출
    sim_scores=list(enumerate(cos_sim[idx]))

    # 유사도에 따라 영화 정렬
    sim_scores=sorted(sim_scores, key=lambda x: x[1], reverse=True)

    # 가장 유사한 10개의 영화/index 추출
    sim_scores=sim_scores[1:11]
    movie_index=[i[0] for i in sim_scores]

    # 가장 유사한 10개의 영화 제목 출력
    return data['title'].iloc[movie_index]

movie_recommendations('Toy Story')
> 15348               Toy Story 3
> 2997                Toy Story 2
> 10301    The 40 Year Old Virgin
> 8327                  The Champ
> 1071      Rebel Without a Cause
> 11399    For Your Consideration
> 1932                  Condorman
> 3057            Man on the Moon
> 485                      Malice
> 11606              Factory Girl


```

