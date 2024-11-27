# https://hub.docker.com/r/linuxserver/code-server
FROM linuxserver/code-server:4.93.1

# ENV for Code-server (VSCode)
ENV TZ="Asia/Seoul"
ENV PUID=0
ENV PGID=1000

# Make DIR for code-server
RUN mkdir /code && chown 1000:1000 /code

# Update & Install the packages
RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y ca-certificates curl gnupg software-properties-common wget unzip apt-transport-https telnet net-tools vim iputils-ping python3 python3-pip gh
RUN wget -qO- https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz | tar -xz -C /usr/local && ln -s /usr/local/jdk-21 /usr/lib/jvm/java-21-openjdk-amd64
RUN apt-get clean
# Install Jupyter
RUN pip install --no-cache-dir --break-system-packages jupyter ipykernel

# ENV for JDK
FROM eclipse-temurin:21
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"


# Docker CLI
RUN apt-get update && install -m 0755 -d /etc/apt/keyrings  \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc  \
    && chmod a+r /etc/apt/keyrings/docker.asc

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli

# Install AWS CLI from `amazon/aws-cli` image
COPY --from=amazon/aws-cli /usr/local/aws-cli/v2 /usr/local/aws-cli/v2
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer

# Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null  \
    && gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint  \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

# RUN apt update && apt-get install -y terraform=1.9.7
# RUN apt update && apt-get install -y terraform
RUN apt update && apt-get install -y terraform

# Kubectl
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg  \
    && echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update && apt-get install -y kubectl

# Kubectx & Kubens
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx  \
    && ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx  \
    && ln -s /opt/kubectx/kubens /usr/local/bin/kubens