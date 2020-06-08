### multi-variable linear regression



#### 1 variable

```python
## ex)1
import tensorflow as tf
tf.set_random_seed(777)
import numpy as np
import pandas as pd

# 변수 정의
w = tf.Variable(tf.random_normal([1]), name='weight')
b = tf.Variable(tf.random_normal([1]), name='bias')
x = tf.placeholder(tf.float32, shape=[None])
y = tf.placeholder(tf.float32, shape=[None])

# model 생성
hf = x*w+b
cost = tf.reduce_mean(tf.square(hf-y))
train = tf.train.GradientDescentOptimizer(learning_rate=0.01).minimize(cost)

# variable 초기화
session = tf.Session()
session.run(tf.global_variables_initializer())

# 예측값 구하기
for step in range(2001):
    _,cv,bv,wv = session.run([train,cost,b,w], feed_dict={x:[1,2,3],y:[2,3,4]})
    if step % 100==0:
        print(step, cv, bv, wv)
> 0 1.3302349 [-0.83235663] [2.168677]
> 100 0.34429216 [-0.5454619] [1.679854]
> 200 0.21275164 [-0.2148748] [1.5344255] .....
> 2000 3.6718488e-05 [0.98404] [1.0070208]
        
print(session.run(hf,feed_dict={x:[10]}))
> [11.054249]

print(session.run(hf,feed_dict={x:[10,10.5]}))
> [11.054249 11.557759]

print(session.run(hf,feed_dict={x:[10,10.5,20]}))
> [11.054249 11.557759 21.124456]

------------------------------------------------------

## ex)2
import tensorflow as tf
tf.set_random_seed(777)
import numpy as np
import pandas as pd

w = tf.Variable([100.], tf.float32)
b = tf.Variable([-10.], tf.float32)
x = tf.placeholder(tf.float32)
y = tf.placeholder(tf.float32)

hf = x*w+b
cost = tf.reduce_sum(tf.square(hf-y))

train = tf.train.GradientDescentOptimizer(0.01).minimize(cost)

xtrain = [1,2,3,4,5]
ytrain = [0,-1,-2,-3,-4]

session = tf.Session()
session.run(tf.global_variables_initializer())

for i in range(1000):
    session.run(train,{x:xtrain,y:ytrain})
    wv,bv,cv = session.run([w,b,cost],{x:xtrain,y:ytrain})
	print('weight :%s bias :%s cost : %s' %(wv,bv,cv))
> weight :[-0.9999995] bias :[0.99999833] cost : 2.5579538e-12
   
--------------------------------------------------------

##  ex)3
import tensorflow as tf
tf.set_random_seed(777)
import numpy as np
import pandas as pd

x = [1,3,5]
y = [10, 28, 40]
w = tf.placeholder(tf.float64)

hf = x*w
loss =  tf.reduce_mean(tf.square(hf-y))

w_history = []
cost_history = []

for i in range (-30,50):
    currw=i*0.1
    loss_value = session.run(loss, feed_dict={w:currw})
    w_history.append(currw)
    core_history.append(loss_value)
    
import matplotlib.pyplot as plt
plt.plot(w_history,core_history)
plt.show

-------------------------------------------------------

## +upgrade
import tensorflow as tf
tf.set_random_seed(777)
import numpy as np
import pandas as pd

xdata = [1,2,3]
ydata = [1,2,3]
w = tf.Variable(tf.random_normal([1]))
x = tf.placeholder(tf.float32)
y = tf.placeholder(tf.float32)

hf = x*w
lr = 0.1
cost = tf.reduce_mean(tf.square(hf-y))
gradient = tf.reduce_mean(((w*x-y)*x))
descent = w-lr*gradient
update = w.assign(descent)

session = tf.Session()
session.run(tf.global_variables_initializer())
for step in range(21):
    print(step, session.run(update, feed_dict={x:xdata,y:ydata}),session.run(w)) 
> 0 [0.0824157] [0.0824157]
> 1 [0.5106217] [0.5106217]
> 2 [0.7389983] [0.7389983] ...
> 20 [0.99999684] [0.99999684]


```



#### multi variable

