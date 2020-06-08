# 연습문제



#### 1231 파이썬9 스크래핑

Q1  다음(Daum)의 주가가 89,000원이고 네이버(Naver)의 주가가 751,000원이라고 가정하고, 어떤 사람이 다음 주식 100주와 네이버 주식 20주를 가지고 있을 때 그 사람이 가지고 있는 주식의 총액을 계산하는 프로그램을 작성하세요.





Q2 문제 2-1에서 구한 주식 총액에서 다음과 네이버의 주가가 각각 5%, 10% 하락한 경우에 손실액을 구하는 프로그램을 작성하세요.





Q3 우리나라는 섭씨 온도를 사용하는 반면 미국과 유럽은 화씨 온도를 주로 사용합니다. 화씨 온도(F)를 섭씨 온도(C)로 변환할 때는 다음과 같은 공식을 사용합니다. 
이 공식을 사용해 화씨 온도가 50일 때의 섭씨 온도를 계산해 보세요.

C = (F-32)/1.8



Q4 화면에 "pizza"를 10번 출력하는 프로그램을 작성하세요.

```python
a='pizza\n'
print(a*10)
```



Q5 월요일에 네이버의 주가가 100만 원으로 시작해 3일 연속으로 하한가(-30%)를 기록했을 때 수요일의 종가를 계산해 보세요.





Q6 다음 형식과 같이 이름, 생년월일, 주민등록번호를 출력하는 프로그램을 작성해 보세요. 이름: 파이썬 생년월일: 2014년 12월 12일 주민등록번호: 20141212-1623210





Q7 s라는 변수에 'Daum KaKao'라는 문자열이 바인딩돼 있다고 했을 때 문자열의 슬라이싱 기능과 연결하기를 이용해 s의 값을 'KaKao Daum'으로 변경해 보세요.

```python
s='Daum KaKao'
k=s[5:10]
d=s[0:5]
print(k+d)
```



Q8 a라는 변수에 'hello world'라는 문자열이 바인딩돼 있다고 했을 때 a의 값을 'hi world'로 변경해 보세요.





Q9 x라는 변수에 'abcdef'라는 문자열이 바인딩돼 있다고 했을 때 x의 값을 'bcdefa'로 변경해 보세요.





Q10 2015년 9월 초의 네이버 종가는 표 3.2와 같습니다. 09/07의 종가를 리스트의 첫 번째 항목으로 입력해서 naver_closing_price라는 이름의 리스트를 만들어보세요.

표 3.2 네이버 종가

날짜	요일	종가
09/11	금	488,500
09/10	목	500,500
09/09	수	501,000
09/08	화	461,500
09/07	월	474,500





Q11
문제 10에서 만든 naver_closing_price를 이용해 해당 주에 종가를 기준으로 가장 높았던 가격을 출력하세요. (힌트: 리스트에서 최댓값을 찾는 함수는 max()이고, 화면에 출력하는 함수는 print()입니다.)





Q12 문제 10에서 만든 naver_closing_price를 이용해 해당 주에 종가를 기준으로 가장 낮았던 가격을 출력하세요. (힌트: 리스트에서 최솟값을 찾는 함수는 min()이고, 화면에 출력하는 함수는 print()입니다.)





Q13 문제 10에서 만든 naver_closing_price를 이용해 해당 주에서 가장 종가가 높았던 요일과 가장 종가가 낮았던 요일의 가격 차를 화면에 출력하세요..





Q14
문제 10에서 만든 naver_closing_price를 이용해 수요일의 종가를 화면에 출력하세요.





Q15 문제 10의 표 3.2를 이용해 날짜를 딕셔너리의 키 값으로, 종가를 딕셔너리의 값으로 사용해 naver_closing_price2라는 딕셔너리를 만드세요.





Q16 문제 15에서 만든 naver_closing_price2 딕셔너리를 이용해 09/09일의 종가를 출력하세요.





