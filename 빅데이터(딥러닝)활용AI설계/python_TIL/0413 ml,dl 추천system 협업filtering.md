###  협업 filtering



#### 1)  contents 기반

```python
### bow : str vec -> num vec
corpus = ['This is the first document','This is the second document','This is the second document','And the third one','Is this the first document?','The last document?']


## 1) DictVectorizer : 단어 갯수로 bow vector 생성
from sklearn.feature_extraction import DictVectorizer
dv = DictVectorizer(sparse=False)
data = [{'a':1,"b":2},{'b':3,'c':1}]

print(dv.fit_transform(data))
> [[1. 2. 0.]
 [0. 3. 1.]]
print(dv.feature_names_)
> ['a', 'b', 'c']
print(dv.transform({'c':4,'d':3}))
> [[0. 0. 4.]]


## 2) CountVectorizer : 단어 토큰화 후 토큰 갯수로 bow vector 생성
from sklearn.feature_extraction.text import CountVectorizer
cv = CountVectorizer()
cv.fit(corpus)

print(cv.vocabulary_)
> {'this': 9, 'is': 3, 'the': 7, 'first': 2, 'document': 1, 'second': 6, 'and': 0, 'third': 8, 'one': 5, 'last': 4}

print(cv.transform(['This is the second document']).toarray())
>[[0 1 0 1 0 0 1 1 0 1]]

print(cv.transform(corpus).toarray())
> [[0 1 1 1 0 0 0 1 0 1]
 [0 1 0 1 0 0 1 1 0 1]
 [0 1 0 1 0 0 1 1 0 1]
 [1 0 0 0 0 1 0 1 1 0]
 [0 1 1 1 0 0 0 1 0 1]
 [0 1 0 0 1 0 0 1 0 0]]


cv2 = CountVectorizer(stop_words=['and','is','the','this']).fit(corpus)
cv2.vocabulary_
> {'first': 1, 'document': 0, 'second': 4, 'third': 5, 'one': 3, 'last': 2}

cv3 = CountVectorizer(stop_words='english').fit(corpus)
cv3.vocabulary_
> {'document': 0, 'second': 1}

cv4 = CountVectorizer(analyzer='char').fit(corpus)
cv4.vocabulary_
> {'t': 15,
 'h': 7,
 'i': 8,
 's': 14,
 ' ': 0,
 'e': 5,
 'f': 6,
 'r': 13,
 'd': 4,
 'o': 12,
 'c': 3,
 'u': 16,
 'm': 10,
 'n': 11,
 'a': 2,
 '?': 1,
 'l': 9}

cv5 = CountVectorizer(token_pattern="t\w+").fit(corpus)
cv5.vocabulary_
> {'this': 2, 'the': 0, 'third': 1}

import nltk
cv6 = CountVectorizer(tokenizer=nltk.word_tokenize).fit(corpus)
cv6.vocabulary_
> {'this': 10,
 'is': 4,
 'the': 8,
 'first': 3,
 'document': 2,
 'second': 7,
 'and': 1,
 'third': 9,
 'one': 6,
 '?': 0,
 'last': 5}

cv7 = CountVectorizer(ngram_range=(1,2)).fit(corpus)
cv7.vocabulary_
> {'this': 20,
 'is': 5,
 'the': 13,
 'first': 3,
 'document': 2,
 'this is': 21,
 'is the': 6,
 'the first': 14,
 'first document': 4,
 'second': 11,
 'the second': 16,
 'second document': 12,
 'and': 0,
 'third': 18,
 'one': 10,
 'and the': 1,
 'the third': 17,
 'third one': 19,
 'is this': 7,
 'this the': 22,
 'last': 8,
 'the last': 15,
 'last document': 9}

cv8 = CountVectorizer(max_df=4,min_df=2).fit(corpus)
cv8.vocabulary_
> {'this': 3, 'is': 1, 'first': 0, 'second': 2}


## 3) Tfidfvectorizer : CountVectorizer와 유사, tf-idf 방식으로 bow vector 생성
tfidf = TfidfVectorizer().fit(corpus)
tfidf.transform(corpus).toarray()
> array([[0.        , 0.37811773, 0.60520354, 0.43784911, 0.        ,
        0.        , 0.        , 0.32761557, 0.        , 0.43784911],
       [0.        , 0.37811773, 0.        , 0.43784911, 0.        ,
        0.        , 0.60520354, 0.32761557, 0.        , 0.43784911],
       [0.        , 0.37811773, 0.        , 0.43784911, 0.        ,
        0.        , 0.60520354, 0.32761557, 0.        , 0.43784911],
       [0.55927514, 0.        , 0.        , 0.        , 0.        ,
        0.55927514, 0.        , 0.24826187, 0.55927514, 0.        ],
       [0.        , 0.37811773, 0.60520354, 0.43784911, 0.        ,
        0.        , 0.        , 0.32761557, 0.        , 0.43784911],
       [0.        , 0.42407356, 0.        , 0.        , 0.82774046,
        0.        , 0.        , 0.36743345, 0.        , 0.        ]])


## 4) HashingVectorizer : 메모리 절약, 속도 빠름
from sklearn.datasets import fetch_20newsgroups
twenty = fetch_20newsgroups()
len(twenty.data)
> 11314

from sklearn.feature_extraction.text import HashingVectorizer
hv = HashingVectorizer(n_features=300000)
hv.transform(twenty.data)

```



