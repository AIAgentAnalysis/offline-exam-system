#!/bin/bash
# Automatically backup Moodle and MariaDB volumes before stopping containers
mkdir -p backup

docker run --rm -v offline-exam-system_moodle_data:/data -v "$(pwd)/backup":/backup alpine tar czf /backup/moodle_data.tar.gz -C /data .
docker run --rm -v offline-exam-system_mariadb_data:/data -v "$(pwd)/backup":/backup alpine tar czf /backup/mariadb_data.tar.gz -C /data .

echo "Auto-backup complete. Files saved in ./backup/"
