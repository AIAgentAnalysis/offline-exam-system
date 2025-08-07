# Automatically backup Moodle and MariaDB volumes before stopping containers

if (!(Test-Path -Path "backup" -PathType Container)) {
    Write-Host "ERROR: 'backup' folder not found in current directory ($(Get-Location))."
    Write-Host "Please run this script from your project folder where the backup folder exists."
    exit 1
}

# Use correct path string for PowerShell
$backupPath = (Get-Location).Path + "\backup"
# Backup Moodle data volume
docker run --rm -v offline-exam-system_moodle_data:/data -v "$backupPath":/backup alpine tar czf /backup/moodle_data.tar.gz -C /data .
# Backup MariaDB data volume
docker run --rm -v offline-exam-system_mariadb_data:/data -v "$backupPath":/backup alpine tar czf /backup/mariadb_data.tar.gz -C /data .

Write-Host "Auto-backup complete. Files saved in ./backup/"

# Ensure script runs regardless of execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
