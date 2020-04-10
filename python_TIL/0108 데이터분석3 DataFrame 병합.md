### " pd.concat() "

#### DataFrame 합치기        



```python
import pandas as pd
from pandas import DataFrame

df1 = pd.DataFrame({'A': ['A0', 'A1', 'A2'],
    'B': ['B0', 'B1', 'B2'],
    'C': ['C0', 'C1', 'C2'],
    'D': ['D0', 'D1', 'D2']},
    index=[0, 1, 2])
df2 = pd.DataFrame({'A': ['A3', 'A4', 'A5'],
    'B': ['B3', 'B4', 'B5'],
    'C': ['C3', 'C4', 'C5'],
    'D': ['D3', 'D4', 'D5']},
    index=[3, 4, 5])
df3 = pd.DataFrame({'E': ['A6', 'A7', 'A8'],
    'F': ['B6', 'B7', 'B8'],
    'G': ['C6', 'C7', 'C8'],
    'H': ['D6', 'D7', 'D8']},
    index=[0, 1, 2])
df4 = pd.DataFrame({'A': ['A0', 'A1', 'A2'],
     'B': ['B0', 'B1', 'B2'],
     'C': ['C0', 'C1', 'C2'],
     'E': ['E0', 'E1', 'E2']},
     index=[0, 1, 3])
df5 = pd.DataFrame({'A': ['A0', 'A1', 'A2'],
     'B': ['B0', 'B1', 'B2'],
     'C': ['C0', 'C1', 'C2'],
     'D': ['D0', 'D1', 'D2']},
     index=['r0', 'r1', 'r2'])
df6 = pd.DataFrame({'A': ['A3', 'A4', 'A5'],
     'B': ['B3', 'B4', 'B5'],
     'C': ['C3', 'C4', 'C5'],
     'D': ['D3', 'D4', 'D5']},
     index=['r3', 'r4', 'r5'])
df7 = pd.DataFrame({'A': ['A0', 'A1', 'A2'],
     'B': ['B0', 'B1', 'B2'],
     'C': ['C0', 'C1', 'C2'],
     'D': ['D0', 'D1', 'D2']},
     index=['r0', 'r1', 'r2'])

df8 = pd.DataFrame({'A': ['A2', 'A3', 'A4'],
     'B': ['B2', 'B3', 'B4'],
     'C': ['C2', 'C3', 'C4'],
     'D': ['D2', 'D3', 'D4']},
     index=['r2', 'r3', 'r4'])

df12=pd.concat([df1,df2])

# default : axis=0 -> 위아래 병합 / column 기준
# axis=1  -> 좌우 병합 / row index 기준
df13_a1=pd.concat([df1,df3],axis=1)
df13_a0=pd.concat([df1,df3],axis=0)
df14_a0=pd.concat([df1,df4])
df14_a1=pd.concat([df1,df4],axis=1)

# default : join='outer'  -> 합집합
df14_out=pd.concat([df1,df4],axis=0,join='outer')

# join='inner'  -> 교집합
df14_in=pd.concat([df1,df4],axis=0,join='inner')
df14_a1_in=pd.concat([df1,df4],axis=1,join='inner')

# join_axes=[기준]  -> 기준점은 모두 출력
df14_a1_in_ja=pd.concat([df1,df4],axis=1,join='inner',join_axes=[df1.index])

# ignore_index=True  -> row/column index 초기화
df56_ig=pd.concat([df5,df6],axis=0,ignore_index=True)
df56_a1_ig=pd.concat([df5,df6],axis=1,ignore_index=True)

# keys['계층index이름','계층index이름2']   -> 계층 index 생성
df56_k=pd.concat([df5,df6],keys=['df_5','df_6'])

# .ix['계층index이름'][index범위]  -> 중분류 & 소분류
df56_k.ix['df_5']
df56_k.ix['df_5'][1:2]
df56_k.ix['df_6'][1:2]

# index 이름 부여
df56_k_n=pd.concat([df5,df6],keys=['df_5','df_6'],names=['dfName','rowData'])

# verify_integrity=True/False  ->  index 중복 여부 확인, True 설정 후 중복 index가 있으면 error
df78_v=pd.concat([df7,df8],verify_integrity=True)
```



#### DataFrame + Series    " pd.concat()" & " append()"

```python
import pandas as pd
from pandas import DataFrame
from pandas import Series

df1 = pd.DataFrame({'A': ['A0', 'A1', 'A2'],
    'B': ['B0', 'B1', 'B2'],
    'C': ['C0', 'C1', 'C2'],
    'D': ['D0', 'D1', 'D2']},
    index=[0, 1, 2])

type(df1['A'])        # pandas.core.series.Series
type(df1[['A','B']])  # pandas.core.frame.DataFrame
type(df1[['A']])      # pandas.core.frame.DataFrame


S1=pd.Series(['s1','s2','s3'],name='S')

dfs11=pd.concat([df1,S1])
dfs11_a1=pd.concat([df1,S1],axis=1)
dfs11_a1_ig=pd.concat([df1,S1],axis=1,ignore_index=True)
```



###  Series 합치기   " pd.concat()" & " append()"

```python
import pandas as pd
from pandas import Series

S1=pd.Series(['s1','s2','s3'],name='S')
S2=pd.Series([1,2,3])
S3=pd.Series([4,5,6])

s123=pd.concat([S1,S2,S3])
type(s123)    # pandas.core.series.Series

s123_1=pd.concat([S1,S2,S3],axis=1)
type(s123_1)  # pandas.core.frame.DataFrame

s123_a1_ig=pd.concat([S1,S2,S3],axis=1,ignore_index=True)
```

------------------------------------------



