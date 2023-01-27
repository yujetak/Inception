# Inception
# 🐬🐬Docker(🐬개념)

<aside>
🎃 컨테이너(container)를 실행, 관리하는 오픈소스 플랫폼

</aside>

### 뭘까

- ‘데이터 또는 프로그램’을 `격리시키는 기능`을 제공하는 S/W
- `리눅스 운영체제` 에서 사용하는 것을 전제로 만들어 짐

### 도커를 사용하는 이유

- `한 서버에서 실행되면` MySQL-WordPress처럼 서로가 꼭 필요한 S/W는 `프로그램 공유` 가 필요. 만약 한 소프트웨어의 버전을 업그레이드 한다면 공유한 프로그램에서 버전이 맞지 않을수도?
- `프로그램을 격리`하면 각각의 프로그램에 해당되는 버전을 설치할 수 있음

### vs가상머신

- 가상머신: 운영체제 위에 하드웨어, 운영체제를 올리고 프로세스를 실행, 가상의 물리서버 생성
- 도커 컨테이너: 하드웨어를 건너뛰고 리눅스 커널을 공유해서 바로 프로세스를 실행, `호스트에 의존`
    - 커널(kernel): 하드웨어 자원을 관리하고 하드웨어와 프로세스 사이의 인터페이스 역할을 수행하는 OS의 핵심 구성요소

# Container

<aside>
🎃 독립된 환경, 우리가 실제 사용하는 것

</aside>

### 독립된 환경?

- 격리된 프로그램과 데이터가 있는 곳
- 독립된 환경은 리눅스의 `cgroup`과 `namespace`를 통해서 구현
    - cgroup 가용할 수 있는 자원의 제한 설정
    - namespace 특정 프로세스가 볼 수 있는 자원의 범위
- 컨테이너는 호스트에서 실행되고 namespace와 cgroup이 적용된 프로세스
- 컨테이너 속에도 운영체제`(비슷한 것)` 존재
    
    ▶️ 전체 리눅스 운영체제가 아님(커널 외 주변부분)
    
    ⏩️ 컨테이너 속 운영체제(비슷한 것)가 리눅스 운영체제 커널에 전달
    

# Image

<aside>
🎃 컨테이너의 설계도, Dockerfile로 만든다

</aside>

Dockerfile 스크립트로 이미지 만들기

### Dockerfile을 build하여 이미지를 만든다

docker build -t [docker-image] [Dockerfile 경로]

### Dockerfile 요소

✦ FROM: 토대가 되는 이미지 지정

✦ COPY: 이미지에 파일이나 폴더를 추가

✦ RUN: `이미지를 빌드`할 때 실행할 명령어를 지정

✦ CMD: `컨테이너를 실행`할 때 실행할 명령어를 지정

✦ ENTRYPOINT: `컨테이너를 실행`할 때 실행할 명령어를 `강제`지정, 명시한 명령어가 PID1번을 받음

✦ EXPOSE: 이미지가 통신에 사용할 포트를 명시적으로 지정

# Docker Compose

<aside>
🍁 도커 컴포즈를 사용하면 여러 개의 명령어를 하나의 `정의 파일(yaml)`로 합쳐 실행할 수 있다

</aside>

전체 시스템을 일괄 실행(run) 또는 종료 및 삭제(down)할 수 있는 도구

- up : 정의 파일에 기재된 내용대로 이미지를 내려받고 컨테이너를 생성 및 실행, 주변 환경(volume, network)또한 반영됨
- down : 컨테이너와 네트워크를 정지 및 삭제, 볼륨과 이미지는 삭제하지 않는다!
- [yaml-ports] host OS와 container 내부의 `포트를 바인딩`
    - expose? 컨테이너에게만 포트를 공개, host OS와 직접 연결되지 않음
- [yaml-depends_on] 종속관계 표현, depends_on에 명시된 컨테이너가 먼저 실행됨. 하지만 완전히 실행될 때까지 기다려주는건 아님(HEALTH CHECK or sleep으로 기다리기)
- [yaml-networks] networks에 언급된 네트워크를 참고, 기본 방식인 bridge는 호스트의 네트워크와 게스트의 네트워크를 연결(bridge)하여 하나의 네트워크처럼 사용하는 방식(가상의 네트워크)

## Dockerfile vs Docker Compose

- docker compose : 컨테이너와 주변환경을 생성한다
- dockerfile: 이미지를 만드는데 쓰인다

### [Daemon](https://blogger.pe.kr/770)

- 서비스의 요청에 대해 응답하기 위해 오랫동안 실행중인 백그라운드(background) 프로세스
- exec nginx -g "daemon off;”
    
    → nginx는 기본 실행이 daemon인데 daemon으로 실행되는 경우 컨테이너가 foreground에 없는 것으로 간주하여 종료시키므로 nginx가 종료된다
    

### PID 1

- 리눅스가 가장 처음 실행하는 프로세스
- 좀비 프로세스의 처리를 담당한다
- ENTRYPOINT로 지정한 명령어가 PID1이 된다

# 🐬🐬Docker(🐬과제 실습)
# Mandatory part

- NGINX TLSv1.2 or TLSv1.3 only (TLS: 인터넷 프로토콜)
- Docker container는 각각  WordPress + php-fpm, MariaDB, Nginx여야 한다
- volume 첫번째는 WordPress database를 두번째는 WordPress website files를 포함해야한다
- docker-network가 컨테이너들 사이에 작동해야한다.

## Recommends

```bash
🎃 Read about how daemons work and whether it’s a good idea to use them or not.
🎃 Read about PID 1 and the best practices for writing Dockerfiles.
🎃 Volumes will be available in the /home/login/data folder of the host machine.
🙅‍♀️ Your NGINX container must be the only the port 443 only.
```

