FROM ubuntu:18.04

ENV USERNAME=charlieegan3
ENV HOME=/home/$USERNAME

# Create user (recreated created in packer build later)
RUN adduser --disabled-password --gecos "" $USERNAME
ARG password
RUN echo $USERNAME:$password | chpasswd
RUN usermod -aG sudo $USERNAME

# Install things
RUN apt-get update
RUN apt-get install -y silversearcher-ag tmux direnv jq tree mosh git

# User things (recreated created in packer build later)
USER $USERNAME
WORKDIR $HOME

# Configure SSH access
RUN mkdir $HOME/.ssh
COPY id_rsa.pub $HOME/.ssh/
ARG id_rsa
RUN echo $id_rsa | base64 -d > $HOME/.ssh/id_rsa
RUN chmod 600 $HOME/.ssh/id_rsa
RUN cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys

# Configure github access
ARG github_token
RUN echo "https://$USERNAME:$github_token@github.com" > $HOME/.git-credentials

# Install latest configuration
COPY dotfiles $HOME
