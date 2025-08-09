# 🐧 WSL2 Development Setup Guide

## Why WSL2 for Moodle Development?

✅ **Better Plugin Support** - Native Linux environment for PHP/Moodle plugins  
✅ **File Permissions** - Proper Unix permissions for themes and customizations  
✅ **Performance** - Faster Docker operations and file I/O  
✅ **Development Tools** - Full Linux toolchain for customization  
✅ **No Path Issues** - Native Unix paths work perfectly with Moodle  

---

## 🚀 Complete WSL2 Setup

### 1. Install WSL2 + Ubuntu
```powershell
# Run in PowerShell as Administrator
wsl --install -d Ubuntu-22.04
wsl --set-default-version 2
```

### 2. Setup Development Environment
```bash
# Inside WSL2 Ubuntu
sudo apt update && sudo apt upgrade -y

# Install essential tools
sudo apt install -y git curl wget unzip php-cli php-zip

# Install Docker (if not using Docker Desktop)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

### 3. Clone and Setup Project
```bash
# Clone in WSL2 filesystem (not /mnt/c/)
cd ~
git clone <your-repo-url> offline-exam-system
cd offline-exam-system

# Make scripts executable
chmod +x *.sh

# Setup environment
cp .env.example .env  # Edit with your settings
```

---

## 🔧 WSL2-Specific Configurations

### Docker Integration
```bash
# Verify Docker works in WSL2
docker --version
docker-compose --version

# Test with your project
./up.sh
```

### File System Best Practices
```bash
# ✅ GOOD: Store project in WSL2 filesystem
~/offline-exam-system/

# ❌ AVOID: Windows filesystem (slow)
/mnt/c/Users/YourName/offline-exam-system/
```

### Network Access
```bash
# Get WSL2 IP for LAN access
hostname -I

# Access from Windows browser
http://localhost:8080
# Or from other devices
http://<wsl-ip>:8080
```

---

## 🎨 Enhanced Development Workflow

### Plugin Development
```bash
# Direct plugin development in WSL2
cd themes/manfree/
code .  # VS Code with WSL extension

# Live editing with volume mounts
# Changes reflect immediately in running container
```

### Custom Theme Development
```bash
# Edit theme files directly
nano themes/manfree/custom.scss
nano themes/manfree/config.php

# Restart to apply changes
docker-compose restart moodle
```

### Database Access
```bash
# Direct database access for development
docker exec -it mariadb mysql -u root -p${DB_ROOT_PASSWORD} bitnami_moodle

# Backup specific tables for testing
docker exec mariadb mysqldump -u root -p${DB_ROOT_PASSWORD} bitnami_moodle mdl_course > courses_backup.sql
```

---

## 🛠️ Development Tools Setup

### VS Code Integration
```bash
# Install VS Code extensions in WSL2
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension bradlc.vscode-tailwindcss
```

### PHP Development
```bash
# Install PHP tools for Moodle development
sudo apt install -y php-dev php-xdebug php-curl php-xml php-mbstring

# Composer for PHP dependencies
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

---

## 🚨 Common WSL2 Issues & Solutions

### Docker Permission Issues
```bash
# Fix Docker socket permissions
sudo chmod 666 /var/run/docker.sock
```

### Memory Limits
```powershell
# Create .wslconfig in Windows user folder
# C:\Users\YourName\.wslconfig
[wsl2]
memory=4GB
processors=2
```

### Port Access Issues
```bash
# Forward ports from WSL2 to Windows
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=8080 connectaddress=<wsl-ip>
```

---

## 📈 Performance Optimizations

### Docker Performance
```yaml
# Add to docker-compose.yml for better performance
services:
  moodle:
    volumes:
      - moodle_data:/bitnami/moodle:cached
      - ./themes/manfree:/bitnami/moodle/theme/manfree:delegated
```

### File Watching
```bash
# Increase file watch limits for development
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

---

## 🎯 Next Steps for Training Institute

1. **Setup WSL2 environment** following this guide
2. **Migrate existing data** using backup/restore scripts
3. **Develop custom plugins** in native Linux environment
4. **Create institute-specific themes** with proper tooling
5. **Setup automated testing** for plugin development

**Pro Tip**: Keep your development in WSL2 filesystem for best performance and compatibility!