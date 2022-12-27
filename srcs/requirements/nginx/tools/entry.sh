# nginx 웹 서버를 foreground로 실행(기본이 background)
# 그렇지 않으면 컨테이너를 생성해도 바로 꺼진다고 함
exec nginx -g "daemon off;"