#!/bin/bash

openssl aes-256-cbc -K $encrypted_f6e6a2265b92_key -iv $encrypted_f6e6a2265b92_iv -in id_rsa.enc -out ./id_rsa -d
chmod 600 id_rsa

docker build -t emacs .
docker run -v ~/id_rsa:/root/.ssh/id_rsa emacs
