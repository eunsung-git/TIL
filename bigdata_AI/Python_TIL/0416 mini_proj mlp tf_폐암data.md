## mini_proj_python

### tensorflow linear regression _ 폐암data



#### 1) 원본 data regression

```python
import tensorflow as tf
tf.set_random_seed(777)
import pandas as pd

path = r'C:\\Users\\student\\Desktop\\dataset\\python\\data'

data = pd.read_csv(path+'\\ThoraricSurgery.csv',header=None)

xdata = data.iloc[:,:17] 
ydata = data.iloc[:,[17]]

from sklearn.preprocessing import StandardScaler
xdata = StandardScaler().fit_transform(xdata)

print(xdata.shape, ydata.shape)
> (470, 17) (470, 1)

# hf = (470,17)*(17,1)+1
x = tf.placeholder(tf.float32, shape=[None,17])
y = tf.placeholder(tf.float32, shape=[None,1])
w = tf.Variable(tf.random_normal([17,1]))
b = tf.Variable(tf.random_normal([1]))

hf = tf.matmul(x,w)+b
cost = -tf.reduce_mean(y*tf.log(hf)+(1-y)*tf.log(1-hf))
train = tf.train.GradientDescentOptimizer(0.01).minimize(cost)

# 임계치 0.7 기준, 1.0 or 0.0
pred = tf.cast(hf>0.7, dtype=tf.float32)
accuracy = tf.reduce_mean(tf.cast(tf.equal(pred, y), dtype=tf.float32))


with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for step in range(20001):
        _,cv = session.run([train,cost],feed_dict={x:xdata, y:ydata})
        
    hv,pv,av = session.run([hf,pred,accuracy],feed_dict={x:xdata,y:ydata})
    print('정확도 : ',av)
> 정확도 :  0.84893614


```



#####  2) train_test_split후 regression

```python
import tensorflow as tf
tf.set_random_seed(777)
import pandas as pd

path = r'C:\\Users\\student\\Desktop\\dataset\\python\\data'

data = pd.read_csv(path+'\\ThoraricSurgery.csv',header=None)

xdata = data.iloc[:,:17] 
ydata = data.iloc[:,[17]]

from sklearn.preprocessing import StandardScaler
xdata = StandardScaler().fit_transform(xdata)

from sklearn.model_selection import *
x_train, x_test, y_train,y_test = train_test_split(xdata,ydata,test_size=0.3, random_state=42)

print(x_train.shape, y_train.shape)
> (329, 17) (329, 1)

# hf = (329,17)*(17,1)+1
x = tf.placeholder(tf.float32, shape=[None,17])
y = tf.placeholder(tf.float32, shape=[None,1])
w = tf.Variable(tf.random_normal([17,1]))
b = tf.Variable(tf.random_normal([1]))

hf = tf.sigmoid(tf.matmul(x,w)+b)
cost = -tf.reduce_mean(y*tf.log(hf)+(1-y)*tf.log(1-hf))
train = tf.train.GradientDescentOptimizer(0.01).minimize(cost)

# 임계치 0.7 기준, 1.0 or 0.0
pred = tf.cast(hf>0.7, dtype=tf.float32)
accuracy = tf.reduce_mean(tf.cast(tf.equal(pred, y), dtype=tf.float32))

with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for step in range(20001):
        _,cv = session.run([train,cost],feed_dict={x:x_train, y:y_train})
    hv,pv,av = session.run([hf,pred,accuracy],feed_dict={x:x_test,y:y_test})
    print('정확도 : ',av)
> 정확도 :  0.822695
    

```

