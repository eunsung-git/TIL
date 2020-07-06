## personal_proj

### 2020 KBO리그 기록 예측 웹페이지 만들기



#### 1. 데이터 전처리

```python
# 투수 데이터 불러오기 및 df 생성

import pandas as pd
import os
player_list_2015 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2015')
player_list_2016 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2016')
player_list_2017 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2017')
player_list_2018 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2018')
player_list_2019 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2019')

path_2015 = 'C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2015/'
player_2015 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_2015+player_list_2015[i], delimiter = '\t')
    player_2015 = pd.concat([i,player_2015], sort=True)
    player_2015 = player_2015.drop(['순위','WPCT'], axis=1)
    player_2015 = player_2015.replace('-', None)
    player_2015['연도'] = 2015
    
path_2016 = 'C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2016/'
player_2016 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_2016+player_list_2016[i], delimiter = '\t')
    player_2016 = pd.concat([i,player_2016], sort=True)
    player_2016 = player_2016.drop(['순위','WPCT'], axis=1)
    player_2016 = player_2016.replace('-', None)
    player_2016['연도'] = 2016

path_2017 = 'C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2017/'
player_2017 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_2017+player_list_2017[i], delimiter = '\t')
    player_2017 = pd.concat([i,player_2017], sort=True)
    player_2017 = player_2017.drop(['순위','WPCT'], axis=1)
    player_2017 = player_2017.replace('-', None)
    player_2017['연도'] = 2017
    
path_2018= 'C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2018/'
player_2018 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_2018+player_list_2018[i], delimiter = '\t')
    player_2018 = pd.concat([i,player_2018], sort=True)
    player_2018 = player_2018.drop(['순위','WPCT'], axis=1)
    player_2018 = player_2018.replace('-', None)
    player_2018['연도'] = 2018
    
path_2019 = 'C:/Users/student/Desktop/kbo_rec/선수별/pitcher/2019/'
player_2019 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_2019+player_list_2019[i], delimiter = '\t')
    player_2019 = pd.concat([i,player_2019], sort=True)
    player_2019 = player_2019.drop(['순위','WPCT'], axis=1)
    player_2019 = player_2019.replace('-', None)
    player_2019['연도'] = 2019
    
player_2015_2019 = pd.concat([player_2015, player_2016, player_2017, player_2018, player_2019], axis=0)
player_2015_2019 = player_2015_2019.reset_index(drop=True)

player_2015_2019.ERA = player_2015_2019.ERA.astype('float32')
player_2015_2019.WHIP = player_2015_2019.WHIP.astype('float32')
player_2015_2019.IP = player_2015_2019.IP.astype('float64')
```



