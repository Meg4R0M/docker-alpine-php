# PHP 7.0 Base Docker image

This is the base PHP image used as parent image for apache & cli images, built from Alpine 3.7

This image should be used as Base image in Dockerfiles needing php.

Example from Apache Dockerfile: 


    FROM meg4r0m/alpine-php7.0
    LABEL apache.version=2.4