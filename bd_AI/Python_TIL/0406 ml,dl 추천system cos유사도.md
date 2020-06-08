>추천system - 사용자의 취향 파악
>
>* contents 기반 
>
>* 협업 기반   
>
>  - memory 기반      ex) KNN
>    - 사용자 기반   :  사용자row x item col
>    - item 기반   :  item row x 사용자 col
>
>  - 잠재요인(latent factor) 기반





```python
import pandas as pd
import numpy as np

from math import sqrt

import matplotlib.pyplot as plt

critics={
    'BTS':{'암수살인':5, '바울':4, '할로윈':1.5},
    '손흥민':{'바울':5, '할로윈':2},
    '레드벨벳':{'암수살인':2.5, '바울':2, '할로윈':1},
    '트와이스':{'암수살인':3.5, '바울':4, '할로윈':5}
}

critics['BTS'](=critics.get('BTS'))
> {'암수살인': 5, '바울': 4, '할로윈': 1.5}

critics.get('BTS').get('바울')
> 4

---------------------------------------------------------

# 유사도 1) 두 점 사이의 거리
def sim(i,j):
    return sqrt(pow(i,2)+pow(j,2))
v1=critics['손흥민']['바울']-critics['레드벨벳']['바울']
v2=critics['레드벨벳']['할로윈']-critics['손흥민']['할로윈']
print(sim(v1,v2))
> 3.1622776601683795

# 피타고라스 활용 두 점 사이의 거라
for i in critics:
    if i != '손흥민':
        d1=critics.get('손흥민').get('바울')- critics.get(i).get('바울')
    if i != '손흥민':
        d2=critics.get('손흥민').get('할로윈')- critics.get(i).get('할로윈')
        print(i, '와의 거리 : ',sim(d1,d2))
> BTS 와의 거리 :  1.118033988749895
> 레드벨벳 와의 거리 :  3.1622776601683795
> 트와이스 와의 거리 :  3.1622776601683795
    
## 피타고라스 활용 유사도 측정
for i in critics:
    if i != '손흥민':
        d1=critics.get('손흥민').get('바울')- critics.get(i).get('바울')
    if i != '손흥민':
        d2=critics.get('손흥민').get('할로윈')- critics.get(i).get('할로윈')
        #print(i, '와의 거리 : ',sim(d1,d2))
        print(i, '와의 유사도 : ',1/(sim(d1,d2)+1))
> BTS 와의 유사도 :  0.4721359549995794
> 레드벨벳 와의 유사도 :  0.2402530733520421
> 트와이스 와의 유사도 :  0.2402530733520421
    

## 특정 값과의 유사도
def sim_distance(data,name1,name2):
    sum=0
    for i in data[name1]:
        if i in data[name2]:
            sum+=pow(data[name1][i]-data[name2][i],2)
    return 1/(sqrt(sum)+1)
    
sim_distance(critics,'BTS','손흥민')
> 0.4721359549995794


## critics에서 BTS와 공통으로 본 영화 중, 평점이 가장 유사한 관객 n명 추출
# top_match(영화평점data,기준관객,등수,유사도함수)
def top_match(data,name,rank=3,simf=sim_distance):
    sim_list=[]
    for i in data:
        if name != i:
            sim_list.append((simf(data,name,i),i))
            sim_list.sort()
            sim_list.reverse()
    return sim_list[:rank]

print(top_match(critics,'BTS',2))
> [(0.4721359549995794, '손흥민'), (0.23582845781094, '레드벨벳')]

    
```