```python
import tensorflow as tf
tf.set_random_seed(777)
import numpy as np
import pandas as pd

x1data = [73,93,90,95,72]
x2data = [80,88,92,98,66]
x3data = [75,92,90,100,70]
ydata = [152,185,180,195,140]

x1 = tf.placeholder(tf.float32)
x2 = tf.placeholder(tf.float32)
x3 = tf.placeholder(tf.float32)
y = tf.placeholder(tf.float32)

w1 = tf.Variable(tf.random_normal([1]))
w2 = tf.Variable(tf.random_normal([1]))
w3 = tf.Variable(tf.random_normal([1]))
b = tf.Variable(tf.random_normal([1]))

hf = (w1*x1) + (w2*x2) + (w3*x3) +b
cost = tf.reduce_mean(tf.square(hf-y))

train = tf.train.GradientDescentOptimizer(1e-5).minimize(cost)

session = tf.Session()
session.run(tf.global_variables_initializer())

for step in range(2001):
    cv,hfv,_ = session.run([cost,hf,train],feed_dict={x1:x1data,x2:x2data,x3:x3data,y:ydata})
    if step%100==0:
        print(step, 'cost : '.cv, '\npred : ',hfv)
> 0 cost :  6.1499033 
pred :  [147.35031 185.87961 179.82005 196.06105 142.6829 ]
> 100 cost :  5.93 
pred :  [147.42566 185.82414 179.84383 196.07703 142.6195 ]
> 200 cost :  5.720698 
pred :  [147.49918 185.77005 179.86708 196.0925  142.55771] .....
> 2000 cost :  3.2808762 
pred :  [148.55586 184.99844 180.20802 196.29689 141.67842]
    
--------------------------------------------------------

### matrix-mul

## ex)1
import tensorflow as tf
tf.set_random_seed(777)
import numpy as np
import pandas as pd

xdata = [[73,93,90,95,72],
        [80,88,92,98,66],
        [75,92,90,100,70]]
ydata = [[152],[185],[180],[195],[140]]

xdata = np.array(xdata).T

# shape 결정
# hf = (5,3)*(3,1)+1
x = tf.placeholder(tf.float32,shape=[None,3])
y = tf.placeholder(tf.float32,shape=[None,1])
w = tf.Variable(tf.random_normal([3,1]))
b = tf.Variable(tf.random_normal([1]))

hf = tf.matmul(x,w)+b

cost = tf.reduce_mean(tf.square(hf-y))
train = tf.train.GradientDescentOptimizer(1e-5).minimize(cost)

session = tf.Session()
session.run(tf.global_variables_initializer())

for step in range(2001):
    cv,hfv,_ = session.run([cost,hf,train],feed_dict={x:xdata,y:ydata})
    if step%10==0:
        print(cv,hfv)
> 136525.45 [[-177.20445]
 			[-209.63411]
 			[-210.40378]
 			[-224.71936]
 			[-159.89354]]
> 1.8939139 [[150.89435]
 			[183.24127]
 			[181.01419]
 			[196.95312]
 			[139.4426 ]] .....
> 1.6993535 [[150.68968]
 			[183.42894]
 			[180.99254]
 			[196.79425]
 			[139.67268]]



## ex)2
import tensorflow as tf
tf.set_random_seed(777)
import numpy as np
import pandas as pd

path = r'C:\\Users\\student\\Desktop'

data = pd.read_csv(path+'\\data-01-test-score.csv', header=None)

xdata = data.iloc[:,:3]
xdata.shape
> (25,3)

ydata = data.iloc[:,3]
ydata.shape
> (25,)

# shape 결정
# hf = (25,3)*(3,1)+1
x = tf.placeholder(tf.float32,shape=[None,3])
y = tf.placeholder(tf.float32,shape=[None,1])
w = tf.Variable(tf.random_normal([3,1]))
b = tf.Variable(tf.random_normal([1]))

hf = tf.matmul(x,w)+b

cost = tf.reduce_mean(tf.square(hf-y))
train = tf.train.GradientDescentOptimizer(1e-5).minimize(cost)

session = tf.Session()
session.run(tf.global_variables_initializer())

for step in range(2001):
    cv,hfv,_ = session.run([cost,hf,train],feed_dict={x:xdata,y:ydata})
    if step%100==0:
        print(cv,hfv)

```



#### logistic regression

```python
xdata = [[1,2],
        [2,3],
        [3,1],
        [4,3],
        [5,3],
        [6,2]]
ydata = [[0],
        [0],
        [0],
        [1],
        [1],
        [1]]

x = tf.placeholder(tf.float32, shape=[None,2])
y = tf.placeholder(tf.float32, shape=[None,1])
w = tf.Variable(tf.random_normal([2,1]))
b = tf.Variable(tf.random_normal([1]))

hf = tf.sigmoid(tf.matmul(x,w)+b)
cost = -tf.reduce_mean(y*tf.log(hf)+(1-y)*tf.log(1-hf))
train = tf.train.GradientDescentOptimizer(0.01).minimize(cost)

# 임계치 0.5 기준, 1.0 or 0.0
pred = tf.cast(hf>0.5, dtype=tf.float32)
accuracy = tf.reduce_mean(tf.cast(tf.equal(pred, y),dtype=tf.float32))

with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for step in range(20001):
        _,cv = session.run([train, cost], feed_dict={x:xdata, y:ydata})
        if step%4000==0:
            print(step, cv)
    hv,pv,av = session.run([hf,pred,accuracy], feed_dict={x:xdata,y:ydata})
    print('예측값 : ',hv, '\n예측분류 : ', pv, '\n정확도 : ',av)
> 0 0.62309486
> 4000 0.2605465
> 8000 0.1717112
> 12000 0.12764817
> 16000 0.101727284
> 20000 0.084693916
> 예측값 :  [[0.00897123]
 			[0.11037017]
 			[0.17158212]
 			[0.85132694]
 			[0.97493875]
 			[0.9924251 ]] 
> 예측분류 :  [[0.]
 			 [0.]
 			 [0.]
 			 [1.]
 			 [1.]
 			 [1.]] 
> 정확도 :  1.0


```



