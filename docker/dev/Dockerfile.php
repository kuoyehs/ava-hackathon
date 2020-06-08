FROM php:fpm-alpine

# install extensions
RUN apk update && apk upgrade --update && apk add \
    coreutils \
    autoconf \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    postgresql-dev \
    libxml2-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install pdo_pgsql

COPY docker/dev/php.ini /usr/local/etc/php/

EXPOSE 9000
CMD ["php-fpm"]

WORKDIR /app

# let other containers mount this directory
VOLUME /app
