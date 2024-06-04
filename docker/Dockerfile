FROM php:8.1-apache

# Copy virtual host into container
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Enable rewrite mode
RUN a2enmod rewrite

# Install necessary packages
RUN apt-get update && \
    apt-get install \
    libzip-dev \
    wget \
    curl \
    git \
    unzip \
    less \
    default-mysql-client  \
    -y --no-install-recommends

# Install PHP Extensions
RUN docker-php-ext-install pdo_mysql mysqli 

RUN pecl install -o -f xdebug-3.1.5 \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable mysqli 
#     && rm -rf /tmp/pear

# Copy composer installable
# COPY ./install-composer.sh ./

# Install wp-cli 
# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
     mv wp-cli.phar /usr/local/bin/wp \
    && chown root:www-data /usr/local/bin/wp
# RUN  mkdir /usr/local/bin/wp 

COPY ./install-wp-cli.sh /var/
RUN bash /var/install-wp-cli.sh 
    # && rm ./install-wp-cli.sh

# Copy php.ini
COPY ./php.ini /usr/local/etc/php/

# Cleanup packages and install composer
RUN apt-get purge -y g++ \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    # && sh ./install-composer.sh \
    # && rm ./install-composer.sh

# Change the current working directory
WORKDIR /var/www/html

# Change the owner of the container document root
RUN chown -R www-data:www-data /var/www/html

# Start Apache in foreground
CMD ["apache2-foreground"]

