FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow

RUN set -ex && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y --quiet --no-install-recommends install \
      ca-certificates \
      apt-utils \
      apt-transport-https \
      gnupg-agent \
      gnupg2 \
      curl \
      wget \
      jq \
      git \
      tree \
      bash-completion \
      software-properties-common \
      openssl && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_10/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list && \
    wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/Debian_10/Release.key -O- | apt-key add - && \
    curl https://baltocdn.com/helm/signing.asc | apt-key add - && \
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    apt-get update && \
    echo "For custom version set: apt-get -y install docker-ce-cli=<VERSION_STRING>, for ex. 5:18.09.1~3-0~debian-stretch" && \
    apt-get -y --quiet --no-install-recommends install \
      pass \
      docker-ce-cli \
      kubectl \
      helm \
      skopeo \
      mutt && \
    kubectl completion bash > /etc/bash_completion.d/kubectl && \
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && \
    mv kustomize /usr/bin/ && \
    apt-get clean
