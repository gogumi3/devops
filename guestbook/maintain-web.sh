
#!/bin/bash

while true
do
    # 현재 실행 중인 web 컨테이너 개수 확인
    COUNT=$(docker compose ps --status running -q web | wc -l)

    echo "현재 web 컨테이너: $COUNT개"

    # 3개가 아니면 다시 3개로 맞추기
    if [ "$COUNT" -ne 3 ]; then
        echo "web 컨테이너 개수 복구 중..."
        docker compose up -d --scale web=3
    fi

    # 10초마다 다시 확인
    sleep 10
done