```python
# 타자 데이터 불러오기 및 df 생성

import pandas as pd
import os
hitter_list_2015 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/hitter/2015')
hitter_list_2016 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/hitter/2016')
hitter_list_2017 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/hitter/2017')
hitter_list_2018 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/hitter/2018')
hitter_list_2019 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/hitter/2019')

path_hitter_2015 = 'C:/Users/student/Desktop/kbo_rec/선수별/hitter/2015/'
hitter_2015 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_hitter_2015+hitter_list_2015[i], delimiter = '\t')
    hitter_2015 = pd.concat([i,hitter_2015], sort=True)
    hitter_2015 = hitter_2015.drop(['순위'], axis=1)
    hitter_2015 = hitter_2015.replace('-', None)
    hitter_2015['연도'] = 2015
    
path_hitter_2016 = 'C:/Users/student/Desktop/kbo_rec/선수별/hitter/2016/'
hitter_2016 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_hitter_2016+hitter_list_2016[i], delimiter = '\t')
    hitter_2016 = pd.concat([i,hitter_2016], sort=True)
    hitter_2016 = hitter_2016.drop(['순위'], axis=1)
    hitter_2016 = hitter_2016.replace('-', None)
    hitter_2016['연도'] = 2016

path_hitter_2017 = 'C:/Users/student/Desktop/kbo_rec/선수별/hitter/2017/'
hitter_2017 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_hitter_2017+hitter_list_2017[i], delimiter = '\t')
    hitter_2017 = pd.concat([i,hitter_2017], sort=True)
    hitter_2017 = hitter_2017.drop(['순위'], axis=1)
    hitter_2017 = hitter_2017.replace('-', None)
    hitter_2017['연도'] = 2017
    
path_hitter_2018= 'C:/Users/student/Desktop/kbo_rec/선수별/hitter/2018/'
hitter_2018 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_hitter_2018+hitter_list_2018[i], delimiter = '\t')
    hitter_2018 = pd.concat([i,hitter_2018], sort=True)
    hitter_2018 = hitter_2018.drop(['순위'], axis=1)
    hitter_2018 = hitter_2018.replace('-', None)
    hitter_2018['연도'] = 2018
    
path_hitter_2019 = 'C:/Users/student/Desktop/kbo_rec/선수별/hitter/2019/'
hitter_2019 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_hitter_2019+hitter_list_2019[i], delimiter = '\t')
    hitter_2019 = pd.concat([i,hitter_2019], sort=True)
    hitter_2019 = hitter_2019.drop(['순위'], axis=1)
    hitter_2019 = hitter_2019.replace('-', None)
    hitter_2019['연도'] = 2019
    
hitter_2015_2019 = pd.concat([hitter_2015, hitter_2016, hitter_2017, hitter_2018, hitter_2019], axis=0)
hitter_2015_2019 = hitter_2015_2019.reset_index(drop=True)

hitter_2015_2019.AVG = hitter_2015_2019.AVG.astype('float32')
```



```python
# 투수 팀 데이터 불러오기 및 df 생성

import pandas as pd
import os
team_list= os.listdir('C:/Users/student/Desktop/kbo_rec/팀별/pitcher')

path_team = 'C:/Users/student/Desktop/kbo_rec/팀별/pitcher/'

team_2015_2019 = pd.DataFrame()

team_2015 = pd.read_csv(path_team+team_list[0], delimiter = '\t')
team_2015['연도'] = 2015
team_2016 = pd.read_csv(path_team+team_list[1], delimiter = '\t')
team_2016['연도'] = 2016
team_2017 = pd.read_csv(path_team+team_list[2], delimiter = '\t')
team_2017['연도'] = 2017
team_2018 = pd.read_csv(path_team+team_list[3], delimiter = '\t')
team_2018['연도'] = 2018
team_2019 = pd.read_csv(path_team+team_list[4], delimiter = '\t')
team_2019['연도'] = 2019

team_2015_2019 = pd.concat([team_2015, team_2016, team_2017, team_2018, team_2019], axis=0)
team_2015_2019 = team_2015_2019.drop(['순위'], axis=1)
team_2015_2019 = team_2015_2019.replace('-', None)
team_2015_2019 = team_2015_2019.reset_index(drop=True)
```



```python
# 타자 팀 데이터 불러오기 및 df 생성

import pandas as pd
import os

team2_list= os.listdir('C:/Users/student/Desktop/kbo_rec/팀별/hitter')
path_team2 = 'C:/Users/student/Desktop/kbo_rec/팀별/hitter/'

team2_2015_2019 = pd.DataFrame()

team2_2015 = pd.read_csv(path_team2+team2_list[0], delimiter = '\t')
team2_2015['연도'] = 2015
team2_2016 = pd.read_csv(path_team2+team2_list[1], delimiter = '\t')
team2_2016['연도'] = 2016
team2_2017 = pd.read_csv(path_team2+team2_list[2], delimiter = '\t')
team2_2017['연도'] = 2017
team2_2018 = pd.read_csv(path_team2+team2_list[3], delimiter = '\t')
team2_2018['연도'] = 2018
team2_2019 = pd.read_csv(path_team2+team2_list[4], delimiter = '\t')
team2_2019['연도'] = 2019

team2_2015_2019 = pd.concat([team2_2015, team2_2016, team2_2017, team2_2018, team2_2019], axis=0)
team2_2015_2019 = team2_2015_2019.drop(['순위'], axis=1)
team2_2015_2019 = team2_2015_2019.replace('-', None)
team2_2015_2019 = team2_2015_2019.reset_index(drop=True)
```