- [https://docs.docker.com/get-started/overview/](https://docs.docker.com/get-started/overview/)

### 🎃 Read about how daemons work and whether it’s a good idea to use them or not

- docker: 컨테이너라는 환경에서 애플리케이션을 패키징하고 실행할 수 있는 기능을 제공
    - 여러 컨테이너를 동시 실행 가능
    - `tail ⭐️-f⭐️ ?`
        - 종료시키지 않고⭐️f 옵션⭐️ 그대로 실행시켜놓는 명령어
        - 애초에 daemon으로 실행시키면 백그라운드에 상주

➡️ inception과제에서 3개의 컨테이너를 동시에 실행시키는데, Foreground 프로세스는 사용자의 입력을 받는 상태이다. 컨테이너 개수만큼 터미널(혹은 키보드)를 가질 수 없으므로 Background(도커에서는 daemon)로 실행한다.

- daemon
    - docker daemon(dockerd): 호스트의 백그라운드에서 도커 객체를 관리하는 서비스
    - docker client: 도커 사용자가 docker와 상호작용하도록 함
        - `docker run` → client가 dockerd에게 명령 전송 → docker API를 사용하여 명령 수행

### 🎃 Read about PID 1 and the best practices for writing Dockerfiles.

[https://cloud.google.com/architecture/best-practices-for-building-containers?hl=ko#signal-handling](https://cloud.google.com/architecture/best-practices-for-building-containers?hl=ko#signal-handling)

- PID 1 : 시작할 때 실행된 첫번째 프로세스(init 시스템 *systemd)
- 💣[문제점 1] Linux 커널이 신호를 처리하는 방법
    - pid 1과 그렇지 않은 프로세스의 차이
    - signal handler가 PID 1 프로세스에 자동으로 동록되지 않으므로 SIGTERM 또는 SIGINT같은 신호가 기본적으로 작동하지 않는다
    - SIGKILL등을 사용해야하는데 오류나 원치 않는 알림이 생길 수 있다
- 💣[문제점 2]
    - 기본 init 시스템이 좀비프로세스를 제거하는 데도 사용된다
    - 부모 프로세스가 사라진 프로세스는 PID 1 프로세스가 거둔다
    - 컨테이너에서는 PID 1을 갖는 프로세스가 책임을 갖게 하므로 제대로 처리해야하는 문제
- 🛡️[해결법]
    - CMD 또는 ENTRYPOINT를 사용하여 프로세스를 실행하는 것
        
        ```bash
        FROM debian:9
        
        RUN apt-get update && \
            apt-get install -y nginx
        
        EXPOSE 80
        
        CMD [ "nginx", "-g", "daemon off;" ]
        # nginx는 실행할 수 있는 최초이자 유일한 프로세스가 됨
        ```
        
        때로는 쉘 스크립트로 환경을 준비하여 프로세스를 실행할 수 있도록 해야함 → 쉘 스크립트가 PID 1을 가지게 되므로 `exec` 명령어로 프로세스를 실행해야함!
        

## remote-ssh

👩‍💻 ubuntu server

🗳️ virtual box port forwarding
hostport 4242, guestport 22

- sudo apt-get install openssh-server git make -y
- ssh-keygen && cat ~/.ssh/id_rsa.pub
- sudo apt update -y && sudo apt upgrade -y
    
    > if (update error)ss
    
    sudo dpkg -r snapd gnome-software-plugin-snap
    
    sudo apt update
    
    sudo apt full-apgrade
    

🖥 vscode

- ssh {USER}@localhost -p 4242

# 2. wordpress
🧚우다다다 적고 물어보고 적고 물어보고 실습해서 정리본이 없는...코드 주석으로 있을지도!
## nginx:웹서버, wordpress: 웹사이트 제작 

## php-fpm configure

- [https://www.php.net/manual/en/install.fpm.configuration.php](https://www.php.net/manual/en/install.fpm.configuration.php)

## ****wp-config.php****

- [https://ithemes.com/blog/wordpress-wp-config-php-file-explained/](https://ithemes.com/blog/wordpress-wp-config-php-file-explained/)

# 3.  MariaDB
🧚우다다다 적고 물어보고 적고 물어보고 실습해서 정리본이 없는...코드 주석으로 있을지도!

🚨 error 발생 → 해결 volume 이름이랑 컨테이너 이름이랑 같았다🤕

🚨 nc -v 192.168.1.90 9900 ([https://m.blog.naver.com/tawoo0/221564885896](https://m.blog.naver.com/tawoo0/221564885896))

🚨 그 놈의 권한…권한….

- sudo 처리
- `sudo make`

## 🗃 wordpress 에 추가한 유저 확인하는법

1. mariadb Dockerfile위치로 이동
2. docker exec -it mariadb sh
3. mysql -uroot -proot42
4. show databases;
5. use wordpress;
6. show tables;
7. select * from wp_users;

## 🚷 컨테이너 들여보내줘.......

1. 각각의 컨테이너 접근 → cd srcs/requirements/wordpress (Dockerfile 있는 곳으로 이동)
2. docker build -t wordpress-image . (wordpress-image라는 이미지를 현재 위치에 빌드)
3. docker run -it --name wordpress wordpress-i
4. docker exec -it [container name = docker ps] [command경로 = /bin/sh]

## 🤔💭 생각해보면 좋았을 것!
sh와 Dockerfile에서 할 일을 의미적으로 나누기! 설치나 셋팅 등등이 막 섞여 있는데 과연 어떻게 나누면 좋았을까
