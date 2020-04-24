#### cnn_mnist_keras model

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

xtrain = xtrain.reshape(xtrain.shape[0],28,28,1).astype('float64')/255
xtest = xtest.reshape(xtest.shape[0],28,28,1).astype('float64')/255

ytrain = np_utils.to_categorical(ytrain,10)
ytest = np_utils.to_categorical(ytest,10)

print(xtrain.shape, ytrain.shape, xtest.shape, ytest.shape)
> (60000, 28, 28, 1) (60000, 10) (10000, 28, 28, 1) (10000, 10)

# model 구성
model = Sequential()

model.add(Conv2D(32, kernel_size=(3,3), input_shape=(28,28,1), activation='relu'))
model.add(Conv2D(64, kernel_size=(3,3), activation='relu'))
model.add(MaxPooling2D(pool_size=2))
model.add(Dropout(0.25))

model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(10, activation='softmax'))

# model 환경 설정
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

modeldir = './mycnnmodel/'

if not os.path.exists(modeldir):
    modelpath = './mycnnmodel/{epoch:02d}-{val_loss:.4f}.hdf5'
    os.mkdir(modeldir)

checkpointer = ModelCheckpoint(filepath=modelpath, monitor='val_loss', verbose=1, save_best_only=True)

es = EarlyStopping(monitor='val_loss', patience=10)

------------------------------------------------

## generator 선언
from keras.preprocessing.image import ImageDataGenerator

train_gen = ImageDataGenerator(rescale=1./255)
train_gen = train_gen.flow_from_directory('C:\\Users\\student\\Desktop\\dataset\\python\\image_data\\train', 
                             target_size=(24,24), batch_size=3, class_mode='categorical')

test_gen = ImageDataGenerator(rescale=1./255)
test_gen = test_gen.flow_from_directory('C:\\Users\\student\\Desktop\\dataset\\python\\image_data\\test', 
                             target_size=(24,24), batch_size=3, class_mode='categorical')

## cnn model 설정
# 크기(24,24), 채널 3, 필터 3*3, 필터개수 32, relu
model=Sequential()
model.add(Conv2D(32, kernel_size=(3,3), activation='relu', input_shape=(24,24,3)))
# 필터 3*3, 필터개수 64, relu
model.add(Conv2D(64, kernel_size=(3,3), activation='relu'))
# maxpool 2*2
model.add(MaxPooling2D(pool_size=(2,2)))
# 플래튼 => Dense(128개 뉴런 출력) => Dense(softmax)
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dense(3, activation='softmax'))

model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

model.fit_generator(train_gen, steps_per_epoch=15, epochs=50, validation_data=test_gen, validation_steps=5)

model.evaluate_generator(test_gen, steps=5)[1]
> 1.0


## img 변형
from keras.preprocessing.image import array_to_img, img_to_array, load_img
re_gen = ImageDataGenerator(rescale=1./255, rotation_range=15, width_shift_range=0.1, height_shift_range=0.1,
                  shear_range=0.5, zoom_range=[0.8,2.0], horizontal_flip=True,  vertical_flip=True, fill_mode='nearest')

i = 0
for batch in re_gen.flow(x,batch_size=1, save_to_dir='store', save_prefix='tri', save_format='png'):
    i += 1
    if i > 50:
        break

```

