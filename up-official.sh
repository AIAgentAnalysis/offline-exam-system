#!/bin/bash
set -e
# Start with official Moodle image

echo "Starting Training Institute LMS (Official Moodle)..."

# Restore data if backup exists
./auto-restore-working.sh

# Start with official Moodle
docker-compose -f docker-compose-official.yml up -d

echo "✅ LMS started successfully at http://localhost:8080"
echo "📋 Using Official Moodle Image - Better backup compatibility"