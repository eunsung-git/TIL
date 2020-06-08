## mini_proj_python

### 상관계수 추천 system_영화평점



```python
import pandas as pd
import numpy as np

from math import sqrt

import matplotlib.pyplot as plt


path=r'C:\\Users\\student\\Desktop\\공부\\멀캠TIL\\dataset\\python\\movielens'

ratings=pd.read_csv(path+'\\ratings.csv')
movies=pd.read_csv(path+'\\movies.csv')

# ratings 데이터를 userId가 인덱스로 movieId가 컬럼으로 가도록 재구성
data=pd.pivot_table(ratings, 'rating', 'userId', 'movieId')

# NaN 값을 -1로 변경
data.fillna(-1, inplace=True)



## 상관 계수를 이용해 추천 영화 및 예상 평점 출력

def sim_pearson(data, n1, n2):
    sumX=0
    sumY=0
    sumSqX=0
    sumSqY=0
    sumXY=0
    cnt=0

    for i in data.loc[n1, data.loc[n1, :]>=0].index:
        if data.loc[n2, i]>=0:
            sumX+=data.loc[n1, i]
            sumY+=data.loc[n2, i]
            sumSqX+=pow(data.loc[n1, i], 2)
            sumSqY+=pow(data.loc[n2, i], 2)
            sumXY+=(data.loc[n1, i] * data.loc[n2, i])
            cnt+=1
            
    if cnt != 0:
        return (sumXY-((sumX*sumY)/cnt)) / sqrt(((sumSqX-(pow(sumX, 2)/cnt)) * (sumSqY-(pow(sumY, 2)/cnt)))+1e-7)
    
    
def top_match(data, name, rank=2, simf=sim_pearson):
    simList=[]
    for i in data.index:
        if name != i:
            if simf(data, name, i) is not None:
                simList.append((simf(data, name, i), i))
    simList.sort()
    simList.reverse()
    
    return simList[:rank]


def recommendation(data, person, simf=sim_pearson):
    res=top_match(data, person, len(data))
    score_dic={}
    sim_dic={}
    myList=[]
    for sim, name in res:
        if sim<0:
            continue
        for movie in data.loc[person, data.loc[person, :]<0].index:
            simSum=0
            if data.loc[name, movie]>=0:
                simSum+=sim * data.loc[name, movie]
                
                score_dic.setdefault(movie, 0)
                score_dic[movie]+=simSum
                
                sim_dic.setdefault(movie, 0)
                sim_dic[movie]+=sim
                
    for key in score_dic:
        myList.append((score_dic[key] / (sim_dic[key]+1e-7), key))
    myList.sort()
    myList.reverse()
    
    return myList

# userId=1 에게 영화 상위 10개 추천
movieList=[]
for r, m_id in recommendation(data, 1):
    movieList.append((r, movies.loc[movies['movieId']==m_id, 'title'].values[0]))
movieList[:10]
> [(4.999999499999993, 'Convent, The (O Convento) (1995)'),
>  (4.999999373183189, 'Chaperone, The (2011)'),
>  (4.999999373183189, 'Color of Friendship, The (2000)'),
>  (4.9999991873013885, 'Story of G.I. Joe (1945)'),
>  (4.999999175543349, 'Shelter (2007)'),
>  (4.999999133973823, 'Bigger Than the Sky (2005)'),
>  (4.999999056103958,
  'Investigation of a Citizen Above Suspicion (Indagine su un cittadino al di sopra di ogni sospetto) (1970)'),
>  (4.999999034236146, 'Slaves of New York (1989)'),
>  (4.999998922988259, 'To Have, or Not (En avoir (ou pas)) (1995)'),
>  (4.999998887128813, 'Secrets of Jonathan Sperry, The (2008)')]



```

