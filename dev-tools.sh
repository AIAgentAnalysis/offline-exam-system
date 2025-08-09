#!/bin/bash
# Development tools setup for WSL2 Moodle development

echo "🔧 Setting up Moodle development tools in WSL2..."

# Install PHP development tools
sudo apt update
sudo apt install -y php-cli php-zip php-curl php-xml php-mbstring php-dev

# Install Composer
if ! command -v composer &> /dev/null; then
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
    echo "✅ Composer installed"
fi

# Install Node.js for theme development
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo "✅ Node.js installed"
fi

# Install Moodle development tools
npm install -g grunt-cli

# Setup file permissions for development
sudo chown -R $USER:$USER themes/
sudo chown -R $USER:$USER plugins/

# Create development shortcuts
cat > dev-commands.sh << 'EOF'
#!/bin/bash
# Quick development commands

# Restart Moodle container
alias moodle-restart='docker-compose restart moodle'

# Access Moodle container
alias moodle-shell='docker exec -it moodle bash'

# Access database
alias moodle-db='docker exec -it mariadb mysql -u root -p${DB_ROOT_PASSWORD} bitnami_moodle'

# Watch logs
alias moodle-logs='docker-compose logs -f moodle'

# Quick backup for testing
alias quick-backup='./auto-backup.sh'

echo "Development shortcuts loaded!"
echo "Usage: moodle-restart, moodle-shell, moodle-db, moodle-logs, quick-backup"
EOF

chmod +x dev-commands.sh

echo "✅ Development tools setup completed!"
echo "Run 'source dev-commands.sh' to load development shortcuts"