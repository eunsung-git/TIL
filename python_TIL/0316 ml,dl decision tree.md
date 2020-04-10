## decision-tree

#### <bank data 분석>

##### data 전처리

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.tree import export_graphviz
from sklearn import tree
from sklearn import metrics
%matplotlib inline

bank=pd.read_csv('bank.csv')

# column별 null 갯수
bank.isnull().sum()

#  기술통계
bank.describe()

# graph 출력
sns.boxplot(x=bank['age'])
sns.distplot(bank['age'],bins=100)
sns.boxplot(x=bank['duration'])

----------------------------------------------------------

## convert categorical data

bankData=bank.copy()

# 'job' column별 갯수 출력
bankData['job'].value_counts()

# deposit==yes & bankData['job']
bankData[bankData.deposit=='yes'].groupby('job').size()

jobs=list(set(bankData['job'].values))
for j in jobs:
    print('{:15} : {:5}'.format(j,len(bankData[(bankData['deposit']=='yes')& (bankData['job']==j)])))
    
# 특정 값 수정
bankData['job']=bankData['job'].replace(['management','admin.'],'white-collar')
bankData['job']=bankData['job'].replace(['services','housemaid'],'pink-collar')
bankData['job']=bankData['job'].replace(['retired','student','unknown'],'other')
bankData['poutcome']=bankData['poutcome'].replace('other','unknown')


# column 삭제
bankData.drop('contact',axis=1,inplace=True)

# map 함수를 이용한 특정 값 수정
bankData['default_cat']=bankData['default'].map({'yes':1,'no':0})
bankData.drop('default',axis=1,inplace=True)

bankData['housing_cat']=bankData['housing'].map({'yes':1,'no':0})
bankData.drop('housing',axis=1,inplace=True)

bankData['loan_cat']=bankData['loan'].map({'yes':1,'no':0})
bankData.drop('loan',axis=1,inplace=True)

bankData['deposit_cat']=bankData['deposit'].map({'yes':1,'no':0})
bankData.drop('deposit',axis=1,inplace=True)

# np.where()를 이용한 특정 값 수정
bankData['pdays']=np.where(bankData['pdays']==-1,10000,bankData['pdays'])
bankData['recent_pdays']=np.where(bankData['pdays'],1/bankData['pdays'],1/bankData['pdays'])

bankData.drop('pdays', axis=1, inplace=True)

# get_dummies()
bankWithDummies=pd.get_dummies(data=bankData,columns=['job','marital','education','poutcome'],prefix=['job','marital','education','poutcome'])
bankWithDummies.head()

--------------------------------------------------------

# 시각화
bankWithDummies.plot(kind='scatter',x='age',y='balance')

bankWithDummies.plot(kind='hist',x='poutcome_success',y='duration')

```



##### EDA

```python
# 계약기간이 만료된 사람들
bankWithDummies[bankData.deposit_cat==1].describe()

# 정기예금, 개인대출, 주택대출 모두 있는 사람 수
len(bankWithDummies[(bankData['deposit_cat']==1)&(bankWithDummies['loan_cat'])&(bankWithDummies['housing_cat'])])

# 정기예금, 채무 불이행인 사람 수
len(bankWithDummies[(bankWithDummies['deposit_cat']==1)&(bankWithDummies['default_cat']==1)])

# 직업별 정기예금 가입 비율
plt.figure(figsize=(10,6))
sns.barplot(x='job',y='deposit_cat',data=bankData)

```



### classification

```python
# 상관분석표
bankwd=bankWithDummies
corr=bankwd.corr()
plt.figure(figsize=(10,10))
cmap=sns.diverging_palette(220,10,as_cmap=True)
sns.heatmap(corr,cmap=cmap,linewidths=.5,square=True,center=0,vmax=.3,cbar_kws={'shrink':.80})

# deposit_cat 상관계수 df
corr_deposit=pd.DataFrame(corr['deposit_cat'].drop('deposit_cat'))

# deposit_cat 기준 내림차순 정렬
corr_deposit.sort_values(by='deposit_cat',ascending=False)
```



### decision tree

```python
# 입력변수
dropDeposit=bankwd.drop('deposit_cat',1)

# 출력변수
label=bankwd.deposit_cat

# train_test_split(입력변수, 출력변수, 사이즈, 랜덤)
dataTrain, dataTest,labelTrain,labelTest=train_test_split(dropDeposit,label,train_size=0.5,random_state=42)

# decision tree
dt2=tree.DecisionTreeClassifier(max_depth=2)
dt2.fit(dataTrain,labelTrain)
dt2_sc_train=dt2.score(dataTrain, labelTrain)
dt2_sc_test=dt2.score(dataTest, labelTest)
print('training score :',dt2_sc_train)
print('test score :',dt2_sc_test)

dt5=tree.DecisionTreeClassifier(max_depth=5)
dt5.fit(dataTrain,labelTrain)
dt5_sc_train=dt5.score(dataTrain, labelTrain)
dt5_sc_test=dt5.score(dataTest, labelTest)
print('training score :',dt5_sc_train)
print('test score :',dt5_sc_test)
```

