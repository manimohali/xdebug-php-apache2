#!/bin/bash

# MySQL connection details
MYSQL_HOST=db
MYSQL_USER=root
MYSQL_PASSWORD=root
MYSQL_DATABASE=pacific_database

# Wait for MySQL to be ready
until mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" > /dev/null 2>&1; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 1
done

# Check if database exists
DB_EXISTS=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES LIKE '$MYSQL_DATABASE'" | grep "$MYSQL_DATABASE" > /dev/null; echo "$?")

# Create the database if it doesn't exist
if [ "$DB_EXISTS" -ne 0 ]; then
  echo "Database $MYSQL_DATABASE does not exist. Creating..."
  mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "CREATE DATABASE $MYSQL_DATABASE"
  echo "Database $MYSQL_DATABASE created!"
fi

# Import the data
echo "Importing data into $MYSQL_DATABASE..."
mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /var/www/html/pacific_test_export.sql
echo "Data import completed!"
