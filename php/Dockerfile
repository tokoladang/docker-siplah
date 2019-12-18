FROM php:7.4-fpm-alpine3.10

RUN apk add --no-cache \
    nginx \
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
        postgresql-libs \
        postgresql-dev \
        unzip \
        zlib-dev \
    ; \
    \
    docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-webp-dir=/usr --with-png-dir=/usr --with-xpm-dir=/usr; \
    docker-php-ext-install bz2 gd opcache zip bcmath pdo pgsql pdo_pgsql mysqli pdo_mysql; \
    \
    runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --virtual .phpmyadmin-phpexts-rundeps $runDeps; \
    apk del .build-deps && \
    apk del postgresql-dev

RUN addgroup -g 1000 -S siplah && \
    adduser -s /bin/sh -D -u 1000 -S siplah -G siplah && \
    mkdir /home/siplah/web && \
    chown siplah:siplah /home/siplah/web

COPY etc /etc

COPY run.sh /run.sh
RUN chmod u+rwx /run.sh

WORKDIR /home/siplah/web

EXPOSE 443 80

ENTRYPOINT ["/run.sh"]
CMD ["app"]
