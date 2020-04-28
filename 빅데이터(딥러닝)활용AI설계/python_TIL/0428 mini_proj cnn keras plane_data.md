## mini_proj_python

### CNN keras plane_data

```python
import tensorflow as tf
from tensorflow import keras
from keras.models import Sequential
from keras.layers import *
from keras.preprocessing.image import *
from keras.callbacks import EarlyStopping, ReduceLROnPlateau
from sklearn.model_selection import train_test_split
import pandas as pd
import os

## data 불러오기 및 df 만들기
planes = os.listdir('C:\\Users\\student\\Desktop\\dataset\\python\\planesnet')

categories = []
for name in planes:
    category = name.split('__')[0]
    if category == '0':
        categories.append('X')
    else:
        categories.append('O')
        
df = pd.DataFrame({'filename': planes, 'label':categories})

df.label.value_counts()
> X    24000
> O     8000

## train/test set 나누기
train_df, test_df = train_test_split(df, test_size=0.25, random_state=42)

## generator 생성
idg = ImageDataGenerator(rescale=1./255)
train_idg = idg.flow_from_dataframe(train_df, 'C:\\Users\\student\\Desktop\\dataset\\python\\planesnet',
                                              x_col='filename', y_col='label', class_mode='binary', 
                                              target_size=(20,20), batch_size=200)
test_idg = idg.flow_from_dataframe(test_df, 'C:\\Users\\student\\Desktop\\dataset\\python\\planesnet',
                                              x_col='filename', y_col='label', class_mode='binary', 
                                              target_size=(20,20), batch_size=200)


## model 생성
model = Sequential()
model.add(Conv2D(32, (3,3),input_shape=(20,20,3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Dropout(0.3))

model.add(Conv2D(64, (3,3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Dropout(0.3))

model.add(Flatten())
model.add(Dense(128, activation='relu'))

model.add(Dense(1, activation='sigmoid'))

## model 환경 설정
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

## model 학습
model.fit_generator(train_idg, epochs=5, steps_per_epoch=110, validation_data=test_idg, validation_steps=40)

## model 평가
model.evaluate_generator(test_idg)[1]
> 0.9548749923706055

```

