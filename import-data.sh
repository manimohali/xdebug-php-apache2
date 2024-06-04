#!/bin/bash

# Path to the backup file
BACKUP_FILE="/var/www/html/backup.sql"

# Wait for MySQL to be ready
until mysqladmin ping -h db --silent; do
  echo "Waiting for MySQL..."
  sleep 2
done

# Check if the backup file exists
if [ -f "$BACKUP_FILE" ]; then
  # Import data using WP-CLI
  wp db import "$BACKUP_FILE" --allow-root --path="/var/www/html"
else
  echo "Backup file not found: $BACKUP_FILE"
fi

# Any other WP-CLI commands can be added here
# wp plugin install some-plugin --activate --allow-root

echo "Database export and import completed."
