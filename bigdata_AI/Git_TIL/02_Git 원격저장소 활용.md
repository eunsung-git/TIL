# Git 원격 저장소 활용

> 부제 : 집에서 수업 내용 복습하는 법

* 집에 git 저장소가 없는 경우 `clone` 을 받는다.

  ```bash
  $ git clone {__url__}
  ```

## 시나리오

1. 멀캠

   1. `commit` 

      * 수업 종료 후 commit

      ```bash
      $ git commit -m '4/10 - 케라스 활용방법'
      ```

   2. `push`

      ```bash
      $ git push origin master
      ```

2. 집

   1. `pull`

      ```bash
      $ git pull origin master
      ```

   2. 복습 

   3. `commit` 

      ```bash
      $ git commit -m '4/10 - keras 복습(블로그 정리)'
      ```

   4. `push`

      ```bash
      $ git push origin master
      ```

3. 다음날

   ```bash
   $ git pull origin master
   ```

   * 수업을 잘 듣는다.



## 원격 저장소 활용시 주의사항

* 원격 저장소와 로컬 저장소의 이력이 다른 경우 아래와 같이 나타난다.
  * 예) pull을 하지 않고, 집에서 commit 하고 push 하는 경우

```bash
$ git push origin master
To https://github.com/edutak/git.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'https://github.com/edutak/git.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. 
# 너는 아마도 원할 걸..? 
# 원격저장소(remote) 변화들(changes) 통합
# push를 다시 하기전에...
You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```







