## mini_ proj_python  

### "bike-sharing  분석"



##### 1)  bike-sharing data 불러오기 & 각 data 확인

```python
import numpy as np
import pandas as pd

train=pd.read_csv('train_bike.csv',parse_dates=['datetime'])
train
train.info()
train.shape
train.describe()
```



##### 2) 중복 data & null 확인

```python
train.duplicated(['weather'])
train.duplicated(['temp'])
train.duplicated(['humidity'])
train.duplicated(['windspeed'])
train.duplicated(['casual'])
train.duplicated(['registered'])

train.isnull()

```



##### 3) datetime에서 년,월,일,시,분,초를 추출하여 각각의 column으로 구성 / 

    ##### 년,월,일,시 에 따른 평균 대여량 구하기

```python
train['datetime'].dt.year
train['datetime'].dt.month
train['datetime'].dt.day
train['datetime'].dt.hour
train['datetime'].dt.minute
train['datetime'].dt.hour
train['datetime'].dt.second
train['datetime'].dt.dayofweek 

train['year']=train['datetime'].dt.year
train['month']=train['datetime'].dt.month
train['day']=train['datetime'].dt.day
train['hour']=train['datetime'].dt.hour
train['minute']=train['datetime'].dt.minute
train['dayofweek']=train['datetime'].dt.dayofweek

---------------------------------------------------------------------
## 연도별 평균 대여량
train.groupby('year')[['count']].mean() 

## 월별 평균 대여량
train.groupby('month')[['count']].mean() 

## 일별 평균 대여량
train.groupby('day')[['count']].mean() 

## 시간별 평균 대여량
train.groupby('hour')[['count']].mean()

## 요일별별 평균 대여량
train.groupby('dayofweek')[['count']].mean()

```



##### 4) 근무일 유무/요일/계절/날씨(기온&바람)에 따른 시간대별 자전거 대여량 구하기

```python
## 근무일별 시간대별 대여량
train.groupby(['workingday','hour'])[['count']].describe()
#train.pivot_table('count',['workingday','hour']).describe()

## 요일별 시간대별 대여량
train.groupby(['dayofweek','hour'])[['count']].describe()
#train.pivot_table('count',['dayofweek','hour']).describe()

## 계절별 시간대별 대여량
train.groupby(['season','hour'])[['count']].describe()
#train.pivot_table('count',['season','hour']).describe()

## 날씨별 시간대별 대여량
## (1) 기온별
## 1 계절별 기온 구간 나누기
bins=[-2.00,4.00,20.00,45.00]
labels=['winter','sf','summer']
temp=list(train['temp'])

cats=pd.cut(temp, bins, labels=labels)

## 2 구간별 기온에 대한 새로운 column 추가
train['temp_cat']=pd.cut(temp, bins, labels=labels)

## 기온별 시간대별 대여량
train.groupby(['temp_cat','hour'])[['count']].describe()
#train.pivot_table('count',['temp_cat','hour']).describe()

## (2) 바람세기별
## 1 0값 -> 결측값 대체
train['windspeed']=train['windspeed'].replace(0,np.nan)

## 2 계절별 바람세기 구간 나누기
bins=[0.00,9.00,19.00,25.00]
labels=['weak','middle','strong']
windspeed=list(train['windspeed'])

cats=pd.cut(windspeed, bins, labels=labels)

## 2 구간별 바람세기에 대한 새로운 column 추가
train['windspeed_cat']=pd.cut(windspeed, bins, labels=labels)

## 바람세기별 시간대별 대여량
train.groupby(['windspeed_cat','hour'])[['count']].describe()
#train.pivot_table('count',['windspeed_cat','hour']).describe()

```



##### 5) 연도별 월별 자전거 대여량 구하기

```python
train.groupby(['year','month'])[['count']].describe()
```



##### 6) 아웃라이어제거
정상범위 데이터 : count열값-count열값평균 < 3*(count.std)

```python
train[train['count']-train['count'].mean()<3*(train['count'].std())]
```

------------------------------------------------------------------------------------------------------------------------



### ver.2

