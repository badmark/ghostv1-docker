FROM Ubuntu:16.04

RUN useradd -ms /bin/bash ghost

USER ghost
WORKDIR /home/ghost

RUN usermod -aG sudo ghost

RUN apt update && apt upgrade -y && apt install nginx mysql-server -y && ufw allow 'Nginx Full'

RUN su - ghost

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash && sudo apt-get install -y nodejs

RUN sudo npm i -g ghost-cli

RUN sudo mkdir /var/www/ghost && sudo chown ghost:users /var/www/ghost && cd /var/www/ghost && ghost install







