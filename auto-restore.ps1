# Automatically restore Moodle and MariaDB volumes from backup when starting on a new PC

if (!(Test-Path -Path "backup" -PathType Container)) {
    Write-Host "ERROR: 'backup' folder not found in current directory ($(Get-Location))."
    Write-Host "Please run this script from your project folder where the backup folder exists."
    exit 1
}

if (Test-Path "backup/moodle_data.tar.gz") {
    docker volume create offline-exam-system_moodle_data | Out-Null
    $currentPath = (Get-Location).Path
    docker run --rm -v offline-exam-system_moodle_data:/data -v "${currentPath}\backup:/backup" alpine tar xzf /backup/moodle_data.tar.gz -C /data
    Write-Host "Moodle data restored."
} else {
    Write-Host "No Moodle backup found."
}

if (Test-Path "backup/mariadb_data.tar.gz") {
    docker volume create offline-exam-system_mariadb_data | Out-Null
    $currentPath = (Get-Location).Path
    docker run --rm -v offline-exam-system_mariadb_data:/data -v "${currentPath}\backup:/backup" alpine tar xzf /backup/mariadb_data.tar.gz -C /data
    Write-Host "MariaDB data restored."
} else {
    Write-Host "No MariaDB backup found."
}

# Ensure script runs regardless of execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
