from django.shortcuts import render

# Create your views here.
def index(request):
    hello = 'hello :)'
    lunch = '라면'
    context = {
        'hello':hello, 
        'l':lunch
    }
    return render(request, 'pages/index.html', context)

def hello(request, name):

    context = {
        'name': name
    }
    return render(request, 'pages/hello.html', context)

def multiple(request, num1, num2):
    result = num1 * num2
    context = {
        'num1': num1,
        'num2': num2,
        'result': result
    }
    return render(request, 'pages/multiple.html', context)

from datetime import datetime
def dtl(request):
    foods = ['짜장면','짬뽕','양장피']
    sentence = 'Life is short, you need python'
    fruits = ['apple','banana','cucumber','mango']
    datetimenow = datetime.now()
    empty_list = []

    context = {
        'foods': foods,
        'sentence': sentence,
        'fruits': fruits,
        'datetimenow': datetimenow,
        'empty_list': empty_list,
    }
    return render(request, 'pages/dtl.html', context)

def bday(request):
    # 1. today
    today = datetime.now()
    # 2. (month, day) 비교
    result = (today.month == 2 and today.day == 24)
    context = {
        'result': result
    }
    return render(request, 'pages/bday.html', context)

def throw(request):
    context = {

    }
    return render(request, 'pages/throw.html', context)

def catch(request):
    username = request.GET.get('username') # 'nwith'
    message = request.GET.get('message')  # dict type { 'message':'hello' }에서 'hi' 추출
    context  = {
        'username': username,
        'message': message,
    }
    return render(request, 'pages/catch.html', context)

def lotto(request):
    context = {

    }
    return render(request, 'pages/lotto.html', context)

import random
def generate(request):
    # number type으로 받았어도, int() 처리
    count = int(request.GET.get('count'))
    lotto_num = range(1,46)
    lottos = []
    for n in range(count):
        lottos.append(sorted(random.sample(lotto_num,6)))
    
    context = {
        'lottos': lottos,
    }
    return render(request, 'pages/generate.html', context)

def user_new(request):
    context = {

    }
    return render(request, 'pages/user_new.html', context)

def user_create(request):
    username = request.POST.get('username')
    pw = request.POST.get('pw')
    context = {
        'username': username,
        'pw': pw,
    }
    return render(request, 'pages/user_create.html', context)