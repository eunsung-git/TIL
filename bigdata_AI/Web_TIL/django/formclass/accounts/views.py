from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, UserChangeForm, PasswordChangeForm
from django.contrib.auth import login as auth_login, logout as auth_logout
from .forms import CustomUserChangeForm, ProfileForm
from django.contrib.auth import update_session_auth_hash
from .models import Profile
from django.contrib.auth.decorators import login_required
from django.contrib.auth import get_user_model

# Create your views here.

def signup(request):
    # if login-ing, return index
    if request.user.is_authenticated:
        return redirect('articles:index')

    if request.method == "POST":
        # user 생성
        # 1. data를 form에 넣기
        form = UserCreationForm(request.POST)
        profile_form = ProfileForm(request.POST, request.FILES)
        # 2. 유효성 검사
        if form.is_valid() and profile_form.is_valid():
            # 3. 유효하다면 data 저장
            user = form.save()
            profile = profile_form.save(commit=False)
            profile.user = user
            profile.save()
            # profile 생성
            # Profile.objects.create(user=user)
            # 3-1. 회원가입 후, 바로 로그인
            auth_login(request, user)
            # 4. 저장 결과 확인
            return redirect('articles:index')

    else:
        # user 생성 form 보여주기
        form = UserCreationForm()
        # profile 생성 form 보여주기
        profile_form = ProfileForm()
    context = {
        'form': form,
        'profile_form': profile_form,
    }
    return render(request, 'accounts/signup.html', context)

def login(request):
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
             #/articles/new/
            return redirect(request.GET.get('next') or 'articles:index')

    else:
        # user 로그인 페이지 보여주기
        form = AuthenticationForm()
    context = {
        'form': form,
    }
    return render(request, 'accounts/login.html', context)

def logout(request): # POST
    if request.method == 'POST':
        # logout
        auth_logout(request)
    return redirect('articles:index')

def delete(request):  #POST
    # if not login-ing, return index
    if not request.user.is_authenticated:
        return redirect('articles:index')

    # user 삭제
    if request.method == 'POST':
        request.user.delete()
    return redirect('articles:index')

def edit(request):
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

def password(request):
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

@login_required
def profile_detail(request):
    # 1:n - user.comment_set / comment.user
    # 1:1 - user.profile / profile.user
    profile = request.user.profile
    context = {
        'profile': profile,
    }
    return render(request, 'accounts/profile_detail.html', context)

@login_required
def profile_edit(request):
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

def profile(request, username):
    # user:profile = 1:1
    # 1. profile.user.username
    profile = Profile.objects.get(user__username=username)
    # 2. user.profile
    # profile = get_user_model().objects.get(username=username).profile
    context = {
        'profile': profile,
    }
    return render(request, 'accounts/profile_detail.html', context)