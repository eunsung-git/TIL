# Git branch

## 1. branch 관련 명령어

> Git 브랜치를 위해 root-commit을 발생시키고 진행하세요.

1. 브랜치 생성

    ```bash
    (master) $ git branch {브랜치명}
    ```

2. 브랜치 이동

    ```bash
    (master) $ git checkout {브랜치명}
    ```

3. 브랜치 생성 및 이동

    ```bash
    (master) $ git checkout -b {브랜치명}
    ```

4. 브랜치 삭제

    ```bash
    (master) $ git branch -d {브랜치명}
    ```

5. 브랜치 목록

    ```bash
    (master) $ git branch
    ```

6. 브랜치 병합

    ```bash
    (master) $ git merge {브랜치명}
    ```

	* master 브랜치에서 {브랜치명}을 병합

## 2. branch 병합 시나리오

> branch 관련된 명령어는 간단하다.
>
> 다양한 시나리오 속에서 어떤 상황인지 파악하고 자유롭게 활용할 수 있어야 한다.

### 상황 1. fast-foward

> fast-foward는 feature 브랜치 생성된 이후 master 브랜치에 변경 사항이 없는 상황

1. feature/data-clean branch 생성 및 이동

   ```bash
   (master) $ git checkout -b feature/data-clean
   Switched to a new branch 'feature/data-clean'
   (feature/data-clean) $
   ```

2. 작업 완료 후 commit

   ```bash
   $ touch clean.txt
   $ git add .
   $ git commit -m 'Complete clean'
   ```


3. master 이동

   ```bash
   (feature/data-clean) $ git checkout master
   Switched to branch 'master'
   (master) $
   ```


4. master에 병합

   ```bash
   (master) $ git merge feature/data-clean
   ```


5. 결과 -> fast-foward (단순히 HEAD를 이동)

   ```bash
   (master) $ git merge feature/data-clean
   git merge feature/data-clean 
   Updating 1036e68..98079f0
   Fast-forward
    clean.txt | 0
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 clean.txt
   ```

6. branch 삭제

   ```bash
   $ git branch -d feature/data-clean 
   Deleted branch feature/data-clean (was 98079f0).
   ```
   
   

---

### 상황 2. merge commit

> 서로 다른 이력(commit)을 병합(merge)하는 과정에서 **다른 파일이 수정**되어 있는 상황
>
> git이 auto merging을 진행하고, **commit이 발생된다.**

1. feature/tensorflow branch 생성 및 이동

   ```bash
   (master) $ git checkout -b feature/tensorflow
   Switched to a new branch 'feature/tensorflow'
   (feature/tensorflow) $
   ```

   

2. 작업 완료 후 commit

   ```bash
   $ touch tf.txt
   $ git add .
   $ git commit -m 'Complete TF'
   ```

   

3. master 이동

   ```bash
   $ git checkout master
   ```

4. *master에 추가 commit 이 발생시키기!!*

   * **다른 파일을 수정 혹은 생성하세요!**

   

5. master에 병합

   ```bash
   (master) $ git merge feature/tensorflow
   ```

   

6. 결과 -> 자동으로 *merge commit 발생*

   * git log로 확인 해보세요!



7. 그래프 확인하기

   ```bash
   $ git log --oneline --graph
   *   dfc05ab (HEAD -> master) Merge branch 'feature/tensorflow'       
   |\
   | * 9b97ef6 (feature/tensorflow) Complete Tensorflow
   * | 610325b hotfix
   |/
   * 98079f0 Complete clean
   * 1036e68 Init
   ```

   

8. branch 삭제

   ```bash
   $ git checkout -d feature/tensorflow
   ```

   

---

### 상황 3. merge commit 충돌

> 서로 다른 이력(commit)을 병합(merge)하는 과정에서 **같은 파일의 동일한 부분이 수정**되어 있는 상황
>
> git이 auto merging을 하지 못하고, 충돌 메시지가 뜬다.
>
> 해당 파일의 위치에 표준형식에 따라 표시 해준다.
>
> 원하는 형태의 코드로 직접 수정을 하고 직접 commit을 발생 시켜야 한다.

1. feature/visualization branch 생성 및 이동

   ```bash
   $ git checkout -b feature/visualization
   ```

2. 작업 완료 후 commit

   ```bash
   $ touch visual.txt
   # README.md 수정
   # 아래 상태 메시지로 확인하세요.
   $ git status
   On branch feature/visualization
   Changes not staged for commit:                        alization)
     (use "git add <file>..." to update what will be committed)
     (use "git restore <file>..." to discard changes in walization)orking directory)
           modified:   README.md
   
   Untracked files:
     (use "git add <file>..." to include in what will be 
   committed)
           visual.txt
   
   no changes added to commit (use "git add" and/or "git 
   commit -a")
   $ git add .
   $ git commit -m 'Complete visual'
   ```
   
   


3. master 이동

   ```bash
   $ git checkout master
   ```
   
   


4. *master에 추가 commit 이 발생시키기!!*

   * **동일 파일을 수정 혹은 생성하세요!**
   

   
5. master에 병합

   ```bash
   $ git merge feature/visualization 
   Auto-merging README.md
   CONFLICT (content): Merge conflict in README.md
   Automatic merge failed; fix conflicts and then commit the result.
   ```


6. 결과 -> *merge conflict발생*

   > git status 명령어로 충돌 파일을 확인할 수 있음.
   
   ```bash
   (master|MERGING) $ git status
   On branch master
   # 충돌 난 곳이 있음.
   You have unmerged paths.
     # 고치고 나서 commit을 실행 시킬 것.
     (fix conflicts and run "git commit")        
     (use "git merge --abort" to abort the merge)
   
   Changes to be committed:
           new file:   visual.txt
   
   # README.md 이 동시에 수정됨.
   # 해결하고 add 할 것..
   Unmerged paths:
     (use "git add <file>..." to mark resolution)
           both modified:   README.md
   ```


7. 충돌 확인 및 해결

   ```
   <<<<<<< HEAD
   * 분석 내용 정리
   =======
   * 시각화 작업
   >>>>>>> feature/visualization
   ```


8. merge commit 진행

   > 2번 상황에서는 merge commit 이 발생하였지만, 그 중간 과정에서 충돌이 났기 때문에 직접 변경사항을 add하고 commit을 하여야 합니다.

   ```bash
   $ git add .
   $ git commit
   ```

   * vim 편집기 화면이 나타납니다.

   * 자동으로 작성된 커밋 메시지를 확인하고, `esc`를 누른 후 `:wq`를 입력하여 저장 및 종료를 합니다.
      * `w` : write
      * `q` : quit
      
   * 커밋이  확인 해봅시다.

9. 그래프 확인하기

     ```bash
    $ git log --oneline --graph
    *   891aafc (HEAD -> master) Merge branch 'feature/visualization'   
    |\
    | * 2d2e099 (feature/visualization) Complete Visual
    * | 31eaefc Update markdown
    |/
    *   dfc05ab Merge branch 'feature/tensorflow'
    |\
    | * 9b97ef6 Complete Tensorflow
    * | 610325b hotfix
    |/
    * 98079f0 Complete clean
    * 1036e68 Init
     ```


10. branch 삭제

    ```bash
    $ git branch -d feature/visualization
    ```

    

    
