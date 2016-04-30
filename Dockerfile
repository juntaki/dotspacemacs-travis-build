FROM ubuntu:trusty
MAINTAINER juntaki
WORKDIR /root

RUN apt-get upgrade && apt-get update
RUN apt-get -y install build-essential git wget
RUN DEBIAN_FRONTEND=noninteractive apt-get -y build-dep emacs24
RUN wget -O- http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.xz | tar xJf -
ADD .spacemacs /root/
RUN git clone --recursive https://github.com/syl20bnr/spacemacs.git ~/.emacs.d

RUN set -x && \
    cd emacs-24.5 && \
    ./configure --prefix=$HOME/local && \
    make && \
    make install

# Try twice  https://github.com/syl20bnr/spacemacs/issues/5658
RUN env SHELL=/bin/bash ~/local/bin/emacs -nw -batch -u root -q -kill && \
    env SHELL=/bin/bash ~/local/bin/emacs -nw -batch -u root -q -kill

RUN git config --global user.email "me@juntaki.com" && \
    git config --global user.name "juntaki"

RUN rm /root/.emacs.d/.gitignore
        

RUN git init && \\
    git add local && \\
    git add .emacs.d && \\
    git submodule add https://github.com/juntaki/spacemacs-prebuild.git && \\
    git commit -m "spacemacs" && \\
    git remote add origin git@github.com:juntaki/dotemacs.git

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

CMD bash -c "cat ~/.ssh/id_rsa.tmp > ~/.ssh/id_rsa; chmod 600 ~/.ssh/id_rsa; git push -f -u origin master"
