## mini_proj_python

### MLP_ iris 분류



```python
import numpy as  np
import pandas as pd
import re
import matplotlib.pyplot as plt
%matplotlib inline

from sklearn.model_selection import train_test_split

# MLP model
from sklearn.neural_network import MLPRegressor
from sklearn.neural_network import MLPClassifier

------------------------------------------------------

# iris  dataset 불러오기
from sklearn.datasets import load_iris
iris=load_iris()

# iris df 만들기
iris_df=pd.DataFrame(iris.data, columns=iris.feature_names)

# target column 추가
iris_df['target']=iris.target_names[iris.target]

# train set / test set 생성
iris_train=iris_df.copy()
iris_train.drop(['target'],axis=1,inplace=True)

xtrain, xtest,ytrain,ytest=train_test_split(iris_train,iris_df['target'],train_size=0.7,random_state=42)

--------------------------------------------------------

# MLPClassifier model 생성
mlc=MLPClassifier(solver='lbfgs',alpha=1e-5,hidden_layer_sizes=3)
mlc.fit(xtrain,ytrain)

# target scoring
train_score=mlc.score(xtrain,ytrain)
test_score=mlc.score(xtest,ytest)
print('train_score :',train_score)
print('test_score :',test_score)
> train_score : 0.9809523809523809
> test_score : 1.0
    
> train_score : 0.6666666666666666
> test_score : 0.7111111111111111

```

