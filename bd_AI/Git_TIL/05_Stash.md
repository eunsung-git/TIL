# Stash

> 작업 내역을 저장할 수 있는 공간이 있다.

## 기본 명령

1. stash 보관

   ```bash
   $ git stash
   ```

2. stash 반영

   ```bash
   $ git stash pop 
   # $ git stash apply - 반영
   # $ git stash drop  - 삭제
   ```

3. stash 목록

   ```bash
   $ git stash list
   ```



## 상황

> git은 commit 되지 않은 변경 사항에 대해서는 되돌리 수 없다.
>
> 따라서, 작업 내역이 있을 때(WD/Staging area 상태인 작업) 병합 과정이 진행되지 않는다. (merge, pull)

```bash
$ git pull origin master
remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 4 (delta 0), reused 3 (delta 0), pack-reused 0
Unpacking objects: 100% (4/4), done.
From https://github.com/edutak/1001-ai
 * branch            master     -> FETCH_HEAD
   38ea6fa..64e06b8  master     -> origin/master

# pull 내용을 받아오면, 지금 로컬 변경사항 중 다음 파일이 덮어씌여질 것이다.
error: Your local changes to the following files would be overwritten by merge:
        README.md
# 커밋을 하거나
# stash를 해라.
Please commit your changes or stash them before you merge.
Aborting
Updating 38ea6fa..64e06b8

```

* 해결 과정

```bash
student@M1303 MINGW64 ~/Desktop/백일장 (master)
$ git stash
Saved working directory and index state WIP on master: 38ea6fa Init

student@M1303 MINGW64 ~/Desktop/백일장 (master)
$ git stash list
stash@{0}: WIP on master: 38ea6fa Init

student@M1303 MINGW64 ~/Desktop/백일장 (master)
$ git pull origin master
From https://github.com/edutak/1001-ai
 * branch            master     -> FETCH_HEAD
Updating 38ea6fa..64e06b8
Fast-forward
 README.md | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

student@M1303 MINGW64 ~/Desktop/백일장 (master)
$ git stash pop
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
The stash entry is kept in case you need it again.
```











