# 🚨 Docker Running But Website Not Opening - Troubleshooting Guide

## Problem Scenario
- `docker ps` shows containers as "Up" or "Restarting"
- Website at `localhost:8080` not accessible
- Moodle appears to be running but can't reach it

## Step-by-Step Diagnosis

### 1. Check Container Status
```bash
docker ps
# Look for STATUS column:
# - "Up X minutes" = Good
# - "Restarting (X) Y seconds ago" = Problem
```

### 2. Check Container Logs
```bash
docker logs moodle --tail 20
# Look for error messages like:
# - "config.php: No such file or directory"
# - Database connection errors
# - Apache/PHP errors
```

### 3. Find Container IP Address
```bash
# Method 1: Inspect container
docker inspect moodle | grep IPAddress

# Method 2: Get network info
docker network ls
docker network inspect offline-exam-system_default

# Method 3: Quick IP extraction
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' moodle
```

### 4. Test Direct Container Access
```bash
# Replace X.X.X.X with actual container IP
curl -s -o /dev/null -w "%{http_code}" http://X.X.X.X:8080

# If returns 200 = Moodle works, port forwarding issue
# If returns 000 = Moodle not responding
```

### 5. Check Port Forwarding
```bash
# Check if port 8080 is listening on host
ss -tlnp | grep 8080
netstat -tlnp | grep 8080

# Should show:
# LISTEN 0.0.0.0:8080
```

### 6. Test Different Access Methods
```bash
# Test with wget
wget -q --spider http://localhost:8080 && echo "SUCCESS" || echo "FAILED"

# Test with curl
curl -s http://localhost:8080 | head -5

# Test actual content
curl -I http://localhost:8080
```

## Common Solutions

### Solution 1: Backup Corruption (Most Common)
**Symptoms:** Container keeps restarting, config.php missing
```bash
# Complete cleanup
docker-compose down -v
docker system prune -f

# Start fresh
docker-compose up -d
```

### Solution 2: Port Conflict
**Symptoms:** Port already in use
```bash
# Check what's using port 8080
sudo lsof -i :8080

# Kill conflicting process or change port in docker-compose.yml
```

### Solution 3: WSL2 Networking Issue
**Symptoms:** Works on container IP but not localhost
```bash
# Restart WSL2
wsl --shutdown
wsl

# Or restart Docker Desktop
```

### Solution 4: Firewall/Security
**Symptoms:** Connection refused
```bash
# Check Windows firewall
# Allow Docker Desktop through firewall
# Check antivirus blocking ports
```

## Prevention Tips

1. **Always check logs first**: `docker logs moodle`
2. **Test container IP directly** before assuming network issues
3. **Keep backup verification**: Check backup integrity before restore
4. **Document working configurations** for quick recovery

## Quick Reference Commands

```bash
# Essential diagnosis commands
docker ps                                    # Container status
docker logs moodle --tail 10               # Recent logs
docker inspect moodle | grep IPAddress     # Get container IP
curl -I http://localhost:8080              # Test website
ss -tlnp | grep 8080                       # Check port listening

# Recovery commands
docker-compose down -v                     # Complete cleanup
docker system prune -f                     # Remove unused resources
docker-compose up -d                       # Fresh start
```

## When to Use Each Solution

- **Restarting containers** → Check logs, likely backup issue
- **Port not accessible** → Check port forwarding and conflicts  
- **Works on container IP only** → WSL2/networking issue
- **Connection refused** → Firewall/security blocking

---
**Created:** $(date)
**Last Updated:** $(date)
**Project:** Manfree Technologies LMS