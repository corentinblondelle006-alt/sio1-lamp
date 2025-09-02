FROM php:8.3-apache
COPY app/ /var/www/html

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf 

# Install useful tools and install important libaries
RUN apt-get -y update  \
    && apt-get -y --no-install-recommends install nano wget dialog locales \
    && apt-get -y --no-install-recommends install default-mysql-client zlib1g-dev libzip-dev libicu-dev \
    && apt-get -y --no-install-recommends install --fix-missing apt-utils build-essential git curl libonig-dev\ 
    && apt-get install -y iputils-ping \
    && apt-get -y --no-install-recommends install --fix-missing libcurl4 libcurl4-openssl-dev zip openssl

RUN apt-get update && apt-get install -y --no-install-recommends \
    # Dépendances PHP essentielles
    zlib1g-dev libzip-dev libicu-dev libonig-dev libcurl4-openssl-dev \
    # Outils dev essentiels
    git curl nano \
    # BDD 
    default-mysql-client 

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && mkdir -p /var/log/xdebug \
    && chmod 777 /var/log/xdebug \
    && touch /var/log/xdebug/xdebug.log \
    && chmod 666 /var/log/xdebug/xdebug.log
  
# Other PHP8 Extensions
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install zip mbstring


# Insure an SSL directory exists
RUN mkdir -p /etc/apache2/ssl

# Enable apache modules
RUN a2enmod rewrite headers ssl

# Cleanup
RUN rm -rf /usr/src/* \
    && rm -rf /var/lib/apt/lists/* 

# Crée un script pour recharger Apache/PHP
RUN echo '#!/bin/bash\nkill -USR2 1\necho "Apache/PHP rechargé"' > /usr/local/bin/reload-php.sh \
    && chmod +x /usr/local/bin/reload-php.sh

WORKDIR /var/www/html
