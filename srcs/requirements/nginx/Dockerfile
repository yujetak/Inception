# docker build image automatically by reading the instructions from a dockerfile
# FROM creates a layer from 'alpine:latest' docker image
FROM alpine:3.16
# RUN build your application
RUN apk update && apk upgrade
RUN apk add nginx
RUN mkdir -p /var/www/
# COPY add files from your docker client's current directory
COPY ./tools/entry.sh /tmp/run_nginx.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
# SET cert directory
RUN mkdir -p /etc/nginx/ssl
RUN chmod 700 /etc/nginx/ssl
# MAKE certification
RUN apk add openssl
RUN apk upgrade && apk update
########### openssl ############
# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04
# https://ubuntu.com/server/docs/security-certificates
# openssl: OpenSSL 관리 기본 명령어
# ssl? 공용 또는 개인 인증 기관에서 서명하지 않은 SSL / TSL(대충 높은 신뢰도의 인증서) 인증서. 대신 작성자의 개인 또는 루트 CA 인증서로 서명됨
# req: 생성한 고유의 인증서를 사용하도록 지정
# -x509: 공개키 표준을 'x.509'. 자체 서명된 인증서를 발행한다고 전달함
# -nodes: 보안 스킵
# -days 365: 1년을 유효기간으로 설정
# -newkey rsa:2048: 새 인증서와 새 키를 동시에 생성, 2048비트 길이의 RSA키(암호 시스템)를 생성
# -keyout: 키 파일의 위치 지정
# -out: 인증서 저장 위치 지정
################################
RUN openssl req -x509 \
								-newkey rsa:2048 \
								-days 365 \
								-nodes \
								-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=yotak" \
								-keyout /etc/nginx/ssl/localhost.yotak.key \
								-out /etc/nginx/ssl/localhost.yotak.crt

# RUN apk add openrc
RUN chmod +x /tmp/run_nginx.sh
ENTRYPOINT [ "sh", "/tmp/run_nginx.sh" ]

EXPOSE 443