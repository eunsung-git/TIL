### RNN tensorflow

```python
import tensorflow as tf
import numpy as np

tf.reset_default_graph()

idx2char = ['h','i','e','l','o']

xdata = [[0,1,0,2,2,3,3]]

# [None,sequence_length,input_dim]
xonehot = [[
    [1,0,0,0,0],
    [0,1,0,0,0],
    [1,0,0,0,0],
    [0,0,1,0,0],
    [0,0,0,1,0],
    [0,0,0,1,0],
]]

ydata = [[1,0,2,3,3,4]]

print(np.shape(xdata), np.shape(xonehot), np.shape(ydata))
> (1, 7) (1, 6, 5) (1, 6)


num_classes = 5

# onehot 크기
input_dim = 5

# rnn cell 출력 갯수
hidden_size = 5

# 문장 갯수
batch_size = 1

sequence_length = 6
learning_rate = 0.1

x = tf.placeholder(tf.float32, [None,sequence_length,input_dim])
y = tf.placeholder(tf.int32, [None, sequence_length])

cell = tf.contrib.rnn.BasicLSTMCell(num_units=hidden_size, state_is_tuple=True)
initial_state = cell.zero_state(batch_size, tf.float32)
outputs, _states = tf.nn.dynamic_rnn(cell, x, initial_state=initial_state, dtype=tf.float32)

## 입력 shape = (train단어 갯수, 입력 글자 수, 원핫인코딩크기)
## 출력 shape = (단어갯수, 입력 글자 수, n)
xforfc = tf.reshape(outputs, [-1,hidden_size])
outputs = tf.contrib.layers.fully_connected(inputs=xforfc, num_outputs=num_classes, activation_fn=None)
outputs = tf.reshape(outputs, [batch_size,sequence_length,num_classes])

weights = tf.ones([batch_size,sequence_length])
sequence_loss = tf.contrib.seq2seq.sequence_loss(logits=outputs, targets=y, weights=weights)

cost = tf.reduce_mean(sequence_loss)
train = tf.train.AdamOptimizer(learning_rate).minimize(cost)

pred = tf.argmax(outputs, axis=2)

with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for i in range(100):
        lv, _ = session.run([cost, train], feed_dict={x:xonehot, y:ydata})
        res = session.run([pred], feed_dict={x:xonehot})
        print(i, 'cost : ', lv, 'pred : ', res, 'y: ', ydata)
        
        s = [idx2char[c] for c in np.squeeze(res)]
        print('\nprediction str : ',''.join(s))
> 0 cost :  1.5929407 pred :  [array([[3, 3, 3, 3, 3, 3]], dtype=int64)] y:  [[1, 0, 2, 3, 3, 4]]

prediction str :  llllll
> 1 cost :  1.4803996 pred :  [array([[3, 3, 3, 3, 3, 3]], dtype=int64)] y:  [[1, 0, 2, 3, 3, 4]]

prediction str :  llllll
> 2 cost :  1.367546 pred :  [array([[3, 3, 3, 3, 3, 3]], dtype=int64)] y:  [[1, 0, 2, 3, 3, 4]]

prediction str :  llllll
    ...
> 98 cost :  0.0010950867 pred :  [array([[1, 0, 2, 3, 3, 4]], dtype=int64)] y:  [[1, 0, 2, 3, 3, 4]]

prediction str :  ihello
> 99 cost :  0.0010848677 pred :  [array([[1, 0, 2, 3, 3, 4]], dtype=int64)] y:  [[1, 0, 2, 3, 3, 4]]

prediction str :  ihello
    
-----------------------------------------------------

tf.reset_default_graph()

hidden_size = 2
cell = tf.contrib.rnn.BasicLSTMCell(num_units=hidden_size)

xdata = np.array([[[1,0,0,0]]], dtype=np.float32)

outputs, _states = tf.nn.dynamic_rnn(cell, xdata, dtype=tf.float32)

with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    print(outputs.eval())
> [[[-0.06736547  0.01449173]]]


```



#####  numpy 차원 확대&축소

```python
import numpy as np

x = np.array([1,2])
y = np.expand_dims(x, axis=0)
print(y.shape)
> (1, 2)
print(y)
> [[1 2]]

z = np.expand_dims(x, axis=1)
print(z.shape)
> (2, 1)
print(z)
> [[1]
   [2]]

s = np.array([[[0],[1],[2]]])
print(s.shape)
> (1, 3, 1)
print(np.squeeze(s))
> [0 1 2]

```

