#### 주가예측 tensorflow

```python
import tensorflow as tf
import numpy as np
import pandas as pd

xy = np.loadtxt('C:\\Users\\student\\Desktop\\dataset\\python\\data\\data-02-stock_daily.csv', delimiter=',')

xy = xy[::-1]

seq_len  = 7
data_dim = 5
hidden_dim = 10
output_dim = 1
lr = 0.01
iterations = 500

trainsize = int(len(xy)*0.7)
train = xy[:trainsize]
test = xy[trainsize-seq_len:]

def MinMaxScaler(data):
    denom = np.max(data, axis=0)-np.min(data, axis=0)
    nume = data-np.min(data, axis=0)
    return nume/denom

train = MinMaxScaler(train)
test = MinMaxScaler(test)

def builddata(timeseries, seq_len):
    xdata = []
    ydata = []
    for i in range(0, len(timeseries)-seq_len):
        tx = timeseries[i:i+seq_len,:]
        ty = timeseries[i+seq_len,[-1]]
        xdata.append(tx)
        ydata.append(ty)
    return np.array(xdata), np.array(ydata)

trainx, trainy = builddata(train, seq_len)
testx, testy = builddata(test, seq_len)


x = tf.placeholder(tf.float32, [None, seq_len, data_dim])
y = tf.placeholder(tf.float32, [None, 1])

cell = tf.contrib.rnn.BasicLSTMCell(num_units=hidden_dim, state_is_tuple=True, activation=tf.tanh)

outputs, _states = tf.nn.dynamic_rnn(cell, x, dtype=tf.float32)
yhat = tf.contrib.layers.fully_connected(outputs[:,-1], output_dim, activation_fn=None)

loss = tf.reduce_mean(tf.square(yhat-y))
train = tf.train.AdamOptimizer(lr).minimize(loss)

targets = tf.placeholder(tf.float32, [None,1])
preds = tf.placeholder(tf.float32, [None,1])
rmse = tf.sqrt(tf.reduce_mean(tf.square(targets-preds)))

with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    for i in range(iterations):
        _, cv = session.run([train, loss], feed_dict={x:trainx, y:trainy})
        print('step:{} loss:{}'.format(i,cv))
    test_pred = session.run(yhat, feed_dict={x:testx})
    rmsev = session.run(rmse, feed_dict={targets:testy, preds:test_pred})
    print('rmse value:{}'.format(rmsev))
> step:0 loss:0.26945263147354126
> step:1 loss:0.1663144826889038
> step:2 loss:0.0865398496389389
...
> step:497 loss:0.001542618847452104
> step:498 loss:0.001541442354209721
> step:499 loss:0.0015402680728584528
> rmse value:0.052862219512462616


```

