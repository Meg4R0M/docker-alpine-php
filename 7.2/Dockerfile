FROM alpine:3.8

LABEL php.version=7.2
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="php-alpine" \
    org.label-schema.description="small php image based on alpine" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-alpine-php"

# Environments
ENV TIMEZONE Europe/Paris

RUN echo "@edge-main http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "@edge-community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# trust this project public key to trust the packages.
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# make sure you can use HTTPS
RUN apk --update add ca-certificates

# ADD SDK AND BASIC TOOLS.
RUN apk add --update alpine-sdk sudo git bash nano vim

RUN apk add --update tzdata && \
    apk --update add ca-certificates \
    && apk add -U \
    curl \
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
    php7-zip \
    php7-bcmath \
    php7-sodium \
    php7-ctype \
    php7-tokenizer \
    php7-simplexml \
    php7-iconv \
    && rm -rf /var/cache/apk/*

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /etc/php7/conf.d/tzone.ini

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
COPY custom_vars.ini /etc/php7/conf.d/custom_vars.ini

RUN echo "xdebug.remote_enable=1" >> /etc/php7/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_connect_back=1" >> /etc/php7/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /etc/php7/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_port=9001" >> /etc/php7/conf.d/docker-php-ext-xdebug.ini

ENV PHP_VERSION 7.2.10

# START WITH BASH.
CMD ["/bin/bash"]
