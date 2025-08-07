#!/bin/bash
# Restore data if backup exists, then start containers
./auto-restore.sh
docker-compose up -d