#### 2 -1) 기록 조회 함수 구현

```python
## 투수별 기록 조회 함수
def find_player_rec():
    name = str(input('선수 이름 : '))
    year = int(input('연도 : '))
    option = str(input('기록 : '))
    
    # 조건에 해당하는 df 생성
    find_player_record = player_2015_2019[(player_2015_2019['선수명'] == name) &
                                         (player_2015_2019['연도'] == year)][option]
    # series to string
    find_player_record = find_player_record.to_string()
    # record만 추출
    record = find_player_record[-5:]
    
    print ("{year}년 {name}의 {option} : ".format(name=name,year=year,option=option), record)
-----------------------------------------------------------------------  
find_player_rec()
> 선수 이름 : 문승원
> 연도 : 2018
> 기록 : ERA
> 2018년 문승원의 ERA :    4.6
```



```python
## 투수 팀별 기록 조회 함수

def find_team_rec():
    team = str(input('팀 이름 : '))
    year = int(input('연도 : '))
    option = str(input('기록 : '))
    
    # 조건에 해당하는 df 생성
    find_team_record = team_2015_2019[(team_2015_2019['팀명'] == team) &
                                         (team_2015_2019['연도'] == year)][option]
    # series to string
    find_team_record = find_team_record.to_string()
    # record만 추출
    record = find_team_record[-6:]
    
    print ("{year}년 {team}의 {option} : ".format(team=team,year=year,option=option), record)
-------------------------------------------------------------------------   
find_team_rec()
> 팀 이름 : LG
> 연도 : 2016
> 기록 : IP
> 2016년 LG의 IP :  1287.6
```



#### 2 -2) 2020 기록 예측 함수 구현

```python
## 투수 기록 예측 함수

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.ensemble import RandomForestRegressor
import os
%matplotlib inline

def pred_player_rec():
    name = str(input('선수 이름 : '))
    option  = str(input('기록 : '))

    #### 기록 예측 모델
    pred_record_df = player_2015_2019.copy()

    # 선수명, 팀명, 연도 column 제거
    pred_record_df_num = pred_record_df.iloc[:,:10]  # (~,10)
    
    ## xtrain, ytrain 생성
    xtrain = pred_record_df[pred_record_df.선수명 == name]  # (5,13)
    xtrain = xtrain.drop([option], axis=1)  # (5,12)
    xtrain = xtrain.drop(['연도', '팀명'], axis=1)  # (5,10)
    xtrain = xtrain.drop(['선수명'], axis=1)  # (5,9)
    
    ytrain = pred_record_df[pred_record_df.선수명 == name][option].to_frame()  # (5,1)
    
    ## randomforest regressor model 학습
    model = RandomForestRegressor(max_depth=10, n_jobs=-1, n_estimators = 800)
    model.fit(xtrain, np.ravel(ytrain))
    
    # xtest data 불러오기 및 정제
    player_list_2020 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/2020')
    path_player_2020 = 'C:/Users/student/Desktop/kbo_rec/선수별/2020/'
    pred_player_2020 = pd.DataFrame()
    for i in range(10):
        i = pd.read_csv(path_player_2020+player_list_2020[i], delimiter = '\t')
        pred_player_2020 = pd.concat([i,pred_player_2020], sort=True)
        pred_player_2020 = pred_player_2020.drop(['순위','W','L','SV','HLD','WPCT','R'], axis=1)
        pred_player_2020 = pred_player_2020.replace('-', None)
        pred_player_2020['연도'] = 2020
        pred_player_2020.ERA = pred_player_2020.ERA.astype('float32')
        pred_player_2020.WHIP = pred_player_2020.WHIP.astype('float32')
        pred_player_2020.IP = pred_player_2020.IP.astype('float64')

    # xtest 생성
    xtest = pred_player_2020[pred_player_2020['선수명'] == name]  # (1,13)
    xtest = xtest.drop([option], axis=1)  # (1,12)
    xtest = xtest.drop(['연도','팀명'], axis=1) # (1,10)
    xtest = xtest.drop(['선수명'], axis=1)  # (1,9)
    
    # model 예측
    pred = model.predict(xtest) ## array type으로 출력됨
    pred_df = pd.DataFrame(pred)
    pred_df.columns = [option]  # (1,1) df
    pred_df['연도'] = 2020   # (1,2) df
    
    # 예측값과 concat할 기존 record df 생성
    record_opt_df = pred_record_df[pred_record_df.선수명 == name][[option, '연도']]
    pred_opt = pd.concat([record_opt_df, pred_df])

    # 팀명 추출
    pred_player_team = pred_record_df[pred_record_df['선수명'] == name]['팀명'].to_list()
    # 팀이 2개 이상일 경우, 최근 소속 팀명 추출
    recent_team = pred_player_team[-1]

    # 시각화
    plt.figure()

    plt.plot(pred_opt.연도, pred_opt[option], marker='o', label=option)
    plt.title('Annual Record & Predicted 2020', fontsize=23)
    plt.xlabel('Year', fontsize=14)
    plt.ylabel('Record', fontsize=14)
    plt.xticks(pred_opt.연도)
    plt.legend(fontsize=12, loc="best")
    plt.grid(True)
    plt.show()
    
    # 예측 결과 출력
    print("2020년 {team} 투수 {name}의 {option} 예상 기록 : ".format(team=recent_team,name=name,option=option), pred) 
-------------------------------------------------------------------
pred_player_rec()
> 선수 이름 : 유희관
> 기록 : WHIP
> graph
> 2020년 두산 투수 유희관의 WHIP 예상 기록 :  [1.48793751]
```



