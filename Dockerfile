FROM php:7.0-cli
MAINTAINER Hivinau GRAFFE <hivinau.graffe@hotmail.fr>

RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list

# Packages
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libmcrypt-dev \
    php-pear \
    wget \
    curl \
    git \
  && rm -r /var/lib/apt/lists/*

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
# Mongo
RUN pecl install mongodb-1.2.8 
ADD php/mongodb.ini /usr/local/etc/php/conf.d/mongodb.ini

# Set up the application directory
WORKDIR /app
