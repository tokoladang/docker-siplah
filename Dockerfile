from composer

RUN set -ex; \
    \
    apk add --no-cache --virtual .build-deps \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
        zlib-dev \
    ; \
    \
    docker-php-ext-install gd; \
    apk del .build-deps
