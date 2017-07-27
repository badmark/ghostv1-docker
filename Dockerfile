FROM ubuntu:16.04
MAINTAINER badmark@gmail.com


ENV MYSQL_USER=ghost \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN  apt update && apt install sudo curl -y
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
    && rm -rf ${MYSQL_DATA_DIR} \
    && rm -rf /var/lib/apt/lists/*

RUN echo "ghost ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN useradd -ms /bin/bash ghost

USER ghost

WORKDIR /home/ghost

COPY entrypoint.sh /sbin/entrypoint.sh
RUN sudo chmod 755 /sbin/entrypoint.sh


RUN sudo -i usermod -aG sudo ghost

#RUN sudo apt-get install -y mysql-server

RUN sudo apt update && sudo apt install nginx -y

#RUN sudo ufw allow 'Nginx Full'

RUN sudo su - ghost

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash && sudo apt-get install -y nodejs

RUN sudo npm i -g ghost-cli

RUN sudo mkdir /var/www/ghost && sudo chown ghost:users /var/www/ghost && cd /var/www/ghost && ghost install







