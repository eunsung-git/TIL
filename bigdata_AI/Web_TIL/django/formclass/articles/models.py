from django.db import models
from imagekit.models import ProcessedImageField
from imagekit.processors import Thumbnail
from django.conf import settings

# Create your models here.

# user:Article = 1:N
# Artlcie:Comment = 1:N
# user:Comment = 1:N

class Article(models.Model):
    title = models.CharField(max_length=10)
    content = models.TextField()
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    like_users = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_articles', blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    # image = models.ImageField(blank=True)
    image = ProcessedImageField(
        blank=True,
        processors=[Thumbnail(300,300),], # 가공 종류
        format='JPEG', # 확장자
        options={'quality':90,} # 확장자 옵션
        )

class Comment(models.Model):
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    article = models.ForeignKey(Article, on_delete=models.CASCADE)
    
    # Article : Comment = 1:N
    # (부모) : (자식)
    
    # on_delete 옵션
    # 1. CASCADE - 부모가 삭제되면 자삭도 삭제
    # 2. PROTECT - 자식이 있으면 부모 삭제 불가
    # 3. SET_NULL - 부모가 삭제되면 자식의 FK에 null 할당
    # 4. SET_DEFAULT - 부모가 삭제되면 자식의 FK에 default값 할당
    # 5. DO_NOTHING - 아무것도 하지 않음

    # 게시판 댓글 달기
    # 1. Create
    # comment = Comment()
    # comment.content = '댓글기능추가'
    # comment.article = article (= comment.article_id = 1)
    # comment.save()

    # 2. Read
    # 2-1. 게시글로부터 댓글 불러오기
    # article = Article.objects.get(pk=1)
    # comments = article.comment_set.all()
    # 2-2. 댓글 조건으로 불러오기
    # article = Article.objects.get(pk=1)
    # Comment.objects.filter(article_id=1) (= Comment.objects.filter(article=article) )

    # 3. 댓글로부터 게시물 불러오기
    # comment = Comment.objects.get(pk=1)
    # article = comment.article
    # article.title
    # article.content


# django Fixtures
# 1. dumpdata
# python manage.py dumpdata app이름.model이름 --indent=2 > article.json
# 2. loaddata
# python manage.py loaddata article.json
# 3. csv -> fixtures
# https://hpy.hk/c2f