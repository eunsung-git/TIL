### cnn_dogcat

```python
import pandas as pd
import numpy as np
from keras.preprocessing.image import *
from keras.utils import to_categorical
from keras.callbacks import EarlyStopping, ReduceLROnPlateau
from sklearn.model_selection import train_test_split
import matplotlib. pyplot as plt
import random
import os

# data 형상 관련 상수
image_width = 128
image_height = 128
image_size = (image_width, image_height)
image_channel = 3

# data 불러오기
path = r'C:\\Users\\student\\Desktop\\dataset\\python\\dogcat'

trainfiles = os.listdir(path+'\\train')

# train df 생성
categories = []
for name in trainfiles:
    category = name.split('.')[0]
    if category == 'dog':
        categories.append(1)
    else:
        categories.append(0)
        
df = pd.DataFrame({'trainfiles': trainfiles, 'category':categories})

df.category.value_counts().plot.bar()



## 배치 정규화(batch normalization) : 신경망 입력data를 (평균,분산)=(0,1)로 정규화
from keras.models import Sequential
from keras.layers import *

model = Sequential()
model.add(Conv2D(32, (3,3), activation='relu', input_shape=(image_width, image_height, image_channel)))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Dropout(0.25))

model.add(Conv2D(64, (3,3), activation='relu'))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Dropout(0.25))

model.add(Flatten())
model.add(Dense(512, activation='relu'))
model.add(BatchNormalization())
model.add(Dropout(0.5))

model.add(Dense(2, activation='softmax'))

model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

es = EarlyStopping(patience=10)
lrreduction = ReduceLROnPlateau(monitor='val_accuracy', patience=2, factor=0.5, min_lr=0.00001, verbose=1)

callbacks =  [es, lrreduction]

# col type을 string으로 변경
df.category = df.category.replace({0:'cat',  1:'dog'})

train_df, validate_df = train_test_split(df, test_size=0.2, random_state=42)

train_df = train_df.reset_index(drop=True)

validate_df = validate_df.reset_index(drop=True)

train_df.category.value_counts().plot.bar()

validate_df.category.value_counts().plot.bar()

total_train = train_df.shape[0]
total_validate = validate_df.shape[0]
batch_size = 15

## train generator 설정
traingen = ImageDataGenerator(rotation_range=15, rescale=1./255, shear_range=0.1, zoom_range=0.2, horizontal_flip=True, 
                  width_shift_range=0.1, height_shift_range=0.1)
traingenerator = traingen.flow_from_dataframe(train_df, 'C:\\Users\\student\\Desktop\\dataset\\python\\dogcat\\train\\',
                            x_col='trainfiles', y_col='category', target_size=image_size, class_mode='categorical',
                             batch_size=batch_size)

## validate generator 설정
validategen = ImageDataGenerator(rescale=1./255)
validategenerator = validategen.flow_from_dataframe(validate_df, 'C:\\Users\\student\\Desktop\\dataset\\python\\dogcat\\train\\',
                            x_col='trainfiles', y_col='category', target_size=image_size, class_mode='categorical',
                             batch_size=batch_size)

## model 학습
history = model.fit_generator(traingenerator, epochs=3, steps_per_epoch=total_train//batch_size,
                             validation_data=validategenerator, validation_steps=total_validate//batch_size,
                             callbacks=callbacks)


# test df 생성
path = r'C:\\Users\\student\\Desktop\\dataset\\python\\dogcat'
filenames = os.listdir(path+'\\test')

categories = []
for name in filenames:
    category = name.split('.')[0]
    if category == 'dog':
        categories.append(1)
    else:
        categories.append(0)
        
testdf = pd.DataFrame({'filenames': filenames, 'category':categories})

testdf.category = testdf.category.replace({0:'cat',  1:'dog'})

total_test = testdf.shape[0]

batch_size = 15

## test generator 설정
testgen = ImageDataGenerator(rescale=1./255)
testgenerator = testgen.flow_from_dataframe(testdf, 'C:\\Users\\student\\Desktop\\dataset\\python\\dogcat\\test\\',
                            x_col='filenames', y_col='category', target_size=image_size, class_mode='categorical',
                             batch_size=batch_size)

## test 예측
print('Predict')
output = model.predict_generator(testgenerator, steps=5)
np.set_printoptions(formatter={'float': lambda x: "{0:0.3f}".format(x)})
print(testgenerator.class_indices)
print(output)

```

