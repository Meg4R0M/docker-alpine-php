FROM alpine:3.7

LABEL php.version=7.0
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="php-alpine" \
    org.label-schema.description="small php image based on alpine" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-php-alpine"

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# Environments
ENV TIMEZONE Europe/Paris

RUN echo "@main http://dl-cdn.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories \
    && echo "@community http://dl-cdn.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories \
    && echo "@community36 http://dl-cdn.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories \
    && echo "@cast http://php.codecasts.rocks/7.0" >> /etc/apk/repositories

RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone \
    && wget http://dl-4.alpinelinux.org/alpine/v3.5/main/x86_64/libwebp-0.5.2-r0.apk \
    && apk add libwebp-0.5.2-r0.apk \
    && wget http://dl-4.alpinelinux.org/alpine/v3.5/main/x86_64/imagemagick-6.9.6.8-r1.apk \
    && apk add imagemagick-6.9.6.8-r1.apk
    
RUN apk add -U \
    curl \
    tini \
    icu-libs@main

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-7.0.21-r0.apk \
    && apk add php7-7.0.21-r0.apk

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-common-7.0.21-r0.apk \
    && apk add php7-common-7.0.21-r0.apk

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-intl-7.0.21-r0.apk \
    && apk add php7-intl-7.0.21-r0.apk

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-session-7.0.21-r0.apk \
    && apk add php7-session-7.0.21-r0.apk

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-xml-7.0.21-r0.apk \
    && apk add php7-xml-7.0.21-r0.apk

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-dom-7.0.21-r0.apk \
    && apk add php7-dom-7.0.21-r0.apk

RUN wget http://dl-4.alpinelinux.org/alpine/v3.5/main/x86_64/libressl2.4-libcrypto-2.4.4-r0.apk \
    && apk add libressl2.4-libcrypto-2.4.4-r0.apk

RUN wget http://dl-4.alpinelinux.org/alpine/v3.5/main/x86_64/libressl2.4-libssl-2.4.4-r0.apk \
    && apk add libressl2.4-libssl-2.4.4-r0.apk

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-openssl-7.0.21-r0.apk \
    && apk add php7-openssl-7.0.21-r0.apk

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-phar-7.0.21-r0.apk \
    && apk add php7-phar-7.0.21-r0.apk

RUN apk add -U \
    php7-mysqlnd@cast \
    php7-mysqli@cast \
    php7-json@cast \
    php7-xsl@cast \
    php7-mcrypt@cast \
    php7-curl@cast \
    php7-imagick@cast \
    php7-xmlrpc@cast \
    php7-memcached@cast \
    php7-xdebug@cast \
    php7-mbstring@cast

RUN wget http://php.codecasts.rocks/v3.5/php-7.0/x86_64/php7-gd-7.0.21-r0.apk \
    && apk add php7-gd-7.0.21-r0.apk

RUN rm -rf /var/cache/apk/*

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
COPY custom_vars.ini /etc/php7/conf.d/custom_vars.ini

RUN ln -sf /usr/bin/php7 /usr/bin/php

ENTRYPOINT ["/bin/sh"]