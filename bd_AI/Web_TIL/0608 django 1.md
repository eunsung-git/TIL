### django 설치 및 기본

```bash
## git bash  
# 가상환경 만들기
$ python -m venv venv

# 가상환경 활성화
$ source venv/Scripts/activate

# django package 설치
$ pip install django==2.2.13

# django project 생성
$ django-admin startproject 프로젝트명 경로
$ django-admin startproject intro .
# . -> 현재 폴더
# .. -> 상위 폴더
.
.
.
# vs code 실행
$ code .

# interpreter 설정
ctrl + shift + p  -> 만든 가상환경 선택

# server 실행
$ python manage.py runserver

# app 생성
$ python manage.py startapp app이름
$ python manage.py startapp pages

# app 등록
settings.py -> line 33 INSTALLED_APPS 에 추가

# language 설정
settings.py -> line 107 LANGUAGE_CODE 에 입력
```



```html
## pages/templates/
# html 작성
```



```python
## pages/views.py
# 함수 정의


## intro/urls.py
> from pages import views

line 19 urlpatterns
# path 추가
> path('주소창path', views.함수이름),
```

