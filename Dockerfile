FROM php:7.4-fpm-alpine3.10

RUN apk add --no-cache \
    nginx \
    libzip \
    postgresql-libs \
    unzip \
    supervisor

# Install dependencies
RUN set -ex; \
    \
    apk add --no-cache --virtual .build-deps \
        bzip2-dev \
        libzip-dev \
        postgresql-dev \
        zlib-dev \
    ; \
    \
    docker-php-ext-install bz2 opcache zip bcmath pdo_pgsql pdo_mysql; \
    apk del .build-deps

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN addgroup -g 1000 -S siplah && \
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
