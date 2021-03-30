#!/bin/bash
echo "Start waiting for MySQL"
until mysql -h $DB_HOSTNAME -u$DB_USERNAME -p$DB_PASSWORD -e "SELECT 1;"; do
    echo "MySQL is unavailable - sleeping"
    sleep 1
done
echo "MySQL is ready to accept connections"

echo "Start waiting for Redis"
until redis-cli -h $REDIS_HOST ping; do
    echo "Redis is unavailable - sleeping"
    sleep 1
done
echo "Redis is ready"