### " pd.merge()"

```python
import pandas as pd
from pandas import DataFrame

dfleft = DataFrame({'KEY': ['K0', 'K1', 'K2', 'K3'],
    'A': ['A0', 'A1', 'A2', 'A3'],
    'B': ['B0', 'B1', 'B2', 'B3']})
dfright = DataFrame({'KEY': ['K2', 'K3', 'K4', 'K5'],
    'C': ['C2', 'C3', 'C4', 'C5'],
    'D': ['D2', 'D3', 'D4', 'D5']})
dfleft2 = DataFrame({'KEY': ['K0', 'K1', 'K2', 'K3'],
     'A': ['A0', 'A1', 'A2', 'A3'],
     'B': ['B0', 'B1', 'B2', 'B3'],
     'C': ['C0', 'C1', 'C2', 'C3']})
dfright2 = DataFrame({'KEY': ['K0', 'K1', 'K2', 'K3'],
     'B': ['B0_2', 'B1_2', 'B2_2', 'B3_2'],
     'C': ['C0_2', 'C1_2', 'C2_2', 'C3_2'],
     'D': ['D0_2', 'D1_2', 'D2_2', 'D3_3']})

# default : how='inner'  -> 교집합
dflr=pd.merge(dfleft,dfright)
dflr_in=pd.merge(dfleft,dfright,how='inner')

# how='outer'  -> 합집합
dflr_out=pd.merge(dfleft,dfright,how='outer')

# how='left' -> 왼쪽 df를 중심으로 inner (= left join)
dflr_l=pd.merge(dfleft,dfright,how='left')

# how='right' -> 오른쪽 df를 중심으로 inner  (= right join)
dflr_r=pd.merge(dfleft,dfright,how='right')

# on='공통data'    -> 공통data를 기준으로 merge  
dflr_l_on=pd.merge(dfleft,dfright,how='left',on='KEY')
dflr_r_on=pd.merge(dfleft,dfright,how='right',on='KEY')
dflr_out_on=pd.merge(dfleft,dfright,how='outer',on='KEY')

# indicator=True   -> merge 결과값 정보 column 추가 출력
dflr_out_on_idc=pd.merge(dfleft,dfright,how='outer',on='KEY',indicator=True)
dflr_out_on_idc=pd.merge(dfleft,dfright,how='outer',on='KEY',indicator='indicator_info')

# 중복되는 column이름에 자동으로 suffixes(_x, _y) 추가
dflr2_on=pd.merge(dfleft2,dfright2,on='KEY')

# suffixes=('suffix이름','suffix이름2')   -> 중복 column에 할당되는 suffixes 이름 지정
dflr2_on_suf=pd.merge(dfleft2,dfright2,on='KEY',suffixes=('_left','_right'))




dfleft_ind = DataFrame({
    'A': ['A0', 'A1', 'A2', 'A3'],
    'B': ['B0', 'B1', 'B2', 'B3']},
    index=['K0', 'K1', 'K2', 'K3'])
dfright_ind = DataFrame({
    'C': ['C2', 'C3', 'C4', 'C5'],
    'D': ['D2', 'D3', 'D4', 'D5']},
    index=['K2', 'K3', 'K4', 'K5'])

# left/right_index=True   -> index 기준으로 merge
dflr_ind=pd.merge(dfleft_ind,dfright_ind,left_index=True,right_index=True)

dflr_ind_l=pd.merge(dfleft_ind,dfright_ind,left_index=True,right_index=True,how='left')

dflr_ind_r=pd.merge(dfleft_ind,dfright_ind,left_index=True,right_index=True,how='right')

dflr_ind_out=pd.merge(dfleft_ind,dfright_ind,left_index=True,right_index=True,how='outer')



dfleft_key = DataFrame({
    'KEY':['K0', 'K1', 'K2', 'K3'],
    'A': ['A0', 'A1', 'A2', 'A3'],
    'B': ['B0', 'B1', 'B2', 'B3']})
dfright_ind = DataFrame({
    'C': ['C2', 'C3', 'C4', 'C5'],
    'D': ['D2', 'D3', 'D4', 'D5']},
    index=['K2', 'K3', 'K4', 'K5'])

# column & index 에 공통data가 동시에 존재
dflrkind=pd.merge(dfleft_key,dfright_ind,left_on='KEY',right_index=True,how='left')
```



### " join() "

```python
import pandas as pd
from pandas import DataFrame

dfleft_ind = DataFrame({
    'A': ['A0', 'A1', 'A2', 'A3'],
    'B': ['B0', 'B1', 'B2', 'B3']},
    index=['K0', 'K1', 'K2', 'K3'])
dfright_ind = DataFrame({
    'C': ['C2', 'C3', 'C4', 'C5'],
    'D': ['D2', 'D3', 'D4', 'D5']},
    index=['K2', 'K3', 'K4', 'K5'])

# df1.join(df2)      -> index 기준으로 join(=merge)
# default : how='left'
dfleft_ind.join(dfrignt_ind)
dfleft_ind.join(dfright_ind,how='right')
dfleft_ind.join(dfright_ind,how='outer')



dfleft_key = DataFrame({
    'KEY':['K0', 'K1', 'K2', 'K3'],
    'A': ['A0', 'A1', 'A2', 'A3'],
    'B': ['B0', 'B1', 'B2', 'B3']})
dfright_ind = DataFrame({
    'C': ['C2', 'C3', 'C4', 'C5'],
    'D': ['D2', 'D3', 'D4', 'D5']},
    index=['K2', 'K3', 'K4', 'K5'])

# column & index 에 공통data가 동시에 존재
dfleft_key.join(dfright_ind,on='KEY',how='left')
```

