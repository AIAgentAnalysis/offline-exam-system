#!/bin/bash
# Fixed restore script that works with Bitnami

echo "Restoring Moodle data..."

# Create volumes first
docker volume create offline-exam-system_moodle_data
docker volume create offline-exam-system_mariadb_data

# Restore Moodle data
if [ -f "backup/moodle_data.tar.gz" ]; then
    docker run --rm -v offline-exam-system_moodle_data:/data -v "$(pwd)/backup":/backup busybox tar xzf /backup/moodle_data.tar.gz -C /data
    echo "Moodle data restored."
else
    echo "No Moodle backup found."
fi

# Restore MariaDB data  
if [ -f "backup/mariadb_data.tar.gz" ]; then
    docker run --rm -v offline-exam-system_mariadb_data:/data -v "$(pwd)/backup":/backup busybox tar xzf /backup/mariadb_data.tar.gz -C /data
    echo "MariaDB data restored."
else
    echo "No MariaDB backup found."
fi

# Fix permissions
docker run --rm -v offline-exam-system_moodle_data:/data busybox chown -R 1001:1001 /data
docker run --rm -v offline-exam-system_mariadb_data:/data busybox chown -R 999:999 /data