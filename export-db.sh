#!/bin/bash

CONTAINER_NAME="xdebug-php-apache2-app-1"
EXPORT_PATH="/var/www/html/backup.sql"

docker exec -it $CONTAINER_NAME wp db export $EXPORT_PATH --allow-root
