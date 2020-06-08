## MLP  tensorflow&keras



> > weight 초기화
>
> | 활성화f | 초기화 algorithm |
> | ------- | ---------------- |
> | sigmoid | Xavier           |
> | relu    | He               |





#### MNIST classification_tensorflow

```python
import tensorflow as tf
import random
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from tqdm import tqdm

## data 불러오기
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets('MNIST_data/',one_hot=True)

## parameter 설정
epochs=15
batchsize=100

## xavier 활용 weight 초기화 설정
x = tf.placeholder(tf.float32, [None,28*28])
y = tf.placeholder(tf.float32, [None,10])

w1 = tf.get_variable('w1', shape=[784,256], initializer=tf.contrib.layers.xavier_initializer())
b1 = tf.Variable(tf.random_normal([256]))
l1 = tf.nn.relu(tf.matmul(x,w1)+b1) 

w2 = tf.get_variable('w2', shape=[256,256], initializer=tf.contrib.layers.xavier_initializer())
b2 = tf.Variable(tf.random_normal([256]))
l2 = tf.nn.relu(tf.matmul(l1,w2)+b2) 

w3 = tf.get_variable('w3', shape=[256,256], initializer=tf.contrib.layers.xavier_initializer())
b3 = tf.Variable(tf.random_normal([256]))
l3 = tf.nn.relu(tf.matmul(l2,w3)+b3) 

w4 = tf.get_variable('w4', shape=[256,256], initializer=tf.contrib.layers.xavier_initializer())
b4 = tf.Variable(tf.random_normal([256]))
l4 = tf.nn.relu(tf.matmul(l3,w4)+b4) 

w5 = tf.get_variable('w5', shape=[256,10], initializer=tf.contrib.layers.xavier_initializer())
b5 = tf.Variable(tf.random_normal([10]))
hf = tf.matmul(l4,w5)+b5

##  model 학습
cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits_v2(logits=hf, labels=y))
train = tf.train.AdamOptimizer(0.001).minimize(cost)

pred =  tf.equal(tf.argmax(hf,axis=1),tf.argmax(y,axis=1))
accuracy = tf.reduce_mean(tf.cast(pred, tf.float32))

session = tf.Session()
session.run(tf.global_variables_initializer())
for epoch in range(epochs):
    avg_cost=0
    batch = int(mnist.train.num_examples/batchsize)
        
    pbar = tqdm(range(batch))
    for i in pbar:
        batchx,batchy = mnist.train.next_batch(batchsize)
        cv,_ = session.run([cost,train], {x:batchx,y:batchy})
        avg_cost += cv/batch
        pbar.set_description('cost:%f' % avg_cost)
print('accuracy : ', session.run(accuracy, {x:mnist.test.images,y:mnist.test.labels})) 
> accuracy :  0.9784
    
------------------------------------------------------------

## he 활용 weight 초기화 설정
x = tf.placeholder(tf.float32, [None,28*28])
y = tf.placeholder(tf.float32, [None,10])

w1 = tf.get_variable('w1', shape=[784,256], initializer=tf.keras.initializers.he_normal())
b1 = tf.Variable(tf.random_normal([256]))
l1 = tf.nn.relu(tf.matmul(x,w1)+b1) 

w2 = tf.get_variable('w2', shape=[256,256], initializer=tf.keras.initializers.he_normal())
b2 = tf.Variable(tf.random_normal([256]))
l2 = tf.nn.relu(tf.matmul(l1,w2)+b2) 

w3 = tf.get_variable('w3', shape=[256,256], initializer=tf.keras.initializers.he_normal())
b3 = tf.Variable(tf.random_normal([256]))
l3 = tf.nn.relu(tf.matmul(l2,w3)+b3) 

w4 = tf.get_variable('w4', shape=[256,256], initializer=tf.keras.initializers.he_normal())
b4 = tf.Variable(tf.random_normal([256]))
l4 = tf.nn.relu(tf.matmul(l3,w4)+b4) 

w5 = tf.get_variable('w5', shape=[256,10], initializer=tf.keras.initializers.he_normal())
b5 = tf.Variable(tf.random_normal([10]))
hf = tf.matmul(l4,w5)+b5

##  model 학습
cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits_v2(logits=hf, labels=y))
train = tf.train.AdamOptimizer(0.001).minimize(cost)

pred =  tf.equal(tf.argmax(hf,axis=1),tf.argmax(y,axis=1))
accuracy = tf.reduce_mean(tf.cast(pred, tf.float32))

session = tf.Session()
session.run(tf.global_variables_initializer())
for epoch in range(epochs):
    avg_cost=0
    batch = int(mnist.train.num_examples/batchsize)
        
    pbar = tqdm(range(batch))
    for i in pbar:
        batchx,batchy = mnist.train.next_batch(batchsize)
        cv,_ = session.run([cost,train], {x:batchx,y:batchy})
        avg_cost += cv/batch
        pbar.set_description('cost:%f' % avg_cost)
print('accuracy : ', session.run(accuracy, {x:mnist.test.images,y:mnist.test.labels})) 
> accuracy :  0.9804
    
-------------------------------------------------------------

## 시각화
index = []
original = []
pred_list = []
labels = session.run(tf.argmax(mnist.test.labels,1))
preds = session.run(tf.argmax(hf,1), feed_dict={x:mnist.test.images})

for i in range(mnist.test.num_examples):
    if preds[i] != labels[i]:
        index.append(i)
        original.append(labels[i])
        pred_list.append(preds[i])
        
df = pd.DataFrame({'label':original, 'pred': pred_list}, index=index)

plt.figure(figsize=(12,6))
plt.hist(df['pred'], bins=10)
plt.xlabel('fault_pred')
plt.grid()
plt.show()



cnt=0
for n in (df.query('label==4').sample(n=8).index):
    cnt+=1
    plt.subplot(4,4,cnt)
    plt.imshow(mnist.test.images[n].reshape(28,28),cmap='Greys')
    t='label: '+str(df['label'][n])+' pred: '+str(df['pred'][n])
    plt.title(t)
plt.tight_layout()
plt.show()

```



