### MLP & CNN_fashion mnist





#### MLP  fashion_mnist

```python
import tensorflow as tf
from tensorflow import keras
from keras.models import Sequential
from keras.layers import *
import numpy as np
import matplotlib.pyplot as plt

fashion_mnist = keras.datasets.fashion_mnist
(trainimage, trainlabel), (testimage, testlabel) = fashion_mnist.load_data()

classnames = ['t-shirt', 'trouser', 'pullover', 'dress', 'coat', 'sandal','shirt', 'sneaker',
             'bag', 'ankle boot']

print(trainimage.shape, trainlabel.shape) 
> (60000, 28, 28) (60000,)
print(testimage.shape, testlabel.shape)
> (10000, 28, 28) (10000,)

trainimage = trainimage.reshape((60000,28*28))/255.0
testimage = testimage.reshape((10000,28*28))/255.0

model = Sequential()

model.add(Dense(512, input_shape=(28*28,), activation='relu'))
model.add(Dense(128, activation='relu'))
model.add(Dense(32, activation='relu'))
model.add(Dense(10, activation='softmax'))

model.compile(loss='sparse_categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

model.fit(trainimage, trainlabel, epochs=5, batch_size=128)

model.evaluate(testimage, testlabel)[1]
> 0.8274000287055969

classnames[np.argmax(model.predict(testimage)[0])]
> 'ankle boot'

```



#### CNN  fashion_mnist

```python
from keras.preprocessing.image import *
from keras.utils import to_categorical
from keras.models import Sequential
from keras.layers import *
from keras.callbacks import EarlyStopping, ReduceLROnPlateau
from sklearn.model_selection import train_test_split
import pandas as pd
import numpy as np

fashion_mnist = keras.datasets.fashion_mnist
(trainimage, trainlabel), (testimage, testlabel) = fashion_mnist.load_data()

print(trainimage.shape, trainlabel.shape)
> (60000, 28, 28) (60000,)
print(testimage.shape, testlabel.shape)
> (10000, 28, 28) (10000,)

trainimage = trainimage.reshape(trainimage.shape[0],28,28,1)/255.0
testimage = testimage.reshape(testimage.shape[0],28,28,1)/255.0

model = Sequential()

model.add(Conv2D(64, (3,3), activation='relu', input_shape=(28,28,1)))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=2))
model.add(Dropout(0.3))

model.add(Conv2D(128, (3,3), activation='relu'))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=2))
model.add(Dropout(0.3))

model.add(Conv2D(256, (3,3), activation='relu'))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=2))
model.add(Dropout(0.3))

model.add(Flatten())
model.add(Dense(10, activation='relu'))
model.add(BatchNormalization())
model.add(Dropout(0.3))

model.add(Dense(10, activation='softmax'))

model.compile(loss='sparse_categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

es = EarlyStopping(patience=5)

lrreduction = ReduceLROnPlateau(monitor='val_accuracy', patience=2, factor=0.5, min_lr=0.00001, verbose=1)

callbacks = [es, lrreduction]

model.fit(trainimage, trainlabel, epochs=10, batch_size=128, callbacks=callbacks)

model.evaluate(testimage, testlabel)[1]
> 0.5712000131607056

```

