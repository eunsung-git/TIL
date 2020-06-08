

#### MNIST 분류_tensorflow

```python
import tensorflow as tf
import matplotlib.pyplot as plt
import random
tf.set_random_seed(777)
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets('MNIST_data/', one_hot=True)

x = tf.placeholder(tf.float32, [None,784])
y = tf.placeholder(tf.float32, [None,10])
w = tf.Variable(tf.random_normal([784,10]))
b = tf.Variable(tf.random_normal([10]))

hf = tf.nn.softmax(tf.matmul(x,w)+b)
cost = tf.reduce_mean(-tf.reduce_sum(y*tf.log(hf), axis=1))
train = tf.train.GradientDescentOptimizer(0.1).minimize(cost)

accuracy = tf.reduce_mean(tf.cast(tf.equal(tf.argmax(hf,axis=1), tf.argmax(y,axis=1)), tf.float32))
epochs = 15
batchsize = 100
liter = int(mnist.train.num_examples/batchsize)

with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for epoch in range(epochs):
        avg_cv = 0
        for i in range(liter):
            xdata, ydata = mnist.train.next_batch(batchsize)
            _,cv = session.run([train,cost],feed_dict={x:xdata,y:ydata})
            avg_cv += cv/liter
        print('epoch : {:04d}, cost : {:.9f}'.format(epoch+1,avg_cv))
    print('정확도 : ', accuracy.eval(session=session, feed_dict={x:mnist.test.images,y:mnist.test.labels}))
    randomnum = random.randint(0,mnist.test.num_examples-1)
    print('label : ', session.run(tf.argmax(mnist.test.labels[randomnum:randomnum+1],1)))
    print('pred  : ',session.run(tf.argmax(hf,1), feed_dict={x:mnist.test.images[randomnum:randomnum+1]}))
    
plt.imshow(mnist.test.images[randomnum:randomnum+1].reshape(28,28), cmap='Greys')
plt.show()
> epoch : 0001, cost : 2.680337871
> epoch : 0002, cost : 1.115407937
> epoch : 0003, cost : 0.889779988
> epoch : 0004, cost : 0.776934914
> epoch : 0005, cost : 0.706603727
> epoch : 0006, cost : 0.656221640
> epoch : 0007, cost : 0.618211451
> epoch : 0008, cost : 0.588414714
> epoch : 0009, cost : 0.563992278
> epoch : 0010, cost : 0.543115929
> epoch : 0011, cost : 0.525853374
> epoch : 0012, cost : 0.510185846
> epoch : 0013, cost : 0.496858924
> epoch : 0014, cost : 0.484849581
> epoch : 0015, cost : 0.473984458
> 정확도 :  0.8906
> label :  [4]
> pred  :  [4]

```



#### MNIST 분류_keras

```python
from keras.utils import np_utils
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Activation
import numpy as np

(xtrain,ytrain),(xtest,ytest) = mnist.load_data()

# 전처리 
xtrain = xtrain.reshape(60000,784).astype('float32')/255.0
xtest = xtest.reshape(10000,784).astype('float32')/255.0

# 원핫인코딩
ytrain = np_utils.to_categorical(ytrain)
ytest = np_utils.to_categorical(ytest)

# model 설정
model = Sequential()
model.add(Dense(units=64, input_dim=28*28, activation='relu'))
model.add(Dense(units=10, activation='softmax'))

# 학습 환경 설정
model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['accuracy'])

# 학습
model.fit(xtrain, ytrain, epochs=5, batch_size=50, validation_data=(xval,yval))

# model 평가
metrics=model.evaluate(xtest, ytest, batch_size=50)
print('evaluation : '+str(metrics))
> evaluation : [2.191178497672081, 0.25450000166893005]
    
# 예측
idx = np.random.choice(xtest.shape[0],5)
xhat = xtest[idx]
yhat = model.predict_classes(xhat)

for i in range(5):
    print('예측값 : '+ str(yhat[i]) + '실제값 : ' +str(np.argmax(ytest[idx[i]])))
> 예측값 : 0 실제값 : 0
> 예측값 : 2 실제값 : 2
> 예측값 : 0 실제값 : 0
> 예측값 : 1 실제값 : 1
> 예측값 : 7 실제값 : 7
        
# model 저장
model.save('mnist_model.h5')

# model 불러오기
from keras.models import load_model
model = load_model('mnist_model.h5')
yhat = model.predict_classes(xhat)

for i in range(10):
    print('예측값 : '+ str(yhat[i]) + '실제값 : '+str(np.argmax(ytest[idx[i]])))
> 예측값 : 6 실제값 : 3
> 예측값 : 6 실제값 : 9
> 예측값 : 6 실제값 : 2
> 예측값 : 6 실제값 : 6
> 예측값 : 8 실제값 : 3
> 예측값 : 9 실제값 : 9
> 예측값 : 6 실제값 : 6
> 예측값 : 1 실제값 : 1
> 예측값 : 2 실제값 : 2
> 예측값 : 2 실제값 : 4

```



