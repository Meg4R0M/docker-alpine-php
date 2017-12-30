FROM meg4r0m/alpine-php7.1:7.1

LABEL apache.version=2.4 \
      php.version=7.1

LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="php-alpine" \
    org.label-schema.description="small apache-php image based on alpine" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-php-alpine"

ARG DOCKER_TIMEZONE=Europe/Paris
ARG DOCKER_LOCALE=fr_FR.UTF-8

# Configure timezone
# -----------------------------------------------------------------------------
RUN apk add --update tzdata && \
	cp /usr/share/zoneinfo/$DOCKER_TIMEZONE /etc/localtime && \
	echo $DOCKER_TIMEZONE > /etc/timezone

# Base packages
# Java (used for eg. eZTika indexing)
# poppler-utils used for pdftotext binary (note that eztika is a much better option!)
# -----------------------------------------------------------------------------
RUN apk add --no-cache \
    pwgen \
    sudo \
    nano \
    unzip \
    imagemagick \
    jpegoptim \
    poppler-utils \
    openjdk7-jre \
    curl

# Install language pack
RUN apk --no-cache add ca-certificates wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-bin-2.25-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-i18n-2.25-r0.apk && \
    apk add glibc-bin-2.25-r0.apk glibc-i18n-2.25-r0.apk glibc-2.25-r0.apk

# Iterate through all locale and install it
# Note that locale -a is not available in alpine linux, use `/usr/glibc-compat/bin/locale -a` instead
COPY ./locale.md /locale.md
RUN cat locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8

# locale for date, time & currency php functions
# -----------------------------------------------------------------------------

ENV LC_ALL $DOCKER_LOCALE
ENV LANG $DOCKER_LOCALE
ENV LANGUAGE $DOCKER_LOCALE

# Apache
# -----------------------------------------------------------------------------
RUN apk add apache2 \
     apache2-ssl \
     libxml2-dev \
     apache2-utils \
     apache2-proxy \
     php7-apache2 \
     php7-phar

# Local user
# => to try : run container with --user option to set root user id with host user id
# -----------------------------------------------------------------------------
# nb: the 1013 used here for user id and group id is later on replaced by the code in bootstrap.sh...
RUN addgroup -g 1013 site && \
    adduser -S -u 1013 -G site site \
        -h /home/site -s /bin/sh site && \
    adduser site site && \
    adduser site www-data && \
    chown -R site:site /home/site;
# Adding bashrc conf
#    cp /etc/skel/.* /home/site/; \

COPY root/. /

# Apache config
# -----------------------------------------------------------------------------
ENV APACHE_RUN_USER site
ENV APACHE_RUN_GROUP site
ENV APACHE_LOG_DIR /var/log/apache2/sites
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR  /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVER_NAME localhost

RUN mkdir /var/log/apache2/sites && \
    mkdir /run/apache2/

RUN sed -i 's#^User .*#User site#g' /etc/apache2/httpd.conf && \
    sed -i 's#^Group .*#Group site#g' /etc/apache2/httpd.conf && \
    sed -i 's#^ErrorLog .*#ErrorLog /var/log/apache2/sites/error.log#g' /etc/apache2/httpd.conf && \
    sed -i 's#CustomLog .*#CustomLog /var/log/apache2/sites/access.log combined#g' /etc/apache2/httpd.conf

RUN sed -i 's/^#ServerName .*/ServerName localhost/g' /etc/apache2/httpd.conf && \
    sed -i 's#^Listen .*#Listen 80\n\
Listen 82#g' /etc/apache2/httpd.conf && \
    sed -i 's/^LoadModule proxy_fdpass_module/#LoadModule proxy_fdpass_module/' /etc/apache2/conf.d/proxy.conf && \
    sed -i "s/^#LoadModule slotmem_shm_module/LoadModule slotmem_shm_module/" /etc/apache2/httpd.conf && \
    sed -i "s/^#LoadModule vhost_alias_module/LoadModule vhost_alias_module/" /etc/apache2/httpd.conf&& \
    sed -i "s/^#LoadModule info_module/LoadModule info_module/" /etc/apache2/httpd.conf

# vhost config
# -----------------------------------------------------------------------------
# default & controlpanel
COPY conf/010-controlpanel.conf /tmp/010-controlpanel.conf
RUN cat /tmp/010-controlpanel.conf >> /etc/apache2/httpd.conf && \
    rm /tmp/010-controlpanel.conf

COPY conf/controlpanel.tar.gz /tmp/controlpanel.tar.gz
RUN tar -zxf /tmp/controlpanel.tar.gz -C /home/site/ && \
    rm /tmp/controlpanel.tar.gz

# Run composer install for phpmemadmin vendors
RUN cd /home/site/controlpanel/phpmemadmin && \
    curl -sS https://getcomposer.org/installer | php -- && \
    php composer.phar install --no-dev --ignore-platform-reqs

# Clear archives in apt cache folder
RUN rm -rf /var/cache/apk/*

# Get bootstrap script
RUN mkdir /root/pre-init.d/
COPY conf/bootstrap.sh /root/pre-init.d/bootstrap.sh
RUN chmod 755 /root/pre-init.d/bootstrap.sh

EXPOSE 80 82 443

WORKDIR /var/www/

CMD ["/root/pre-init.d/bootstrap.sh"]