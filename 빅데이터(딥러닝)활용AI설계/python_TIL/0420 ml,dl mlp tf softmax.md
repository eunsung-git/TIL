###  softmax()



```python
import numpy as np

x = [2,4,6,8]
y =  [81,93,91,97]

mx = np.mean(x)
my = np.mean(y)

# 기울기 / y절편
divisor=sum([(mx-i)**2 for i in x])

def top(x,mx,y,my):
    d=0
    for i in range(len(x)):
        d+=(x[i]-mx)*(y[i]-my)
    return d
dividend=top(x, mx,y ,my)

print('분모 : ', divisor)
> 분모 : 20.0
print('분자 : ', dividend)
> 분자 : 46.0
  
w = dividend/divisor
> 2.3

b=my-(mx*w)
> 79.0

```



##### 다중선형회귀 softmax 모델

```python
import tensorflow as tf

w1 = tf.Variable(tf.random_normal([1],0,10,dtype=tf.float32, seed=0))
w2 = tf.Variable(tf.random_normal([1],0,10,dtype=tf.float32, seed=0))
b = tf.Variable(tf.random_normal([1],0,100,dtype=tf.float32, seed=0))

hf = w1*x1+w2*x2+b
rmse = tf.sqrt(tf.reduce_mean(tf.square(hf-y)))
lr=0.1

train = tf.train.GradientDescentOptimizer(lr).minimize(rmse)

with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for step in range(5001):
        session.run(train)
        if step%500==0:
            print('rmse =  %.4f, w1 = %.4f, w2 = %.4f, y절편 = %.4f' % (session.run(rmse),session.run(w1),session.run(w2),session.run(b))
> ......
> rmse =  1.8370, w1 = 1.7713, w2 = 2.4087, y절편 = 77.8928
> rmse =  1.8369, w1 = 1.7699, w2 = 2.4082, y절편 = 77.9022
> rmse =  1.8369, w1 = 1.7699, w2 = 2.4082, y절편 = 77.9022
> rmse =  1.8369, w1 = 1.7699, w2 = 2.4082, y절편 = 77.9022
                  
```



##### multi-label classification 모델

```python
import tensorflow as tf

xdata = [[1, 2, 1, 1],
          [2, 1, 3, 2],
          [3, 1, 3, 4],
          [4, 1, 5, 5],
          [1, 7, 5, 5],
          [1, 2, 5, 6],
          [1, 6, 6, 6],
          [1, 7, 7, 7]]
ydata = [[0, 0, 1],
          [0, 0, 1],
          [0, 0, 1],
          [0, 1, 0],
          [0, 1, 0],
          [0, 1, 0],
          [1, 0, 0],
          [1, 0, 0]]

x=tf.placeholder("float", [None, 4])
y=tf.placeholder("float", [None, 3])

nb_classes=3

w=tf.Variable(tf.random_normal([4,nb_classes]))
b=tf.Variable(tf.random_normal([nb_classes]))

hf=tf.nn.softmax(tf.matmul(x,w)+b)

cost =  tf.reduce_mean(-tf.reduce_sum(y*tf.log(hf),axis=1))
train=tf.train.GradientDescentOptimizer(0.1).minimize(cost)

with  tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for step in range(2001):
        _,cv = session.run([train,cost],feed_dict={x:xdata,y:ydata})
        if step%200==0:
            print(step, cv)
> 0 8.804543
> 200 0.5869044
> 400 0.48635316
> 600 0.4106661
> 800 0.34325993
> 1000 0.27526036
> 1200 0.22037323
> 1400 0.20071372
> 1600 0.18424241
> 1800 0.17022079
> 2000 0.15814176


with  tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for step in range(2001):
        res = session.run(hf, feed_dict={x:[[1,11,7,9]]})
        if step%200==0:
            print('분류결과 : '+str(session.run(tf.argmax(res,1))[0]))
> 분류결과 : 1
 
```

