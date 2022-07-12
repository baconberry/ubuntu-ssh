# Mostly taken from https://stackoverflow.com/questions/22886470/start-sshd-automatically-with-docker-container
FROM ubuntu

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo ubuntu
RUN echo 'ubuntu:ubuntu' | chpasswd

USER ubuntu
WORKDIR /home/ubuntu
USER root

RUN mkdir -p /run/sshd 
RUN apt-get -qq update \
    && apt-get -qq --no-install-recommends install openssh-server \
    && apt-get -qq --no-install-recommends install vim-tiny \
    && apt-get -qq clean    \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-o", "ListenAddress=0.0.0.0"]
