### mlp text_preprocessing keras

##### Tokenizer( )

```python
from keras.preprocessing.text import Tokenizer

## Tokenizer()  - 일종의 corpus 생성
tok = Tokenizer()
text = 'Regret for wasted time is more wasted time'

# 문자 단위 토큰화
tok.fit_on_texts(text)
tok.word_index
> {'e': 1,
   't': 2,
   'r': 3,
   's': 4,
   'i': 5,
   'm': 6,
   'o': 7,
   'w': 8,
   'a': 9,
   'd': 10,
   'g': 11,
   'f': 12}

# 단어 단위 토큰화
tok.fit_on_texts([text])
tok.word_index
> {'wasted': 1, 'time': 2, 'regret': 3, 'for': 4, 'is': 5, 'more': 6}

-----------------------------------------------------------

texts = ['먹고 싶은 사과', '먹고 싶은 바나나', '길고 노란 바나나 바나나','저는 과일이 좋아요']

# 문자 단위 토큰화
tok = Tokenizer()
tok.fit_on_texts(texts)
tok.word_index
> {'바나나': 1,
   '먹고': 2,
   '싶은': 3,
   '사과': 4,
   '길고': 5,
   '노란': 6,
   '저는': 7,
   '과일이': 8,
   '좋아요': 9}

## Tokenizer().texts_to_matrix()
# dtm
tok.texts_to_matrix(texts, mode='count')
> array([[0., 0., 1., 1., 1., 0., 0., 0., 0., 0.],
         [0., 1., 1., 1., 0., 0., 0., 0., 0., 0.],
         [0., 2., 0., 0., 0., 1., 1., 0., 0., 0.],
         [0., 0., 0., 0., 0., 0., 0., 1., 1., 1.]])

# tfidf
tok.texts_to_matrix(texts, mode='tfidf')
> array([[0.        , 0.        , 0.84729786, 0.84729786, 1.09861229,
        0.        , 0.        , 0.        , 0.        , 0.        ],
         [0.        , 0.84729786, 0.84729786, 0.84729786, 0.        ,
        0.        , 0.        , 0.        , 0.        , 0.        ],
         [0.        , 1.43459998, 0.        , 0.        , 0.        ,
        1.09861229, 1.09861229, 0.        , 0.        , 0.        ],
         [0.        , 0.        , 0.        , 0.        , 0.        ,
        0.        , 0.        , 1.09861229, 1.09861229, 1.09861229]])

# 단어 존재 유무
tok.texts_to_matrix(texts, mode='binary')
> array([[0., 0., 1., 1., 1., 0., 0., 0., 0., 0.],
         [0., 1., 1., 1., 0., 0., 0., 0., 0., 0.],
         [0., 1., 0., 0., 0., 1., 1., 0., 0., 0.],
         [0., 0., 0., 0., 0., 0., 0., 1., 1., 1.]])

# 문장단위 등장 비율
tok.texts_to_matrix(texts, mode='freq')
> array([[0.        , 0.        , 0.33333333, 0.33333333, 0.33333333,
        0.        , 0.        , 0.        , 0.        , 0.        ],
         [0.        , 0.33333333, 0.33333333, 0.33333333, 0.        ,
        0.        , 0.        , 0.        , 0.        , 0.        ],
         [0.        , 0.5       , 0.        , 0.        , 0.        ,
        0.25      , 0.25      , 0.        , 0.        , 0.        ],
         [0.        , 0.        , 0.        , 0.        , 0.        ,
        0.        , 0.        , 0.33333333, 0.33333333, 0.33333333]])

```



##### padding

```python
from keras.preprocessing.sequence import pad_sequences

## pad_sequences( ) - 문장 길이를 동일하게 맞춤
pad_sequences([[1,2,3],[2,3,4,5],[6,7]], maxlen=2)
> array([[2, 3],
         [4, 5],
         [6, 7]])

pad_sequences([[1,2,3],[2,3,4,5],[6,7]], maxlen=3, padding='pre')
> array([[1, 2, 3],
         [3, 4, 5],
         [0, 6, 7]])

pad_sequences([[1,2,3],[2,3,4,5],[6,7]], maxlen=3, padding='post')
> array([[1, 2, 3],
         [3, 4, 5],
         [6, 7, 0]])

```



#### mlp text preprocessing

```python
import pandas as pd
from sklearn.datasets import fetch_20newsgroups
from keras.utils import to_categorical
import matplotlib.pyplot as plt

newsdata = fetch_20newsgroups(subset='train')
print(newsdata.keys())
> dict_keys(['data', 'filenames', 'target_names', 'target', 'DESCR'])

print(len(newsdata.data), len(newsdata.target))
> 11314 11314

df = pd.DataFrame(newsdata.data, columns=['email'])
df['target'] = newsdata.target

# 20 주제, 11314 샘플
print(df.target.nunique(), df.email.nunique() )
> 20 11314

## 주제별 샘플 갯수
# 1) value_counts()
df['target'].value_counts()
# 2) groupby()
df.groupby('target').size()
> 10    600
> 15    599
> 8     598
> 9     597
> 11    595
> 13    594
> 7     594
> 14    593
> 5     593
> 12    591
> 2     591
> 3     590
> 6     585
> 1     584
> 4     578
> 17    564
> 16    546
> 0     480
> 18    465
> 19    377


newsdata_test = fetch_20newsgroups(subset='test', shuffle=True)

train_email = df['email']
train_label = df['target']

test_email = newsdata_test.data
test_label = newsdata_test.target


## data preprocessing
def pre_data(traindata, testdata, mode):
    # 빈도수 상위 10000개 단어로 토큰화
    tok = Tokenizer(num_words=10000)
    tok.fit_on_texts(traindata)
    xtrain = tok.texts_to_matrix(traindata, mode=mode)
    xtest = tok.texts_to_matrix(testdata, mode=mode)
    return xtrain, xtest, tok.index_word

xtrain, xtest, index_word = pre_data(train_email, test_email, 'binary')
print(xtrain.shape, xtest.shape, train_label.shape, test_label.shape)
> (11314, 10000) (7532, 10000) (11314,) (7532,)

# label 원핫인코딩
ytrain = to_categorical(train_label, 20)
ytest = to_categorical(test_label, 20)
print(xtrain.shape, xtest.shape, ytrain.shape, ytest.shape)
> (11314, 10000) (7532, 10000) (11314, 20) (7532, 20)


from keras.layers import Dropout
from keras.models import Sequential

## model 훈련&평가
def fit_eval(xtrain, ytrain, xtest, ytest):
    model = Sequential()
    model.add(Dense(256, input_shape=(10000,), activation='relu'))
    model.add(Dropout(0.5))
    model.add(Dense(128, activation='relu'))
    model.add(Dropout(0.5))
    model.add(Dense(20, activation='softmax'))
    
    model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
    
    model.fit(xtrain, ytrain, batch_size=128, epochs=5, validation_split=0.1, verbose=1)
    
    score = model.evaluate(xtest, ytest, batch_size=128)
    return score[1]

fit_eval(xtrain, ytrain, xtest, ytest)
> 0.825809895992279


xtrain, xtest, _ = pre_data(train_email, test_email, 'binary')

score = fit_eval(xtrain, ytrain, xtest, ytest)
print('accuracy : ', score)
> accuracy :  0.8279341459274292






```

