To achieve this, you can use a custom shell script that runs after the MySQL service is up and the PHP/Apache container is started. The script will utilize WP-CLI to import data into the database.

Here's a step-by-step guide on how to set this up:

1. **Create a Custom Shell Script**: This script will use WP-CLI to import data into the database.

2. **Modify `docker-compose.yml`**: Add a command to the PHP service to run the shell script after the containers are started.

### Step 1: Create the Custom Shell Script

Create a file named `import-data.sh` in your project directory:

```sh
#!/bin/bash

# Wait for MySQL to be ready
until mysqladmin ping -h db --silent; do
  echo "Waiting for MySQL..."
  sleep 2
done

# Import data using WP-CLI
wp db import /path/to/your/dump.sql --allow-root

# Any other WP-CLI commands can be added here
# wp plugin install some-plugin --activate --allow-root

echo "Data import completed."
```

Make sure the script is executable:

```sh
chmod +x import-data.sh
```

### Step 2: Modify `docker-compose.yml`

Update your `docker-compose.yml` to include a command that runs the shell script after the PHP/Apache service starts:

```yaml
version: '3.8'

services:
  web:
    image: php:8.1-apache
    container_name: my_php_app
    volumes:
      - .:/var/www/html
    ports:
      - "8080:80"
    depends_on:
      - db
    environment:
      MYSQL_HOST: db
      MYSQL_DATABASE: php_mvc
      MYSQL_USER: root
      MYSQL_PASSWORD: root
    command: >
      sh -c "apache2-foreground & ./import-data.sh"
    working_dir: /var/www/html

  db:
    image: mysql:5.7
    container_name: my_mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: php_mvc
    ports:
      - "3306:3306"
```

### Step 3: Update Dockerfile

Ensure your `Dockerfile` includes the necessary steps to install WP-CLI and copies the `import-data.sh` script:

```dockerfile
FROM php:8.1-apache

# Copy virtual host into container
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Enable rewrite mode
RUN a2enmod rewrite

# Install necessary packages and PHP extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev \
    wget \
    curl \
    git \
    unzip \
    && docker-php-ext-install zip pdo_mysql mysqli \
    && docker-php-ext-enable pdo_mysql mysqli

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    chown root:www-data /usr/local/bin/wp

# Copy and execute WP-CLI installation script
COPY ./install-wp-cli.sh /var/
RUN bash /var/install-wp-cli.sh

# Copy import data script
COPY ./import-data.sh /var/www/html/
RUN chmod +x /var/www/html/import-data.sh

# Copy php.ini
COPY ./php.ini /usr/local/etc/php/

# Cleanup packages
RUN apt-get purge -y g++ \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/* \
    && rm -rf /tmp/*

# Change the current working directory
WORKDIR /var/www

# Change the owner of the container document root
RUN chown -R www-data:www-data /var/www

# Start Apache in foreground
CMD ["apache2-foreground"]
```

### Steps to Run

1. **Build and Start Containers**:
   ```sh
   docker-compose up --build
   ```

