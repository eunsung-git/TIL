# Branch

> branch 기능은 서로 다른 독립된 작업 이력을 관리할 수 있도록 한다.

* [git flow](https://nvie.com/posts/a-successful-git-branching-model/)

  

## 기초 명령어

1. branch 생성

   ```bash
   $ git branch {브랜치이름}
   ```

2. branch 이동

   ```bash
   (master) $ git checkout {브랜치이름}
   (브랜치이름) $
   ```

3. branch 생성 및 이동

   ```bash
   (master) $ git checkout -b {브랜치이름}
   (브랜치이름) $
   ```

4. branch 목록

   ```bash
   (master) $ git branch
   *master
   브랜치이름
   ```

5. branch 병합

   ```bash
   (master) $ git merge {브랜치이름}
   ```

   * `master` 브랜치에 `{브랜치이름}` 의 이력을 병합시킨다.

6. branch 삭제

   ```bash
   $ git branch -d {브랜치이름}
   ```

   