```python
import pandas as pd

path = r'C:\\Users\\student\\Desktop\\dataset\\python\\tmdb-movie-metadata'

data = pd.read_csv(path+'\\tmdb_5000_movies.csv')
data = data[['id','genres', 'keywords','vote_average', 'vote_count','popularity','title','overview']]

m = data['vote_count'].quantile(0.9)
data = data[data['vote_count']>=m]

# str data를 num처럼 취급
import ast
from ast import literal_eval

data.genres = data.genres.apply(literal_eval)
data.keywords = data.keywords.apply(literal_eval)

data.genres = data.genres.apply(lambda x : [d['name'] for d in x]).apply(lambda x : ' '.join(x))
data.keywords = data.keywords.apply(lambda x : [d['name'] for d in x]).apply(lambda x : ' '.join(x))

# genres data를 CountVectorized
count_vec = CountVectorizer(ngram_range=(1,3))
count_vec_genres = count_vec.fit_transform(data.genres)
count_vec_genres.shape
> (481,364)


## 영화별 cos 유사도 측정 & 내림차순 sort
genres_cos_sim = cosine_similarity(count_vec_genres,count_vec_genres).argsort()[:,::-1]
genres_cos_sim
> array([[  0,  13,  42, ..., 298, 297, 240],
       [ 11,   1, 200, ..., 329, 330, 240],
       [  2, 376, 216, ..., 314, 304, 240],
       ...,
       [478, 187,  12, ..., 326, 327,   0],
       [479, 466, 383, ..., 220, 224,   0],
       [480, 468, 294, ..., 246, 248,   0]], dtype=int64)
genres_cos_sim.shape
> (481,481)


## cos유사도 기반 영화 추천 함수 작성
# 유사도 높은 30개 영화 추천
def movie_recommendation(df,movie_title,top=30):
    target_movie_index = df[df['title']==movie_title].index.values
    sim_index = genres_cos_sim[target_movie_index, :top].reshape(-1)
    sim_index = sim_index[sim_index != target_movie_index]
    res = df.iloc[sim_index].sort_values('vote_count',ascending=False)[:10]
    return res
    
movie_recommendation(data, movie_title='The Dark Knight Rises')

```





#### 2)  items기반 

```python
path = r'C:\\Users\\student\\Desktop\\dataset\\python\\the-movies-dataset'

data = pd.read_csv(path+'\\ratings_small.csv')

# user - item table 구성
data = data.pivot_table('rating',index='userId',columns='movieId')

ratings = pd.read_csv(path+'\\ratings_small.csv')


path = r'C:\\Users\\student\\Desktop\\dataset\\python\\tmdb-movie-metadata'
movies = pd.read_csv(path+'\\tmdb_5000_movies.csv')
movies.rename(columns={'id':'movieId'},inplace=True)

ratings_movies = pd.merge(ratings, movies, on='movieId')

# 사용자별 영화 평점
data = ratings_movies.pivot_table('rating',index='userId',columns='title').fillna(0)

# 영화별 사용자 평점
data = data.T

## 영화별 cos유사도 기반 10개 영화 추천
movie_sim = cosine_similarity(data,data)
movie_sim_df = pd.DataFrame(data=movie_sim, index=data.index, columns=data.index)
movie_sim_df['Romeo Must Die'].sort_values(ascending=False)[1:10]

```





#### 3)  행렬분해 (SVD) 기반

```python
path = r'C:\\Users\\student\\Desktop\\dataset\\python\\movielens-small'

rating = pd.read_csv(path+'\\ratings.csv')
movie = pd.read_csv(path+'\\movies.csv')

from sklearn.decomposition import TruncatedSVD
from scipy.sparse.linalg import svds
import warnings
warnings.filterwarnings('ignore')

rating.drop('timestamp',axis=1,inplace=True)
movie.drop('genres',axis=1,inplace=True)

user_movie = pd.merge(rating, movie, on='movieId')
user_movie_rating = user_movie.pivot_table('rating',index='userId',columns='title').fillna(0)

movie_user_rating = user_movie_rating.T
movie_user_rating.shape
> (9064, 671)


## Truncated SVD 
# (9064,671) -> (9064,12)
svd_mat = TruncatedSVD(n_components=12).fit_transform(movie_user_rating)
svd_mat.shape
> (9064, 12)

# pearson 상관계수
corr = np.corrcoef(svd_mat)

movie_title = user_movie_rating.columns
movie_title_list = list(movie_title)
gog = movie_title_list.index('Guardians of the Galaxy (2014)')
list(movie_title[corr[gog]>=0.9])[:50]
> ['10,000 BC (2008)',
 '2 Guns (2013)',
 '2012 (2009)',
 '21 (2008)',
 '300: Rise of an Empire (2014)',
 'Abduction (2011)',
 'Adjustment Bureau, The (2011)',
 'Adventures of Tintin, The (2011)',
 'Alice in Wonderland (2010)',
 'Amazing Spider-Man, The (2012)']











```



 

