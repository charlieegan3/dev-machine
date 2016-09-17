# Containerized Vim

FROM alpine:latest

WORKDIR /home/developer
ENV HOME /home/developer
ENV TERM=xterm-256color

# dev dependencies
RUN apk add --update --virtual build-deps build-base
RUN apk add make libxpm-dev libx11-dev libxt-dev ncurses-dev \
                     git libsm libice libxt libx11 ncurses

# general dependencies
RUN apk add bash ctags curl unzip ctags unzip

# install vim
RUN apk add vim

# language / runtimes
RUN apk add go ruby ruby-dev python python-dev
ENV GOPATH /home/developer/Code
ENV PATH $GOPATH/bin:$PATH

# clear apk cache
RUN rm -rf /var/cache/apk/*

# install tools
# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN gem install curses --no-ri --no-rdoc
RUN ~/.fzf/install
# goimports (required for gofmt)
RUN go get golang.org/x/tools/cmd/goimports

# download config files
ADD ./.vimrc .vimrc

# install vim plugins
RUN curl -fLo /home/developer/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir /home/developer/.vim/colors
RUN curl https://raw.githubusercontent.com/nelstrom/vim-mac-classic-theme/master/colors/mac_classic.vim > /home/developer/.vim/colors/mac_classic.vim
RUN vim -c PlugInstall -c qall!

CMD ["vim"]