```python
## 투수 팀 기록 예측 함수

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.ensemble import RandomForestRegressor
import os
%matplotlib inline

def pred_team_rec():
    name = str(input('팀 이름 : '))
    option  = str(input('기록 : '))

    #### 기록 예측 모델
    pred_record_df = team_2015_2019.copy()  # (~,17)

    ## xtrain, ytrain 생성
    xtrain = pred_record_df[pred_record_df.팀명 == name]  # (5,17)
    xtrain = xtrain.drop([option], axis=1)  # (5,16)
    xtrain = xtrain.drop(['연도', '팀명'], axis=1)  # (5,14)

    ytrain = pred_record_df[pred_record_df.팀명 == name][option].to_frame()  # (5,1)
    
    ## randomforest regressor model 학습
    model = RandomForestRegressor(max_depth=10, n_jobs=-1, n_estimators = 800)
    model.fit(xtrain, np.ravel(ytrain))
    
    # xtest data 불러오기 및 정제
    team_list= os.listdir('C:/Users/student/Desktop/kbo_rec/팀별')
    path_team_2020 = 'C:/Users/student/Desktop/kbo_rec/팀별/2020.txt'

    pred_team_2020 = pd.read_csv(path_team_2020, delimiter = '\t')  # (10, 18)
    pred_team_2020 = pred_team_2020.drop(['G','순위'], axis=1)  # (10, 16)
    pred_team_2020['연도'] = 2020   # (10, 17)
    pred_team_2020 = pred_team_2020.replace('-', None)
    pred_team_2020 = pred_team_2020.reset_index(drop=True)
    
    # xtest 생성
    xtest = pred_team_2020[pred_team_2020['팀명'] == name]  # (1,17)
    xtest = xtest.drop([option], axis=1)  # (1,16)
    xtest = xtest.drop(['연도','팀명'], axis=1) # (1,14)
    
    # model 예측
    pred = model.predict(xtest) ## array type으로 출력됨
    pred_df = pd.DataFrame(pred)
    pred_df.columns = [option]  # (1,1) df
    pred_df['연도'] = 2020   # (1,2) df
    
    # 예측값과 concat할 기존 record df 생성
    record_opt_df = pred_record_df[pred_record_df.팀명 == name][[option, '연도']]
    pred_opt = pd.concat([record_opt_df, pred_df])

    # 시각화
    plt.figure()

    plt.plot(pred_opt.연도, pred_opt[option], marker='o', label=option)
    plt.title('Annual Record & Predicted 2020', fontsize=23)
    plt.xlabel('Year', fontsize=14)
    plt.ylabel('Record', fontsize=14)
    plt.xticks(pred_opt.연도)
    plt.legend(fontsize=12, loc="best")
    plt.grid(True)
    plt.show()
    
    # 예측 결과 출력
    print("2020년 {name}의 {option} 예상 기록 : ".format(name=name,option=option), pred) 
---------------------------------------------------------------------
pred_team_rec()
> 팀 이름 : SK
> 기록 : ERA
> graph
> 2020년 SK의 ERA 예상 기록 :  [4.5213625]
```



