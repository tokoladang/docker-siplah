FROM php:7.4-fpm-alpine3.10

RUN apk add --no-cache \
    nginx \
    libzip \
    libpng \
    postgresql-libs \
    unzip \
    supervisor

# Install dependencies
RUN set -ex; \
    \
    apk add --no-cache --virtual .build-deps \
        bzip2-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxpm-dev \
        libzip-dev \
        postgresql-dev \
        zlib-dev \
    ; \
    \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp --with-xpm; \
    docker-php-ext-install bz2 gd opcache zip bcmath pdo_pgsql pdo_mysql; \
    apk del .build-deps

RUN EXPECTED_COMPOSER_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '${EXPECTED_COMPOSER_SIGNATURE}') { echo 'Composer.phar Installer verified'; } else { echo 'Composer.phar Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    addgroup -g 1000 -S siplah && \
    adduser -s /bin/sh -D -u 1000 -S siplah -G siplah && \
    mkdir /home/siplah/app && \
    chown siplah:siplah /home/siplah/app

COPY etc /etc

COPY run.sh /run.sh
RUN chmod u+rwx /run.sh

COPY --chown=siplah:siplah index.php /home/siplah/app/public/index.php

WORKDIR /home/siplah/app

EXPOSE 443 80

ENTRYPOINT ["/run.sh"]
CMD ["app"]
