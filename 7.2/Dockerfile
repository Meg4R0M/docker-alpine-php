FROM alpine:3.8

LABEL php.version=7.2
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="php-alpine" \
    org.label-schema.description="small php image based on alpine" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-alpine-php"

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# Environments
ENV TIMEZONE Europe/Paris

RUN echo "@edge-main http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "@edge-community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone \
    && apk --update add ca-certificates \
    && apk add -U \
    tini \
    imagemagick \
    php7 \
    php7-mysqlnd \
    php7-pdo_mysql \
    php7-json \
    php7-xsl \
    php7-intl \
    php7-mcrypt \
    php7-curl \
    php7-imagick \
    php7-gd \
    php7-xmlrpc \
    php7-memcached \
    php7-xdebug \
    php7-mbstring \
    php7-phar \
    php7-zlib \
    php7-openssl \
    && rm -rf /var/cache/apk/*

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
COPY custom_vars.ini /etc/php7.2/conf.d/custom_vars.ini

ENV PHP_VERSION 7.2.8

ENTRYPOINT ["/bin/sh"]