#### 3 -1) 투수 기록 예측 + 시각화 + 예측값 저장 

```python
### graph 한글 깨짐 방지 설정
import matplotlib
from matplotlib import font_manager, rc
import platform
if platform.system()=="Windows":
    font_name=font_manager.FontProperties(fname="c:/Windows/Fonts/malgun.ttf").get_name()
    rc('font', family=font_name)
matplotlib.rcParams['axes.unicode_minus']=False

import warnings
warnings.filterwarnings("ignore")
```

```python
import matplotlib.pyplot as plt
import numpy as np
from sklearn.ensemble import RandomForestRegressor
import os
%matplotlib inline

# xtest data 불러오기 및 정제
player_list_2020 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/2020')
path_player_2020 = 'C:/Users/student/Desktop/kbo_rec/선수별/2020/'
pred_player_2020 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_player_2020+player_list_2020[i], delimiter = '\t')
    pred_player_2020 = pd.concat([i,pred_player_2020], sort=True)
    pred_player_2020 = pred_player_2020.drop(['순위','WPCT'], axis=1)
    pred_player_2020 = pred_player_2020.replace('-', None)
    pred_player_2020['연도'] = 2020
    pred_player_2020.ERA = pred_player_2020.ERA.astype('float32')
    pred_player_2020.WHIP = pred_player_2020.WHIP.astype('float32')
    pred_player_2020.IP = pred_player_2020.IP.astype('float64')
    
player_2020_list = list(pred_player_2020['선수명'])
player_past_list = list(player_2015_2019['선수명'])
player_list = []
for i in player_2020_list:
    if i in player_past_list:
        player_list.append(i)

p_option_list = list(player_2015_2019.iloc[:,:15])

for name in player_list:
    for option in p_option_list:
        #### 기록 예측 모델
        pred_record_df = player_2015_2019.copy()
        
        ## xtrain, ytrain 생성
        xtrain = pred_record_df[pred_record_df.선수명 == name]  # (5,18)
        xtrain = xtrain.drop([option], axis=1)  # (5,17)
        xtrain = xtrain.drop(['연도', '팀명'], axis=1)  # (5,15)
        xtrain = xtrain.drop(['선수명'], axis=1)  # (5,14)

        ytrain = pred_record_df[pred_record_df.선수명 == name][option].to_frame()  # (5,1)

        ## randomforest regressor model 학습
        model = RandomForestRegressor(max_depth=10, n_jobs=-1, n_estimators = 800)
        model.fit(xtrain, np.ravel(ytrain))

        # xtest 생성
        xtest = pred_player_2020[pred_player_2020['선수명'] == name]  # (1,18)
        xtest = xtest.drop([option], axis=1)  # (1,17)
        xtest = xtest.drop(['연도','팀명'], axis=1) # (1,15)
        xtest = xtest.drop(['선수명'], axis=1)  # (1,14)

        # model 예측
        pred = model.predict(xtest) ## array type으로 출력됨
        pred_df = pd.DataFrame(pred)
        pred_df.columns = [option]  # (1,1) df
        pred_df['연도'] = 2020   # (1,2) df

        # 예측값과 concat할 기존 record df 생성
        record_opt_df = pred_record_df[pred_record_df.선수명 == name][[option, '연도']]
        pred_opt = pd.concat([record_opt_df, pred_df])

        # 팀명 추출
        pred_player_team = pred_record_df[pred_record_df['선수명'] == name]['팀명'].to_list()
        # 팀이 2개 이상일 경우, 최근 소속 팀명 추출
        recent_team = pred_player_team[-1]

        # 시각화
        pred = round(pred[0], 4)
        pred = str(pred)
        plt.figure(figsize=(10,5))

        plt.plot(pred_opt.연도, pred_opt[option], marker='o', label=option)

        plt.title('2020년 '+recent_team+' 투수 '+name+'의 '+option+' 예상 기록 : '+pred, fontsize=23)
        plt.xlabel('Year', fontsize=14)
        plt.ylabel('Record', fontsize=14)
        plt.xticks(pred_opt.연도)
        plt.legend(fontsize=12, loc="best")
        plt.grid(True)

        img_path = 'C:/Users/student/Desktop/kbo_rec/htm/pred_player/pitcher/'
        plt.savefig(img_path+name+option+'_2020.png', dpi=200, edgecolor='black', pad_inches=0.5)
```



