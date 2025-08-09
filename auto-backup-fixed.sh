#!/bin/bash
# Fixed backup script that works with any Moodle image

echo "Creating backup..."

# Create backup directory
mkdir -p backup

# Backup Moodle data volume
docker run --rm -v offline-exam-system_moodle_data:/data -v "$(pwd)/backup":/backup mariadb:10.6 tar czf /backup/moodle_data.tar.gz -C /data .

# Backup MariaDB data volume  
docker run --rm -v offline-exam-system_mariadb_data:/data -v "$(pwd)/backup":/backup mariadb:10.6 tar czf /backup/mariadb_data.tar.gz -C /data .

# Verify backup contains config.php
if tar -tzf backup/moodle_data.tar.gz | grep -q "config.php"; then
    echo "✅ config.php found in backup. Backup is complete."
else
    echo "⚠️  config.php not found. Backup may be incomplete."
fi

echo "✅ Auto-backup complete. Files saved in ./backup/"