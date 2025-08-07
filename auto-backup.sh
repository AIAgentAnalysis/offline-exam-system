#!/bin/bash
# Automatically backup Moodle and MariaDB volumes before stopping containers
mkdir -p backup

# Check if backup folder exists in current directory
if [ ! -d "backup" ]; then
	echo "ERROR: 'backup' folder not found in current directory ($(pwd))."
	echo "Please run this script from your project folder where the backup folder exists."
	exit 1
fi

docker run --rm -v offline-exam-system_moodle_data:/data -v "$(pwd)/backup":/backup alpine tar czf /backup/moodle_data.tar.gz -C /data .
docker run --rm -v offline-exam-system_mariadb_data:/data -v "$(pwd)/backup":/backup alpine tar czf /backup/mariadb_data.tar.gz -C /data .

echo "Auto-backup complete. Files saved in ./backup/"
