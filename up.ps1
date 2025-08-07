# Ensure script runs regardless of execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
# up.ps1 - Windows PowerShell equivalent of up.sh
# Restore data if backup exists, then start containers

. ./auto-restore.ps1

docker-compose up -d
