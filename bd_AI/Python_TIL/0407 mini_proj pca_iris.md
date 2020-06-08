## mini_proj_python

### PCA_iris 분석



```python
import pandas as pd
import numpy as np

from sklearn.preprocessing import StandardScaler

import matplotlib.pyplot as plt
import seaborn as sns


## data 불러오기 및 전처리
from sklearn import datasets
iris=datasets.load_iris()

iris_df=pd.DataFrame(iris['data'],columns=iris['feature_names'])
iris_df['target']=iris['target']

iris_df=iris_df.replace({'target':0},{'target':'Setosa'})
iris_df=iris_df.replace({'target':1},{'target':'Versicolor'})
iris_df=iris_df.replace({'target':2},{'target':'Virginica'})


## iris data 나누기
x=iris_df.iloc[:,:4]
y=iris_df.target


## data 표준화
x_std=StandardScaler().fit_transform(x)


## 공분산 np.cov()
iris_cov=np.cov(x_std.T)
print(iris_cov)
> [[ 1.00671141 -0.11835884  0.87760447  0.82343066]
>  [-0.11835884  1.00671141 -0.43131554 -0.36858315]
>  [ 0.87760447 -0.43131554  1.00671141  0.96932762]
>  [ 0.82343066 -0.36858315  0.96932762  1.00671141]]


## 고유vector/고유값 찾기  np.linalg.eig()
eig_vals, eig_vecs=np.linalg.eig(iris_cov)
print('고유vector \n %s' % eig_vecs)
print('고유값 \n %s' % eig_vals)
> 고유vector 
 [[ 0.52106591 -0.37741762 -0.71956635  0.26128628]
 [-0.26934744 -0.92329566  0.24438178 -0.12350962]
 [ 0.5804131  -0.02449161  0.14212637 -0.80144925]
 [ 0.56485654 -0.06694199  0.63427274  0.52359713]]
> 고유값 
 [2.93808505 0.9201649  0.14774182 0.02085386]
    
    
## 가장 큰 분산값을 가지는 col을 축으로 결정  -> 차원 축소
# sepal 가장 큰 분산 구하기
print(eig_vals[0] / sum(eig_vals[0:2]))
print(eig_vals[1] / sum(eig_vals[0:2]))
> 0.7615071820004647   -> 0번째 축
> 0.23849281799953534

# petal 가장 큰 분산 구하기
print(eig_vals[2] / sum(eig_vals[2:4]))
print(eig_vals[3] / sum(eig_vals[2:4]))
> 0.876308445281628   -> 2번째 축
> 0.12369155471837201


## sepal, petal 정사영
sepal=np.array([i[0:2] for i in x_std])
petal=np.array([i[2:4] for i in x_std])

projected_sepal=sepal.dot(eig_vecs.T[0][0:2])
projected_petal=petal.dot(eig_vecs.T[2][2:4])

## pca 결과 df 만들기
pca_df=pd.DataFrame(projected_sepal, columns=['sepal'])
pca_df['petal']=projected_petal
pca_df['target']=y


## pca df 시각화
sns.lmplot('sepal', 'petal', data=pca_df, hue='target', fit_reg=False)
plt.title('iris_PCA')
plt.show()

```

