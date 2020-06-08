### seaborn 시각화

> > 1차원 float data : kdeplot, rugplot, distplot...
> >  n차원 data (변수 여러개) :
> >
> >    * 2차원 float - scatterplot(jointplot)
> >    * 2차원 category - heatmap
> >    * 2차원 float + category - barplot, boxplot, pointplot, violinplot, swarmplot,stripplot
> >    * 3차원 이상 float - pairplot
> >    * 3차원 이상 float + category - category에 hue 속성 지정
>
> > category별 data : countplot



```python
import pandas as pd
import numpy as np

import seaborn as sns
import matplotlib.pyplot as plt

ax=plt.subplots()
tips=sns.load_dataset('tips')
ax=sns.regplot(x='total_bill',y='tip',data=tips,fit_reg=False)
ax.set_xlabel('TB')
ax.set_ylabel('Tip')
ax.set_title('Total bill and Tip')


joint=sns.jointplot(x='total_bill',y='tip',data=tips,kind='hex')
joint.set_axis_labels(xlabel='TB',ylabel='Tip')


kde,ax=plt.subplots()
ax=sns.kdeplot(data=tips['total_bill'],data2=tips['tip'],shade=True)
ax.set_xlabel('TB')
ax.set_ylabel('Tip')
ax.set_title('Kernel Density Plot')


ax=plt.subplots()
sns.barplot(x='time',y='total_bill', data=tips)


ax=plt.subplots()
sns.boxplot(x='total_bill',data=tips,orient='v')
sns.boxplot(x='day',y='total_bill',data=tips,hue='smoker',palette='Set3')
sns.swarmplot(x='day',y='total_bill',data=tips)


ax=plt.subplots()
sns.violinplot(x='time',y='total_bill',data=tips)


sns.pairplot(tips)
pg=sns.PairGrid(tips)
pg.map_upper(sns.regplot)
pg.map_lower(sns.kdeplot)
pg.map_diag(sns.distplot,rug=True)



#http://seaborn.pydata.org/
```







```python
import pandas as pd
import numpy as np

import seaborn as sns
import matplotlib.pyplot as plt

iris=sns.load_dataset('iris')
titanic=sns.load_dataset('titanic')
flights=sns.load_dataset('flights')

x=iris.petal_length.values
sns.rugplot(x)
sns.kdeplot(x)
sns.distplot(x)


## 2차원 float
sns.jointplot(x='sepal_length',y='sepal_width',data=iris,kind='scatter')

sns.jointplot(x='sepal_length',y='sepal_width',data=iris,kind='kde')


## 3차원 이상 
sns.pairplot(iris,hue='species',markers=['o','s','D'])


## 2차원 category
titanic_size=titanic.pivot_table(index='class',columns='sex',aggfunc='size')
sns.heatmap(titanic_size,annot=True,fmt='d',cmap=sns.light_palette('black'))

sns.heatmap(fp,linewidths=1,annot=True, fmt='d')


## 2차원 float+category
sns.barplot(x='day',y='total_bill',data=tips)
sns.boxplot(x='day',y='total_bill',data=tips)
sns.violinplot(x='day',y='total_bill',data=tips)
sns.stripplot(x='day',y='total_bill',data=tips,jitter=True)
sns.swarmplot(x='day',y='total_bill',data=tips)


sns.barplot(x='day',y='total_bill',data=tips,hue='sex')

sns.stripplot(x='day',y='total_bill',data=tips,hue='sex')
plt.legend(loc=1)

```



### pandas  시각화

```python
import pandas as pd
import numpy as np

df=pd.DataFrame(np.random.randn(100,3),index=pd.date_range('1/28/2020',periods=100),columns=['A','B','C']).cumsum()
df.plot()


iris.sepal_length[:20].plot(kind='bar',rot=90)
#=
iris.sepal_length[:20].plot.bar(rot=90)


df2=iris.groupby(iris.species).mean()
df2.plot.bar(rot=0)


df3=titanic.pclass.value_counts()
df3.plot.pie(autopct='%.2f%%')


iris.plot.hist()
iris.plot.kde()

```





### 선형대수

> >data 갯수, 형태에 따라
> >scalar(숫자 1개), vector(숫자 n개), matrix(vector n개),tensor(matrix n개)

```python
## 비슷한 image 찾기
from sklearn.datasets import load_digits
digits=load_digits()
samples=[0,10,20,30,1,11,21,31]
d=[]
for i in range(8):
    d.append(digits.images[samples[i]])
plt.figure(figsize=(8,2))
for i in range(8):
    plt.subplot(1,8,i+1)
    plt.imshow(d[i],cmap=plt.cm.bone_r)
    plt.title('lmage{}'.format(i+1))
    plt.grid(False)
    plt.xticks([]);plt.yticks([])
    
# 2d -> 64d
v=[]
for i in range(8):
    v.append(d[i].reshape(64,1))
plt.figure(figsize=(8,2))
for i in range(8):
    plt.subplot(1,8,i+1)
    plt.imshow(v[i],cmap=plt.cm.bone_r)
    plt.title('vector{}'.format(i+1))
    plt.grid(False)
    plt.xticks([]);plt.yticks([])  

    
    
## tensor image 출력    
from scipy import misc
img=misc.face()

plt.subplot(221)
plt.imshow(img,cmap=plt.cm.gray)
plt.axis('off')

plt.subplot(222)
plt.imshow(img[:,:,0],cmap=plt.cm.gray)
plt.axis('off')

plt.subplot(223)
plt.imshow(img[:,:,1],cmap=plt.cm.gray)
plt.axis('off')

plt.subplot(224)
plt.imshow(img[:,:,2],cmap=plt.cm.gray)
plt.axis('off')

```





### 내적   np.dot(x.T,y)  /  x.T@y   

> > vector간 곱셈
> >
> > * 차원이 같은 vector
> >* row vec * col vec  
> > * 내적의 결과값은 scalar
> >* vector간 유사도 계산에 활용

```python
x=np.array([[1],[2],[3]])
y=np.array([[4],[5],[6]])
np.dot(x.T,y)     # <- reshape
#=
x.T@y
#array([[32]])



## vector간 유사도 측정
from sklearn.datasets import load_digits
digits=load_digits()
d1=digits.images[0]
d2=digits.images[10]
d3=digits.images[1]
d4=digits.images[11]

v1=d1.reshape(64,1)
v2=d2.reshape(64,1)
v3=d3.reshape(64,1)
v4=d4.reshape(64,1)

plt.figure(figsize=(9,9))
import matplotlib.gridspec as gridspec
gs=gridspec.GridSpec(1,8,height_ratios=[1],width_ratios=[9,1,9,1,9,1,9,1])

for i in range(4):
    plt.subplot(gs[2*i])
    plt.imshow(eval('d'+str(i+1)),cmap=plt.cm.bone_r)
    plt.subplot(gs[2*i+1])
    plt.imshow(eval('v'+str(i+1)),cmap=plt.cm.bone_r)
    
## 유사도 비교    
(v1.T@v2)[0][0] #3064.0
(v1.T@v3)[0][0] #1866.0
(v1.T@v4)[0][0] #1883.0
#v2가 v1과 가장 유사함 
(np.dot(v3.T,v1))[0][0] #1866.0
(np.dot(v3.T,v2))[0][0] #2421.0
(np.dot(v3.T,v4))[0][0] #3661.0
#v4가 v3와 가장 유사함


```

