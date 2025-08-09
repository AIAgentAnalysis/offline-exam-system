#!/bin/bash
set -e
# Backup data, then stop containers
echo "Stopping LMS and creating backup..."
./auto-backup.sh
docker-compose down
echo "✅ LMS stopped and backup completed"
