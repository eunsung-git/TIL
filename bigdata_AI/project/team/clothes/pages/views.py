from django.shortcuts import render, redirect
# class 추가 시 from . import class이름

# Create your views here.
def main(request):
    return render(request, 'pages/main.html')

def recom(request):  # GET
    # mainpage form
    do = request.GET.get('do')
    si = request.GET.get('si')
    dong = request.GET.get('dong')
    gender = request.GET.get('gender')

    context = {
        'do': do, 'si': si, 'dong': dong, 'gender': gender,
    }
    
    return render(request, 'pages/recom.html')

def signup(request): # POST
    # 회원가입 페이지
    gender = request.POST.get('gender')
    id = request.POST.get('id')
    password = request.POST.get('password')


    return redirect('pages:signup')

def login_sel(request): # GET
    context = {

    }
    return render(request, 'pages/login_sel.html', context)

def non_sel(request): # GET
    context = {

    }
    return render(request, 'pages/non_sel.html', context)

def signup_comp(request): #POST
    return redirect('pages:signup_comp')

def tips(request):

    context = {

    }
    return render(request, 'pages/tips.html', context)
