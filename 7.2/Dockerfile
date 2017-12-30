FROM alpine:3.7

LABEL php.version=7.2
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
    && echo "@cast http://php.codecasts.rocks/v3.7/php-7.2" >> /etc/apk/repositories

RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone \
    && wget http://dl-4.alpinelinux.org/alpine/v3.6/main/x86_64/imagemagick-7.0.5.10-r0.apk \
    && apk add imagemagick-7.0.5.10-r0.apk \
    && apk --update add ca-certificates \
    && apk add -U \
    tini \
    php7@cast \
    php7-mysqlnd@cast \
    php7-pdo_mysql@cast \
    php7-json@cast \
    php7-xsl@cast \
    php7-intl@cast \
    php7-mcrypt@edge-community \
    php7-curl@cast \
    php7-imagick@cast \
    php7-gd@cast \
    && wget http://php.codecasts.rocks/v3.7/php-7.2/x86_64/php7-xmlrpc-7.2.0-r3.apk \
    && apk add php7-xmlrpc-7.2.0-r3.apk \
    && apk add -U php7-memcached@cast \
    php7-xdebug@edge-community \
    php7-mbstring@cast \
    php7-phar@cast \
    php7-zlib@cast \
    && wget http://php.codecasts.rocks/v3.7/php-7.2/x86_64/php7-openssl-7.2.0-r3.apk \
    && apk add php7-openssl-7.2.0-r3.apk \
    && ln -s /usr/bin/php7 /usr/bin/php \
    && rm -rf /var/cache/apk/*

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
COPY custom_vars.ini /etc/php7.2/conf.d/custom_vars.ini

ENTRYPOINT ["/bin/sh"]