#### 3 -2) 투수 팀 기록 예측 + 시각화 + 예측값 저장 

```python
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.ensemble import RandomForestRegressor
import os

teamname_list = list(set(player_2015_2019['팀명']))
t_option_list = team_2015_2019.drop(['팀명','연도'], axis=1)
t_option_list = list(t_option_list.columns)

for name in teamname_list:
    for option in t_option_list:  #16
        #### 기록 예측 모델
        pred_record_df = team_2015_2019.copy()  # (~,18)

        ## xtrain, ytrain 생성
        xtrain = pred_record_df[pred_record_df.팀명 == name]  # (5,18)
        xtrain = xtrain.drop([option], axis=1)  # (5,17)
        xtrain = xtrain.drop(['연도', '팀명'], axis=1)  # (5,15)

        ytrain = pred_record_df[pred_record_df.팀명 == name][option].to_frame()  # (5,1)

        ## randomforest regressor model 학습
        model = RandomForestRegressor(max_depth=10, n_jobs=-1, n_estimators = 800)
        model.fit(xtrain, np.ravel(ytrain))

        # xtest data 불러오기 및 정제
        team_list= os.listdir('C:/Users/student/Desktop/kbo_rec/팀별')
        path_team_2020 = 'C:/Users/student/Desktop/kbo_rec/팀별/2020.txt'

        pred_team_2020 = pd.read_csv(path_team_2020, delimiter = '\t')  # (10, 18)
        pred_team_2020 = pred_team_2020.drop(['순위'], axis=1)  # (10, 17)
        pred_team_2020['연도'] = 2020   # (10, 18)
        pred_team_2020 = pred_team_2020.replace('-', None)
        pred_team_2020 = pred_team_2020.reset_index(drop=True)

        # xtest 생성
        xtest = pred_team_2020[pred_team_2020['팀명'] == name]  # (1,18)
        xtest = xtest.drop([option], axis=1)  # (1,17)
        xtest = xtest.drop(['연도','팀명'], axis=1) # (1,15)

        # model 예측
        pred = model.predict(xtest) ## array type으로 출력됨
        pred_df = pd.DataFrame(pred)
        pred_df.columns = [option]  # (1,1) df
        pred_df['연도'] = 2020   # (1,2) df

        # 예측값과 concat할 기존 record df 생성
        record_opt_df = pred_record_df[pred_record_df.팀명 == name][[option, '연도']]
        pred_opt = pd.concat([record_opt_df, pred_df])

        # 시각화
        pred = round(pred[0], 4)
        pred = str(pred)
        plt.figure(figsize=(10,5))

        plt.plot(pred_opt.연도, pred_opt[option], marker='o', label=option)

        plt.title('2020년 '+name+'의 '+option+' 예상 기록 : '+pred, fontsize=23)
        plt.xlabel('Year', fontsize=14)
        plt.ylabel('Record', fontsize=14)
        plt.xticks(pred_opt.연도)
        plt.legend(fontsize=12, loc="best")
        plt.grid(True)

        timg_path = 'C:/Users/student/Desktop/kbo_rec/htm/pred_team/pitcher/'
        plt.savefig(timg_path+name+'_'+option+'_2020.png', dpi=200, edgecolor='black', pad_inches=0.5)
```



