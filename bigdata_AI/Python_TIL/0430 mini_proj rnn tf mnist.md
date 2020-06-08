## mini_proj_python

### RNN tensorflow mnist

```python
### data 불러오기
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets('MNIST_data/', one_hot=True)

### 변수 설정
lr = 0.01
total_epoch = 30
batch_size = 128

# 한 번에 입력받는 데이터 갯수
n_input = 28
# 한 이미지당 28번 step
n_step = 28
# cell 출력 갯수
n_hidden = 128
# 숫자 종류 (0~9)
n_class = 10

x = tf.placeholder(tf.float32, [None,n_step,n_input])
y = tf.placeholder(tf.float32, [None,n_class])
w = tf.Variable(tf.random_normal([n_hidden, n_class]))
b = tf.Variable(tf.random_normal([n_class]))

### rnn training cell 설정
cell = tf.nn.rnn_cell.BasicLSTMCell(num_units=n_hidden)

### rnn 신경망 설정
## outputs :  [batch_size, n_step, n_hidden]
outputs, _states = tf.nn.dynamic_rnn(cell, x, dtype=tf.float32)

## outputs shape 변경
# [batch_size, n_step, n_hidden] => [batch_size, n_class]
# step 1) [batch_size, n_step, n_hidden] => [n_step, batch_size, n_hidden]
outputs = tf.transpose(outputs, [1,0,2])
# step 2) [n_step, batch_size, n_hidden] => [batch_size, n_class]
outputs = outputs[-1]

model = tf.matmul(outputs, w)+b
cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits_v2(logits=model, labels=y))
train = tf.train.AdamOptimizer(lr).minimize(cost)

session=tf.Session()
session.run(tf.global_variables_initializer())

total_batch = int(mnist.train.num_examples/batch_size)

### model training
for epoch in range(total_epoch):
    total_cost = 0
    for i in range(total_batch):
        batchx, batchy = mnist.train.next_batch(batch_size)
        # x 형태로 reshape (128,784) => (128,28,28)
        batchx = batchx.reshape((batch_size,n_step,n_input))
        
        _, cv = session.run([train, cost], feed_dict={x:batchx, y:batchy})
        total_cost += cv
    print('epoch : ', '%4d' % (epoch+1), 'cost : ', '{:.3f}'.format(total_cost/total_batch))
> epoch :     1 cost :  0.338
> epoch :     2 cost :  0.087
> epoch :     3 cost :  0.063
> epoch :     4 cost :  0.054
> epoch :     5 cost :  0.044
...
> epoch :    28 cost :  0.022
> epoch :    29 cost :  0.020
> epoch :    30 cost :  0.031
        
### model 평가
iscorrect = tf.equal(tf.argmax(model, axis=1), tf.argmax(y, axis=1))
accuracy = tf.reduce_mean(tf.cast(iscorrect, tf.float32))

testsize = len(mnist.test.images)
xtest = mnist.test.images.reshape(testsize,n_step,n_input)
ytest = mnist.test.labels

print(session.run(accuracy, feed_dict={x:xtest, y:ytest}))
> 0.983

```

