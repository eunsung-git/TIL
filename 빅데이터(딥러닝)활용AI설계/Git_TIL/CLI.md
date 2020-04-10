# CLI

> Command Line Interface에서는 명령어와 그 결과를 항상 주의하자.

1. `ls` - 디렉토리 목록

   ```bash
   $ ls
    a.txt    b.txt   image/
   ```

2. `cd` - 디렉토리 변경

   ```bash
   ~/Desktop/ $ cd image/
   ~/Desktop/image/ $ cd ..
   ~/Desktop/ $ pwd
   /c/Users/student/Desktop/
   ```

   * `.` : 현재 디렉토리
   * `..` : 상위 디렉토리
   * `~` : 홈 디렉토리
     * 위의 상황에서는 C드라이브의 Users 폴더 내부의 students 폴더

3. `pwd` - 현재 작업 디렉토리

   ```bash
   ~/Desktop/ $ pwd
   /c/Users/student/Desktop/
   ```

## Vi(Vim)

> CLI 환경에서 쓸 수 있는 텍스트 에디터 중 하나

commit 하는 과정에서 메시지 옵션을 쓰지 않으면, 나타난다.

```bash
$ git commit
```

* 편집 모드(`i`) - 텍스트 편집
* 명령 모드(`esc`)
  * `:wq`
  * `w` : write (저장)
  * `q` : quit (종료)





