# 볼륨 새성 (volume name : cloud-cicd-src)
# 윈도우 환경에서는 역슬래시("\")를 지우고 명령어를 한 줄로 입력
docker volume create  \
--opt device="C:/cicd/cicd-start/IDE/src" \
--opt o=bind --opt type=none cloud-cicd-src

docker volume create  \
--opt device="C:/cicd/cicd-start/IDE/vscode" \
--opt o=bind --opt type=none vscode

docker volume create  \
--opt device="C:/cicd/cicd-start/IDE/jenkins" \
--opt o=bind --opt type=none jenkins-home

# 볼륨 생성 확인
docker volume ls