from django.shortcuts import render, redirect
from .models import Article, Comment
from .forms import ArticleForm, CommentForm
from django.contrib.auth.decorators import login_required

# Create your views here.
def index(request):
    articles = Article.objects.all()
    context = {
        'articles': articles,
    }
    return render(request, 'articles/index.html', context)

@login_required  # 로그인 검증 메소드
def new(request):
    if request.method =='POST':
        # database에 저장
        # 1. data 불러오기
        # title = request.POST.get('title')
        # content = request.POST.get('content')
        # image = request.FILES.get('image')
        form = ArticleForm(request.POST, request.FILES)

        # 2-1. data 유효성 검사
        if form.is_valid():
            # (ModelForm) 2-2. data 저장
            article = form.save(commit=False)
            article.user = request.user # (= article.user_id = request.user.pk)
            article.save()

            # # 2-2. 검증된 data 불러오기
            # title = form.cleaned_data.get('title')
            # content = form.cleaned_data.get('content')
            # # 2-3. data 저장
            # article = Article(title=title, content=content)
            # article.save()

            # 3. 저장된 data 확인
            return redirect('articles:detail', article.pk)

    else: # 'GET'
        # 작성 양식 보여주기
        form = ArticleForm()
    context = {
        'form': form,
    }
    return render(request, 'articles/new.html', context)


def detail(request, pk):  # urls.py의 path에서 쓰는 변수 추가
    # 1. pk에 해당하는 data 불러오기
    article = Article.objects.get(pk=pk)

    # 댓글작성 양식 불러오기
    comment_form = CommentForm()

    context = {
        'article': article,
        'comment_form': comment_form,
    }
    return render(request, 'articles/detail.html', context)

@login_required
def delete(request, pk):  # POST
    article = Article.objects.get(pk=pk)

    if request.user != article.user:
        return redirect('article:detail', article.pk)

    if request.method == 'POST':
        article.delete()
    return redirect('articles:index')

@login_required
def edit(request, pk):
    # 1. data 불러오기
    article = Article.objects.get(pk=pk)

    if request.user != article.user:
        return redirect('article:detail', article.pk)
    
    if request.method == 'POST':
        # data 수정
        # (ModelForm) 2-1. form에 data 집어넣기 (검증) + instance와 연결
        form = ArticleForm(request.POST, instance=article)

        # # 2-1. form에 data 집어넣기 (검증)
        # form = ArticleForm(request.POST)
        
        # 2-2. form에서 data 유효성 검사
        if form.is_valid():
            # (ModelForm) 2-3. data 저장
            article = form.save()

            # # 2-3. data 저장
            # article.title = form.cleaned_data.get('title')
            # article.content = form.cleaned_data.get('content')
            # article.save()

            # 3. 저장된 data 확인
            return redirect('articles:detail', article.pk)

    else:
        # data 수정 폼 보여주기
        # (ModelForm) 2. form에 data 넣기
        form = ArticleForm(instance=article)

        # # 2. form에 data 넣기
        # form = ArticleForm(initial=article.__dict__)
    
    context = {
        'form': form,
    }
    return render(request, 'articles/edit.html', context)

@login_required
def comments_new(request, article_pk):  # POST
    # 1. 요청이 POST인지 점검
    if request.method == 'POST':
        # 2. Form에 data 넣기 (유효성 검사)
        form = CommentForm(request.POST)
        # 3. 유효성 검사 시행
        if form.is_valid():
            # 4. data 저장
            comment = form.save(commit=False)
            # 4-1. article 정보 넣기
            comment.article_id = article_pk
            # 4-2. user 정보 넣기
            comment.user = request.user
            comment.save()
    # 5. 생성된 댓글 확인
    return redirect('articles:detail', article_pk)

@login_required
def comments_delete(request, article_pk, pk):  # POST
    # 2. pk로 삭제하려는 data 불러오기
    comment = Comment.objects.get(pk=pk)

    if request.user != comment.user:
        return redirect('article:detail', comment.article.pk)

    # 1. 요청이 POST인지 점검
    if request.method == 'POST':
        # 3. 삭제
        comment.delete()
    # 4. 삭제 확인
    return redirect('articles:detail', article_pk)

@login_required
def comments_edit(request, article_pk, pk):  # GET, POST
    # 수정할 data 가져오기
    comment = Comment.objects.get(pk=pk)

    if request.user != comment.user:
        return redirect('article:detail', comment.article.pk)
 
    # 요청이 POST인지 GET인지 점검
    if request.method == 'POST':
        # 수정
        # 1. form에 data 넣기
        form = CommentForm(request.POST, instance=comment)
        # 2. 유효성 검사
        if form.is_valid():
            # 3. data 저장
            comment = form.save()
            # 4. 수정된 댓글 확인
            return redirect('articles:detail', article_pk)

    else:
        # 수정 폼 보여주기
        # 1. form class 초기화(생성)
        form = CommentForm(instance=comment)


    
    context = {
        'form': form,
    }
    return render(request, 'articles/comments_edit.html', context)

def like(request, pk):
    user = request.user
    article = Article.objects.get(pk=pk)
    if request.method == 'POST':
        if user in article.like_users.all():
            article.like_users.remove(user)
        else:
            article.like_users.add(user)

    return redirect('articles:detail', pk)