Q17 중첩 루프를 이용해 신문 배달을 하는 프로그램을 작성하세요. 단, 아래에서 arrears 리스트는 신문 구독료가 미납된 세대에 대한 정보를 포함하고 있는데, 해당 세대에는 신문을 배달하지 않아야 합니다.

>>> apart = [[101, 102, 103, 104],[201, 202, 203, 204],[301, 302, 303, 304], [401, 402, 403, 404]]
>>> arrears = [101, 203, 301, 404]





Q18 두 개의 정수 값을 받아 두 값의 평균을 구하는 함수를 작성하세요.
def myaverage(a, b):

```python
def myaverage(a,b):
    return (a+b)/2

a=input()
b=input()

avg=myaverage(int(a),int(b))
print(avg)
```



Q19 함수의 인자로 리스트를 받은 후 리스트 내에 있는 모든 정수 값에 대한 최댓값과 최솟값을 반환하는 함수를 작성하세요.
def get_max_min(data_list):





Q20 절대 경로를 입력받은 후 해당 경로에 있는 *.txt 파일의 목록을 파이썬 리스트로 반환하는 함수를 작성하세요.
def get_txt_list(path):





Q21
체질량 지수(BMI; Body Mass Index)는 인간의 비만도를 나타내는 지수로서 체중과 키의 관계로 아래의 수식을 통해 계산합니다. 여기서 중요한 점은 체중의 단위는 킬로그램(kg)이고 신장의 단위는 미터(m)라는 점입니다.

BMI=체중(kg)신장(m)2
일반적으로 BMI 값에 따라 다음과 같이 체형을 분류하고 있습니다.

BMI <18.5, 마른체형
18.5 <= BMI < 25.0, 표준
25.0 <= BMI < 30.0, 비만
BMI >= 30.0, 고도 비만
함수의 인자로 체중(kg)과 신장(cm)을 받은 후 BMI 값에 따라 ‘마른체형’, ‘표준’, ‘비만’, ‘고도 비만’ 중 하나를 출력하는 함수를 작성하세요.

```python
def BMI(a,b):
    return a/(b**2)

kg=input()
m=input()


bmi=BMI(float(kg),float(m))

if bmi < 18.5:
    print('마른체형')
elif bmi >= 18.5 and bmi < 25.0:
    print('표준')
elif bmi >= 25.0 and bmi < 30.0:
    print('비만')
elif bmi >= 30.0:
    print('고도비만')
```







Q22 사용자로부터 키(cm)와 몸무게(kg)를 입력받은 후 BMI 값과 BMI 값에 따른 체형 정보를 화면에 출력하는 프로그램을 작성해 보세요. 파이썬에서 사용자 입력을 받을 때는 input 함수를 사용하며, 작성된 프로그램은 계속해서 사용자로부터 키와 몸무게를 입력받은 후 BMI 및 체형 정보를 출력해야 합니다(무한 루프 구조).





Q23 삼각형의 밑변과 높이를 입력받은 후 삼각형의 면적을 계산하는 함수를 작성하세요.

def get_triangle_area(width, height):

```python
def get_triangle_area(width, height):
    return (width*height)/2

width=input()
height=input()

a=get_triangle_area(int(width), int(height))
print(a)
```



Q24 함수의 인자로 시작과 끝을 나타내는 숫자를 받아 시작부터 끝까지의 모든 정수값의 합을 반환하는 함수를 작성하세요(시작값과 끝값을 포함).

def add_start_to_end(start, end):





Q25
함수의 인자로 문자열을 포함하는 리스트가 입력될 때 각 문자열의 첫 세 글자로만 구성된 리스트를 반환하는 함수를 작성하세요. 예를 들어, 함수의 입력으로 ['Seoul', 'Daegu', 'Kwangju', 'Jeju']가 입력될 때 함수의 반환값은 ['Seo', 'Dae', 'Kwa', 'Jej']입니다.







#### 0102 파이썬10 스크래핑2

Q1 다음의 조건을 만족하는 Point라는 클래스를 작성하세요.

