#!/bin/bash

docker build -t emacs .

openssl aes-256-cbc -K $encrypted_f6e6a2265b92_key -iv $encrypted_f6e6a2265b92_iv -in id_rsa.enc -out ./id_rsa -d
docker run -v `pwd`/id_rsa:/root/.ssh/id_rsa.tmp emacs
