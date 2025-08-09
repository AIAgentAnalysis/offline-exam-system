# 💾 Backup & Recovery Guide - Manfree Technologies LMS

## ⚠️ Important: Backup Safety

### Current Situation
- **Fresh Moodle is running** - Don't lose this working state!
- **Old backups exist** in `backup/` folder but may be corrupted
- **Need to create new backup** from current working system

## 🔄 Safe Backup Process

### 1. Create New Backup (While System is Running)
```bash
# Create new backup from current working system
./auto-backup.sh

# This will create:
# - backup/moodle_data.tar.gz (fresh, working)
# - backup/mariadb_data.tar.gz (fresh, working)
```

### 2. Backup Verification
```bash
# Check if config.php exists in new backup
tar -tzf backup/moodle_data.tar.gz | grep "^./config.php$"

# Should return: ./config.php
# If empty = backup failed
```

### 3. Archive Old Backups (Safety)
```bash
# Create archive folder
mkdir -p backup/archive/$(date +%Y%m%d_%H%M%S)

# Move old backups to archive
mv backup/*.tar.gz backup/archive/$(date +%Y%m%d_%H%M%S)/

# Create fresh backup
./auto-backup.sh
```

## 🔍 How to Find Container IP Address

### Method 1: Docker Inspect (Recommended)
```bash
# Get container IP
docker inspect moodle | grep IPAddress

# Output example:
# "IPAddress": "172.18.0.4"
```

### Method 2: Quick IP Extraction
```bash
# One-liner to get IP
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' moodle

# Output: 172.18.0.4
```

### Method 3: Network Information
```bash
# List networks
docker network ls

# Inspect network (replace with actual network name)
docker network inspect offline-exam-system_default
```

### Method 4: Container Internal Check
```bash
# Get IP from inside container
docker exec moodle hostname -I
```

## 📋 Backup Recovery Scenarios

### Scenario 1: System Working - Want to Backup
```bash
# Safe backup while running
./down.sh    # This backs up AND stops
./up.sh      # This restores AND starts
```

### Scenario 2: System Broken - Need to Restore
```bash
# If you have good backup
docker-compose down -v    # Clean everything
./up.sh                   # Restore and start

# If backup is corrupted
docker-compose down -v    # Clean everything  
docker-compose up -d      # Start fresh (lose data)
```

### Scenario 3: Want to Test Backup Without Losing Current
```bash
# Method 1: Use different project name
docker-compose -p test-restore up -d

# Method 2: Copy project folder
cp -r offline-exam-system offline-exam-system-test
cd offline-exam-system-test
./up.sh
```

## 🛡️ Backup Best Practices

### 1. Regular Backup Schedule
```bash
# Add to crontab for daily backup
crontab -e
# Add: 0 2 * * * cd /path/to/offline-exam-system && ./auto-backup.sh
```

### 2. Backup Verification Script
```bash
# Create verification script
cat > verify-backup.sh << 'EOF'
#!/bin/bash
echo "Verifying backup integrity..."

# Check if files exist
if [ ! -f "backup/moodle_data.tar.gz" ]; then
    echo "❌ Moodle backup missing"
    exit 1
fi

if [ ! -f "backup/mariadb_data.tar.gz" ]; then
    echo "❌ Database backup missing"  
    exit 1
fi

# Check if config.php exists in backup
if tar -tzf backup/moodle_data.tar.gz | grep -q "^./config.php$"; then
    echo "✅ Moodle backup verified"
else
    echo "❌ Moodle backup corrupted (no config.php)"
    exit 1
fi

echo "✅ All backups verified successfully"
EOF

chmod +x verify-backup.sh
```

### 3. Multiple Backup Locations
```bash
# Copy backups to external location
cp backup/*.tar.gz /mnt/external-drive/lms-backups/
# Or upload to cloud storage
```

## 🚨 Emergency Recovery

### If Everything Breaks
1. **Stop all containers**: `docker-compose down -v`
2. **Clean Docker**: `docker system prune -f`
3. **Start fresh**: `docker-compose up -d`
4. **Wait for initialization**: Check logs with `docker logs moodle`
5. **Create new backup**: `./auto-backup.sh`

### If Backup is Corrupted
1. **Don't panic** - start fresh installation
2. **Recreate content** using your course templates
3. **Import questions** from `question_set/` folder
4. **Reinstall plugins** from `plugins/` folder
5. **Apply theme** from `themes/manfree/`

## 📊 Backup Status Check

### Quick Health Check
```bash
# Check current system
docker ps                           # All containers running?
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080  # Website accessible?

# Check backup integrity  
./verify-backup.sh                  # Backups valid?

# Check disk space
df -h                               # Enough space for backups?
```

---
**Remember:** Always test your backups in a separate environment before relying on them for recovery!