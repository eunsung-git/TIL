from django.contrib import admin
from .models import Member

class MemberAdmin(admin.ModelAdmin):
	list_display = ('pk','password','gender','clothes',)

# Register your models here.
admin.site.register(Member, MemberAdmin)