
#!/bin/bash
# Automatically restore Moodle and MariaDB volumes from backup when starting on a new PC

# Check if backup folder exists in current directory
if [ ! -d "backup" ]; then
  echo "ERROR: 'backup' folder not found in current directory ($(pwd))."
  echo "Please run this script from your project folder where the backup folder exists."
  exit 1
fi

if [ -f backup/moodle_data.tar.gz ]; then
  docker volume create offline-exam-system_moodle_data
  docker run --rm -v offline-exam-system_moodle_data:/data -v "$(pwd)/backup":/backup mariadb:10.6 tar xzf /backup/moodle_data.tar.gz -C /data
  echo "Moodle data restored."
else
  echo "No Moodle backup found."
fi

if [ -f backup/mariadb_data.tar.gz ]; then
  docker volume create offline-exam-system_mariadb_data
  docker run --rm -v offline-exam-system_mariadb_data:/data -v "$(pwd)/backup":/backup mariadb:10.6 tar xzf /backup/mariadb_data.tar.gz -C /data
  echo "MariaDB data restored."
else
  echo "No MariaDB backup found."
fi
