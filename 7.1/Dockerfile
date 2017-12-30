FROM alpine:3.7

LABEL php.version=7.1
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="php-alpine" \
    org.label-schema.description="small php image based on alpine" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-php-alpine"

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# Environments
ENV TIMEZONE Europe/Paris

RUN echo "@edge-main http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "@edge-community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "@cast http://php.codecasts.rocks/7.1" >> /etc/apk/repositories


RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone \
    && wget http://dl-4.alpinelinux.org/alpine/v3.6/main/x86_64/imagemagick-7.0.5.10-r0.apk \
    && apk add imagemagick-7.0.5.10-r0.apk \
    && apk add -U \
    tini \
    php7@edge-community \
    php7-mysqlnd@edge-community \
    php7-pdo_mysql@edge-community \
    php7-json@edge-community \
    php7-xsl@edge-community \
    php7-intl@edge-community \
    php7-mcrypt@edge-community \
    php7-curl@edge-community \
    php7-imagick@edge-community \
    php7-gd@edge-community \
    php7-xmlrpc@edge-community \
    php7-memcached@edge-community \
    php7-xdebug@edge-community \
    php7-mbstring@edge-community \
    php7-phar@edge-community \
    php7-zlib@edge-community \
    && rm -rf /var/cache/apk/*

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
COPY custom_vars.ini /etc/php7.1/conf.d/custom_vars.ini

ENTRYPOINT ["/bin/sh"]