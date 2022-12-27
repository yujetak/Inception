# nginx는 기본으로 daemon으로 실행되는데 background에서 실행되면
# 컨테이너가 앱이 종료된 것으로 간주하여 nginx가 종료됨
exec nginx -g "daemon off;"
