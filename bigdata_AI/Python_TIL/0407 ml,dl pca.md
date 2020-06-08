### PCA (주성분분석)

```python
import pandas as pd
import numpy as np

from sklearn.preprocessing import StandardScaler

import matplotlib.pyplot as plt
import seaborn as sns


df = pd.DataFrame(columns=['calory', 'breakfast', 'lunch', 'dinner', 'exercise', 'body_shape'])
df.loc[0] = [1200, 1, 0, 0, 2, 'Skinny']
df.loc[1] = [2800, 1, 1, 1, 1, 'Normal']
df.loc[2] = [3500, 2, 2, 1, 0, 'Fat']
df.loc[3] = [1400, 0, 1, 0, 3, 'Skinny']
df.loc[4] = [5000, 2, 2, 2, 0, 'Fat']
df.loc[5] = [1300, 0, 0, 1, 2, 'Skinny']
df.loc[6] = [3000, 1, 0, 1, 1, 'Normal']
df.loc[7] = [4000, 2, 2, 2, 0, 'Fat']
df.loc[8] = [2600, 0, 2, 0, 0, 'Normal']
df.loc[9] = [3000, 1, 2, 1, 1, 'Fat']

# data 나누기
x=df[['calory','breakfast','lunch','dinner','exercise']]
y=df[['body_shape']]


## 공분산 np.cov()
np.cov(x_std.T)
> [[ 1.11111111  0.88379717  0.76782385  0.89376551 -0.93179808]
>  [ 0.88379717  1.11111111  0.49362406  0.81967902 -0.71721914]
>  [ 0.76782385  0.49362406  1.11111111  0.40056715 -0.76471911]
>  [ 0.89376551  0.81967902  0.40056715  1.11111111 -0.63492063]
>  [-0.93179808 -0.71721914 -0.76471911 -0.63492063  1.11111111]]


## 고유vector & 고유값 찾기  np.linalg.eig()
eig_vals, eig_vecs=np.linalg.eig(cov_matrix)
print('고유vector \n %s' % eig_vecs)
print('고유값 \n %s' % eig_vals)
> 고유vector 
 [[ 0.508005    0.0169937  -0.84711404  0.11637853  0.10244985]
 [ 0.44660335  0.36890361  0.12808055 -0.63112016 -0.49973822]
 [ 0.38377913 -0.70804084  0.20681005 -0.40305226  0.38232213]
 [ 0.42845209  0.53194699  0.3694462   0.22228235  0.58954327]
 [-0.46002038  0.2816592  -0.29450345 -0.61341895  0.49601841]]
> 고유값 
 [4.0657343  0.8387565  0.07629538 0.27758568 0.2971837 ]
    

## 가장 큰 고유값에 data 정사영  -> 차원 축소
# x_std (10*5)  ->  eig.vecs.T[n] (5*1) 
projected_x=x_std.dot(eig_vecs.T[0])

res=pd.DataFrame(projected_x,columns=['PC1'])
res['yaxis']=0.0
res['label']=y

sns.lmplot('PC1', 'yaxis', data=res, hue='label', fit_reg=False)
plt.title('PCA result')

```

