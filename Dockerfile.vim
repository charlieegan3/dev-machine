FROM alpine:latest

WORKDIR /home/developer
ENV HOME /home/developer

# dev dependencies
RUN apk add --update --virtual build-deps build-base
RUN apk add make libxpm-dev libx11-dev libxt-dev ncurses-dev \
                     git libsm libice libxt libx11 ncurses

# general dependencies
RUN apk add bash ctags curl unzip ctags unzip

# language / runtimes
RUN apk add go ruby ruby-dev python python-dev

# intall vim
RUN apk add vim

# clear apk cache
RUN rm -rf /var/cache/apk/*

# install tools
# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN gem install curses --no-ri --no-rdoc
RUN ~/.fzf/install

# download config files
RUN curl https://codeload.github.com/charlieegan3/dotfiles/zip/master > dotfiles.zip
RUN unzip -jo dotfiles.zip
RUN rm dotfiles.zip

# install vim plugins
RUN curl -fLo /home/developer/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir /home/developer/.vim/colors
RUN curl https://raw.githubusercontent.com/nelstrom/vim-mac-classic-theme/master/colors/mac_classic.vim > /home/developer/.vim/colors/mac_classic.vim
RUN vim -c PlugInstall -c qall!

# install vim go tools
ENV GOPATH /home/developer/Code
ENV PATH $GOPATH/bin:$PATH
RUN go get golang.org/x/tools/cmd/goimports

# set terminal colors
ENV TERM=xterm-256color

CMD ["vim"]
