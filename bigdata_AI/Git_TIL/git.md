# git

> git = 분산형버전관리시스템(DVS), 소스코드형상관리도구로, 
>
> ​         코드의 이력을 관리할 수 있음

## git 로컬 저장소 활용

> git 은 repository 로 각각 프로젝트를 관리

### 0. 기본 설정

git에서 이력을 남기기 위해 작성자(author) 정보 추가. 

매 컴퓨터에서 최초로 한 번만 설정

```bash
$ git config --global user.name {유저네임}
$ git config --global user.email {이메일}
```

* 일반적으로 {유저네임}, {이메일} 에는 github 정보 기입

### 1. 저장소 생성

```bash
$ git init
Initialized empty Git repository in C:/Users/student/Desktop/til/.git/

```

### 2. add

> 커밋 대상 파일을 staging area 로 이동
>
> 즉, 이력을 남길 파일을 담아 놓음

```bash
. = 현재 디렉토리.
$ git add .
$ git add git.md
$ git add images/

```

항상 git status 를 통해 상태 확인!!!!

```bash
$ git status
on branch master
```

```bash
no commits yetgit
```

```bash
Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   "\353\247\210\355\201\254\353\213\244\354\232\264 \354\235\264\353\257\270\354\247\200.jpg"
        new file:   "\353\247\210\355\201\254\353\213\244\354\232\264 \355\231\234\354\232\251\353\262\225 \355\203\200\354\235\264\355\217\254\353\235\274.md"

```

### 3. commit

> git에서 이력을 남기기 위해 commit 진행

```bash
$ git commit -m 'Git 기초'
[master (root-commit) 71ffe82] Git 기초
 2 files changed, 85 insertions(+)
 create mode 100644 "\353\247\210\355\201\254\353\213\244\354\232\264 \354\235\264\353\257\270\354\247\200.jpg"
 create mode 100644 "\353\247\210\355\201\254\353\213\244\354\232\264 \355\231\234\354\232\251\353\262\225 \355\203\200\354\235\264\355\217\254\353\235\274.md"

```

* 이력을 확인하기 위해 git log 활용

```bash
$ git log
commit 71ffe82b66513bdf6ae24e931717417774ebd124 (HEAD -> master)
Author: eunsung-git <silvery0224@naver.com>
Date:   Thu Dec 5 12:39:35 2019 +0900

    Git 기초

```

## git 원격 저장소 활용

### 0. 기본 설정

> 원격 저장소 생성  ex) github

### 1. 원격 저장소 등록

origin 이라는 이름으로 해당 url을 원격 저장소로 등록

```bash
git remote add origin https://github.com/eunsung-git/TIL.git
```

```bash
origin  https://github.com/eunsung-git/TIL.git (fetch)
```

### 2. 원격 저장소 push

앞으로 변경사항이 있으면 항상 add, commit, push 진행

```bash
$ git push -u origin master
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 8.36 KiB | 8.36 MiB/s, done.
Total 4 (delta 0), reused 0 (delta 0)
To https://github.com/eunsung-git/TIL.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```

> 강사님 메모 참고
>
> https://github.com/edutak/TIL-a



-ㅡ