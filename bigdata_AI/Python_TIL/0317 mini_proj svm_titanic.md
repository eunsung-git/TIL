## mini_proj_python

### SVM_titanic 생존 여부



#### train data

##### data 전처리

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
import seaborn as sns

from sklearn.model_selection import train_test_split

# 정규화
from sklearn.preprocessing import MinMaxScaler

# SVC
from sklearn.svm import SVC

# k-fold
from sklearn.model_selection import cross_val_score, StratifiedKFold

# LinearSVC
from sklearn.svm import LinearSVC

# RGF SVC - GridSearchCV
from sklearn.model_selection import GridSearchCV

-----------------------------------------------------------

path=r'C:\\Users\\student\\Desktop\\공부\\멀캠TIL\\dataset\\python\\data'

train=pd.read_csv(path+'\\titanic_train.csv')
test=pd.read_csv(path+'\\titanic_test.csv')

train.head()
train.info()
train.isnull().sum()
train.columns

-----------------------------------------------------------

## 전처리

trainData=train.copy()

# 필요없는 column 삭제
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

trainData.isnull().sum()
> Survived        0
> Pclass          0
> SibSp           0
> Parch           0
> Fare            0
> Sex_cat         0
> Embarked_cat    0

----------------------------------------------------------

# 정규화
y_train=np.array(trainData['Survived'])

x_train=trainData.drop(['Survived'], axis=1)
x_train=np.array(x_train)

scaler=MinMaxScaler()
x_train=scaler.fit_transform(x_train)

```



##### SVM model 생성

##### [1] SVC()

```python
# train set, test set 나누기
xtrain, xtest, ytrain,ytest=train_test_split(x_train,y_train,train_size=0.7,random_state=42)

## 적절한 C 찾기
# 1) SVC() 모델
for thisC in [1,3,5,10,40,60,80,100]:
    model=SVC(kernel='linear',C=thisC).fit(xtrain,ytrain)
    score_train=model.score(xtrain,ytrain)
    score_test=model.score(xtest,ytest)
    print('SVC - C: {}, train score: {:2f}, test score : {:2f} \n'.format(thisC,score_train,score_test))
> SVC - C: 1, train score: 0.784912, test score : 0.791045 
> SVC - C: 3, train score: 0.784912, test score : 0.791045 
> SVC - C: 5, train score: 0.784912, test score : 0.791045 
> SVC - C: 10, train score: 0.784912, test score : 0.791045 
> SVC - C: 40, train score: 0.784912, test score : 0.791045 
> SVC - C: 60, train score: 0.784912, test score : 0.791045 
> SVC - C: 80, train score: 0.784912, test score : 0.791045 
> SVC - C: 100, train score: 0.784912, test score : 0.791045
            
# 2) k-fold 교차검증 모델
model=SVC(kernel='linear', C=20).fit(xtrain,ytrain)
scores=cross_val_score(model, xtrain, ytrain, cv=5)
print('k-fold cv score : ' + str(scores))
print('k-fold cv 평균 score : ' + str(scores.mean()))
> k-fold cv score : [0.73015873 0.888      0.70967742 0.78225806 0.81451613]
> k-fold cv 평균 score : 0.7849220686123912

# 2)-1 stratified k-fold 교차검증
st_scores=cross_val_score(model, xtrain, ytrain,cv=StratifiedKFold(5,random_state=10,shuffle=True))
print('stratified k-fold cv score : ' + str(st_scores))
print('stratified k-fold cv 평균 score : ' + str(st_scores.mean()))
> stratified k-fold cv score : [0.8015873  0.824      0.7983871  0.71774194 0.78225806]
> stratified k-fold cv 평균 score : 0.784794879672299

```



##### [2] LinearSVC()

```python
## 적절한 C 찾기
for thisC in [1,3,5,10,40,60,80,100]:
    model2=LinearSVC(C=thisC).fit(xtrain,  ytrain)
    score_train=model2.score(xtrain,ytrain)
    score_test=model2.score(xtest,ytest)
    print('LinearSVC - C: {}, train score: {:2f}, test score : {:2f} \n'.format(thisC,score_train,score_test))
> LinearSVC - C: 1, train score: 0.794543, test score : 0.798507 
> LinearSVC - C: 3, train score: 0.794543, test score : 0.794776 
> LinearSVC - C: 5, train score: 0.794543, test score : 0.794776 
> LinearSVC - C: 10, train score: 0.794543, test score : 0.794776 
> LinearSVC - C: 40, train score: 0.799358, test score : 0.802239 
> LinearSVC - C: 60, train score: 0.791332, test score : 0.794776 
> LinearSVC - C: 80, train score: 0.797753, test score : 0.802239 
> LinearSVC - C: 100, train score: 0.744783, test score : 0.772388 
```



##### [3]  RBF SVC()

```python
## 적절한 C, gamma 찾기
# GridSearchCV
param={'C':[1,2,3,5,7,10], 'gamma':[.1, .25, .5, .75, 1]}
model=GridSearchCV(SVC(kernel='rbf'), param, cv=5).fit(xtrain, ytrain)
print(model.best_params_)
print(model.best_score_)
> {'C': 2, 'gamma': 0.75}
> 0.8170144462279294
```



#### test data

##### data 전처리

```python
testData=test.copy()

# 필요없는 column 삭제
testData.drop(['PassengerId'],axis=1,inplace=True)
testData.drop(['Name'],axis=1,inplace=True)
testData.drop(['Ticket'],axis=1,inplace=True)
testData.drop(['Cabin'],axis=1,inplace=True)
testData.drop(['Age'],axis=1,inplace=True)

# 특정 값 대체 / nan 처리
testData['Sex_cat']=testData['Sex'].map({'male':1,'female':0})
testData.drop('Sex',axis=1,inplace=True)
testData['Embarked_cat']=testData['Embarked'].map({'S':1,'C':2, 'Q':3})
testData.drop('Embarked',axis=1,inplace=True)

testData['Embarked_cat']=testData['Embarked_cat'].fillna(0)
testData['Fare']=testData['Fare'].fillna(0)

testData.isnull().sum()
> Pclass          0
> SibSp           0
> Parch           0
> Fare            0
> Sex_cat         0
> Embarked_cat    0

# 정규화
testData=scaler.fit_transform(testData)
```



##### model 생성 및 예측

```python
# model 만들기
model_test=SVC(kernel='rbf', C=2, gamma=.75).fit(xtrain,ytrain)

# 예측
pred=model_test.predict(testData)
pred=pd.DataFrame(pred)
pred
```