#!/bin/bash
# Automatically restore Moodle and MariaDB volumes from backup when starting on a new PC
if [ -f backup/moodle_data.tar.gz ]; then
  docker volume create offline-exam-system_moodle_data
  docker run --rm -v offline-exam-system_moodle_data:/data -v "$(pwd)/backup":/backup alpine tar xzf /backup/moodle_data.tar.gz -C /data
  echo "Moodle data restored."
else
  echo "No Moodle backup found."
fi

if [ -f backup/mariadb_data.tar.gz ]; then
  docker volume create offline-exam-system_mariadb_data
  docker run --rm -v offline-exam-system_mariadb_data:/data -v "$(pwd)/backup":/backup alpine tar xzf /backup/mariadb_data.tar.gz -C /data
  echo "MariaDB data restored."
else
  echo "No MariaDB backup found."
fi
