#!/bin/bash
# Backup data, then stop containers
./auto-backup.sh
docker-compose down
