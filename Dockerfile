FROM php:7.1.6-fpm
MAINTAINER Hivinau GRAFFE <hivinau.graffe@hotmail.fr>

# update machine
RUN apt-get update

# Packages
## Mongo
RUN pecl install mongodb \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/ext-mongodb.ini 
  
## Others
RUN apt-get install -y \
    libmcrypt-dev \
    php-pear \
    wget \
    curl \
  && rm -r /var/lib/apt/lists/*

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/compose

# Set up the application directory
WORKDIR /app