#### MNIST classification_keras

```python
from keras.models import Sequential
from keras.layers import Dense
import numpy as np
np.random.seed(42)
tf.set_random_seed(42)

## data 불러오기 및 전처리
from keras.datasets import mnist
(trainimage,trainlabel),(testimage,testlabel) = mnist.load_data()

trainimage = trainimage.reshape((60000,28*28)).astype('float32')/255
testimage = testimage.reshape((10000,28*28)).astype('float32')/255

from keras.utils import to_categorical
trainlabel = to_categorical(trainlabel)
testlabel = to_categorical(testlabel)

## model 생성
model = Sequential()
model.add(Dense(512,input_shape=(28*28,), activation='relu'))
model.add(Dense(10,activation='softmax'))

## model 환경 설정
model.compile(loss='categorical_crossentropy', optimizer='rmsprop', metrics=['accuracy'])

## model 학습
model.fit(trainimage, trainlabel,epochs=5, batch_size=128)

## model 평가
model1.evaluate(testimage, testlabel)[1]
> 0.9804999828338623


```

#### 영화리뷰 분류_keras

```python
## data 불러오기 및 전처리
from keras.datasets import imdb
(traindata,trainlabel),(testdata,testlabel) = imdb.load_data(num_words=10000)

# {word : index} dict 생성
wordindex = imdb.get_word_index()

# dict reverse
rev_wordindex = dict([(value,key) for (key,value) in wordindex.items()])

# 불필요한 단어 제거
review0 = ' '.join([rev_wordindex.get(i-3, '?') for i in traindata[0]])

# 동일한 길이의 리스트가 되도록 padding & 원핫인코딩
def vec_seq(data, dim=10000):
    res = np.zeros((len(data),dim))
    for  i, s in enumerate(data):
        res[i,s] = 1
    return res
    
xtrain = vec_seq(traindata)
xtest= vec_seq(testdata)
print(xtrain.shape, xtest.shape)
> (25000, 10000) (25000, 10000)

ytrain = trainlabel.astype('float32')
ytest = testlabel.astype('float32')


##  model 만들기
model = Sequential()
model.add(Dense(16,input_shape=(10000,), activation='relu'))
model.add(Dense(16, activation='relu'))
model.add(Dense(1, activation='sigmoid'))

## model 환경 설정
model.compile(loss = 'binary_crossentropy', optimizer = 'adam', metrics=['accuracy'])

# 검증 data 추출
xval = xtrain[:10000]
p_xtrain = xtrain[10000:]

yval = ytrain[:10000]
p_ytrain = ytrain[10000:]

model.fit(p_xtrain, p_ytrain, epochs=20, batch_size=512, validation_data=(xval,yval))

model.evaluate(xtest, ytest)[1]
> 0.8650400042533875

```

