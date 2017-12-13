FROM php:7.1.6-fpm
MAINTAINER Hivinau GRAFFE <hivinau.graffe@hotmail.fr>

# update machine
RUN apt-get update

# Packages
## Others
RUN apt-get install -y \
    libmcrypt-dev \
    libssl-dev \
    php-pear \
    wget \
    curl \
    git \
    unzip \
  && rm -r /var/lib/apt/lists/*

## Enable mysqli and pdo extension in php.ini
RUN docker-php-ext-install mysqli && \
    docker-php-ext-install pdo_mysql

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Set up the application directory
WORKDIR /app
