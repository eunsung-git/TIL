## mini_proj_python

### MLP classification tf&keras_인디언data



#### 1 tensorflow

```python
## data 불러오기
import pandas as pd

path = r'C:\\Users\\student\\Desktop\\dataset\\python\\data'
data = pd.read_csv(path+'\\pima-indians-diabetes.csv', header=None)


## data 전처리
# xdata/ydata 분리
xdata = data.iloc[:,:-1]
ydata = data.iloc[:,[-1]]

# 정규화
from sklearn.preprocessing import MinMaxScaler
xdata = MinMaxScaler().fit_transform(xdata)

# train/test 분리
from sklearn.model_selection import train_test_split
xtrain, xtest, ytrain, ytest = train_test_split(xdata,ydata,test_size=0.3)

print(xtrain.shape, xtest.shape)
> (537, 8) (231, 8)

print(ytrain.shape, ytest.shape)]
> (537, 1) (231, 1)


## tf model 생성
import tensorflow as tf
tf.set_random_seed(777)

x = tf.placeholder(tf.float32, shape=[None,8])
y = tf.placeholder(tf.float32, shape=[None,1])

w1 = tf.Variable(tf.random_normal([8,10]))
b1 = tf.Variable(tf.random_normal([10]))
layer1 = tf.nn.relu(tf.matmul(x,w1)+b1)

w2 = tf.Variable(tf.random_normal([10,10]))
b2 = tf.Variable(tf.random_normal([10]))
layer2 = tf.nn.relu(tf.matmul(layer1,w2)+b2)

w3 = tf.Variable(tf.random_normal([10,10]))
b3 = tf.Variable(tf.random_normal([10]))
layer3 = tf.nn.relu(tf.matmul(layer2,w3)+b3)

w4 = tf.Variable(tf.random_normal([10,1]))
b4 = tf.Variable(tf.random_normal([1]))
hf = tf.sigmoid(tf.matmul(layer3,w4)+b4)

cost = -tf.reduce_mean((y*tf.log(hf))+((1-y)*tf.log(1-hf)))
train = tf.train.GradientDescentOptimizer(0.1).minimize(cost)


## model 학습 및 예츨
accuracy = tf.reduce_mean(tf.cast(tf.equal(tf.cast(hf > 0.5, dtype = tf.float32), y), dtype = tf.float32))

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    for epoch in range(10001):
        _, cv = sess.run([train, cost], {x:xtrain,  y:ytrain})
        if epoch % 1000 == 0:
            print('{}번째 cost : {:.9f}'.format(epoch, cv))
    av = sess.run([accuracy], {x:xtest, y:ytest})
    print(av)
> 0번째 cost : 1.015721202
> 1000번째 cost : 0.422954708
> 2000번째 cost : 0.400873423
> 3000번째 cost : 0.396239847
> 4000번째 cost : nan
> 5000번째 cost : nan
> 6000번째 cost : nan
> 7000번째 cost : nan
> 8000번째 cost : nan
> 9000번째 cost : nan
> 10000번째 cost : nan
> [0.63203466]
```



#### 2 keras

```python
from keras.utils import np_utils
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Activation

## model 학습 및 예측
model = Sequential()
model.add(Dense(8,input_dim=8, activation='relu'))
model.add(Dense(4, activation='relu'))
model.add(Dense(2, activation='relu'))
model.add(Dense(1, activation='sigmoid'))

model.compile('adam', 'mean_squared_error', ['accuracy'])

model.fit(xtrain, ytrain, 1000, 10000)

eval = model.evaluate(xtest,ytest,1000)[1]
print('evaluation : ', eval)
> evaluation :  0.7316017150878906
```



------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------



update

#### update 2 keras_weight 초기화

```python
from keras.models import Sequential
from keras.layers import Dense
import numpy as np
np.random.seed(42)
tf.set_random_seed(42)

path = r'C:\\Users\\student\\Desktop\\dataset\\python\\data'
data = np.loadtxt(path+'\\pima-indians-diabetes.csv', delimiter=',')

xdata = data[:,:8]
ydata = data[:,8]

print(xdata.shape, ydata.shape)
> (768, 8) (768,)

model = Sequential()
model.add(Dense(12, input_dim=8, activation='relu'))
model.add(Dense(8, activation='relu'))
model.add(Dense(1,  activation='sigmoid'))

model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

model.fit(xdata, ydata, epochs=200, batch_size=10)

model.evaluate(xdata,ydata)[1]
> 0.78515625


```

