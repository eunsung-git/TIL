from django.shortcuts import render, redirect
from .models import Article

# Create your views here.
def index(request):
    # 모든 database 조회
    articles = Article.objects.all()

    context = {
        'articles': articles,
    }
    return render(request, 'articles/index.html', context)

def new(request):  # GET -> render
     context = {
     }
     return render(request, 'articles/new.html', context)

def create(request):  # POST -> redirect
    title = request.POST.get('title')
    content = request.POST.get('content')
    # database에 저장
    # 1. Article instance 생성
    article = Article(title=title, content=content)
    # 2. 저장
    article.save()

    return redirect(f'/articles/detail/{article.pk}/')

def detail(request, pk):  # GET -> render
    # 원하는 database 조회
    article = Article.objects.get(pk=pk)

    context = {
        'article': article,
    }
    return render(request, 'articles/detail.html', context)

def delete(request, pk):  # POST -> redirect
    # database 삭제 (조회+삭제)
    # 1. 해당 data 조회
    article = Article.objects.get(pk=pk)
    # 2. data 삭제
    article.delete()

    return redirect('/articles/index/')

def edit(request, pk): # GET
    # database 조회
    article = Article.objects.get(pk=pk)

    context = {
        'article': article,
    }
    return render(request, 'articles/edit.html', context)

def update(request, pk): # POST
    title = request.POST.get('title')
    content = request.POST.get('content')
    # database 수정 (조회+수정)
    # 1. 해당 data 조회
    article = Article.objects.get(pk=pk)
    # 2. 해당 data 수정
    article.title = title
    article.content = content
    # 3. 수정된 data 저장
    article.save()

    return redirect(f'/articles/detail/{article.pk}/')