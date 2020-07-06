### django 기능s

#### 0622 image 업로드

```python
해당 app 폴더 안에 static 폴더 생성 후 이미지 파일들 저장

```



```html
해당 html에 {% load static%} 추가
<img src="{% static 'static folder로부터의 상대경로' %}" alt="">


```



##### db에 img 저장

```python
models.py 에서 해당 모델의 class 속성에
> image = models.ImageField(blank=True) 추가

> pip install pillow 설치 후

> python manage.py makemigrations
> python manage.py migrate


해당 app의 forms.py에서
해당 model의 Meta class field 속성에 'image' 추가
> fields = ('title', 'content', 'image',)

해당 html 파일의 form tag에
enctype="multipart/form-data" 추가

views.py 에서 해당 함수의 form에
> form = ArticleForm(request.POST, request.FILES) 수정

settings.py 마지막에
> MEDIA_ROOT = os.path.join(BASE_DIR, 'media') 경로 추가
> MEDIA_URL = '/media/' 추가

전체 project urls.py 에서
> from django.conf import settings
> from django.conf.urls.static import static
> urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) 추가

---------------------------
# 이미지 가공 기능 추가

> pip install pilkit django-imagekit 

settings.py line 33 에서
INSTALLED_APPS에 'imagekit', 추가

models.py에서
> from imagekit.models import ProcessedImageField
> from imagekit.processors import Thumbnail  추가

해당 model class의
image = models.ImageField(blank=True)   -> image = ProcessedImageField(
        blank=True,
        processors=[Thumbnail(300,300),], # 가공 종류
        format='JPEG', # 확장자
        options={'quality':90,} # 확장자 옵션
        )  변경

> python manage.py makemigrations
> python manage.py migrate

--------------------------
 
## django Fixtures
# 파일 일괄 가져오기
> python manage.py dumpdata app이름.model이름 --indent=2 > article.json 

# 파일 일괄 업로드
> python manage.py loaddata article.json

# csv -> fixtures
# https://hpy.hk/c2f 코드 참고

```



#### 0623 로그인 / 회원가입

##### -회원가입

```python
## user create form 만들기
해당 app views.py에 
> from django.contrib.auth.forms import UserCreationForm  추가

해당 함수
> def signup(request):
    if request.user.is_authenticated:
        return redirect('articles:index')

    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            auth_login(request, user)
            return redirect('articles:index')

    else:
        form = UserCreationForm()
    context = {
        'form': form,
    }
    return render(request, 'accounts/signup.html', context)

```

```html
해당 html
<form action="" method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <input type="submit" value="SignUp">
</form>
```



##### -로그인

```python
해당 app views.py에 
> from django.contrib.auth.forms import UserCreationForm, AuthenticationForm   추가
> from django.contrib.auth import login as auth_login 추가 

해당 함수
> def login(request):
    # if login-ing, return index
    if request.user.is_authenticated:
        return redirect('articles:index')

    if request.method == 'POST':
        # user 검증 + login
        # 1. data를 form에 넣기
        form = AuthenticationForm(request, request.POST)
        # 2. 유효성 검사
        if form.is_valid():
            # 3. 유효하다면 login
            user = form.get_user()
            auth_login(request, user)
            # 4. login 결과 확인
            return redirect('articles:index')

    else:
        # user 로그인 페이지 보여주기
        form = AuthenticationForm()
    context = {
        'form': form,
    }
    return render(request, 'accounts/login.html', context)

```



##### -상태 확인

```html
base.html 파일에

<nav>
        {% if user.is_authenticated %}
            <span>{{ user.username }}</span>
            <a href="{% url 'accounts:edit' %}">회원정보수정</a>
             <form action="{% url 'accounts:logout' %}" method="POST">
                {% csrf_token %}
                <input type="submit" value='Logout'>
            </form>
            <form action="{% url 'accounts:delete' %}" method="POST">
                {% csrf_token %}
                <input type="submit" value="Withdrawal">
            </form>
        {% else %}
            <a href="{% url 'accounts:login' %}">Login</a>
            <a href="{% url 'accounts:signup' %}">Signup</a>
        {% endif%}

    </nav>

추가
```



##### -로그아웃

```python
해당 app views.py에 
> from django.contrib.auth import login as auth_login, logout as auth_logout 추가

해당 함수
> def logout(request): # POST
    if request.method == 'POST':
        # logout
        auth_logout(request)
    return redirect('articles:index')

```



##### -회원 탈퇴

```python
해당 함수
> def delete(request):  #POST
    # if not login-ing, return index
    if not request.user.is_authenticated:
        return redirect('articles:index')

    # user 삭제
    if request.method == 'POST':
        request.user.delete()

    return redirect('articles:index')
```

```html
base.html에
<form action="{% url 'accounts:delete' %}" method="POST">
                {% csrf_token %}
                <input type="submit" value="Withdrawal">
            </form>
추가

```



##### -회원 정보 수정

