FROM meg4r0m/debian-php5.4:5.4

LABEL apache.version=2.2 \
      php.version=5.4
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="apache-php5.4-alpine" \
    org.label-schema.description="small php apache-php5.4 based on Debian Wheezy" \
    org.label-schema.vcs-url="https://github.com/psykoterro/apache-php5.4"
ARG DOCKER_TIMEZONE=Europe/Paris
ARG DOCKER_LOCALE=fr_FR.UTF-8

# Configure timezone
# -----------------------------------------------------------------------------
RUN echo $DOCKER_TIMEZONE > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

# Base packages
# Java (used for eg. eZTika indexing)
# poppler-utils used for pdftotext binary (note that eztika is a much better option!)
# -----------------------------------------------------------------------------
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    pwgen \
    sudo \
    nano \
    unzip \
    locales \
    imagemagick \
    jpegoptim \
    poppler-utils \
    openjdk-7-jre-headless;

# locale for date, time & currency php functions
# -----------------------------------------------------------------------------
RUN dpkg-reconfigure locales && \
    echo $DOCKER_LOCALE' UTF-8'>> /etc/locale.gen && \
    locale-gen $DOCKER_LOCALE && \
    /usr/sbin/update-locale LANG=$DOCKER_LOCALE

ENV LC_ALL $DOCKER_LOCALE
ENV LANG $DOCKER_LOCALE
ENV LANGUAGE $DOCKER_LOCALE

# Apache
# -----------------------------------------------------------------------------
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apache2

# Local user
# => to try : run container with --user option to set root user id with host user id
# -----------------------------------------------------------------------------
# nb: the 1013 used here for user id and group id is later on replaced by the code in bootstrap.sh...
RUN addgroup --gid 1013 site && \
    adduser --system --uid=1013 --gid=1013 \
        --home /home/site --shell /bin/bash site && \
    adduser site site && \
    adduser site www-data && \
    cp /etc/skel/.* /home/site/; \
    chown -R site:site /home/site;

# Apache config
# -----------------------------------------------------------------------------
ENV APACHE_RUN_USER site
ENV APACHE_RUN_GROUP site
ENV APACHE_LOG_DIR /var/log/apache2/sites
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR  /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN sed -rie 's|export APACHE_RUN_USER=.*|export APACHE_RUN_USER=site|g' /etc/apache2/envvars && \
    sed -rie 's|export APACHE_RUN_GROUP=.*|export APACHE_RUN_GROUP=site|g' /etc/apache2/envvars && \
    sed -rie 's|export APACHE_LOG_DIR=.*|export APACHE_LOG_DIR=/var/log/apache2|g' /etc/apache2/envvars && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

# For Apache 2.2, we also need to add NameVirtualHost in ports.conf
RUN rm /etc/apache2/ports.conf
COPY conf/ports.conf /etc/apache2/ports.conf
RUN sed -i '/Listen 80/i \NameVirtualHost *:80' /etc/apache2/ports.conf && \
    sed -i '/Listen 82/i \NameVirtualHost *:82' /etc/apache2/ports.conf

RUN a2enmod rewrite headers vhost_alias proxy_http proxy ssl info status

# vhost config
# -----------------------------------------------------------------------------
# default & controlpanel
COPY conf/010-default.conf /etc/apache2/sites-available/010-default.conf
COPY conf/010-controlpanel.conf /tmp/010-controlpanel.conf
RUN cat /tmp/010-controlpanel.conf >> /etc/apache2/apache2.conf && \
    rm /tmp/010-controlpanel.conf

COPY conf/controlpanel.tar.gz /tmp/controlpanel.tar.gz
RUN tar -zxf /tmp/controlpanel.tar.gz -C /home/site/ && \
    rm /tmp/controlpanel.tar.gz

RUN  a2dissite 000-default && \
     a2ensite 010-default.conf

# dynamic vhosts
# a2ensite is run in bootstrap.sh for these as they could also be mounted as volume at run time
COPY conf/001-dynamic-vhost-ez5.conf /etc/apache2/sites-available/001-dynamic-vhost-ez5.conf
COPY conf/003-dynamic-vhost-ez4.conf /etc/apache2/sites-available/003-dynamic-vhost-ez4.conf
COPY conf/ez5-common.conf /etc/apache2/sites-available/ez5-common.conf

# Run composer install for phpmemadmin vendors
RUN cd /home/site/controlpanel/phpmemadmin && \
    curl -sS https://getcomposer.org/installer | php -- && \
    php composer.phar install --no-dev --ignore-platform-reqs

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get bootstrap script
COPY bootstrap.sh /root/bootstrap.sh
RUN chmod 755 /root/bootstrap.sh

EXPOSE 443
EXPOSE 80
EXPOSE 82

WORKDIR /var/www/

CMD ["/root/bootstrap.sh"]