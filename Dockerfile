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
  
## Mongo
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Create sql structure
ADD t4u.sql /tmp/t4u.sql
RUN /bin/bash -c "/usr/bin/mysqld_safe --skip-grant-tables &" && \
  sleep 5 && \
  mysql -u root -e "CREATE DATABASE t4u" && \
  mysql -u root mydb < /tmp/t4u.sql

# Set up the application directory
WORKDIR /app
