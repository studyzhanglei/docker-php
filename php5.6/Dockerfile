FROM php:5.6-fpm

LABEL MAINTAINER="Php5.6"

ENV TZ=Asia/Shanghai \
    PHPREDIS_VERSION=3.1.4 \
    AMQP_VERSION=1.10.2 \
    PSR_VERSION=0.6.0
#copy start sh
COPY ./sh/start.sh /bin/
# #copy opcache.ini
RUN chmod -R 711 /bin/start.sh
# RUN curl -o /etc/apt/sources.list http://mirrors.cloud.tencent.com/repo/debian10_sources.list \
#     && apt-get clean all \
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libfreetype6-dev libjpeg62-turbo-dev librabbitmq-dev \
        vim wget  net-tools nginx procps zip unzip cron libonig-dev libzip-dev\
# Install composer
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer self-update --clean-backups \
# Install PHP extensions
    && docker-php-ext-install \
     pdo_mysql opcache iconv bcmath sockets  mbstring  json zip \
# Install amqp extension
    && wget http://pecl.php.net/get/amqp-${AMQP_VERSION}.tgz -O /tmp/amqp.tar.tgz \
    && pecl install /tmp/amqp.tar.tgz \
# Install redis extension
    && wget http://pecl.php.net/get/redis-${PHPREDIS_VERSION}.tgz -O /tmp/redis.tar.tgz \
    && pecl install /tmp/redis.tar.tgz \
# Install mongodb
    && pecl install mongodb-1.7.5 \
# Install psr extension
    && wget http://pecl.php.net/get/psr-${PSR_VERSION}.tgz -O /tmp/psr.tar.tgz \
    && pecl install /tmp/psr.tar.tgz \
# Install
    && docker-php-ext-enable amqp redis  psr mongodb\
# Timezone
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
# clean .tar.gz
    && rm -Rf /tmp/*