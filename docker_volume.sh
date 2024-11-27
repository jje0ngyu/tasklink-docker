# 볼륨 새성 (volume name : tasklink-cicd-src)
# 윈도우 환경에서는 역슬래시("\")를 지우고 명령어를 한 줄로 입력
docker volume create  \
--opt device="D:/WORK_SPACE/tasklink-docker/src" \
--opt o=bind --opt type=none tasklink-cicd-src

docker volume create  \
--opt device="D:/WORK_SPACE/tasklink-docker/vscode" \
--opt o=bind --opt type=none vscode

docker volume create  \
--opt device="D:/WORK_SPACE/tasklink-docker/jenkins" \
--opt o=bind --opt type=none jenkins-home

# 볼륨 생성 확인
docker volume ls