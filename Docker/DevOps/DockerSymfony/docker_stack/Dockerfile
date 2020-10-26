# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/develop/develop-images/multistage-build/#stop-at-a-specific-build-stage
# https://docs.docker.com/compose/compose-file/#target


# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION=7.4

# "php" stage
FROM php:${PHP_VERSION}-fpm-alpine AS php

# Persistent / runtime deps
RUN apk add --no-cache \
    acl \
    fcgi \
    file \
    gettext \
    git \
    bash \
    ;

ARG APCU_VERSION=5.1.18
RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    icu-dev \
    libzip-dev \
    postgresql-dev \
    zlib-dev \
    ; \
    \
    docker-php-ext-configure zip; \
    docker-php-ext-install -j$(nproc) \
    intl \
    pdo_pgsql \
    zip \
    ; \
    pecl install \
    apcu-${APCU_VERSION} \
    ; \
    pecl clear-cache; \
    docker-php-ext-enable \
    apcu \
    opcache \
    ; \
    \
    runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
    | tr ',' '\n' \
    | sort -u \
    | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --no-cache --virtual .api-phpexts-rundeps $runDeps; \
    \
    apk del .build-deps

# Symfony binary
RUN set -eux; \
    curl -sS https://get.symfony.com/cli/installer | bash; \
    mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# Composer
ENV COMPOSER_ALLOW_SUPERUSER=1
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Symfony Flex globally to speed up download of Composer packages (parallelized prefetching)
RUN set -eux; \
    composer global require "symfony/flex" --prefer-dist --no-progress --no-suggest --classmap-authoritative; \
    composer clear-cache
ENV PATH="${PATH}:/root/.composer/vendor/bin"

WORKDIR /srv/php

# Create specific user, avoid root for security reasons
ARG CURRENT_UID
ARG CURRENT_GID
RUN addgroup -S -g ${CURRENT_GID} candidate; \
    adduser -S -u ${CURRENT_UID} -D -G candidate candidate;

# Change permisions
RUN set -eux; \
    setfacl -R -m u:candidate:rwX $PHP_INI_DIR ; \
    setfacl -R -m u:candidate:rwX /var ; \
    setfacl -dR -m u:candidate:rwX /var ; \
    setfacl -R -n -m  u:candidate:rwX ./ ; \
    setfacl -dR -n -m u:candidate:rwX ./ ; \
    chown -R candidate:candidate /var ; \
    chown -R candidate:candidate $PHP_INI_DIR ; \
    chown -R candidate:candidate ./

USER candidate

CMD ["tail", "-f", "/dev/null"]
