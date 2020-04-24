## mini_proj_python

### tensorflow_자동차data예측

#### 경사하강모델 만들기

```python
# data 불러오기
import pandas as pd

path = r'C:\\Users\\student\\Desktop\\dataset\\python\\carsdata'
cardata = pd.read_csv(path+'\\cars.csv')

cardata = cardata.iloc[:,[1,3]]

# train/test data 나누기
x_cylinders = list(cardata.iloc[:,0])
y_hp = list(cardata.iloc[:,1])

# tensorflow 활용 선형 모델 변수 설정
import tensorflow as tf

w = tf.Variable(tf.random_normal([1]))
b = tf.Variable(tf.random_normal([1]))
hf = x_cylinders*w+b

session = tf.Session()
session.run(tf.global_variables_initializer())

cost = tf.reduce_mean(tf.square(hf-y_hp))

## 경사하강모델 생성
opt = tf.train.GradientDescentOptimizer(0.001)
train = opt.minimize(cost)

# cost 찾기
for step in range(100001):
    session.run(train)
    if step%10000==0:
        print(step,session.run(cost),session.run(w),session.run(b))
> 0 12731.397 [0.07588387] [0.5491068]
> 10000 467.01245 [19.52112] [-2.645878]
> 20000 466.85068 [19.706339] [-3.777532]
> 30000 466.84528 [19.740103] [-3.9838383]
> 40000 466.84512 [19.746172] [-4.0210075]
> 50000 466.8451 [19.747238] [-4.0275464]
> 60000 466.8451 [19.747238] [-4.0275464]
> 70000 466.8451 [19.747238] [-4.0275464]
> 80000 466.8451 [19.747238] [-4.0275464]
> 90000 466.8451 [19.747238] [-4.0275464]
> 100000 466.8451 [19.747238] [-4.0275464]

# cylinder==7일때, hp 예상값 구하기
yhat = session.run(w)[0]*7+session.run(b)[0]
print('예상값 :',yhat)
> 예상값 : 134.20312070846558


```