Point 클래스는 생성자를 통해 (x, y) 좌표를 입력받는다.
setx(x), sety(y) 메서드를 통해 x 좌표와 y 좌표를 따로 입력받을 수도 있다.
get() 메서드를 호출하면 튜플로 구성된 (x, y) 좌표를 반환한다.
move(dx, dy) 메서드는 현재 좌표를 dx, dy만큼 이동시킨다.
모든 메서드는 인스턴스 메서드다.

```python
class Point():
    def __init__(self, x, y) : # 좌표 입력 시 자동으로 변수 생성
        self.x = x
        self.y = y
    def setx(self, x):
        self.x = x
    def sety(self, y) :
        self.y = y
    def get(self):
        return (self.x, self.y)
    def move(self, dx, dy):
        self.dx = dx
        self.dy = dy
        x = self.x + self.dx # 입력받은 dx, dy만큼 움직이는 메서드 
        y = self.y + self.dy
        return(x, y)
```



Q2 문제 2

문제 1에서 생성한 Point 클래스에 대한 인스턴스를 생성한 후 4개의 메서드를 사용하는 코드를 작성하세요.
p=Point(3,2)
p.get()
...
p.move(-3,-2) => 0,0

```python
p = Point(3,2)
print(p.get()) # 자동 변수 생성 확인

p.setx(6)
p.sety(3)
print(p.get()) # 각각 입력받은 변수 잘 돌아가는지 확인

res = p.move(2,-3)
print(res)
```





Q3 1부터 10까지의 숫자를 각 라인 단위로 파일에 출력하는 프로그램을 작성하세요.

생성되는 파일의 이름은 number.txt 이다.

```python
f=open('c:/da/number.txt','w')
for i in range(0,10):
    i+=1
    f.write(str(i)+'\n')
f.close()
```





Q4 사용자에게 경로를 입력받은 후 해당 경로에 있는 디렉터리와 파일 목록을 flist.txt라는 파일로 출력하는 함수를 작성하세요.

```python
import glob
# c:/Windows/*
data = input("경로를 입력해주세요") +'/*'
list(glob.glob(data))

f = open("flist.txt",'w')
for i in list(glob.glob(data)):
    f.write(i+'\n')
f.close()

```







Q5 윤동주 시인 방송 출연 년월일 추출(화요일 수업내용 중)

```python
from bs4 import BeautifulSoup
import urllib.request as req
import re

url='https://ko.wikipedia.org/wiki/%EC%9C%A4%EB%8F%99%EC%A3%BC'
res=req.urlopen(url)
soup=BeautifulSoup(res, 'html.parser')
p=soup.select('#mw-content-text > div > ul:nth-child(71)')
for a in p:
    day=a.text
    pat=re.compile('\d+[년]\s\d+[월]\s\d+[일]')
    print(pat.findall(day))
# ['1984년 12월 22일', '1988년 3월 1일', '1995년 3월 11일', '2006년 7월 31일', '2006년 8월 7일', '2009년 8월 15일', '2011년 11월 4일', '2016년 3월 6일']
```



Q6 영문, 숫자 포함하여 특수문자 모두 제거(오늘 수업내용 중)

res=req.urlopen(url)
soup=BeautifulSoup(res, 'html.parser')
#soup.title.string
title=soup.find("title").string

#wf태그값 추출
soup.find('wf').string

```python
from bs4 import BeautifulSoup
import urllib.request as req
import re

url='http://www.weather.go.kr/weather/forecast/mid-term-rss3.jsp'    
res=req.urlopen(url)
soup3=BeautifulSoup(res, 'html.parser')
q=soup3.find('wf')
for b in q:
    kor=b.string
    pat=re.compile('[가-힣]+')
    print(pat.findall(kor))
#['기압골의', '영향으로', '일부터', '일', '사이에', '전국에', '비', '또는', '눈이', '오겠고', '제주도는', '일에도', '비가', '오겠습니다', '한편', '동풍의', '영향으로', '일은', '강원영동에', '비', '또는', '눈이', '오겠습니다', '그', '밖의', '날은', '고기압의', '가장자리에', '들어', '가끔', '구름많겠습니다', '기온은', '평년', '최저기온', '최고기온', '보다', '높겠습니다', '강수량은', '평년', '보다', '많겠습니다']
```

