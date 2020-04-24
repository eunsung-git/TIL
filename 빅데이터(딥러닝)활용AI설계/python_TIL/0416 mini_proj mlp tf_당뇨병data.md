## mini_proj_python

### tensorflow linear regression_당뇨병data



```python
import tensorflow as tf
import numpy as np

path = r'C:\\Users\\student\\Desktop\\dataset\\python\\data'
xy =  np.loadtxt(path+'\\data-03-diabetes.csv',delimiter=',')

xdata = xy[:,0:-1]
ydata = xy[:,[-1]]

print(xdata.shape, ydata.shape)
> (759, 8) (759, 1)

x = tf.placeholder(tf.float32,  shape=[None,8])
y = tf.placeholder(tf.float32,  shape=[None,1])
w = tf.Variable(tf.random_normal([8,1]))
b = tf.Variable(tf.random_normal([1]))

hf = tf.sigmoid(tf.matmul(x,w)+b)
cost = -tf.reduce_mean(y*tf.log(hf)+(1-y)*tf.log(1-hf))

train = tf.train.GradientDescentOptimizer(0.01).minimize(cost)

pred = tf.cast(hf>0.5, dtype=tf.float32)
accuracy = tf.reduce_mean(tf.cast(tf.equal(pred, y),dtype=tf.float32))

with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for step in range(10001):
        cv,_ = session.run([cost,train],feed_dict={x:xdata,y:ydata})
        if step%1000==0:
            print(step, cv)
    hv,pv,av = session.run([hf,pred,accuracy], feed_dict={x:xdata,y:ydata})
    print('정확도 : ',av)
> 0 0.8338923
> 1000 0.6937843
> 2000 0.6200365
> 3000 0.5751145
> 4000 0.54692006
> 5000 0.52851325
> 6000 0.5160017
> 7000 0.5071722
> 8000 0.5007305
> 9000 0.4958928
> 10000 0.49216756
> 정확도 :  0.76943344


```

