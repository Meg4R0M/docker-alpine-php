FROM debian:wheezy

LABEL php.version=5.4
LABEL maintainer="Florian Durano <psykoterro@gmail.com>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="meg4r0m" \
    org.label-schema.name="php-alpine" \
    org.label-schema.description="small php image based on alpine" \
    org.label-schema.vcs-url="https://github.com/psykoterro/docker-php-alpine"

# Base packages
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    curl \
    php5 \
		php5-mysqlnd \
		php5-json \
		php5-xsl \
		php5-intl \
		php5-mcrypt \
		php5-curl \
		php5-imagick \
		php5-gd \
		php5-xmlrpc \
		php5-memcached \
		php5-xdebug

# PHP config
# -----------------------------------------------------------------------------
# Custom PHP variables
COPY custom_vars.ini /etc/php5/conf.d/custom_vars.ini

# remove default xdebug config
RUN rm /etc/php5/conf.d/20-xdebug.ini

# Clear archives in apt cache folder
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]