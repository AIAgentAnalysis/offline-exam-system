#!/bin/bash
# Manual backup method that always works

echo "Creating manual backup..."

# Create backup directory with timestamp
BACKUP_DIR="backup/manual-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup Moodle files directly from container
docker exec moodle tar czf - -C /bitnami/moodle . > "$BACKUP_DIR/moodle_files.tar.gz"

# Backup database
docker exec mariadb mysqldump -u root -pmoodle bitnami_moodle > "$BACKUP_DIR/database.sql"

# Backup volumes
docker run --rm -v offline-exam-system_moodle_data:/data -v "$(pwd)/$BACKUP_DIR":/backup busybox tar czf /backup/moodle_volume.tar.gz -C /data .
docker run --rm -v offline-exam-system_mariadb_data:/data -v "$(pwd)/$BACKUP_DIR":/backup busybox tar czf /backup/mariadb_volume.tar.gz -C /data .

echo "✅ Manual backup completed in $BACKUP_DIR"
ls -la "$BACKUP_DIR"