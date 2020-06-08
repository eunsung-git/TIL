## mini_proj_python

### 협업filtering_영화평점

#### item기반_영화 추천system

```python
# data 불러오기
import pandas as pd
path = r'C:\\Users\\student\\Desktop\\dataset\\python\\movielens'

ratings = pd.read_csv(path+'\\ratings.csv')
movies = pd.read_csv(path+'\\movies.csv')

# 필요없는 column 제거
ratings.drop('timestamp',axis=1, inplace=True)

# item(영화) 기준 data 병합
ratings_movies = pd.merge(ratings, movies, on='movieId')

# 사용자 * 아이템 table 생성 & nan 제거
user_movie = ratings_movies.pivot_table('rating', index='userId', columns='title').fillna(0)

# 아이템 * 사용자 table 형태로 변경
movie_user = user_movie.T

# cos 유사도 기반 상위 10개 영화 추천
from sklearn.metrics.pairwise import cosine_similarity
cos_sim = cosine_similarity(movie_user,movie_user)
cos_sim_df = pd.DataFrame(data=cos_sim, index=movie_user.index, columns=movie_user.index)
cos_sim_df['Huckleberry Finn (1974)'].sort_values(ascending=False)[1:10]
> title
> Open Season 2 (2008)                                 0.741999
> Happily Ever After (1993)                            0.722315
> Kids in America (2005)                               0.659380
> Nothing (2003)                                       0.548821
> Wild Child (2008)                                    0.485071
> After School Special (a.k.a. Barely Legal) (2003)    0.479632
> Daddy Day Camp (2007)                                0.456172
> 300 Spartans, The (1962)                             0.434145
> Copying Beethoven (2006)                             0.424264
Name: Huckleberry Finn (1974), dtype: float64



```

