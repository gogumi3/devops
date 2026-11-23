
# DevOps 개인 프로젝트

## 1. 프로젝트 소개

### 프로젝트 주제
Docker와 Kubernetes를 활용한 방명록 배포 및 운영

### 프로젝트 목표
기존 방명록 애플리케이션을 활용하여 Docker 이미지 생성,
컨테이너 배포, Kubernetes 설정 변경 및 장애 복구 과정을
직접 실습하고 DevOps 도구의 역할을 이해한다.

## 2. 사용 기술

- Python / Flask: 방명록 웹 애플리케이션
- Redis: 방명록 데이터 저장
- Docker: 애플리케이션 이미지 생성
- Docker Compose: 다중 컨테이너 구성
- GHCR: Docker 이미지 저장
- Kubernetes / Minikube: 컨테이너 배포 및 관리
- Git / GitHub: 소스코드 및 버전 관리

## 3. 프로젝트 진행 과정

### 3-1. 기존 서비스 정상화
- Guestbook Pod가 READY 0/1 상태인 문제 발견
- kubectl describe와 logs로 원인 조사
- Redis 호스트 이름 조회 실패 확인
- Deployment 재시작 후 Redis 연결 성공
- Guestbook Pod 2개 모두 정상 실행 확인

### 3-2. ConfigMap 설정 변경
- APP_TITLE을 "DevOps 개인 프로젝트"로 변경
- THEME_COLOR를 파란색으로 변경
- Docker 이미지 재빌드 없이 설정 변경 성공

### 3-3. replicas 변경
- Guestbook Pod를 2개에서 3개로 확장
- Redis를 통한 방명록 데이터 유지 확인
- 실험 후 replicas를 2개로 복구

### 3-4. 포트 변경
- NodePort를 30080에서 30081로 변경
- 변경된 포트로 서비스 접속 확인
- 실험 후 30080으로 복구

### 3-5. ReadinessProbe 실험
- 정상 경로 /readyz를 /wrong으로 변경
- 새 Pod의 READY 0/1 상태 확인
- 정상 경로로 복구
- Deployment 정상 배포 완료 확인

### 3-6. Docker 이미지 업데이트
- Python 애플리케이션의 실행 로그 수정
- Docker 이미지 v3 생성
- GHCR 이미지 사용 및 Kubernetes 재배포
- Guestbook Pod 2개 모두 1/1 Running 확인
- 실행 로그에서 [v3] 출력 확인

## 4. 오류 및 해결 사례

### 사례 1. Redis 연결 실패

증상:
Guestbook Pod가 Running이지만 READY 0/1 상태

확인:
kubectl describe pod
kubectl logs

원인:
Redis 호스트 이름 조회 실패로 메모리 모드 실행

해결:
kubectl rollout restart deployment/guestbook

결과:
Redis 연결 성공 및 ReadinessProbe 200 응답

### 사례 2. ReadinessProbe 실패 실험

증상:
새로운 Guestbook Pod의 READY 상태가 0/1

확인:
kubectl get pods
kubectl get deployment guestbook -o yaml

원인:
readinessProbe 경로를 /wrong으로 잘못 설정

해결:
경로를 /readyz로 복구 후 재배포

결과:
Deployment 정상 배포 및 Pod 1/1 상태 복구

## 5. 프로젝트를 통해 배운 점

Docker를 통해 애플리케이션을 이미지로 만들고,
Kubernetes를 이용하여 여러 컨테이너를 관리하는
과정을 이해할 수 있었다.

ConfigMap을 이용하면 이미지를 다시 빌드하지 않고도
애플리케이션 설정을 변경할 수 있다는 점을 확인했다.

또한 컨테이너가 실행 중인 상태와 실제 서비스를
제공할 준비가 된 상태는 다르다는 것을 알게 되었다.

오류가 발생했을 때 로그와 Pod 상태를 확인하면서
원인을 분석하는 과정이 중요하다는 것을 배웠다.

## 6. 개선점 및 느낀 점

프로젝트를 다시 진행한다면 처음부터 설정 파일과
실험 결과를 체계적으로 기록할 것이다.

수동으로 이미지를 빌드하고 배포하는 과정이 반복되므로
향후 GitHub Actions 등을 활용하여 빌드와 배포를
자동화하는 방법도 학습하고 싶다.

DevOps는 단순히 프로그램을 배포하는 것이 아니라
서비스를 안정적으로 운영하고 오류를 해결하는
과정까지 포함한다는 것을 이해하게 되었다.
