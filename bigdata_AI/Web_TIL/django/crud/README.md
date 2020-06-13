# CRUD

1. python 가상환경
```
python -m venv venv
```

2. python 가상환경 활성화
- Ctrl + Shift + p -> Select Interpreter -> 'venv' 선택
or
```
source venv/Scripts/activate
```

3. django 설치
```
pip install django==2.2.13
```

4. django project 생성
```
django-admin startproject crud .
```

5. django app 생성
```
python manage.py startapp articles
```

6. django app 등록
- settings.py -> INSTALLED_APPS 에 app 이름 추가

7. 언어/시간 설정
- settings.py -> LANGUAGE_CODE 에 'ko-kr' 입력
- settings.py -> TIME_ZONE 에 'Asia/Seoul' 입력

8. base.html 설정
- settings.py -> TEMPLATES -> DIRS
```
os.path.join(BASE_DIR, 'templates')
``` 
- 해당 app 폴더에 templates 폴더 생성
- templates/base.html 생성

9. urls.py 분리
- 해당 app -> urls.py 생성
- 기존 project 폴더 -> urls.py 에
```
from django.urls import path, include
# path('app이름/', include('app이름.urls')),
```