----------------------------------------------



#### 0103 파이썬11 스크래핑3

Q1 파이썬 키워드에 대한 질문 추출

```python
url = "https://search.naver.com/search.naver?where=kin&sm=tab_jum&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC"
response = requests.get(url)
soup = BeautifulSoup(response.text,'html.parser')
​
# 페이지에서 질문 제목 추출
for link in soup.select("ul.type01 dt.question a"):
    print(link.text)
```

Q2 1페이지에 있는 질문 모두 추출

```python
url = "https://search.naver.com/search.naver?where=kin&sm=tab_jum&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC"
response = requests.get(url)
soup = BeautifulSoup(response.text,'html.parser')

# 페이지에 있는 각 질문 페이지로 가는 url 추출
links =[]
for link in soup.select('ul.type01 dt.question a'):
    links.append(link.attrs['href'])

# 각 질문 페이지로 가서 질문 추출
for link in links:
    response = requests.get(link)
    text = response.text
    soup = BeautifulSoup(text,'html.parser')
    print("\nQuestion\n")
    for x in soup.select("div.title"): # 질문 제목에서 질문 추출
        print(x.text)
    for x in soup.select("div.c-heading__content"): # 질문 본문에서 질문 추출
        print(x.text)
    print("="*40)
```



Q3 1~10 페이지에 있는 질문 모두 추출

```python
url = "https://search.naver.com/search.naver?where=kin&sm=tab_jum&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC"
response = requests.get(url)
soup = BeautifulSoup(response.text,'html.parser')

#총 질문 수 추출
num_sentence = soup.select_one("span.title_num").text
num = int(num_sentence[7:10]+num_sentence[11:14]) # 총 질문 수 str -> int
page_num = num//10 + 1 # 페이지 수 구하기


for i in range(10): #10페이지만 하니깐 range(10) 전체페이지하려면 page_num
    print("%d 페이지의 질문입니다."%(i+1))
    url = "https://search.naver.com/search.naver?where=kin&kin_display=10&qt=&title=0&&answer=0&grade=0&choice=0&sec=0&nso=so%3Ar%2Ca%3Aall%2Cp%3Aall&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC&c_id=&c_name=&sm=tab_pge&kin_start="+str(10*(i+1)+1)
    response = requests.get(url)
    text = response.text
    soup = BeautifulSoup(text,'html.parser')
    
    # 페이지에 있는 질문 10개의 url 저장
    links =[]
    for link in soup.select('ul.type01 dt.question a'):
        links.append(link.attrs['href'])
    
    # 각 질문의 질문과 답변 추출
    for link in links:
        response = requests.get(link)
        text = response.text
        soup = BeautifulSoup(text,'html.parser')
        
        # 질문 제목에 있는 것과 본문에 있는 것 모두 추출
        print("\nQuestion\n")
        for x in soup.select("div.title"):
            print(x.text)
        for x in soup.select("div.c-heading__content"):
            print(x.text)
        print("="*40)
```



Q4 1~10 페이지에 있는 질문/답변 모두 추출

