## Eng NLP

#### 1 토큰화

```python
import nltk 
nltk.download()

import konlpy

### 단어토큰화 - 구두점/특수문자 제거

## 1) word_tokenize()
from nltk.tokenize import word_tokenize
word_tokenize("Mr.Jacob's Don't be")
> ['Mr.Jacob', "'s", 'Do', "n't", 'be']

## 2) WordPunctTokenizer().tokenize()
from nltk.tokenize import WordPunctTokenizer
WordPunctTokenizer().tokenize("Mr.Jacob's Don't be")
> ['Mr', '.', 'Jacob', "'", 's', 'Don', "'", 't', 'be']

## 3) text_to_word_sequence()
from tensorflow.keras.preprocessing.text import text_to_word_sequence
text_to_word_sequence("Mr.Jacob's Don't be")
> ['mr', "jacob's", "don't", 'be']

## 4) TreebankWordTokenizer().tokenize()
from nltk.tokenize import TreebankWordTokenizer
TreebankWordTokenizer().tokenize("Mr.Jacob's Don't be")
> ['Mr.Jacob', "'s", 'Do', "n't", 'be']

----------------------------------------------------------

### 문장토큰화

## sent_tokenize()
from nltk.tokenize import sent_tokenize
text="Python is an interpreted, high-level, general-purpose programming language. Created by Guido van Rossum and first released in 1991, Python's design philosophy emphasizes code readability with its notable use of significant whitespace. Its language constructs and object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects."
sent_tokenize(text)
> ['Python is an interpreted, high-level, general-purpose programming language.', "Created by Guido van Rossum and first released in 1991, Python's design philosophy emphasizes code readability with its notable use of significant whitespace.", 'Its language constructs and object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects.']


```



```python
#### 토큰화 과정

### 1) 문장 토큰화
from nltk.tokenize import sent_tokenize
from nltk.corpus import stopwords
text="Python is an interpreted, high-level, general-purpose programming language. Created by Guido van Rossum and first released in 1991, Python's design philosophy emphasizes code readability with its notable use of significant whitespace. Its language constructs and object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects."
text_tk=sent_tokenize(text)

### 2) 문장 ->  단어  토큰화
stopwords=stopwords.words('english')
worddict={}
sentences_tk=[]

for t in text_tk:
    words_tk=word_tokenize(t)
    wordlist=[]
    for word in words_tk:
        # 소문자
        word=word.lower()
        # 불용어 제거
        if word not in stopwords:
            # 길이 2 이하 단어 제거
            if len(word)>2:
                wordlist.append(word)
                # 토큰화된 단어 갯수 세기
                if word not in worddict:
                    worddict[word]=0
                worddict[word]+=1
    # 문장별 단어 토큰화            
    sentences_tk.append(wordlist)

## 문장 -> 단어 토큰화 후 전처리
print(wordlist) 
> ['language', 'constructs', 'object-oriented', 'approach', 'aim', 'help', 'programmers', 'write', 'clear', 'logical', 'code', 'small', 'large-scale', 'projects']

## {토큰화된 단어 : 갯수}
> {'python': 2, 'interpreted': 1, 'high-level': 1, 'general-purpose': 1, 'programming': 1, 'language': 2, 'created': 1, 'guido': 1, 'van': 1, 'rossum': 1, 'first': 1, 'released': 1, '1991': 1, 'design': 1, 'philosophy': 1, 'emphasizes': 1, 'code': 2, 'readability': 1, 'notable': 1, 'use': 1, 'significant': 1, 'whitespace': 1, 'constructs': 1, 'object-oriented': 1, 'approach': 1, 'aim': 1, 'help': 1, 'programmers': 1, 'write': 1, 'clear': 1, 'logical': 1, 'small': 1, 'large-scale': 1, 'projects': 1}

## 문장별 단어 토큰화
> [['python', 'interpreted', 'high-level', 'general-purpose', 'programming', 'language'], ['created', 'guido', 'van', 'rossum', 'first', 'released', '1991', 'python', 'design', 'philosophy', 'emphasizes', 'code', 'readability', 'notable', 'use', 'significant', 'whitespace'], ['language', 'constructs', 'object-oriented', 'approach', 'aim', 'help', 'programmers', 'write', 'clear', 'logical', 'code', 'small', 'large-scale', 'projects']]


### 3) 정렬
## 단어 갯수별
sorted(worddict.items(),key=lambda x:x[1],reverse=True)
> [('python', 2), ('language', 2), ('code', 2), ('interpreted', 1), ('high-level', 1), ('general-purpose', 1), ('programming', 1), ('created', 1), ('guido', 1), ('van', 1), ('rossum', 1), ('first', 1), ('released', 1), ('1991', 1), ('design', 1), ('philosophy', 1), ('emphasizes', 1), ('readability', 1), ('notable', 1), ('use', 1), ('significant', 1), ('whitespace', 1), ('constructs', 1), ('object-oriented', 1), ('approach', 1), ('aim', 1), ('help', 1), ('programmers', 1), ('write', 1), ('clear', 1), ('logical', 1), ('small', 1), ('large-scale', 1), ('projects', 1)]

## 단어 알파벳 순서별
> [('write', 1), ('whitespace', 1), ('van', 1), ('use', 1), ('small', 1), ('significant', 1), ('rossum', 1), ('released', 1), ('readability', 1), ('python', 2), ('projects', 1), ('programming', 1), ('programmers', 1), ('philosophy', 1), ('object-oriented', 1), ('notable', 1), ('logical', 1), ('large-scale', 1), ('language', 2), ('interpreted', 1), ('high-level', 1), ('help', 1), ('guido', 1), ('general-purpose', 1), ('first', 1), ('emphasizes', 1), ('design', 1), ('created', 1), ('constructs', 1), ('code', 2), ('clear', 1), ('approach', 1), ('aim', 1), ('1991', 1)]

## list 없이 정렬 출력
vs=sorted(worddict.items(),key=lambda x:x[1],reverse=True)

for w,f in vs:
  print(w,f)
> python 2
> language 2
> code 2
> interpreted 1
> high-level 1
> general-purpose 1
> programming 1
> created 1  .......


## 정렬 list에 index 추가하기
vs=sorted(worddict.items(),key=lambda x:x[1],reverse=True)
wordcount={}
i=0

for w,f in vs:
    if f>1:
        i+=1
        wordcount[w]=i
print(wordcount)
> {'python': 1, 'language': 2, 'code': 3}

---------------------------------------------------------

# 가장 많이 언급된 상위 2개 단어/index 출력
rank=2
wordfreq=[w for w,i in wordcount.items() if i>rank]

for w in wordfreq:
    del wordcount[w]
    
print(wordcount)
> {'python': 1, 'language': 2}


```



