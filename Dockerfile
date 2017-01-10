FROM ubuntu:latest
MAINTAINER juntaki
WORKDIR /root

RUN apt-get upgrade && apt-get update
RUN apt-get -y install build-essential git wget emacs-nox
ADD .spacemacs /root/
RUN git clone --recursive https://github.com/syl20bnr/spacemacs.git ~/.emacs.d

# Try twice  https://github.com/syl20bnr/spacemacs/issues/5658
RUN env SHELL=/bin/bash emacs -nw -batch -u root -q -kill && \
    env SHELL=/bin/bash emacs -nw -batch -u root -q -kill

RUN git config --global user.email "me@juntaki.com" && \
    git config --global user.name "juntaki"

RUN rm /root/.emacs.d/.gitignore
RUN rm -rf /root/.emacs.d/.git

RUN git init
RUN git add .emacs.d
RUN git add .spacemacs
RUN git commit -m "spacemacs"
RUN git remote add origin git@github.com:juntaki/dotemacs.git

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

CMD bash -c "cat ~/.ssh/id_rsa.tmp > ~/.ssh/id_rsa; chmod 600 ~/.ssh/id_rsa; git push -f -u origin master"
