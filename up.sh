#!/bin/bash
set -e
# Restore data if backup exists, then start containers
echo "Starting Training Institute LMS..."
./auto-restore.sh
docker-compose up -d
echo "✅ LMS started successfully at http://localhost:8080"