```python
url = "https://search.naver.com/search.naver?where=kin&sm=tab_jum&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC"
response = requests.get(url)
soup = BeautifulSoup(response.text,'html.parser')

for i in range(10): 
    print("%d 페이지의 질문입니다."%(i+1))
    url = "https://search.naver.com/search.naver?where=kin&kin_display=10&qt=&title=0&&answer=0&grade=0&choice=0&sec=0&nso=so%3Ar%2Ca%3Aall%2Cp%3Aall&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC&c_id=&c_name=&sm=tab_pge&kin_start="+str(10*(i+1)+1)
    response = requests.get(url)
    text = response.text
    soup = BeautifulSoup(text,'html.parser')
    
    # 페이지에 있는 질문 10개의 url 저장
    links =[]
    for link in soup.select('ul.type01 dt.question a'):
        links.append(link.attrs['href'])
    
    # 각 질문의 질문과 답변 추출
    for link in links:
        response = requests.get(link)
        text = response.text
        soup = BeautifulSoup(text,'html.parser')
        
        # 질문 제목에 있는 것과 본문에 있는 것 모두 추출
        print("\nQuestion\n")
        for x in soup.select("div.title"):
            print(x.text)
        for x in soup.select("div.c-heading__content"):
            print(x.text)
        
        print("\nAnswer\n")
        i = 1 # 답변이 여러개 일때가 있어서 답변 구분용도
        for x in soup.select("div.se-main-container"):
            print("답변%d"%i)
            print(x.text)
            i += 1
        print("="*40)
```



Q5 추출한 전체 결과에 대해 '초보' 라는 단어가 등장한 횟수 출력

```python
url = "https://search.naver.com/search.naver?where=kin&sm=tab_jum&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC"
response = requests.get(url)
soup = BeautifulSoup(response.text,'html.parser')

total = 0 # '초보'단어가 나온 총 수
for i in range(10):
    url = "https://search.naver.com/search.naver?where=kin&kin_display=10&qt=&title=0&&answer=0&grade=0&choice=0&sec=0&nso=so%3Ar%2Ca%3Aall%2Cp%3Aall&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC&c_id=&c_name=&sm=tab_pge&kin_start="+str(10*(i+1)+1)
    response = requests.get(url)
    text = response.text
    soup = BeautifulSoup(text,'html.parser')
    
    links =[]
    for link in soup.select('ul.type01 dt.question a'):
        links.append(link.attrs['href'])

    for link in links:
        response = requests.get(link)
        text = response.text
        soup = BeautifulSoup(text,'html.parser')
        for x in soup.select("div.title"):
            c1 = len(re.findall('초보',x.text)) # 질문 제목에서 '초보'가 나온 횟수
        for x in soup.select("div.c-heading__content"):
            c2 = len(re.findall('초보',x.text)) # 질문 본문에서 '초보'가 나온 횟수
        for x in soup.select("div.se-main-container"):
            c3 = len(re.findall('초보',x.text)) # 답변에서 '초보'가 나온 횟수
        total += c1+c2+c3

print("'초보'라는 단어는 총%d번 나왔습니다."%total)
```



#### 0104 파이썬12 스크래핑종합

신문사(IT CHOSUN) '빅데이터' 기사 추출/수집

```python
from bs4 import BeautifulSoup
import requests
import urllib.request as req
import re

url = "http://it.chosun.com/svc/list_in/search.html?query=%EB%B9%85%EB%8D%B0%EC%9D%B4%ED%84%B0"
response = requests.get(url)
soup = BeautifulSoup(response.text,'html.parser')

for i in range(300): 
    print("\n%d page"% (i+1))
    url = "http://it.chosun.com/svc/list_in/search.html?query=%EB%B9%85%EB%8D%B0%EC%9D%B4%ED%84%B0&pn="+str(i+1)
    response = requests.get(url)
    text = response.text
    soup = BeautifulSoup(text,'html.parser')
    
    # 페이지에 있는 질문 10개의 url 저장
    links =[]
    for link in soup.select('ul.add_item_wrap > li > div.txt_wrap > a'):
        links.append(link.attrs['href'])
    
    # 각 질문의 질문과 답변 추출
    for link in links:
        response = requests.get(link)
        text = response.text
        soup = BeautifulSoup(text,'html.parser')
        
        # 질문 제목에 있는 것과 본문에 있는 것 모두 추출
        print("\narticle\n")
        for x in soup.select("h1#news_title_text_id"):
            print(x.text)
        for x in soup.select("div.par"):
            print(x.text)
        
```



#### 0106 데이터 분석1 numpy, pandas

1. 다음 행렬과 같은 행렬이 있다.

