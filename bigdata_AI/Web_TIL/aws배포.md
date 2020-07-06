# Deploy to AWS EC2 using Cloud9

## Table of Contents

* [1. Local (개인 컴퓨터)](##1-local-개인-컴퓨터)
    * [1.1. settings.py 분리](#11-settingspy-분리)
    * [1.2. python-decouple (.env)](#12-python-decouple-env)
    * [1.3. Project 복제](#13-project-복제)
    * [1.4. 새 GitHub Repo 생성 & Git Push](#14-새-github-repo-생성--git-push)
* [2. AWS Dashboard](#2-aws-dashboard)
    * [2.1. 회원가입](#21-회원가입)
    * [2.2. Cloud9 인스턴스 생성 및 실행](#22-cloud9-인스턴스-생성-및-실행)
    * [2.3. EC2 인스턴스 Port 열어주기](#23-ec2-인스턴스-port-열어주기)
* [3. AWS Cloud9 IDE](#3-aws-cloud9-ide)
    * [3.1. 환경 설정](#31-환경-설정)
    * [3.2. Project 설정](#32-project-설정)
    * [3.3. 웹 서버 설정 (Nginx)](#33-웹-서버-설정-nginx)
    * [3.4. 앱 서버 설정 (uWSGI)](#34-앱-서버-설정-uwsgi)
    * [3.5. 마무리](#35-마무리)
* [4. 코드 업데이트 반영하기](#4-코드-업데이트-반영하기)
    * [4.1. Commands](#41-commands)
    * [4.2. 자동화 스크립트 만들기](#42-자동화-스크립트-만들기)

---

## 1. Local (개인 컴퓨터)

### 1.1. settings.py 분리

- `settings` 폴더 생성 → 내부에 `__init__.py` 생성

- `settings.py` → `settings/base.py`

- `settings/base.py`
    - 현재 폴더에서 BASE_DIR까지 가기 위한 폴더가 하나 더 생겨서, BASE_DIR 위치를 한 단계 더 상위 폴더로 다시 잡아 준다.

    ```python
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    ```

- `settings/dev.py`

    ```python
    from .base import *

    SECRET_KEY = base.py 에 있는 SECRET_KEY line 

    DEBUG = True

    ALLOWED_HOSTS = []
    ```

- `settings/prod.py`

    ```python
    from .base import *

    SECRET_KEY = base.py 에 있는 SECRET_KEY line 

    DEBUG = True # 추후에 False로 변경 예정

    ALLOWED_HOSTS = [
        '.compute.amazonaws.com',
    ]

    STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
    ```

- `manage.py`
    - `.dev` 추가

    ```python
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', '{ProjectName}.settings.dev')
    ```

- `settings/wsgi.py`
    - `.prod` 추가

    ```python
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', '{ProjectName}.settings.prod')
    ```

### 1.2. python-decouple (.env)

- decouple 설치 &  project 가장 바깥에 .env 생성

  ```bash
  $ pip install python-decouple
  ```

- 숨겨야 하는 변수(값)들 숨기기

  ​	dev.py & prod.py 에

  ```python
  from decouple import config
  SECRET_KEY = config('SECRET_KEY')
  ```

### 1.3. Project 복제 

- `requirements.txt` 생성

    ```bash
    $ pip freeze > requirements.txt
    ```

- project 폴더 통째로 복제

### 1.4. 새 GitHub Repo 생성 & Git Push

- `venv` 제거 (`.git` 있으면 같이 제거)

- `.gitignore` 생성

    python gitignore txt 복사 후,  아래 추가

    ```bash
    # Python.gitignore
    # ...
    
    # VS Code
    .vscode
    
    # Django Media
    media/
    
    # Django Static
    staticfiles/
    
    # tmp & log
    tmp/
    log/
    
    # OS
    Thumbs.db
    ```

- GitHub Repo 생성

- git init, commit, remote add 

- 새로 만든 repository 주소 복사 후, 

    ```bash
    $ git remote add origin https://github.com/eunsung-git/TeamProject.git
    
    $ git push -u origin master
    ```

    

    


## 2. AWS Dashboard

### 2.1. 회원가입

### 2.2. Cloud9 인스턴스 생성 및 실행

다른 옵션 모두 default

- platform - Ubunto server

- Cost-saving setting - Never   로 변경

### 2.3. EC2 - 인스턴스 Port 열어주기

- 해당 cloud9의 보안 그룹 → `aws-cloud9-...` 작업 →  인바운드 규칙 편집
    - 규칙 추가
        - 유형: `HTTP`
        - 소스: `위치 무관`
    - 규칙 저장


## 3. AWS Cloud9 IDE

### 3.1. 환경 설정

- pyenv, pyenv-virtualenv

    ```bash
    $ git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    $ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    $ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    $ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
    $ exec "$SHELL"

    $ git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    $ echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
    $ exec "$SHELL"
    ```

- python

    ```bash
    $ pyenv install 3.7.6
    $ pyenv global 3.7.6
    ```

### 3.2. Project 설정

- Clone from GitHub

    ubuntu:~ 상태에서

    - 메뉴창 설정 - show favorites 어쩌구 

    - projectname folder - add to favorites

    ```bash
    $ git clone {GitHub Repo URL}
    $ cd {ProjectName}
    ```

    cf) (master) 안 뜨면 terminal 종료 후 다시 실행

    

- 가상환경 (virtualenv)

    ```bash
    $ pyenv virtualenv {ProjectName}-venv
    $ pyenv local {ProjectName}-venv
    ```

- Run pip install

    ```bash
    $ pip install -r requirements.txt
    ```

- Set setting module

    ```bash
    $ export DJANGO_SETTINGS_MODULE='{ProjectName}.settings.prod'
    ```

- 해당 project 바깥에 .env 만들고, SECRET_KEY 복사

- Databse migrate

    ```bash
    $ python manage.py migrate
    ```

- Collect staticfiles

    ```bash
    $ python manage.py collectstatic
    ```

### 3.3. 웹 서버 설정 (Nginx)

- Install

    ```bash
    $ sudo apt install -y nginx
    ```

- 80번 포트를 쓰고 있는 다른 웹 서버(apache) 종료 & nginx 시작

    ```bash
    $ sudo systemctl stop apache2
    $ sudo systemctl start nginx
    ```

- 설정 파일 편집

    - `{ProjectName}`: 본인 프로젝트의 이름(폴더명)

    ```bash
    $ sudo vi /etc/nginx/sites-enabled/default
    ```

    ```
    server_name *.compute.amazonaws.com;

    location / {
      uwsgi_pass unix:///home/ubuntu/{ProjectName}/tmp/{ProjectName}.sock;
      include uwsgi_params;
    }

    location /static/ {
      alias /home/ubuntu/{ProjectName}/staticfiles/;
    }
    ```

- 설정 오류 없는지 테스트

    ```bash
    $ sudo nginx -t
    ```

### 3.4. 앱 서버 설정 (uWSGI)

- Install

    ```bash
    $ pip install uwsgi
    ```

- 필요한 폴더들 생성

    ```bash
    $ mkdir tmp
    $ mkdir -p log/uwsgi
    $ mkdir -p .config/uwsgi
    ```

- `.config/uwsgi/{ProjectName}.ini`
    - `{ProjectName}`: 본인 프로젝트의 이름(폴더명)
    - `{VirtualenvName}`: 앞에서 생성한 가상환경 이름

    ```
    [uwsgi]
    chdir = /home/ubuntu/{ProjectName}
    module = {ProjectName}.wsgi:application
    home = /home/ubuntu/.pyenv/versions/{VirtualenvName}

    uid = ubuntu
    gid = ubuntu

    socket = /home/ubuntu/{ProjectName}/tmp/{ProjectName}.sock
    chmod-socket = 666
    chown-socket = ubuntu:ubuntu

    enable-threads = true
    master = true
    vacuum = true
    pidfile = /home/ubuntu/{ProjectName}/tmp/{ProjectName}.pid
    logto = /home/ubuntu/{ProjectName}/log/uwsgi/@(exec://date +%%Y-%%m-%%d).log
    log-reopen = true
    ```

- `.config/uwsgi/uwsgi.service`
    - `{ProjectName}`: 본인 프로젝트의 이름(폴더명)
    - `{VirtualenvName}`: 앞에서 생성한 가상환경 이름

    ```
    [Unit]
    Description=uWSGI Service
    After=syslog.target

    [Service]
    User=ubuntu
    ExecStart=/home/ubuntu/.pyenv/versions/{VirtualenvName}/bin/uwsgi -i /home/ubuntu/{ProjectName}/.config/uwsgi/{ProjectName}.ini

    Restart=always
    KillSignal=SIGQUIT
    Type=notify
    StandardError=syslog
    NotifyAccess=all

    [Install]
    WantedBy=multi-user.target
    ```

- 심볼릭 링크 생성
    - `{ProjectName}`: 본인 프로젝트의 이름(폴더명)

    ```bash
    sudo ln -s ~/{ProjectName}/.config/uwsgi/uwsgi.service /etc/systemd/system/uwsgi.service
    ```

- daemon 등록

    ```bash
    # daemon reload
    sudo systemctl daemon-reload

    # uswgi daemon enable and restart
    sudo systemctl enable uwsgi
    sudo systemctl restart uwsgi.service

    # check daemons
    sudo systemctl | grep nginx
    sudo systemctl | grep uwsgi

    # restart
    sudo systemctl restart nginx
    sudo systemctl restart uwsgi
    ```

### 3.5. 마무리

- 주소로 접속 후, 잘 나오는 지 확인
- `settings/prod.py`
    - Debug 모드 비활성화

    ```python
    DEBUG = False
    ```

- 서버 재시작

    ```bash
    $ sudo systemctl restart nginx
    $ sudo systemctl restart uwsgi
    ```


## 4. 코드 업데이트 반영하기

### 4.1. Commands

- Local 작업 내용을 배포된 서버에 반영하기 위한 commands

    ```bash
    $ git pull

    $ pip install -r requirements.txt

    $ export DJANGO_SETTINGS_MODULE='{ProjectName}.settings.prod'

    $ python manage.py migrate
    $ python manage.py collectstatic

    $ sudo systemctl restart nginx
    $ sudo systemctl restart uwsgi
    ```

### 4.2. 자동화 스크립트 만들기

- `tmp/up.sh`

    ```bash
    echo '>>> Git Pull'
    git pull

    echo '>>> Install Packages'
    pip install -r requirements.txt

    export DJANGO_SETTINGS_MODULE='{ProjectName}.settings.prod'

    echo '>>> Database Migrate'
    python manage.py migrate

    echo '>>> Collect Staticfiles'
    python manage.py collectstatic --noinput

    echo '>>> Restart Servers'
    sudo systemctl restart nginx
    sudo systemctl restart uwsgi
    ```

- 실행

    ```bash
    $ sh tmp/up.sh
    ```
