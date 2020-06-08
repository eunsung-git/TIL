#### stack() / unstack()


```python
import numpy as np
import pandas as pd

data = pd.DataFrame(data=np.arange(16).reshape(4, 4),index=mul_index,
                 columns=['prd_1', 'prd_2', 'prd_3', 'prd_4'],
                 dtype='int')

mul_index = pd.MultiIndex.from_tuples([('cust_1', '2020'),('cust_1','2021'),('cust_2', '2020'), ('cust_2', '2021')])  

datastacked=data.stack()

datastacked['cust_2']['2020'][['prd_1',"prd_2"]]

data.ix['cust_2','prd_3']=np.nan

## nan 출력 x
data.stack()   

## nan 포함 출력
data.stack(dropna=False) 


## 마지막 level이 column
datastacked.unstack()
datastacked.unstack(level=-1)

## 지정한 level이 column
datastacked.unstack(level=0)

```



#### wide_to_long()

```python
import numpy as np
import pandas as pd

data_wide = pd.DataFrame({
    "C1prd1" : {0 : "a", 1 : "b",2:"c"},
    "C1prd2" : {0 : "d", 1 : "e", 2 : "f"},
    "C2prd1" : {0 : 2.5, 1 : 1.2, 2 : .7},
    "C2prd2" : {0 : 3.2, 1 : 1.3, 2 : .1},
    "value" : dict(zip(range(3), np.random.randn(3)))})

data_wide['seq_no']=data_wide.index

pd.wide_to_long(data_wide,['c1','c2'],i='seq_no',j='prd')


```



#### crosstab(index, column)

```python
import numpy as np
import pandas as pd

data=pd.DataFrame({
    'id':['id1','id1','id1','id2','id2','id3'],
    'f1':['a','a','a','b','b','b'],
    'f2':['d','d','d','c','c','d']})

pd.crosstab(data.f1,data.f2)
```





```python
각 성별 생존률
## groupby(기준column)[column].함수()
train.groupby('Sex')['Survived'].mean()
train.groupby('Sex')[['Survived']].mean()

pd.pivot_table(train,index='Sex',values='Survived',aggfunc=np.mean)
train.pivot_table(index='Sex',values='Survived',aggfunc=np.mean)

각 성별 생존자 통계
train.groupby('Sex')[['Survived']].describe()

각 성별 선실별 생존률
train.pivot_table(index=['Sex','Pclass'],values='Survived',aggfunc=np.mean)
train.pivot_table('Survived',['Sex','Pclass'],aggfunc=np.mean)


train.select_dtypes(include=['object','int64'])

obj_df.isnull().any()



train.loc[train['Sex']=='male','Sex']=0
train.loc[train['Sex']=='female','Sex']=1

le=LabelEncoder()
le.fit(['male','female'])
train['Sex']=le.transform(train['Sex'])
train["Sex"]


#sex(m/f)  Pclass(1,2,3)  Embarked(c/q/s)
#10 100
#01 010
dummy_columns=['Sex','Pclass','Embarked']

def myDummy(data,columns):
    for column in columns:
        data=pd.concat([data,pd.get_dummies(data[column],prefix=column)],axis=1)
        data.drop(column,axis=1)
    return data
        
##column을 원핫인코딩하여 리턴  
trainDummy=myDummy(train, dummy_columns)
testDummy=myDummy(test, dummy_columns)
print('before')
print(train.shape)
print(test.shape)
print('after')
print(trainDummy.shape)
print(testDummy.shape)

#before
#(891, 12)
#(418, 11)
#after
#(891, 20)
#(418, 19)




```