#### 3 -3) 타자 기록 예측 + 시각화 + 예측값 저장

```python
import matplotlib.pyplot as plt
import numpy as np
from sklearn.ensemble import RandomForestRegressor
import os
%matplotlib inline

h_option_list = list(hitter_2015_2019.iloc[:,:13])

# xtest data 불러오기 및 정제
hitter_list_2020 = os.listdir('C:/Users/student/Desktop/kbo_rec/선수별/hitter/2020')
path_hitter_2020 = 'C:/Users/student/Desktop/kbo_rec/선수별/hitter/2020/'
pred_hitter_2020 = pd.DataFrame()
for i in range(10):
    i = pd.read_csv(path_hitter_2020+hitter_list_2020[i], delimiter = '\t')
    pred_hitter_2020 = pd.concat([i,pred_hitter_2020], sort=True)
    pred_hitter_2020 = pred_hitter_2020.drop(['순위'], axis=1)
    pred_hitter_2020 = pred_hitter_2020.replace('-', None)
    pred_hitter_2020['연도'] = 2020
    pred_hitter_2020.AVG = pred_hitter_2020.AVG.astype('float32')
    
hitter_2020_list = list(pred_hitter_2020['선수명'])
hitter_past_list = list(hitter_2015_2019['선수명'])
hitter_list = []
for i in hitter_2020_list:
    if i in hitter_past_list:
        hitter_list.append(i)

for name in hitter_list:
    for option in h_option_list:
        #### 기록 예측 모델
        pred_record_df = hitter_2015_2019.copy()
        
        ## xtrain, ytrain 생성
        xtrain = pred_record_df[pred_record_df.선수명 == name]  # (5,15)
        xtrain = xtrain.drop([option], axis=1)  # (5,14)
        xtrain = xtrain.drop(['연도', '팀명'], axis=1)  # (5,12)
        xtrain = xtrain.drop(['선수명'], axis=1)  # (5,11)

        ytrain = pred_record_df[pred_record_df.선수명 == name][option].to_frame()  # (5,1)

        ## randomforest regressor model 학습
        model = RandomForestRegressor(max_depth=10, n_jobs=-1, n_estimators = 800)
        model.fit(xtrain, np.ravel(ytrain))

        # xtest 생성
        xtest = pred_hitter_2020[pred_hitter_2020['선수명'] == name]  # (1,15)
        xtest = xtest.drop([option], axis=1)  # (1,14)
        xtest = xtest.drop(['연도','팀명'], axis=1) # (1,12)
        xtest = xtest.drop(['선수명'], axis=1)  # (1,11)

        # model 예측
        pred = model.predict(xtest) ## array type으로 출력됨
        pred_df = pd.DataFrame(pred)
        pred_df.columns = [option]  # (1,1) df
        pred_df['연도'] = 2020   # (1,2) df

        # 예측값과 concat할 기존 record df 생성
        record_opt_df = pred_record_df[pred_record_df.선수명 == name][[option, '연도']]
        pred_opt = pd.concat([record_opt_df, pred_df])

        # 팀명 추출
        pred_hitter_team = pred_record_df[pred_record_df['선수명'] == name]['팀명'].to_list()
        # 팀이 2개 이상일 경우, 최근 소속 팀명 추출
        recent_team = pred_hitter_team[-1]

        # 시각화
        pred = round(pred[0], 3)
        pred = str(pred)
        plt.figure(figsize=(10,5))

        plt.plot(pred_opt.연도, pred_opt[option], marker='o', label=option)

        plt.title('2020년 '+recent_team+' 타자 '+name+'의 '+option+' 예상 기록 : '+pred, fontsize=23)
        plt.xlabel('Year', fontsize=14)
        plt.ylabel('Record', fontsize=14)
        plt.xticks(pred_opt.연도)
        plt.legend(fontsize=12, loc="best")
        plt.grid(True)

        img_path = 'C:/Users/student/Desktop/kbo_rec/htm/pred_player/hitter/'
        plt.savefig(img_path+name+option+'_2020.png', dpi=200, edgecolor='black', pad_inches=0.5)
```



