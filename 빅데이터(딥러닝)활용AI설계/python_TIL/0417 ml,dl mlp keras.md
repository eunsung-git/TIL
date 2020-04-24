### keras model 구현



> > keras model 만들기
>
> 1  데이터셋 생성
>
> 2  model 구성
>
> 3  학습과정 설정
>
> 4  model 학습
>
> 5  cost, accuracy 측정
>
> 6  model 평가


```python
from keras.utils import np_utils
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Activation

## 1) dataset 생성 및 전처리
(xtrain,ytrain),(xtest,ytest) = mnist.load_data()

xtrain = xtrain.reshape(60000,784).astype('float32')/255.0
xtest = xtest.reshape(10000,784).astype('float32')/255.0

# 원핫인코딩
ytrain = np_utils.to_categorical(ytrain)
ytest = np_utils.to_categorical(ytest)

## 2) model 구성
model = Sequential()
model.add(Dense(units=64, input_dim=28*28, activation='relu'))
model.add(Dense(units=10, activation='softmax'))

## 3) 학습과정 설정
model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['accuracy'])

## 4) model 학습
hist = model.fit(xtrain,ytrain,epochs=5, batch_size=32)
> Epoch 1/5
60000/60000 [==============================] - 2s 35us/step - loss: 0.6608 - accuracy: 0.8319
> Epoch 2/5
60000/60000 [==============================] - 2s 32us/step - loss: 0.3452 - accuracy: 0.9023
> Epoch 3/5
60000/60000 [==============================] - 2s 30us/step - loss: 0.2983 - accuracy: 0.9155
> Epoch 4/5
60000/60000 [==============================] - 2s 32us/step - loss: 0.2694 - accuracy: 0.9239
> Epoch 5/5
60000/60000 [==============================] - 2s 33us/step - loss: 0.2470 - accuracy: 0.9304
        
## 5) cost, accuracy 측정
print(hist.history['loss'])
> [0.660846442190806, 0.3452354679663976, 0.29834899283448857, 0.26937211222449936, 0.24702843420406181]
print(hist.history['accuracy'])
> [0.8319167, 0.9023, 0.9155, 0.92391664, 0.93043333]

## 6) model 평가
res = model.evaluate(xtest,ytest, batch_size=32)

xhat = xtest[0:1]
yhat = model.predict(xhat)
print(yhat)
> [[1.4842747e-04, 9.0432344e-08, 8.8094396e-04, 9.0934383e-03,
        7.3074608e-07, 8.2192841e-05, 1.3494588e-08, 9.8891371e-01,
        3.9105482e-05, 8.4119523e-04]]

-------------------------------------------------------

from keras.utils import np_utils
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Activation

import numpy as np
np.random.seed(3)

(xtrain,ytrain),(xtest,ytest) = mnist.load_data()

xval = xtrain[50000:]
yval = ytrain[50000:]

xtrain = xtrain[:50000]
ytrain = ytrain[:50000]

xtrain = xtrain.reshape(50000,784).astype('float32')/255.0
xval = xval.reshape(10000,784).astype('float32')/255.0
xtest = xtest.reshape(10000,784).astype('float32')/255.0

tri = np.random.choice(50000,700)
vri = np.random.choice(10000,300)

xtrain = xtrain[tri]
ytrain = ytrain[tri]
xval = xval[vri]
yval = yval[vri]

ytrain = np_utils.to_categorical(ytrain)
yval = np_utils.to_categorical(yval)
ytest = np_utils.to_categorical(ytest)

model = Sequential()
model.add(Dense(input_dim=28*28, units=2, activation='relu'))
model.add(Dense(units=10, activation='softmax'))

model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['accuracy'])

hist = model.fit(xtrain,ytrain,epochs=3000,batch_size=10, validation_data=(xval,yval))

model.evaluate(xtest,ytest,batch_size=32)
print('cost : '+str(res[0]))
> cost : 0.22991833183318378
print('accuracy : '+str(res[1]))
> accuracy : 0.9348000288009644
    

```



#### keras model_폐암data 실습

```python
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense, Activation

import numpy as np
np.random.seed(123)

path = r'C:\\Users\\student\\Desktop\\dataset\\python\\data'

data = np.loadtxt(path+'\\ThoraricSurgery.csv',delimiter=',')

data.shape
> (470, 18)

x = data[:,0:17]
y = data[:,17]

model = Sequential()
model.add(Dense(30, input_dim=17,  activation='relu'))
model.add(Dense(1, activation='sigmoid'))
model.compile(loss='mean_squared_error',optimizer='adam', metrics=['accuracy'])

model.fit(x,y, epochs=30, batch_size=10)

model.evaluate(x,y)
> [0.14693006873130798, 0.8510638475418091]

```

