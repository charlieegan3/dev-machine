FROM ubuntu:18.04

ENV USERNAME=charlieegan3
ENV HOME=/home/$USERNAME

# Create user (recreated created in packer build later)
RUN adduser --disabled-password --gecos "" $USERNAME
ARG password
RUN echo $USERNAME:$password | chpasswd
RUN usermod -aG sudo $USERNAME

# Install tools
RUN apt-get update
RUN apt-get install -y silversearcher-ag tmux direnv jq tree mosh git make curl gpg \
      software-properties-common unzip vim python3-pip
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
      add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" && \
      apt-get update && \
      apt-get install -y docker-ce docker-ce-cli containerd.io
RUN curl -o fasd.zip -L https://github.com/clvv/fasd/zipball/1.0.1 && \
      unzip fasd.zip && \
      cd clvv-fasd-4822024 && \
      make install && \
      cd .. && \
      rm -rf clvv-fasd-4822024 fasd.zip

# Install languages/runtimes
RUN curl -LO https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz && \
      tar -C /usr/local -xzf go1.14.1.linux-amd64.tar.gz && \
      rm go1.14.1.linux-amd64.tar.gz

# User things (recreated created in packer build later)
RUN apt-get install -y build-essential
USER $USERNAME
WORKDIR $HOME

# Configure SSH access
RUN mkdir $HOME/.ssh
COPY id_rsa.pub $HOME/.ssh/
ARG id_rsa
RUN echo $id_rsa | base64 -d > $HOME/.ssh/id_rsa
RUN chmod 600 $HOME/.ssh/id_rsa
RUN cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys

# Configure GPG keys
ARG gpg_pub
ARG gpg_priv
RUN echo $gpg_pub | base64 -d > pub
RUN echo $gpg_priv | base64 -d > priv
RUN gpg --import --batch pub
RUN gpg --import --batch priv

# Configure github access
ARG github_token
RUN echo "https://$USERNAME:$github_token@github.com" > $HOME/.git-credentials

# Install latest configuration
COPY --chown=charlieegan3:charlieegan3 dotfiles $HOME

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
      vim +PlugInstall +qall
RUN export PATH=$PATH:/usr/local/go/bin && export GOPATH=$HOME/Code/go && \
     vim main.go +GoInstallBinaries +qall
RUN pip3 install --upgrade neovim
