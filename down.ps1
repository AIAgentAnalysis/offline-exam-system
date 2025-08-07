# Ensure script runs regardless of execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
# down.ps1 - Windows PowerShell equivalent of down.sh
# Backup data, then stop containers

. ./auto-backup.ps1

docker-compose down