#### 2 추출

```python
### 표제어(lemmatization) 추출  ->  단어 기본형 추출
from nltk.stem import WordNetLemmatizer
wnl=WordNetLemmatizer()

# WordNetLemmatizer().lemmatize('단어', '품사')
wnl.lemmatize('watched', 'v')
> watch

wnl.lemmatize('has', 'v')
> have

-----------------------------------------------------------

### 어간(stem) 추출 
from nltk.tokenize import word_tokenize

text="Python is an interpreted, high-level, general-purpose programming language."
word_tk=word_tokenize(text)

# 1) PorterStemmer().stem()
from nltk.stem import PorterStemmer
ps=PorterStemmer()

print([ps.stem(w) for w in word_tk])
> ['python', 'is', 'an', 'interpret', ',', 'high-level', ',', 'general-purpos', 'program', 'languag', '.']


# 2) LancasterStemmer().stem()
from nltk.stem import LancasterStemmer
ls=LancasterStemmer()

print([ls.stem(w) for w in word_tk])
> ['python', 'is', 'an', 'interpret', ',', 'high-level', ',', 'general-purpose', 'program', 'langu', '.']


```



#### 3 불용어 (stopwords) 처리

```python
from nltk.tokenize import word_tokenize

## stopwords.words()
from nltk.corpus import stopwords
stopwords=stopwords.words('english')

ex="Family is not an important thing. It's everything."
ex_tk=word_tokenize(ex)
print(ex_tk)
> ['Family', 'is', 'not', 'an', 'important', 'thing', '.', 'It', "'s", 'everything', '.']

res=[]
for word in ex_tk:
    if word not in stopwords:
        res.append(word)
print(res)
> ['Family', 'important', 'thing', '.', 'It', "'s", 'everything', '.']

```



--------------------------------------------------------------------------------------------------------



### Kor NLP

#### 1 토큰화

```python
### 형태소 토큰화
from konlpy.tag import Okt
okt=Okt()

# Okt().morphs() -> 형태소 추출
okt.morphs("오늘은 수요일, 내일은 목요일입니다.")
> ['오늘', '은', '수요일', ',', '내일', '은', '목요일', '입니다', '.']

# Okt().pos() -> (형태소,품사) 추출
okt.pos("오늘은 수요일, 내일은 목요일입니다.")
> [('오늘', 'Noun'), ('은', 'Josa'), ('수요일', 'Noun'), (',', 'Punctuation'), ('내일', 'Noun'), ('은', 'Josa'), ('목요일', 'Noun'), ('입니다', 'Adjective'), ('.', 'Punctuation')]

# Okt().nouns() -> 명사 추출
okt.nouns("오늘은 수요일, 내일은 목요일입니다.")
> ['오늘', '수요일', '내일', '목요일']


```



#### 2 불용어 (stopwords) 처리

```python
from nltk.tokenize import word_tokenize

## stopwords.words()
from nltk.corpus import stopwords

ex='최근 코로나 19 감염으로 인해 확진자 및 사망자가 증가하고 있습니다. 코로나19를 이겨냅시다'
kor_stopwords='인해 및 하고 있습니다'
kor_stopwords=kor_stopwords.split(" ")

res=[]
for word in word_tokenize(ex):
    if word not in kor_stopwords:
        res.append(word)
print(res)
> ['최근', '코로나', '19', '감염으로', '확진자', '사망자가', '증가하고', '.', '코로나19를', '이겨냅시다']
```





#### 3 원핫인코딩

```python
### 1) okt 원핫인코딩
from konlpy.tag import Okt
okt=Okt()
kor_tk=okt.morphs('나는 자연어 처리를 학습한다')

kor_index={}
for v in kor_tk:
    if v not in kor_index.keys():
        kor_index[v]=len(kor_index)
        
def ohe(w,kor_index):
    ohv=[0]*len(kor_index)
    index=kor_index[w]
    ohv[index]=1
    return ohv
    
ohe("자연어", kor_index)
> [0, 0, 1, 0, 0, 0, 0]


### 2) keras 활용 원핫인코딩
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.utils import to_categorical
tk=Tokenizer()

## 단어집합/index 생성
text='데이터 분석은 판다스 최고야 판다스 곰이야'
tk.fit_on_texts([text])
print(tk.word_index)
> {'판다스': 1, '데이터': 2, '분석은': 3, '최고야': 4, '곰이야': 5}

## 단어집합 기준, index로 반환
text2='판다스 분석은 동물원에서 한다'
tk.texts_to_sequences([text2])
> [[1, 3]]

## 원핫인코딩
enc=tk.texts_to_sequences([text2])[0]
to_categorical(enc)
> array([[0., 1., 0., 0.],
       [0., 0., 0., 1.]], dtype=float32)

```

