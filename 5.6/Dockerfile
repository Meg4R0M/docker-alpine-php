FROM alpine:3.7

LABEL php.version=5.6
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

RUN apk upgrade --no-cache

RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
    apk add --update \
    curl \
    libmemcached \
    php \
    php5-json \
    php5-xsl \
    php5-intl \
	php5-mcrypt \
	php5-curl \
	php5-gd \
	php5-xmlrpc \
    php5-phar \
    php5-openssl \
    php5-zlib \
    php5-opcache \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted gnu-libiconv

RUN apk --no-cache add ca-certificates \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.5/community php5-xdebug \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-php5-memcached/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-php5-memcached/releases/download/2.2.0-r0/php5-memcached-2.2.0-r0.apk \
    && wget https://github.com/sgerrand/alpine-pkg-php5-imagick/releases/download/unreleased/php5-imagick-3.4.3-r0.apk \
    && wget http://dl-4.alpinelinux.org/alpine/v3.6/main/x86_64/imagemagick-7.0.5.10-r0.apk \
    && apk add php5-memcached-2.2.0-r0.apk \
    && apk add imagemagick-7.0.5.10-r0.apk \
    && apk add php5-imagick-3.4.3-r0.apk \
    && rm -rf /var/cache/apk/*

RUN ln -sf /usr/bin/php5 /usr/bin/php

# -----------------------------------------------------------------------------
# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
COPY custom_vars.ini /etc/php5/cli/conf.d/custom_vars.ini
#RUN cp /etc/php5/cli/conf.d/custom_vars.ini /etc/php5/apache2/conf.d/custom_vars.ini

ENTRYPOINT ["/bin/sh"]