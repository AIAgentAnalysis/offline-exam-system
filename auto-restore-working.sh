#!/bin/bash
# Working restore script using existing containers

echo "Restoring Moodle data..."

# Create volumes first
docker volume create offline-exam-system_moodle_data
docker volume create offline-exam-system_mariadb_data

# Start containers temporarily to restore data
docker-compose up -d mariadb
sleep 10

# Restore using existing MariaDB container
if [ -f "backup/moodle_data.tar.gz" ]; then
    docker run --rm -v offline-exam-system_moodle_data:/data -v "$(pwd)/backup":/backup mariadb:10.6 bash -c "cd /data && tar xzf /backup/moodle_data.tar.gz"
    echo "Moodle data restored."
fi

if [ -f "backup/mariadb_data.tar.gz" ]; then
    docker run --rm -v offline-exam-system_mariadb_data:/data -v "$(pwd)/backup":/backup mariadb:10.6 bash -c "cd /data && tar xzf /backup/mariadb_data.tar.gz"
    echo "MariaDB data restored."
fi

# Stop temporary containers
docker-compose down