#### 3 -4) 타자  팀 기록 예측 + 시각화 + 예측값 저장

```python
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.ensemble import RandomForestRegressor
import os

team2name_list = list(set(hitter_2015_2019['팀명']))
t2_option_list = team2_2015_2019.drop(['팀명','연도'], axis=1)
t2_option_list = list(t2_option_list.columns)

for name in team2name_list:
    for option in t2_option_list:  #15
        #### 기록 예측 모델
        pred_record_df = team2_2015_2019.copy()  # (~,15)

        ## xtrain, ytrain 생성
        xtrain = pred_record_df[pred_record_df.팀명 == name]  # (5,15)
        xtrain = xtrain.drop([option], axis=1)  # (5,14)
        xtrain = xtrain.drop(['연도', '팀명'], axis=1)  # (5,12)

        ytrain = pred_record_df[pred_record_df.팀명 == name][option].to_frame()  # (5,1)

        ## randomforest regressor model 학습
        model = RandomForestRegressor(max_depth=10, n_jobs=-1, n_estimators = 800)
        model.fit(xtrain, np.ravel(ytrain))

        # xtest data 불러오기 및 정제
        team2_list= os.listdir('C:/Users/student/Desktop/kbo_rec/팀별/hitter')
        path_team2_2020 = 'C:/Users/student/Desktop/kbo_rec/팀별/hitter/2020.txt'

        pred_team2_2020 = pd.read_csv(path_team2_2020, delimiter = '\t')  # (10, 15)
        pred_team2_2020 = pred_team2_2020.drop(['순위'], axis=1)  # (10, 14)
        pred_team2_2020['연도'] = 2020   # (10, 15)
        pred_team2_2020 = pred_team2_2020.replace('-', None)
        pred_team2_2020 = pred_team2_2020.reset_index(drop=True)

        # xtest 생성
        xtest = pred_team2_2020[pred_team2_2020['팀명'] == name]  # (1,15)
        xtest = xtest.drop([option], axis=1)  # (1,14)
        xtest = xtest.drop(['연도','팀명'], axis=1) # (1,12)

        # model 예측
        pred = model.predict(xtest) ## array type으로 출력됨
        pred_df = pd.DataFrame(pred)
        pred_df.columns = [option]  # (1,1) df
        pred_df['연도'] = 2020   # (1,2) df

        # 예측값과 concat할 기존 record df 생성
        record_opt_df = pred_record_df[pred_record_df.팀명 == name][[option, '연도']]
        pred_opt = pd.concat([record_opt_df, pred_df])

        # 시각화
        pred = round(pred[0], 3)
        pred = str(pred)
        plt.figure(figsize=(10,5))

        plt.plot(pred_opt.연도, pred_opt[option], marker='o', label=option)

        plt.title('2020년 '+name+'의 '+option+' 예상 기록 : '+pred, fontsize=23)
        plt.xlabel('Year', fontsize=14)
        plt.ylabel('Record', fontsize=14)
        plt.xticks(pred_opt.연도)
        plt.legend(fontsize=12, loc="best")
        plt.grid(True)

        timg_path = 'C:/Users/student/Desktop/kbo_rec/htm/pred_team/hitter/'
        plt.savefig(timg_path+name+'_'+option+'_2020.png', dpi=200, edgecolor='black', pad_inches=0.5)
```