```python
해당 app views.py에 
> from django.contrib.auth.forms import UserCreationForm,AuthenticationForm, UserChangeForm  추가
> from .forms import CustomUserChangeForm 추가

해당 함수
> def edit(request):
    user = request.user
    if request.method == 'POST':
        # user update
        # 1. data를 form에 넣기
        form = CustomUserChangeForm(request.POST, instance=user)
        # 2. 유효성 검사
        if form.is_valid():
            # 3. 유효하다면, 저장
            form.save()
            # 4. update 결과 페이지
            return redirect('articles:index')
    else:
        # update form 보여주기
        form = CustomUserChangeForm(instance=user)
    context = {
        'form': form,
    }
    return render(request, 'accounts/edit.html', context)



## 새로운 form 생성
해당 app 폴더에 forms.py 생성 후
> from django import forms
> from django.contrib.auth.forms import UserChangeForm  
> from django.contrib.auth import get_user_model
입력

해당 class
> class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = get_user_model()  # auth.user
        fields = ('username','email','first_name','last_name',)

```

```html
edit.html

<form action="" method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <input type="submit" value="Update">
</form>

```



##### 비밀번호 수정

```python
해당 app views.py에 
> from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, UserChangeForm, PasswordChangeForm 추가

해당 함수
> def password(request):
    user = request.user
    if request.method == 'POST':
        # password 변경
        # 1. data에 form 넣기
        form = PasswordChangeForm(user, request.POST)
        # 2. 유효성 검사
        if form.is_valid():
            # 3. 유효하다면, 저장
            user = form.save()
            # 3-1. 저장 후, login 세션 유지
            update_session_auth_hash(request, user)
            # 4. 보내기
            return redirect('accounts:edit')
    else:
        # password update form 보여주기
        form = PasswordChangeForm(user)
    context = {
        'form': form,
    }
    return render(request, 'accounts/password.html', context)

```

```html
password.html

<form action="" method="POSt">
    {% csrf_token %}
    {{ form.as_p }}
    <input type="submit" value="Update P">
</form>
```



#### 0624 권한 설정

```python
### 메소드
해당 app views.py에서
> from django.contrib.auth.decorators import login_required 추가

# 로그인 검증
해당 함수 위에 
@login_required 추가  

```



#### 0625 프로필

```python
해당 app models.py에 새로운 class 추가
> from imagekit.models import ProcessedImageField
> from imagekit.processors import Thumbnail
> from django.conf import settings

> class Profile(models.Model):
    nickname = models.CharField(max_length=20, blank=True)
    image = ProcessedImageField(
        blank=True,
        processors=[Thumbnail(300,300),],
        format='png',)
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)

# 프로필+회원가입
해당 app views.py의 회원가입 함수 수정
> user = form.save() 밑에 
Profile.objects.create(user=user) 추가

> from .models import Profile 추가

새로운 profile 함수 추가
> def profile_detail(request):
    # 1:n - user.comment_set / comment.user
    # 1:1 - user.profile / profile.user
    profile = request.user.profile
    context = {
        'profile': profile,
    }
    return render(request, 'accounts/profile_detail.html', context)

```

```html
profile_detail.html

<a href="{% url 'accounts:profile_edit' %}">Edit</a>

<p>{{ profile.nickname }}</p>
{% if profile.image %}
    <p><img src="{{ profile.image.url }}" alt="profile image"></p>
{% endif %}
<a href="{% url 'accounts:edit' %}">회원정보수정</a>
```



##### 프로필 수정

```python
views.py
> from .forms import ProfileForm 추가

해당 함수 작성
> def profile_edit(request):
    # 1. 현재 로그인된 profile 가져오기
    profile = request.user.profile

    if request.method == 'POST':
        # profile update
        # 1.data를 form에 넣기
        form = ProfileForm(request.POST, request.FILES, instance=profile)
        # 2. 유효성 검사
        if form.is_valid():
            # 3. 저장
            form.save()
            # 4. 확인 페이지 안내
            return redirect('accounts:profile_detail')
     
    else:
        # 2. form에 profile 넣기
        form =  ProfileForm(instance=profile)
    context = {
        'form': form,
    }
    return render(request, 'accounts/profile_edit.html', context)


forms.py에서
> from .models import Profile
새로운 form 생성
> class ProfileForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ('nickname', 'image',)
        
```

```html
profile_edit.html

<form action="" method="POST" enctype="multipart/form-data">
    {% csrf_token %}
    {{ form.as_p }}
    <input type="submit" value="Update">
</form>
```



```html
base.html

<nav>
        {% if user.is_authenticated %}
            <a href="{% url 'accounts:profile_detail' %}">
                {{ user.username }}
            </a>
             <form action="{% url 'accounts:logout' %}" method="POST">
                {% csrf_token %}
                <input type="submit" value='Logout'>
            </form>
            
        {% else %}
            <a href="{% url 'accounts:login' %}">Login</a>
            <a href="{% url 'accounts:signup' %}">Signup</a>
        {% endif%}
```

```html
edit.html

<form action="" method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <input type="submit" value="Update">
</form>

<form action="{% url 'accounts:delete' %}" method="POST">
    {% csrf_token %}
    <input type="submit" value="Withdrawal">
</form>
```



##### 가입 항목 추가

```python
views.py에서
signup 함수 수정
> 

```

```html
signup.html


```

