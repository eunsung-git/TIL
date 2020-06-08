> CNN(Convolutional Neural Net)
>
> convolutional layer : 입력데이터로부터 특징 추출
>
> pooling layer : 특징의 대표값 추출
>
> Conv2D



#### mnist_keras model

```python
from keras.datasets import mnist
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import *
from keras.callbacks import ModelCheckpoint, EarlyStopping
import numpy as np
import sys
import tensorflow as tf
import os

## data 불러오기 및 전처리
(xtrain,ytrain), (xtest,ytest) = mnist.load_data()

print(xtrain.shape, ytrain.shape)
> (60000, 28, 28) (60000,)
print(xtest.shape, ytest.shape)
> (10000, 28, 28) (10000,)

xtrain = xtrain.reshape(xtrain.shape[0],784).astype('float64')/255
xtest = xtest.reshape(xtest.shape[0],784).astype('float64')/255

ytrain = np_utils.to_categorical(ytrain,10)
ytest = np_utils.to_categorical(ytest,10)


## model 구성
model = Sequential()
model.add(Dense(512, input_dim=784, activation='relu'))
model.add(Dense(10, activation='softmax'))

## model 환경 설정
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

## model 최적화
modeldir = './mymodel/'

if not os.path.exists(modeldir):
    modelpath = './mymodel/{epoch:02d}-{val_loss:.4f}.hdf5'
    os.mkdir(modeldir)

## model 저장 옵션 설정
checkpointer = ModelCheckpoint(filepath=modelpath, monitor='val_loss', verbose=1, save_best_only=True)

es = EarlyStopping(monitor='val_loss', patience=10)


## model 생성
history = model.fit(xtrain, ytrain, validation_data=(xtest,ytest), epochs=30, batch_size=200, callbacks=[checkpointer, es])

print('test accuracy : %.4f' % (model.evaluate(xtest,ytest)[1]))
> test accuracy : 0.9785


## 시각화
val_loss = history.history['val_loss']
train_loss = history.history['loss']

xlen = np.arange(len(train_loss))

plt.plot(xlen, val_loss, marker='.', c='red', label='test_loss')
plt.plot(xlen, train_loss, marker='.', c='blue', label='train_loss')
plt.legend()
plt.grid()
plt.xlabel('epoch')
plt.ylabel('loss')
plt.show()


```



#### mnist_keras model 2

```python
from keras.datasets import mnist
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import *
from keras.callbacks import ModelCheckpoint, EarlyStopping
import numpy as np
import sys
import tensorflow as tf
import os

## data 불러오기 및 전처리
(xtrain,ytrain), (xtest,ytest) = mnist.load_data()

print(xtrain.shape, ytrain.shape)
> (60000, 28, 28) (60000,)
print(xtest.shape, ytest.shape)
> (10000, 28, 28) (10000,)

xtrain2 = xtrain.reshape(xtrain.shape[0],28,28,1).astype('float64')/255
xtest2 = xtest.reshape(xtest.shape[0],28,28,1).astype('float64')/255

ytrain = np_utils.to_categorical(ytrain,10)
ytest = np_utils.to_categorical(ytest,10)


## model 구성
model2 = Sequential()
# Conv2D(filter갯수, kernel_size=(,), input_shape=(r,c,color), activation= )
model2.add(Conv2D(32, kernel_size=(3,3), input_shape=(28,28,1), activation='relu'))
model2.add(Conv2D(64, kernel_size=(3,3), activation='relu'))
model2.add(MaxPooling2D(pool_size=2))
model2.add(Dropout(0.25))
# Flatten() - 1차원으로 변경
model2.add(Flatten())
model2.add(Dense(128, activation='relu'))
model2.add(Dropout(0.5))
model2.add(Dense(10, activation='softmax'))


## model 환경 설정
model2.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

## model 생성
history = model2.fit(xtrain2, ytrain, validation_data=(xtest2,ytest), epochs=30, batch_size=200, callbacks=[checkpointer, es])

print('test accuracy : %.4f' % (model2.evaluate(xtest2,ytest)))
> test accuracy : 0.9932

```



