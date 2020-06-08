### RNN eng-fra 번역기

```python
import pandas as pd

df = pd.read_csv('C:/Users/student/Downloads/fra-eng/fra.txt', sep='\t', header=None)
del df[2]
df.columns = ['eng','fra']
df = df[:70000]

## 시그널 추가
df.fra = df.fra.apply(lambda x: '\t ' + x + ' \n')

# 알파벳 단위 토큰화
engvocab = set()
fravocab = set()

for line in df.eng:
    for c in line:
        engvocab.add(c)
        
for line in df.fra:
    for c in line:
        fravocab.add(c)
        
engvocab_size = len(engvocab)+1
fravocab_size = len(fravocab)+1
print(engvocab_size, fravocab_size)
> 80 106

engvocab = sorted(list(engvocab))
fravocab = sorted(list(fravocab))

eng_to_idx = dict([(c,i+1)  for i,c in enumerate(engvocab)])
fra_to_idx=dict([(c,i+1) for i,c in enumerate(fravocab)])


## 영어 문장 => 정수 인코딩
encoder_input = []
for li in df.eng:
    t = []
    for c in li:
        t.append(eng_to_idx[c])
    encoder_input.append(t)
print(encoder_input[:10])
> [[30, 64, 10], [31, 58, 10], [31, 58, 10], [41, 70, 63, 2], [41, 70, 63, 2], [46, 57, 64, 23], [46, 64, 72, 2], [29, 58, 67, 54, 2], [31, 54, 61, 65, 2], [33, 70, 62, 65, 10]]

## 프랑스어 문장 => 정수 인코딩
decoder_input=[]
for li in df.fra:
    t = []
    for c in li:
        t.append(fra_to_idx[c])
    decoder_input.append(t)
print(decoder_input[:10])
> [[1, 3, 48, 53, 3, 4, 3, 2], [1, 3, 45, 53, 64, 73, 72, 3, 4, 3, 2], [1, 3, 45, 53, 64, 73, 72, 14, 3, 2], [1, 3, 29, 67, 73, 70, 71, 105, 4, 3, 2], [1, 3, 29, 67, 73, 70, 57, 78, 105, 4, 3, 2], [1, 3, 43, 73, 61, 3, 26, 3, 2], [1, 3, 83, 53, 3, 53, 64, 67, 70, 71, 105, 4, 3, 2], [1, 3, 27, 73, 3, 58, 57, 73, 3, 4, 3, 2], [1, 3, 82, 3, 64, 9, 53, 61, 56, 57, 105, 4, 3, 2], [1, 3, 45, 53, 73, 72, 57, 14, 3, 2]]

## 프랑스어 문장 출력
decoder_fra = []
for li in df.fra:
    t = []
    i = 0
    for c in li:
        if i > 0:
            t.append(fra_to_idx[c])
        i += 1
    decoder_fra.append(t)
print(decoder_fra[:10])
> [[3, 48, 53, 3, 4, 3, 2], [3, 45, 53, 64, 73, 72, 3, 4, 3, 2], [3, 45, 53, 64, 73, 72, 14, 3, 2], [3, 29, 67, 73, 70, 71, 105, 4, 3, 2], [3, 29, 67, 73, 70, 57, 78, 105, 4, 3, 2], [3, 43, 73, 61, 3, 26, 3, 2], [3, 83, 53, 3, 53, 64, 67, 70, 71, 105, 4, 3, 2], [3, 27, 73, 3, 58, 57, 73, 3, 4, 3, 2], [3, 82, 3, 64, 9, 53, 61, 56, 57, 105, 4, 3, 2], [3, 45, 53, 73, 72, 57, 14, 3, 2]]


## padding
max_eng_len = max([len(li) for li in df.eng])
max_fra_len = max([len(li) for li in df.fra])
print(max_eng_len, max_fra_len)
> 26 76

from keras.preprocessing.sequence import pad_sequences
encoder_input = pad_sequences(encoder_input, maxlen=max_eng_len, padding='post')
decoder_input = pad_sequences(decoder_input, maxlen=max_fra_len, padding='post')
decoder_fra = pad_sequences(decoder_fra, maxlen=max_fra_len, padding='post')

import numpy as np
print(np.shape(encoder_input), np.shape(decoder_input))
> (70000, 26) (70000, 76)


## 원핫인코딩
from keras.utils import to_categorical
encoder_input = to_categorical(encoder_input)
decoder_input = to_categorical(decoder_input)
decoder_fra = to_categorical(decoder_fra)

print(np.shape(encoder_input), np.shape(decoder_input))
# (70000문장, 전체 문장 중 최대 글자 수, 글자 종류)
> (70000, 26, 80) (70000, 76, 106)


## 이전 상태의 실제값을 현재 상태의 decoder 입력으로 training
from keras.layers import Input, Embedding, Dense, LSTM
from keras.models import Model


'''
input = Input(shape=(time-step(시점), feature))
it = LSTM(출력)(input)
d1 = Dense(10, activation='relu')(it)
d2 = Dense(1, activation='sigmoid')(it)
Model(inputs=input, outputs=d2)
'''

# encoder = Input(None, 영어 문자 종류 갯수)
encoder_inputs = Input(shape=(None, engvocab_size))
# decoder = Input(None, 프랑스어 문자 종류 갯수)
decoder_inputs = Input(shape=(None, fravocab_size))

# encoder LSTM
encoder_lstm = LSTM(units=256, return_state=True)
# decoder LSTM
decoder_lstm = LSTM(units=256, return_sequences=True, return_state=True)

# encoder LSTM  cell 입력 정의
# _, hidden state(위쪽), cell state(오른쪽)
_, state_h, state_c = encoder_lstm(encoder_inputs)
# context vector
encoder_states = [state_h, state_c]

decoder_outputs, _, _ = decoder_lstm(decoder_inputs, initial_state=encoder_states)
decoder_softmax = Dense(fravocab_size, activation='softmax')
decoder_outputs = decoder_softmax(decoder_outputs)

model = Model(inputs=[encoder_inputs,decoder_inputs], outputs=decoder_outputs)
model.compile(optimizer='rmsprop', loss='categorical_crossentropy')

model.fit(x=[encoder_input, decoder_input], y=decoder_fra, batch_size=64, epochs=10, validation_split=0.2)
> ....
> Epoch 9/10
56000/56000 [==============================] - 286s 5ms/step - loss: 0.2162 - val_loss: 0.3650
> Epoch 10/10
56000/56000 [==============================] - 291s 5ms/step - loss: 0.2115 - val_loss: 0.3647
        


model.save('my_model2.h5')

```

