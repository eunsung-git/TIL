## SVM

> svm   
>
> - 선형 :  LinearSVM // C(오류허용 결정)
>
> - 비선형 :  RBF SVM // C, gamma(거리 결정)
>
>    C, gamma  
>
>    



#### <mobile-price-range  예측>

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

path=r'C:\\Users\\student\\Desktop\\공부\\멀캠TIL\\dataset\\python\\mobile-price-classification'

train=pd.read_csv(path+'\\train.csv')
test=pd.read_csv(path+'\\test.csv')
train.head()
train.info()
train.isnull().sum().max()
train.columns
train['price_range'].describe()
train['price_range'].unique()

# 상관계수
train_corr=train.corr()
plt.subplots(figsize=(12,10))
sns.heatmap(train_corr,vmax=.8,square=True, annot=True, annot_kws={'size':8})

# 시각화
plt.subplots(figsize=(10,4))
plt.scatter(y=train['price_range'],x=train['battery_power'],color='red')
plt.scatter(y=train['price_range'],x=train['ram'],color='green')
plt.scatter(y=train['price_range'],x=train['n_cores'],color='blue')
plt.scatter(y=train['price_range'],x=train['mobile_wt'],color='orange')

-----------------------------------------------------------

## 정규화
trainData=train.copy()

y_train=np.array(trainData['price_range'])

x_train=trainData.drop(['price_range'],axis=1)
x_train=np.array(x_train)

scaler=MinMaxScaler()
x_train=scaler.fit_transform(x_train)

```



### SVM

#### model 생성
##### [1]  SVC()

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
> SVC - C: 1, train score: 0.955714, test score : 0.931667 
> SVC - C: 3, train score: 0.969286, test score : 0.953333 
> SVC - C: 5, train score: 0.970000, test score : 0.955000 
> SVC - C: 10, train score: 0.975714, test score : 0.960000 
> SVC - C: 40, train score: 0.980714, test score : 0.965000 
> SVC - C: 60, train score: 0.980714, test score : 0.963333 
> SVC - C: 80, train score: 0.982857, test score : 0.960000 
> SVC - C: 100, train score: 0.983571, test score : 0.961667 
            
# 2) k-fold 교차검증
model=SVC(kernel='linear', C=20).fit(xtrain,ytrain)
scores=cross_val_score(model, xtrain, ytrain, cv=5)
print('k-fold cv score : ' + str(scores))
print('k-fold cv 평균 score : ' + str(scores.mean()))
> k-fold cv score : [0.97153025 0.94661922 0.97857143 0.91785714 0.97122302]
> k-fold cv 평균 score : 0.9571602118406952

# 2)-1 stratified k-fold 교차검증
st_scores=cross_val_score(model, xtrain, ytrain,cv=StratifiedKFold(5,random_state=10,shuffle=True))
print('stratified k-fold cv score : ' + str(st_scores))
print('stratified k-fold cv 평균 score : ' + str(st_scores.mean()))
> stratified k-fold cv score : [0.98220641 0.95373665 0.95714286 0.97857143 0.95323741]
> stratified k-fold cv 평균 score : 0.9649789512568898
    
```



##### [2]  LinearSVC()

```python
for thisC in [1,3,5,10,40,60,80,100]:
    model2=LinearSVC(C=thisC).fit(xtrain,  ytrain)
    score_train=model2.score(xtrain,ytrain)
    score_test=model2.score(xtest,ytest)
    print('LinearSVC - C: {}, train score: {:2f}, test score : {:2f} \n'.format(thisC,score_train,score_test))
> LinearSVC - C: 1, train score: 0.842857, test score : 0.811667 
> LinearSVC - C: 3, train score: 0.858571, test score : 0.825000 
> LinearSVC - C: 5, train score: 0.865714, test score : 0.835000 
> LinearSVC - C: 10, train score: 0.875714, test score : 0.845000 
> LinearSVC - C: 40, train score: 0.866429, test score : 0.835000 
> LinearSVC - C: 60, train score: 0.747857, test score : 0.738333 
> LinearSVC - C: 80, train score: 0.797143, test score : 0.776667 
> LinearSVC - C: 100, train score: 0.805714, test score : 0.798333 

```



##### [3]  RBF SVC()

```python
## 적절한 C, gamma 찾기

# 1) 직접 찾기
for thisGamma in [.1, .25, .5, 1]:
    for thisC in [1,5,10,20,40,100]:
        model3=SVC(kernel='rbf', C=thisC, gamma=thisGamma).fit(xtrain, ytrain)
        score_train=model3.score(xtrain,ytrain)
        score_test=model3.score(xtest,ytest)
        print('RBF SVC - C: {}, gamma: {}, train score: {:2f}, test score : {:2f} \n'.format(thisC,thisGamma,score_train,score_test)) 
> RBF SVC - C: 1, gamma: 0.1, train score: 0.938571, test score : 0.878333 
> RBF SVC - C: 5, gamma: 0.1, train score: 0.971429, test score : 0.886667 
> RBF SVC - C: 10, gamma: 0.1, train score: 0.982143, test score : 0.888333 
> RBF SVC - C: 20, gamma: 0.1, train score: 0.992857, test score : 0.883333 
> RBF SVC - C: 40, gamma: 0.1, train score: 0.997857, test score : 0.876667 
> RBF SVC - C: 1, gamma: 0.25, train score: 0.962857, test score : 0.856667 
> RBF SVC - C: 5, gamma: 0.25, train score: 0.995000, test score : 0.871667 
> RBF SVC - C: 10, gamma: 0.25, train score: 1.000000, test score : 0.850000 
> RBF SVC - C: 20, gamma: 0.25, train score: 1.000000, test score : 0.835000 
> RBF SVC - C: 40, gamma: 0.25, train score: 1.000000, test score : 0.838333 
> RBF SVC - C: 1, gamma: 0.5, train score: 0.979286, test score : 0.811667 
> RBF SVC - C: 5, gamma: 0.5, train score: 1.000000, test score : 0.818333 
> RBF SVC - C: 10, gamma: 0.5, train score: 1.000000, test score : 0.813333 
> RBF SVC - C: 20, gamma: 0.5, train score: 1.000000, test score : 0.813333 
> RBF SVC - C: 40, gamma: 0.5, train score: 1.000000, test score : 0.813333 
> RBF SVC - C: 1, gamma: 1, train score: 0.992857, test score : 0.680000 
> RBF SVC - C: 5, gamma: 1, train score: 1.000000, test score : 0.706667 
> RBF SVC - C: 10, gamma: 1, train score: 1.000000, test score : 0.706667 
> RBF SVC - C: 20, gamma: 1, train score: 1.000000, test score : 0.706667 
> RBF SVC - C: 40, gamma: 1, train score: 1.000000, test score : 0.706667
 
----------------------------------------------------------

# 2) GridSearchCV
param={'C':[1,5,10,20,40], 'gamma':[.1, .25, .5, 1]}
model3_2=GridSearchCV(SVC(kernel='rbf'), param, cv=5).fit(xtrain, ytrain)
print(model3_2.best_params_)
print(model3_2.best_score_) 
> {'C': 5, 'gamma': 0.1}
0.8928571428571429
```



#### test data 예측

##### data 전처리

```python
testData=test.copy()
testData=testData.drop(['id'], axis=1)

# 정규화
testData=scaler.fit_transform(testData)
```



##### model 생성 및 예측

```python
# model 만들기
model_test=SVC(kernel='rbf', C=5, gamma=.1).fit(xtrain,ytrain)

# 예측
pred=model_test.predict(testData)
pred=pd.DataFrame(pred)
pred
```