m = np.array([[ 0,  1,  2,  3,  4],
              [ 5,  6,  7,  8,  9],
              [10, 11, 12, 13, 14]])
이 행렬에서 값 7 을 인덱싱한다.
이 행렬에서 값 14 을 인덱싱한다.
이 행렬에서 배열 [6, 7] 을 슬라이싱한다.
이 행렬에서 배열 [7, 12] 을 슬라이싱한다.
이 행렬에서 배열 [[3, 4], [8, 9]] 을 슬라이싱한다.

```python
import numpy as np
m = np.array([[ 0,  1,  2,  3,  4],
              [ 5,  6,  7,  8,  9],
              [10, 11, 12, 13, 14]])

# 이 행렬에서 값 7 을 인덱싱한다. 
m[1,2]
# 이 행렬에서 값 14 을 인덱싱한다.
m[2,4]
# 이 행렬에서 배열 [6, 7] 을 슬라이싱한다.
m[1,[1,2]]
# 이 행렬에서 배열 [7, 12] 을 슬라이싱한다.
m[[1,2],2]
# 이 행렬에서 배열 [[3, 4], [8, 9]] 을 슬라이싱한다.
m[0:2,[3,4]]
```

2. 다음 행렬과 같은 배열이 있다.

x = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
              11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
1) 이 배열에서 3의 배수를 찾아라.
2) 이 배열에서 4로 나누면 1이 남는 수를 찾아라.
3) 이 배열에서 3으로 나누면 나누어지고 4로 나누면 1이 남는 수를 찾아라.

```python
import numpy as np
1) x[x%3==0]                      # array([ 3,  6,  9, 12, 15, 18])
2) x[x%4==1]                      # array([ 1,  5,  9, 13, 17])
3) 
a=x[x%3==0]
b=x[x%4==1]
def intersect(a, b):
    return list(set(a) & set(b))
intersect(a,b)                    # [9]
```

3. a=[3,1,-2,2,1,-3,-2,0,-7]  연속으로 숫자 3개를 곱했을 때 얻어진 결과값이 가장 큰 구간

```python
a=[3,1,-2,2,1,-3,-2,0,-7]

list=[]
for i in range(0,7):
    sum=a[i]*a[i+1]*a[i+2]
    list.append(sum)

maxValue = list[0]
for i in range(1, len(list)):
    if maxValue < list[i]:
        maxValue = list[i]
print(maxValue)
# 6
```

4. b=[[3,1,-2], [2,1,-3], [-2,0,-7]]  숫자 2*2 영역을 구성하는 수를 곱했을 때 얻어진 결과값이 가장 큰 구간

```python
b=[[3,1,-2],[2,1,-3],[-2,0,-7]]
# 소스코드 참고
```

5. 





#### 0107 데이터 분석2 pd.DataFrame

1 zoo data 

```python
# 1.
# 변수명을 위한 col_name list 생성
col_name = np.array(["animal_name", "hair", "feathers", "eggs", "milk", "airborne", "aquatic", "predator", "toothed", "backbone", "breathes", "venomous", "fins", "legs", "tail", "domestic", "catsize", "type"])
# zoo.data 불러오면서 변수명 할당하기
zoo = pd.read_csv("zoo.data", header = None, names=col_name)
zoo

# header는 있고, row_name은 없이 저장
zoo.to_csv('zoo_name.csv', index=False)

-----------------------------------
2. reindex

# 2.
# 0~100사이의 값 중 10 단위로 출력
zoo.reindex(index = range(0,101, 10))

-----------------------------------
3. 결측값을 임의로 추가 -> 결측값 처리 연습

# 3.
# 마지막 부분에 결측값 4개 추가
zoo.reindex(index = list(range(105)))

# 결측값 NA로 채우기
zoo.reindex(index = list(range(105)), fill_value="NA")

# 결측값 forward 방식으로 채우기
zoo.reindex(index = list(range(105)), method="ffill")
```



