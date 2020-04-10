###  MLP



#### <titanic age&survived  예측>

##### 전처리

```python
import numpy as  np
import pandas as pd
import re
import matplotlib.pyplot as plt
%matplotlib inline

# 표준화
from sklearn import preprocessing

# MLP model
from sklearn.neural_network import MLPRegressor
from sklearn.neural_network import MLPClassifier


path=r'C:\\Users\\student\\Desktop\\공부\\멀캠TIL\\dataset\\python\\data'

train=pd.read_csv(path+'\\titanic_train.csv')
test=pd.read_csv(path+'\\titanic_test.csv')

# train set + test set
full=pd.concat([train, test], ignore_index=True)

# 기존 data 없애기
train=pd.DataFrame()
test=pd.DataFrame()

# 새로운 train set, test set 생성
def extract_df():
    train=full.loc[full['Survived'].notnull()]
    test=full.loc[full['Survived'].isnull()]
    return train, test

train, test=extract_df()

-----------------------------------------------------------

## 호칭 단순화

# Name col에서 호칭을 series로 추출
title_sr=full['Name'].str.extract(' ([A-Za-z]+)\.', expand=False)

# 호칭 x Sex
full['Title']=title_sr
pd.crosstab(full['Title'], full['Sex'])

# 호칭 mapping dict 만들기
title_list=set(title_sr)
map_title_dict={'Mlle':'Miss', 'Ms':'Miss', 'Mme':'Miss'}

working_dict={}
for key in ['Lady','Countess','Capt','Col','Don','Major','Rev','Sir','Jonkheer','Dona']:
    working_dict[key]='Rare'
    
# 호칭 mapping dict 합치기
map_title_dict.update(working_dict)
map_title_dict
> {'Mlle': 'Miss',
>  'Ms': 'Miss',
>  'Mme': 'Miss',
> 'Lady': 'Rare',
>  'Countess': 'Rare',
> 'Capt': 'Rare',
> 'Col': 'Rare',
> 'Don': 'Rare',
> 'Major': 'Rare',
> 'Rev': 'Rare',
> 'Sir': 'Rare',
> 'Jonkheer': 'Rare',
> 'Dona': 'Rare'}

# 호칭 치환
full['Title']=full['Title'].replace(map_title_dict)
set(list(full['Title']))
> {'Dr', 'Master', 'Miss', 'Mr', 'Mrs', 'Rare'}

----------------------------------------------------------

## 필요없는 column 제거
subcol=test['PassengerId']
full.drop(['PassengerId','Name','Ticket','Cabin'], axis=1, inplace=True)

-----------------------------------------------------------

# column별 data 종류의 갯수
feature_list=list(full)

for f in feature_list:
    print(f+' '+str(len(full[f].value_counts())))
> Age 98
> Embarked 3
> Fare 281
> Parch 8
> Pclass 3
> Sex 2
> SibSp 7
> Survived 2
> Title 6

-----------------------------------------------------------

## 결측값 처리
full['Embarked'].fillna('S', inplace=True)
full['Fare'].fillna(test['Fare'].median(), inplace=True)

train, test=extract_df()

--------------------------------------------------------

## 원핫인코딩
full['Sex']=full['Sex'].map({'female':0, 'male':1})


def onehot(df, feature_list):
    df=pd.get_dummies(df, columns=feature_list)
    return df
onehot_list=['Title','Pclass','Embarked']
full=onehot(full, onehot_list)

```



#### MLP classifier 기반 나이 예측 & 나이 결측 값 대체

```python
# train set, test set 생성
train, test=extract_df()

train_age=full[[x for x in list(train) if not x in ['Survived']]]  

xpred_age=train_age.loc[train_age['Age'].isnull()]
xtrain_age=train_age.loc[train_age['Age'].notnull()]

ytrain_age=xtrain_age['Age']

xtrain_age.drop('Age', axis=1, inplace=True)
xpred_age.drop('Age', axis=1, inplace=True)

# 표준화
scaler=preprocessing.StandardScaler().fit(xtrain_age)
xtrain_age=scaler.transform(xtrain_age)
xpred_age=scaler.transform(xpred_age)

# age column에서 결측값이 있는 index 추출 (=예측해야 할 row 추출)
age_none_list=full[full['Age'].isnull()].index.tolist()

# MLR model 생성 및 실행
mlr=MLPRegressor(solver='lbfgs',alpha=1e-5, hidden_layer_sizes=(50,50))
mlr.fit(xtrain_age, ytrain_age)

mlr.score(xtrain_age, ytrain_age)
> 0.6103150891181028

# 실제 나이와 예측한 나이 비교
for a,b in zip(np.array(ytrain_age),mlr.predict(xtrain_age)):
    print(a," ", b)
> 22.0   25.108074552548672
> 38.0   44.33613143335651
> 26.0   23.293315517141366
> 35.0   32.77630974311909
> 35.0   28.369185027670177
> 54.0   38.95208639141259
> 2.0   2.999315501006255
> 27.0   29.171149158476382
> 14.0   21.41525004313211
> 4.0   2.084612466195816   ...

# 예측한 값을 데이터에 저장
full['Age'][age_none_list]=mlr.predict(xpred_age).tolist()

```





#### MLP classifier 기반 생존 여부 예측 & 생존 여부 결측값 대체

```python
# train set, test set 생성
xtrain=full[full['Survived'].notnull()]
ytrain=full['Survived'][full['Survived'].notnull()]

xpred=full[full['Survived'].isnull()]

xtrain.drop('Survived',axis=1, inplace=True)
xpred.drop('Survived',axis=1, inplace=True)

# 표준화
scaler=preprocessing.StandardScaler().fit(xtrain)
xtrain=scaler.transform(xtrain)
xpred=scaler.transform(xpred)

# MLC model 생성 및 실행
mlc=MLPClassifier(solver='lbfgs', alpha=1e-5, hidden_layer_sizes=(50,50))
mlc.fit(xtrain,ytrain)
mlc.predict(xtrain)

# 예측한 생존 여부와 passengerid matching
submission=mlc.predict(xpred).astype(int)
pd.DataFrame({'PassengerId':subcol, "Survived":submission})






```

