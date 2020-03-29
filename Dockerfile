FROM ubuntu:18.04

ENV USERNAME=charlieegan3
ENV HOME=/home/$USERNAME

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
     vim main.go +GoInstallBinaries +qall && \
     go get -u github.com/visualfc/gocode
RUN pip3 install --upgrade neovim