#### 0108 데이터 분석3 DataFrame 병합

1 df1 ~ df3 merge(위아래)

```python
import pandas as pd
from pandas import DataFrame

data1=pd.read_csv('concat_1.csv')
data2=pd.read_csv('concat_2.csv')
data3=pd.read_csv('concat_3.csv')

data12=pd.concat([data1,data2])
data23=pd.concat([data2,data3])

data=pd.concat([data12,data23])
data
```

2 1을 how, axis 값 변경하여 test

```python
import pandas as pd
from pandas import DataFrame

data1=pd.read_csv('concat_1.csv')
data2=pd.read_csv('concat_2.csv')
data3=pd.read_csv('concat_3.csv')

data12=pd.concat([data1,data2])
data23=pd.concat([data2,data3])

data=pd.concat([data12,data23])
#data

data_a1=pd.concat([data12,data23],axis=1)
#data_a1

data_in=pd.concat([data12,data23],join='inner')
#data_in

data_out=pd.concat([data12,data23],join='outer')
#data_out
```

```python
import pandas as pd
from pandas import DataFrame

data1=pd.read_csv('concat_1.csv')
data2=pd.read_csv('concat_2.csv')
data3=pd.read_csv('concat_3.csv')

data12=pd.merge(data1,data2,how='outer')
data23=pd.merge(data2,data3,how='outer')

data_out=pd.merge(data12,data23,how='outer')
#data_out

data_in=pd.merge(data12,data23,how='inner')
#data_in

data_l=pd.merge(data12,data23,how='left')
#data_l

data_r=pd.merge(data12,data23,how='right')
#data_r
```

3 ignore_index 적용

```python
import pandas as pd
from pandas import DataFrame

data1=pd.read_csv('concat_1.csv')
data2=pd.read_csv('concat_2.csv')
data3=pd.read_csv('concat_3.csv')

data12=pd.concat([data1,data2])
data23=pd.concat([data2,data3])

data_ig=pd.concat([data12,data23],ignore_index=True)
#data_ig

data_a1_ig=pd.concat([data12,data23],axis=1,ignore_index=True)
#data_a1_ig

data_k=pd.concat([data12,data23],keys=['data_12','data_23'])
#data_k

data_k_n=pd.concat([data12,data23],keys=['data_12','data_23'],names=['concat12','concat23'])
#data_k_n
```

4 merge() / join()

```python
import pandas as pd
from pandas import DataFrame

data1=pd.read_csv('concat_1.csv')
data2=pd.read_csv('concat_2.csv')
data3=pd.read_csv('concat_3.csv')

data12=pd.merge(data1,data2,how='outer')
data23=pd.merge(data2,data3,how='outer')

data_l_on=pd.merge(data12,data23,how='left',on='A')
#data_l_on

data_r_on=pd.merge(data12,data23,how='right',on='A')
#data_r_on

data_out_on=pd.merge(data12,data23,how='outer',on='A')
#data_out_on

data_out_on_idc=pd.merge(data12,data23,how='outer',on='A',indicator='idc_info')
#data_out_on_idc

data_on_suf=pd.merge(data12,data23,on='A',suffixes=('_a','_aa'))
#data_on_suf

data_ind=pd.merge(data12,data23,left_index=True, right_index=True)
#data_ind
```

5 survey 파일 merge 연습 -   survey_site/survey_visited 에 left_on, right_on 적용

```python
import pandas as pd
from pandas import DataFrame

person=pd.read_csv('survey_person.csv')
site=pd.read_csv('survey_site.csv')
survey=pd.read_csv('survey_survey.csv')
visited=pd.read_csv('survey_visited.csv')

survey_sv=pd.merge(site,visited,left_on='name',right_on='site')
#survey_sv
```



#### 0109 데이터분석4 병합응용, 결측값처리

