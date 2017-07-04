FROM php:5.6-cli
MAINTAINER Hivinau GRAFFE <hivinau.graffe@hotmail.fr>

# Packages
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libmcrypt-dev \
    php-pear \
    wget \
    curl \
    git \
  && rm -r /var/lib/apt/lists/*
  
# PHP Extensions
RUN docker-php-ext-install mcrypt zip mbstring

# Memory Limit
RUN echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > /usr/local/etc/php/conf.d/date_timezone.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer about
    
# mongo
RUN apt-get install -y  libsasl2-dev\
                        libssl-dev

RUN pecl install mongo &&\
    echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini

# Set up the application directory
VOLUME ["/app"]
WORKDIR /app
