FROM php:7.4-fpm

RUN apt-get update && apt-get install -y git

RUN apt-get update && apt-get -y install autoconf libzip-dev 

RUN pecl install xdebug-2.8.1 && docker-php-ext-enable xdebug

RUN docker-php-ext-install zip

RUN pecl install grpc && docker-php-ext-enable grpc

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

ARG USER_ID
ARG GROUP_ID

RUN groupadd -f --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
USER user

ADD xdebug.ini /etc/php/conf.d/

WORKDIR /var/www

EXPOSE 9000
