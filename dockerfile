# Sourced from https://github.com/theia-ide/theia-apps/blob/master/theia-python-docker/Dockerfile
ARG NODE_VERSION=10
FROM node:${NODE_VERSION}-stretch

RUN apt-get update \
    && apt-get install -y python python-dev python-pip gettext-base nginx \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

RUN pip install \
    python-language-server \
    flake8 \
    autopep8

ARG version=latest

WORKDIR /home/theia
ADD latest.package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --cache-folder ./ycache && rm -rf ./ycache
RUN yarn theia build
EXPOSE 80
COPY nginx-default.conf.template /etc/nginx/default.conf.template
COPY docker-entrypoint.sh /
ENV SHELL /bin/bash
ENTRYPOINT ["/docker-entrypoint.sh"]