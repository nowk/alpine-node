FROM nowk/alpine-base:3.2
MAINTAINER Yung Hwa Kwon <yung.kwon@damncarousel.com>

ENV NODE_MAJOR 0.12
ENV NODE_VERSION 0.12.2
ENV NPM_VERSION 2.7.4

RUN apk --update --arch=x86_64 add \
    nodejs=${NODE_VERSION}-r0 \
    && rm -rf /var/cache/apk/*

CMD [ "/bin/sh" ]

LABEL \
    version=$NODE_VERSION \
    os="linux" \
    arch="amd64"
