### xml

```python
### xml tree 불러오기
from lxml import etree

tree=etree.parse('sample.xml')

## root node 불러오기
root=tree.getroot()


## 자식 node 불러오기
kids=root.getchildren()

members=[]
albums=[]
for child in kids:
    print(child.tag)
    #name
	#members
	#albums
    print(child.text)
    #여자친구
    
    if child.tag=='name':
        gname=child.text
    elif child.tag=='members':
        for xmember in child:
            members.append(xmember.text)
    elif child.tag=='albums':
        for xalbum in child:
            albums.append([xalbum.get('order'),xalbum.text])

print('girlgroup : %s' %gname)
print('member : ',end='')
for i,m in enumerate(members):
    print(m," ",end='')
print()
for album in albums:
    print(' %s : %s' %(album[0],album[1]))
#girlgroup : 여자친구
#member : 소원  예린  은하  유주  신비  엄지  
# EP 1집 : Season of Glass
# EP 2집 : Flower Bud
# EP 3집 : Snowflake
# 정규 1집 : LOL
```





### json 

```python
import json

path='usagov_bitly_data.txt'

records=[json.loads(line) for line in open(path,encoding='utf8')]
records    # list[{dict}] 형식
#[{'a': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) #Chrome/17.0.963.78 Safari/535.11',
#  'c': 'US',
#  'nk': 1,
#  'tz': 'America/New_York',
#  'gr': 'MA',
#  'g': 'A6qOVH',
#  'h': 'wfLQtf',
#  'l': 'orofrog',
#  'al': 'en-US,en;q=0.8',
#  'hh': '1.usa.gov',
#  'r': 'http://www.facebook.com/l/7AQEFzjSi/1.usa.gov/wfLQtf',
#  'u': 'http://www.ncbi.nlm.nih.gov/pubmed/22415991',
#  't': 1331923247,
#  'hc': 1331822918,
#  'cy': 'Danvers',
#  'll': [42.576698, -70.954903]},
# {'a': 'GoogleMaps/RochesterNY',
#  'c': 'US',
#  'nk': 0,
#......
records[0]['tz']
#'America/New_York'


### 'tz' column값이 있는 경우에만 timezone에 저장 후 출력
[rec['tz'] for rec in records if 'tz' in rec]

----------------------------------------------------------------------

### 'tz' column값의 data 갯수
timezone=[rec['tz'] for rec in records if 'tz' in rec]

## [방법 1] 함수 생성
def get_counts(seq):
    counts={}
    for x in seq:
        if x in counts:
            counts[x]+=1
        else: 
            counts[x]=1
    return counts
get_counts(timezone)
#{'America/New_York': 1251,
# 'America/Denver': 191,
# 'America/Sao_Paulo': 33,
# 'Europe/Warsaw': 16,
# '': 521,
# 'America/Los_Angeles': 382,
# 'Asia/Hong_Kong': 10,
# 'Europe/Rome': 27,
# 'Africa/Ceuta': 2,
#.....

counts=get_counts(timezone)
counts['America/New_York']
#1251


## [방법 2] collettions lib의 defaultdict()   -> 값을 0으로 초기화
from collections import defaultdict

def get_counts2(seq):
    counts=defaultdict(int)
    for x in seq:
        counts[x]+=1
    return counts
get_counts2(timezone)
#defaultdict(int,
#            {'America/New_York': 1251,
#             'America/Denver': 191,
#             'America/Sao_Paulo': 33,
#             'Europe/Warsaw': 16,
#             '': 521,
#             'America/Los_Angeles': 382,
#             'Asia/Hong_Kong': 10,
#             'Europe/Rome': 27,
#             'Africa/Ceuta': 2,
#.....

--------------------------------------------------------------------

### 가장 많이 등장하는 tz top10

## [방법 1] 함수 생성
def counts_top10(count_dict,n=10):
    count_pairs=[(count,tz) for tz,count in count_dict.items()]
    count_pairs.sort(reverse=True)
    return count_pairs[:10]
counts_top10(counts)
#[(1251, 'America/New_York'),
# (521, ''),
# (400, 'America/Chicago'),
# (382, 'America/Los_Angeles'),
# (191, 'America/Denver'),
# (74, 'Europe/London'),
# (37, 'Asia/Tokyo'),
# (36, 'Pacific/Honolulu'),
# (35, 'Europe/Madrid'),
# (33, 'America/Sao_Paulo')]


## [방법 2] collettions lib의 Counter()   -> 객체 안 요소 개수를 dict형태로 출력
from collections import Counter

******************************************************************
mylist=['a','c','d','a','b']
Counter(mylist)         
#Counter({'a': 2, 'c': 1, 'd': 1, 'b': 1})   # list형식은 바로 정렬

mydict={'가':3,'나':1,'다':5}
print(Counter(mydict))
#Counter({'다': 5, '가': 3, '나': 1})    # dict형식은 print()해야 정렬됨

c=Counter(a=3,b=1,c=5)
print(c)
#Counter({'c': 5, 'a': 3, 'b': 1})
sorted(c.elements())
#['a', 'a', 'a', 'b', 'c', 'c', 'c', 'c', 'c']
*******************************************************************

Counter(timezone).most_common(10)
#[('America/New_York', 1251),
#('', 521),
#('America/Chicago', 400),
# ('America/Los_Angeles', 382),
# ('America/Denver', 191),
# ('Europe/London', 74),
# ('Asia/Tokyo', 37),
# ('Pacific/Honolulu', 36),
# ('Europe/Madrid', 35),
# ('America/Sao_Paulo', 33)]


## [방법 3] pandas DataFrame 
import pandas as pd
from pandas import DataFrame, Series

frame=DataFrame(records)   # list[{dict}] -> DataFrame  ==>  key->column
frame['tz'].value_counts()[:10]
#America/New_York       1251
#                        521
#America/Chicago         400
#America/Los_Angeles     382
#America/Denver          191
#Europe/London            74
#Asia/Tokyo               37
#Pacific/Honolulu         36
#Europe/Madrid            35
#America/Sao_Paulo        33


## cf) nan 전처리 후 시각화
ctz=frame['tz'].fillna('missing')   # 1) nan 제거
ctz[ctz=='']='unknown'              # 2) ''  ->  unknown
ctz.value_counts()[:10]
#America/New_York       1251
#unknown                 521
#America/Chicago         400
#America/Los_Angeles     382
#America/Denver          191
#missing                 120
#Europe/London            74
#Asia/Tokyo               37
#Pacific/Honolulu         36
#Europe/Madrid            35

tzc=ctz.value_counts()
tzc[:10].plot(kind='barh')

---------------------------------------------------------------------

### ['a']의 os회사 이름 추출
res=[x.split()[0] for x in frame['a'].dropna()]   # nan 제거 후 split() -> list type 출력
Series(res).value_counts()   # list -> Series 후 value_counts()
#Mozilla/5.0                                          2594
#Mozilla/4.0                                           601
#GoogleMaps/RochesterNY                                121
#Opera/9.80                                             34
#TEST_INTERNET_AGENT                                    24
#GoogleProducer                                         21
#Mozilla/6.0                                             5
#BlackBerry8520/5.0.0.681                                4
#BlackBerry8520/5.0.0.592                                3
#.....

----------------------------------------------------------------------

### ['a']의 windows 요소 출력
cframe=frame[frame['a'].notnull()]

# contain() -> pat 혹은 정규식이 series/index의 str에 포함되어 있는지 판별
import numpy as np
myOs=np.where(cframe['a'].str.contains('Windows'),'Windows','Not Windows')
myOs
#array(['Windows', 'Not Windows', 'Windows', ..., 'Not Windows',
#       'Not Windows', 'Windows'], dtype='<U11')

---------------------------------------------------------------------

### 'tz', myOs에 따라 그룹화
tzos=cframe.groupby(['tz',myOs])
tzos.size().unstack().fillna(0)

```