Q1 A사무실에는 특정일자의 출퇴근 시간이 기록된 거대한 로그파일이 있다고 한다.
파일의 형식은 다음과 같다. (한 라인에서 앞부분은 출근시간(HH:MM:SS), 뒷부분은 퇴근시간이다)
09:12:23 11:14:35
10:34:01 13:23:40
10:34:31 11:20:10
특정시간을 입력(예:11:05:20)으로 주었을 때 그 시간에 총 몇 명이 사무실에 있었는지 알려주는 함수를 작성하시오.







Q2 DashInsert 함수는 숫자로 구성된 문자열을 입력받은 뒤, 문자열 내에서 홀수가 연속되면 두 수 사이에 - 를 추가하고, 짝수가 연속되면 * 를 추가하는 기능을 갖고 있다. 
(예, 454 => 454, 4546793 => 454*67-9-3)
DashInsert 함수를 완성하자.

입력 - 화면에서 숫자로 된 문자열을 입력받는다.
4546793
출력 - *, -가 적절히 추가된 문자열을 화면에 출력한다.
454*67-9-3





#### 0113  데이터분석5 결측값처리2,중복처리,표준화

1 NumPy를 사용하여 다음과 같은 행렬을 만든다.

10 20 30 40
50 60 70 80

```python
import numpy as np
arr=np.arange(8).reshape(2,4)
(arr+1)*10
#array([[10, 20, 30, 40],
#       [50, 60, 70, 80]])
```



2 2. 다음 행렬과 같은 행렬이 있다.

m = np.array([[ 0,  1,  2,  3,  4],
              [ 5,  6,  7,  8,  9],
              [10, 11, 12, 13, 14]])
이 행렬에서 값 7 을 인덱싱한다.
이 행렬에서 값 14 을 인덱싱한다.
이 행렬에서 배열 [6, 7] 을 슬라이싱한다.
이 행렬에서 배열 [7, 12] 을 슬라이싱한다.
이 행렬에서 배열 [[3, 4], [8, 9]] 을 슬라이싱한다.

```python
m[1][2]
m[2][4]
m[1,1:3]
m[1:,2]
m[:2,3:]
```



3 다음 행렬과 같은 배열이 있다.

x = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
              11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
이 배열에서 3의 배수를 찾아라.
이 배열에서 4로 나누면 1이 남는 수를 찾아라.
이 배열에서 3으로 나누면 나누어지고 4로 나누면 1이 남는 수를 찾아라.

```python
x[x%3==0]
x[x%4==1]
x[(x%3==0) & (x%4==1)]
```



4 타이타닉 데이터셋에서 Age , sibsp, parch, fare 컬럼에 대해 표준화 하시오.
-누락값에 대해서는 Age열은 평균 나이로 대체,
-sibsp는 최대값으로 대체
-parch는 최소값으로 대체
-fare는 평균 요금으로 대체



```python

```

#### 0123

1 부터 9까지의 연속된 수를 + 나 - 를 사용하여 합계가 100이 되는 전체 수를 구하시오.

ex) 1 + 2 + 3 - 4 + 5 + 6 + 78 + 9 = 100

```python
num = [list('123456789')]
for i in range(1, 16, 2) :
    res = list()
    for n in num :
        res.append(n[:i]+['+']+n[i:])
        res.append(n[:i]+['-']+n[i:])
        res.append(n[:i]+['']+n[i:])
    num = res.copy() # num에 모든 경우의 수 저장

# 계산 결과 100이 되는 경우만 ans에 저장
answer = list()
for form in num :
    if eval(''.join(form)) == 100 :
        answer.append(''.join(form))

print('총', len(answer), '개') # 총 갯수
print('식 :')
for ans in answer :
    print(ans) # 100을 만족하는 식
    
#총 11 개
#식 :
#1+2+3-4+5+6+78+9
#1+2+34-5+67-8+9
#1+23-4+5+6+78-9
#1+23-4+56+7+8+9
#12+3+4+5-6-7+89
#12+3-4+5+67+8+9
#12-3-4+5-6+7+89
#123+4-5+67-89
#123+45-67+8-9
#123-4-5-6-7+8-9
#123-45-67+89
```



