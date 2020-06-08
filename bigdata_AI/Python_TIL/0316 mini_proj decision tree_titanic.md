## mini_proj_python

### decision tree_titanic 생존 여부



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

path=r'C:\\Users\\student\\Desktop\\공부\\멀캠TIL\\dataset\\python\\data'

train=pd.read_csv(path+'\\titanic_train.csv')
test=pd.read_csv(path+'\\titanic_test.csv')

trainData=train.copy()

# 필요 없는 column 삭제
trainData.drop(['PassengerId'],axis=1,inplace=True)
trainData.drop(['Name'],axis=1,inplace=True)
trainData.drop(['Ticket'],axis=1,inplace=True)
trainData.drop(['Cabin'],axis=1,inplace=True)
trainData.drop(['Age'],axis=1,inplace=True)

# 특정 값 대체 / nan 처리
trainData['Sex_cat']=trainData['Sex'].map({'male':1,'female':0})
trainData.drop('Sex',axis=1,inplace=True)
trainData['Embarked_cat']=trainData['Embarked'].map({'S':1,'C':2, 'Q':3})
trainData.drop('Embarked',axis=1,inplace=True)

trainData['Embarked_cat']=trainData['Embarked_cat'].fillna(0)


# 상관계수
corr=trainData.corr()

plt.figure(figsize=(10,10))
cmap=sns.diverging_palette(220,10,as_cmap=True)
sns.heatmap(corr,cmap=cmap,linewidths=.5,square=True,center=0,vmax=.3,cbar_kws={'shrink':.80})
```



##### decision tree model 생성

```python
# 입력변수
dropSurvived=trainData.drop('Survived',axis=1)

# 출력변수
label=trainData['Survived']

# train set / test set 분리
xtrain, xtest,ytrain,ytest=train_test_split(dropSurvived,label,train_size=0.7,random_state=42)

## 최적의 depth 찾기
# depth=2
dt2=tree.DecisionTreeClassifier(max_depth=2)
dt2.fit(xtrain,ytrain)
dt2_sc_train=dt2.score(xtrain, ytrain)
dt2_sc_test=dt2.score(xtest, ytest)
print('dt2 training score : ',dt2_sc_train)
print('dt2 test score : ',dt2_sc_test)
> dt2 training score :  0.7929373996789727
> dt2 test score :  0.7723880597014925
    
# depth=5
dt5=tree.DecisionTreeClassifier(max_depth=5)
dt5.fit(xtrain,ytrain)
dt5_sc_train=dt5.score(xtrain, ytrain)
dt5_sc_test=dt5.score(xtest, ytest)
print('dt5 training score : ',dt5_sc_train)
print('dt5 test score : ',dt5_sc_test)
> dt5 training score :  0.8459069020866774
> dt5 test score :  0.7649253731343284
    
# depth=7
dt7=tree.DecisionTreeClassifier(max_depth=7)
dt7.fit(xtrain,ytrain)
dt7_sc_train=dt7.score(xtrain, ytrain)
dt7_sc_test=dt7.score(xtest, ytest)
print('dt7 training score : ',dt7_sc_train)
print('dt7 test score : ',dt7_sc_test)
> dt7 training score :  0.8892455858747994
> dt7 test score :  0.8283582089552238
    
# depth=8
dt8=tree.DecisionTreeClassifier(max_depth=8)
dt8.fit(xtrain,ytrain)
dt8_sc_train=dt8.score(xtrain, ytrain)
dt8_sc_test=dt8.score(xtest, ytest)
print('dt8 training score : ',dt8_sc_train)
print('dt8 test score : ',dt8_sc_test)
> dt8 training score :  0.898876404494382
> dt8 test score :  0.8097014925373134
    
# depth=9
dt9=tree.DecisionTreeClassifier(max_depth=9)
dt9.fit(xtrain,ytrain)
dt9_sc_train=dt9.score(xtrain, ytrain)
dt9_sc_test=dt9.score(xtest, ytest)
print('dt9 training score : ',dt9_sc_train)
print('dt9 test score : ',dt9_sc_test)
> dt9 training score :  0.9197431781701445
> dt9 test score :  0.7985074626865671

```