-------------------------------------------------------------------------------------------

#### XOR_tensorflow

```python
xdata = np.array([[0,0],
                  [0,1],
                  [1,0],
                  [1,1]])
ydata = np.array([[0],
                  [1],
                  [1],
                  [0]])

x = tf.placeholder(tf.float32, shape=[None,2])
y = tf.placeholder(tf.float32, shape=[None,1])

w1= tf.Variable(tf.random_normal([2,10]))
b1 = tf.Variable(tf.random_normal([10]))
layer1 = tf.sigmoid(tf.matmul(x,w1)+b1)

w2= tf.Variable(tf.random_normal([10,10]))
b2 = tf.Variable(tf.random_normal([10]))
layer2 = tf.sigmoid(tf.matmul(layer1,w2)+b2)

w3= tf.Variable(tf.random_normal([10,10]))
b3 = tf.Variable(tf.random_normal([10]))
layer4 = tf.sigmoid(tf.matmul(layer2,w3)+b3)

w4= tf.Variable(tf.random_normal([10,1]))
b4 = tf.Variable(tf.random_normal([1]))
hf = tf.sigmoid(tf.matmul(layer4,w4)+b1)

cost = -tf.reduce_mean(y*tf.log(hf)+(1-y)*tf.log(1-hf))
train = tf.train.GradientDescentOptimizer(0.1).minimize(cost)

pred = tf.cast(hf > 0.5, dtype=tf.float32)
accuracy = tf.reduce_mean(tf.cast(tf.equal(pred, y), dtype=tf.float32))

with tf.Session() as session:
    session.run(tf.global_variables_initializer())

    for step in range(10001):
        _, cv = session.run([train,cost], feed_dict={x:xdata, y:ydata})
#         if step % 1000 == 0:
#             print(step, cv)

    hv, pv, av = session.run([hf,pred,accuracy], feed_dict={x:xdata, y:ydata})
    print("\nHypothesis : ", hv, "\nPredicted : ", pv, "\nAccuracy : ", av)
> Hypothesis :  [[5.7107210e-04 1.1042356e-03 8.0111623e-04 1.3730824e-03 4.5457482e-04
  7.5134635e-04 5.5369735e-04 1.3462603e-03 1.4874339e-03 8.9237094e-04]
 [9.9808878e-01 9.9901116e-01 9.9863708e-01 9.9920487e-01 9.9759960e-01
  9.9854684e-01 9.9802887e-01 9.9918890e-01 9.9926597e-01 9.9877644e-01]
 [9.9791783e-01 9.9892271e-01 9.9851513e-01 9.9913359e-01 9.9738497e-01
  9.9841690e-01 9.9785256e-01 9.9911630e-01 9.9920022e-01 9.9866688e-01]
 [1.3376474e-03 2.5847256e-03 1.8757880e-03 3.2125115e-03 1.0648370e-03
  1.7594695e-03 1.2969971e-03 3.1500161e-03 3.4796596e-03 2.0892918e-03]] 
> Predicted :  [[0. 0. 0. 0. 0. 0. 0. 0. 0. 0.]
 [1. 1. 1. 1. 1. 1. 1. 1. 1. 1.]
 [1. 1. 1. 1. 1. 1. 1. 1. 1. 1.]
 [0. 0. 0. 0. 0. 0. 0. 0. 0. 0.]] 
> Accuracy :  1.0
    
```



