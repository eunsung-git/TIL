* NUMPY - 데이터 전처리 (결측치, 표준화/정규화), 수치해석,  다차원 배열 구조, 선형대수 계산 시 사용, 벡터화 연산

  * 정규화 : 각 속성값-min / 각 속성의 max-min

  * 표준화 : avg=0, 표준편차=1

  * 원핫encoding  ex) 10000, 01000, 00100

  * 밀집vector(word2vector)

* PANDAS - 데이터 분석
* matplotlib, seaborn - 시각화

list - 속도 느림, 메모리 多
array - 속도 빠름, 메모리 小, 같은 자료형, 원소 갯수 변경x, 파이썬x  -> numpy배열



### NUMPY   [n차원 배열]

##### 1차원 배열

```py
import numpy as np
ar=numpy.array([0,1,2,3,4])
type(ar)
```

```python
import numpy as np
data=list(range(0,10))
ans=[]
for d in data:
    ans.append(2*d)
print(ans)      # [0,2,4,6,8,10,12,14,16,18]

=> 벡터화 연산 - for 구문 사용x, 빠른 연산 속도
x=np.array(data)
x*2             # array([0,2,4,6,8,10,12,14,16,18])
```

```python
import numpy as np
a=np.array([1,2,3])
b=np.array([4,5,6])
a2=[1,2,3]
b2=[4,5,6]

2*a2+b2   # [1,2,3,1,2,3,4,5,6]
2*a+b     # array([6,9,12])
a2==2     # False
a==2      # array([False, True, False])
#a2>2     #error
a>2       # array([False, False, True])
```



##### 2차원 배열 (행렬, matrix) - llist[list]

##### - 열 : 안쪽 list 의 길이

##### - 행 : 바깥쪽 list의 길이

```python
import numpy as np
m=np.array([[0,1,2], [3,4,5]])   -> 2행 3열
 = array([0,1,2],
         [3,4,5])

# 행의 갯수
len(m)   # 2
# 열의 갯수
len(m[0])   # 3

#배열의 차원
m.ndim     # 2

# 배열의 크기
m.shape    # (2,3)
```



##### 3차원 배열 - list[list[list]]

```python
import numpy as np
m=np.array([[[1,2,3,4],
         [5,6,7,8],
         [9,10,11,12]],
         [[31,32,33,34],
         [35,36,37,38],
         [39,310,311,312]]])      -> 2행 3열 4깊이(면)  2*3*4

# 행의 갯수
len(m)  # 2
# 열의 갯수
len(m[0])  # 3
# 깊이(면)의 갯수
len(m[0][0])   # 4

#배열의 차원
m.ndim     # 3

# 배열의 크기
m.shape    # (2,3,4)
```



##### array slicing 

```python
import numpy as np
ar=np.array([[1,2,3,4], [5,6,7,8]])
ar[0,:]    # 첫번째 행 전체             array([1,2,3,4])
ar[:,1]    # 두번째 열 전체             array([2,6])
ar[1,1:]   # 두번째 행, 두번째 열~마지막  array([6,7,8])
ar[:,:2]   #                          array([[1,2], [5,6]])

ar[0][0]    # 첫번째 행, 첫번째 열        1
ar[0,0]     # 첫번째 행, 첫번째 열        1
ar[0,1]     #                          2
ar[1,1]     #                          6
ar[-1]      #                          [5,6,7,8]
ar[-1,1]=ar[-1,-3]  #                  6
```



##### boolin 참조

조건을 만족하는 값만 추출

```python
import numpy as np
ar=np.array([2,3,4,5])
bidx=np.array([True, True, False, True])

ar[bidx]      # array([2, 3, 5])
ar != 4       # array([ True,  True, False,  True])
ar[ar != 4]   # array([2, 3, 5])
ar[ar%2==0]   # array([2, 4])
ar[ar>3]      # array([4, 5])
```



##### 정수 참조

```python
import numpy as np
ar=np.array([2,3,4,5])
idx=np.array([0,3])
idx2=np.array([0,0,1,1])

ar[idx]     # array([2, 5])
ar[idx2]    # array([2, 2, 3, 3])

```

```python
import numpy as np
ar=np.array([[1,2,3,4], 
             [5,6,7,8]])

ar[:, [0,3]]                    # array([[1, 4],
                                #        [5, 8]])
ar[:,[True,False,False,True]]   # array([[1, 4],
                                #        [5, 8]])
    
ar[:]                  # 전체 행   array([[1, 2, 3, 4],
                       #                 [5, 6, 7, 8]])
ar[:,:]        # 전체 행, 전체 열   array([[1, 2, 3, 4],
               #                         [5, 6, 7, 8]])

```

```python
import numpy as np
ar=np.array([[1,2,3,4], 
             [15,16,17,18],
             [25,26,27,28], 
             [35,36,37,38]])

ar[2,:]                         # array([25, 26, 27, 28])
ar[[2,0],:]                     # array([[25, 26, 27, 28],
                                #        [ 1,  2,  3,  4]])
ar[[2,0,-1],:]                  # array([[25, 26, 27, 28],
                                #        [ 1,  2,  3,  4],
                                #        [35, 36, 37, 38]])
```



```python
import numpy as np
np.arange(8).reshape(2,2,2)
```









### PANDAS  [DataFrame]

```python
import pandas as pd
csvTest=pd.read_csv('test_csv.csv')
csvTest
csvTest.shape    # (5,3)
```

```python
import pandas as pd
text=pd.read_csv("test_text.txt")
text.shape      # (5,1)

**# default : 행 index / 열 index / header**

text2=pd.read_csv("test_text.txt", sep='|')   # '|' 를 기준으로 구분
text2.shape      # (5,3)
```

```python
text2=pd.read_csv("test_text.txt", sep='|',index_col='ID')  # 행 index를  'ID' 열로 지정
```

```python
pd.read_csv("test_text.txt", sep='|',index_col=1)   # index_col에 특정 열을 지정 가능
```

```python
pd.read_csv("test_text_without_name.txt", header=None, sep='|',index_col=0)  # header  없애기
```

```python
pd.read_csv('test_text.txt',sep='|', skiprows=2)  # 연속으로 여러 줄 건너뛰기
```

```python
pd.read_csv('test_text.txt',sep='|', skiprows=[0,2])  # 비연속적 줄 건너뛰기
```

```python
pd.read_csv('test_text.txt',sep='|', nrow=3)        # n줄만 불러오기
```