```python
critics = {
    '레드벨벳': {
        '택시운전사': 2.5,
        '겨울왕국': 3.5,
        '리빙라스베가스': 3.0,
        '넘버3': 3.5,
        '사랑과전쟁': 2.5,
        '세계대전': 3.0,
    },
    'BTS': {
        '택시운전사': 1.0,
        '겨울왕국': 4.5,
        '리빙라스베가스': 0.5,
        '넘버3': 1.5,
        '사랑과전쟁': 4.5,
        '세계대전': 5.0,
    },
    '블랙핑크': {
        '택시운전사': 3.0,
        '겨울왕국': 3.5,
        '리빙라스베가스': 1.5,
        '넘버3': 5.0,
        '세계대전': 3.0,
        '사랑과전쟁': 3.5,
    },
    '소녀시대': {
        '택시운전사': 2.5,
        '겨울왕국': 3.0,
        '넘버3': 3.5,
        '세계대전': 4.0,
    },
    '마마무': {
        '겨울왕국': 3.5,
        '리빙라스베가스': 3.0,
        '세계대전': 4.5,
        '넘버3': 4.0,
        '사랑과전쟁': 2.5,
    },
    '오마이걸': {
        '택시운전사': 3.0,
        '겨울왕국': 4.0,
        '리빙라스베가스': 2.0,
        '넘버3': 3.0,
        '세계대전': 3.5,
        '사랑과전쟁': 2.0,
    },
    '모모랜드': {
        '택시운전사': 3.0,
        '겨울왕국': 4.0,
        '세계대전': 3.0,
        '넘버3': 5.0,
        '사랑과전쟁': 3.5,
    },
    '우주소녀': {'겨울왕국': 4.5, '사랑과전쟁': 1.0,
             '넘버3': 4.0},
}

##  특정 관객에 대한 상관계수
def sim_pearson(data,n1,n2):
    sumx=0
    sumy=0
    sumsqx=0
    sumsqy=0
    sumxy=0
    cnt=0
    for i in data[n1]:
        if i in data[n2]:
            sumx+=data[n1][i]
            sumy+=data[n2][i]
            sumsqx+=pow(data[n1][i],2)
            sumsqy+=pow(data[n2][i],2)
            sumxy+=data[n1][i]*data[n2][i]
            cnt+=1
    return (sumxy-((sumx*sumy)/cnt)) / sqrt((sumsqx-(pow(sumx,2)/cnt))*(sumsqy-(pow(sumy,2)/cnt)))  

sim_pearson(critics, 'BTS', '블랙핑크')
> 0.21693045781865616


## 전체 관객에 대한 상관계수
# critics에서 BTS와 공통으로 본 영화 중, 상관계수가 가장 높은 관객 n명 추출
def top_match(data,name,rank=3,simf=sim_pearson):
    sim_list=[]
    for i in data:
        if name != i:
            sim_list.append((simf(data,name,i),i))
            sim_list.sort()
            sim_list.reverse()
    return sim_list[:rank]

print(top_match(critics,'BTS',5))
> [(0.5692099788303083, '소녀시대'), (0.41791069697885247, '오마이걸'), (0.21693045781865616, '블랙핑크'), (0.15430334996209194, '마마무'), (0.05477225575051661, '레드벨벳')]

---------------------------------------------------------

### 추천 model
# 1) 평점 추측 = 유사도 * 상대방의 평점
# 2) 추측 평점의 총합 / 유사도 총합  -> 모든 관객을 고려했을 때 예상되는 평점
# 3) 예상 평점을 기준으로 예상 평점이 가장 높은 영화 추천

def recommendation(data,person,simf=sim_pearson):
    res=top_match(data,person,len(data))
    
    simsum=0  # 상관계수(유사도) 합
    score_dic={}  # 예상 평점 총합
    sim_dic={}   # 유사도 총합
    list=[]
    for sim, name in res:
        if sim<0 : continue
        for movie in data[name]:
            if movie not in data[person]:
                simsum+=sim*data[name][movie]
                score_dic.setdefault(movie,0)
                score_dic[movie]+=simsum
                
                sim_dic.setdefault(movie,0)
                sim_dic[movie]+=sim
    
  			simsum=0  # 영화 변경  ->  0으로 초기화
    
    for key in score_dic:
        score_dic[key]=score_dic[key]/sim_dic[key]
        list.append((score_dic[key],key))
    list.sort()
    list.reverse()
    return list

recommendation(critics,'소녀시대')
> [(3.0761574975571793, '사랑과전쟁'), (2.1938491995536373, '리빙라스베가스')]

```





```python
path=r'C:\\Users\\student\\Desktop\\공부\\멀캠TIL\\dataset\\python\\영화평점'

data=pd.read_excel(path+'\\영화평점 (1).xlsx',header=1)

# 영화 list 저장
movie_list=data.columns
movie_list=movie_list[1:]

# data 전처리 및 dict type으로 변경
data=data.rename({'Unnamed: 0':'이름'},axis='columns') 
data=data.set_index('이름')
data=data.T
dic_data=data.to_dict()

# 평점이 nan인 영화는 제거
import math
for name in dic_data:
    for movie in movie_list:
        if math.isnan(dic_data[name][movie])!= True : continue
        else : del dic_data[name][movie]

-----------------------------------------------------------

## 나와 상관계수가 가장 높은 5명 추출
def sim_pearson(data,n1,n2):
    sumx=0
    sumy=0
    sumsqx=0
    sumsqy=0
    sumxy=0
    cnt=0
    for i in data[n1]:
        if i in data[n2]:
            sumx+=data[n1][i]
            sumy+=data[n2][i]
            sumsqx+=pow(data[n1][i],2)
            sumsqy+=pow(data[n2][i],2)
            sumxy+=data[n1][i]*data[n2][i]
            cnt+=1
            
    # 상관계수 분모가 0인 경우 처리
    #corr=(sumxy-((sumx*sumy)/cnt))/sqrt((sumsqx-(pow(sumx,2)/cnt))*(sumsqy-(pow(sumy,2)/cnt)))
    numerator=sumxy-((sumx*sumy)/cnt)
    denominator=(sumsqx-(pow(sumx,2)/cnt))*(sumsqy-(pow(sumy,2)/cnt))
    if denominator==0 : corr=0
    else : corr=numerator/sqrt(denominator)
    
    return corr 


def top_match(data,name,rank=3,simf=sim_pearson):
    sim_list=[]
    for i in data:
        if name != i:
            sim_list.append((simf(data,name,i),i))
            sim_list.sort()
            sim_list.reverse()
    return sim_list[:rank]

print(top_match(dic_data,'이은성',5))
> [(1.0, '이성천'), (1.0, '엄다연'), (0.9819805060619622, '정한음'), (0.9604721435546506, '유기욱'), (0.9561828874675149, '오종민')]

-----------------------------------------------------------

## 내가 안 본 영화 중 추천 점수가 높은 순으로 (제목,예상평점) 출력
def recommendation(data,person,simf=sim_pearson):
    res=top_match(data,person,len(data))
    
    simsum=0  # 상관계수(유사도) 합
    score_dic={}  # 예상 평점 총합
    sim_dic={}   # 유사도 총합
    list=[]
    for sim, name in res:
        if sim<0 : continue
        for movie in data[name]:
            if movie not in data[person]:
                simsum+=sim*data[name][movie]
                score_dic.setdefault(movie,0)
                score_dic[movie]+=simsum
                
                sim_dic.setdefault(movie,0)
                sim_dic[movie]+=sim
    
        simsum=0# 영화 변경  ->  0으로 초기화
    
    for key in score_dic:
        score_dic[key]=score_dic[key]/sim_dic[key]
        list.append((score_dic[key],key))
    list.sort()
    list.reverse()
    return list

recommendation(dic_data,'이은성')
> [(10.73978821802968, '부산행'),
 (7.000918231128825, '택시운전사'),
 (4.117118204376513, '국제시장')]

```



