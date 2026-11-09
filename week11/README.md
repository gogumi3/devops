# 11주차 Kubernetes 설정과 상태 점검

## 1. Secret 확인
Secret을 base64 -d로 디코딩하여
원래 값을 확인했다.
Base64는 암호화가 아니라 인코딩이므로
보안에 한계가 있다.

## 2. ConfigMap 변경
APP_TITLE과 THEME_COLOR를 수정하고
Deployment를 재시작했다.
이미지를 다시 빌드하지 않고도
방명록 제목과 색상이 변경되었다.

## 3. Readiness 실패
Redis를 중지하자 guestbook Pod의
READY 상태가 0/1로 바뀌었다.
컨테이너 자체는 Running을 유지했다.

## 4. Liveness 실패
검사 경로를 /devops로 잘못 설정하자
RESTARTS가 1로 증가했다.
이후 정상 YAML을 적용하여 복구했다.

## 5. 트러블슈팅
1. get: Pod 상태 확인
2. describe: Events 확인
3. logs: 프로그램 오류 로그 확인