```python
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
import pandas as pd
import numpy as np

train=pd.read_csv('train_bike.csv', parse_dates=['datetime'])
train.info()
train.head()
train.describe()
train.isnull().sum()

import missingno as msno
msno.matrix(train,figsize=(12,5))

train['year']=train['datetime'].dt.year
train['month']=train['datetime'].dt.month
train['day']=train['datetime'].dt.day
train['hour']=train['datetime'].dt.hour
train['minute']=train['datetime'].dt.minute
train['second']=train['datetime'].dt.second
train['dayofweek']=train['datetime'].dt.dayofweek

## barplot
fig,((ax1,ax2,ax3),(ax4,ax5,ax6))=plt.subplots(nrows=2,ncols=3)
fig.set_size_inches(20,8)
sns.barplot(data=train,x='year',y='count',ax=ax1)
sns.barplot(data=train,x='month',y='count',ax=ax2)
sns.barplot(data=train,x='day',y='count',ax=ax3)
sns.barplot(data=train,x='hour',y='count',ax=ax4)
sns.barplot(data=train,x='minute',y='count',ax=ax5)
sns.barplot(data=train,x='second',y='count',ax=ax6)


## boxplot
fig,axes=plt.subplots(nrows=2,ncols=2)
fig.set_size_inches(20,8)
sns.boxplot(data=train, x='season', y='count',ax=axes[0][0])
sns.boxplot(data=train, x='workingday', y='count',ax=axes[0][1])
sns.boxplot(data=train, orient='v', y='count',ax=axes[1][0])
sns.boxplot(data=train, x='hour', y='count',ax=axes[1][1])


fig,(ax1,ax2,ax3,ax4,ax5)=plt.subplots(nrows=5)
fig.set_size_inches(18,25)
sns.pointplot(data=train, x='hour', y='count', ax=ax1)  # 시간대별 대여량 
sns.pointplot(data=train, x='hour', y='count', hue='workingday', ax=ax2)  # 근무일별 시간대별 대여량
sns.pointplot(data=train, x='hour', y='count', hue='dayofweek', ax=ax3)   #요일별 시간대별 대여량
sns.pointplot(data=train, x='hour', y='count', hue='weather', ax=ax4) # 날씨별 시간대별 대여랑
sns.pointplot(data=train, x='hour', y='count', hue='season', ax=ax5) #계절별 시간대별 대여량


fig,(ax1,ax2,ax3)=plt.subplots(ncols=3)
fig.set_size_inches(12,5)
sns.regplot(data=train, x='temp', y='count', ax=ax1)  #온도별 대여랑
sns.regplot(data=train, x='windspeed', y='count', ax=ax2) #바람세기별 대여랑
sns.regplot(data=train, x='humidity', y='count', ax=ax3)  #습도별 대여랑


## 년-월별 대여량 추이
def ym(mydt):
    return '{0}-{1}'.format(mydt.year,mydt.month)
    
train['year_month']=train['datetime'].apply(ym)

fig,axes=plt.subplots(nrows=1,ncols=1)
fig.set_size_inches(18,4)
sns.barplot(data=train, x='year_month', y='count', ax=axes)


## random forest  -> windspeed 예측
from sklearn.ensemble import RandomForestClassifier

def predict_windspeed(data):
    wCol=['season','weather','humidity','month','temp','year','atemp']
    dataWind0=data.loc[data['windspeed']==0]
    dataWindNot0=data.loc[data['windspeed']!=0]
    
    ## random forest 분류기 객체 생성
    rfModel=RandomForestClassifier()
    dataWindNot0['windspeed']=dataWindNot0['windspeed'].astype('str')
    ## .fit(학습 data) -> 학습 -> 모델 완성
    rfModel.fit(dataWindNot0[wCol],dataWindNot0['windspeed'])
    ## 풍속 0 에 대한 예측
    preValue=rfModel.predict(X=dataWind0[wCol])
    
    predictWind0=dataWind0
    predictWindNot0=dataWindNot0
    
    predictWind0['windspeed']=preValue
    data=predictWindNot0.append(predictWind0)
    
    return data

```

