



```python
import tensorflow as tf

## graph build
# tf.placeholder() : 프로그램 실행 중 값을 변경할 수 있는 변수 정의
#  let x 'float'
a = tf.placeholder('float')
b = tf.placeholder('float')
y = tf.multiply(a,b)

## graph 실행
# tf.Session() :  graph 실행을 위해 필요
session = tf.Session()
# tf.Session.run() : 노드 실행
session.run(y,feed_dict={a:3,b:2})
> 6.0

---------------------------------------------------------

## tensor shape
3 - rank 0 tensor, shape []
[1,2,3] - rank 1 tensor, shape [3]
[[1,2,3],[1,2,3]] == rank 2 tensor, shape [2,1]
[[[1,2,3]],[[4,5,6]]] - rank 3 tensor, shape [2,1,3]

--------------------------------------------------------

a = tf.constant(10)
b = tf.constant(20)
session = tf.Session()
session.run(tf.add(a,b))
> 30

c = tf.add(a,b)
session.run(c)
> 30

session.run(a)
> 10

session.run([a,b])
> [10,20]


a = tf.placeholder(tf.float32)
b = tf.placeholder(tf.float32)
addnode = a+b
session = tf.Session()
session.run(addnode,feed_dict={a:[5,1],b:[3,2]})
> array([8., 3.], dtype=float32)

session.run(addnode,feed_dict={a:[5,1],b:[3,2]})[0]
> 8.0


a = tf.placeholder(tf.float32)
b = tf.placeholder(tf.float32)
triple = (a+b)*b
session = tf.Session()
session.run(triple,feed_dict={a:2,b:3})
> 15.0


x = tf.placeholder(tf.float32,[None,3])
xdata = [[1,2,3],[4,5,6]]
session.run(x,feed_dict={x:xdata})
> [[1., 2., 3.]
   [4., 5., 6.]]


xdata = [[1,2,3],
         [4,5,6]]
x = tf.placeholder(tf.float32,[None,3])
w = tf.Variable(tf.random_normal([3,1]))
b = tf.Variable(tf.random_normal([1]))
hf = tf.matmul(x,w)+b

session.run(tf.global_variables_initializer())
session.run(hf,feed_dict={x:xdata})
> [[-3.869957 ],
   [-7.8708415]]

--------------------------------------------------------

### 선형회귀모델
xtrain = [80,95,97]
ytrain = [82,90,98]
w = tf.Variable(tf.random_normal([1]))
b = tf.Variable(tf.random_normal([1]))
hf = xtrain*w+b

session = tf.Session()
session.run(tf.global_variables_initializer())

cost = tf.reduce_mean(tf.square(hf-ytrain))

## 경사하강
opt = tf.train.GradientDescentOptimizer(0.0001)
train = opt.minimize(cost)

for step in range(2001):
    session.run(train)
    if step%100==0:
        print(step,session.run(cost),session.run(w),session.run(b))
> 0 9.011396 [0.9757739] [1.4104224]
> 100 9.010833 [0.9757478] [1.4128066]
> 200 9.010259 [0.97572166] [1.4151908]
> 300 9.009705 [0.9756956] [1.417575]
> 400 9.00912 [0.97566944] [1.4199592]
> 500 9.008547 [0.9756434] [1.4223434]
> 600 9.007981 [0.9756172] [1.4247276]
> 700 9.007419 [0.97559106] [1.4271117]
> 800 9.006832 [0.975565] [1.4294959]
> 900 9.006292 [0.97553885] [1.4318801]
> 1000 9.005729 [0.97551274] [1.4342643]
> 1100 9.005144 [0.9754867] [1.4366485]
> 1200 9.004559 [0.9754605] [1.4390327]
> 1300 9.004005 [0.9754345] [1.4414169]
> 1400 9.003446 [0.9754082] [1.443801]
> 1500 9.00286 [0.97538215] [1.4461852]
> 1600 9.002307 [0.975356] [1.4485694]
> 1700 9.001722 [0.97532994] [1.4509536]
> 1800 9.001151 [0.97530377] [1.4533378]
> 1900 9.0006075 [0.97527784] [1.455722]
> 2000 9.000014 [0.97525156] [1.4581062]

yhat = session.run(w)[0]*50+session.run(b)[0]
print('예상값 :',yhat)
> 예상값 : 50.22068393230438

```

