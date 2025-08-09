# 📝 Offline Exam System

**Advanced Moodle-based, LAN-ready, Dockerized exam platform. 100% Offline.**

## 🔄 Distributed Workflow Support

**Perfect for multi-location training institutes:**
- **Company Location**: Staff/students use LMS → `./down.sh` → commit backup → push to Git
- **Remote Location**: Pull from Git → `./up.sh` → LMS restored with all data
- **Seamless Sync**: Complete data synchronization via Git repository

---

## � Table of Contents

1. [System Requirements](#system-requirements)
2. [Quick Start](#quick-start)
3. [What's Inside](#whats-inside)
4. [LAN-Based Exam Instructions](#lan-based-exam-instructions)
5. [Docker Services Used](#docker-services-used)
6. [Features](#features)
7. [Plugin Support](#plugin-support)
8. [Lockdown/SEB Support](#lockdownseb-support)
9. [Best Practices](#best-practices)
10. [Backup & Restore](#backup--restore)
11. [Instructor Workflow](#instructor-workflow)
12. [Student Workflow](#student-workflow)
13. [Troubleshooting](#troubleshooting)
14. [Resources](#resources)
15. [Need Help?](#need-help)

---

## 🖥️ System Requirements

**Recommended: WSL2 + Docker Desktop (Windows)**
- WSL2 (Ubuntu 20.04+ recommended)
- Docker Desktop with WSL2 backend
- At least 4GB RAM, 2 CPU cores recommended
- ~10GB free disk space
- Git installed in WSL

**Alternative: Native Linux/macOS**
- Docker Engine/Desktop
- Bash shell
- Git

---

## �🚀 Quick Start

1. **Clone Repo**
   ```bash
   git clone https://github.com/AIAgentAnalysis/offline-exam-system.git
   cd offline-exam-system
   ```

2. **Start All Services**

   ```bash
   docker compose up -d
   ```

3. **Login to Moodle**

   * URL: `http://localhost:8080` or `http://<your-LAN-IP>:8080`
   * Username: `admin`
   * Password: `admin123`

4. **(Optional) Install Plugins**

   * Place plugin `.zip` files inside the `plugins/` folder (e.g., `qtype_coderunner.zip`)
   * Restart containers:

     ```bash
     docker compose down
     docker compose up -d
     ```
   * Visit Moodle's GUI → Site admin → Install plugins

5. **Import Sample Quiz**

   * Moodle GUI → Course → Quiz → Import
   * Use: `import/sample_exam_quiz.xml`

---

## 📦 What's Inside


```plaintext
offline-exam-system/
├── auto-backup.ps1/.sh              # Backup scripts (PowerShell & Bash)
├── auto-restore.ps1/.sh             # Restore scripts (PowerShell & Bash)
├── backup/                          # Backup data (mariadb_data.tar.gz, moodle_data.tar.gz)
├── Configuring/                     # (custom folder, usage TBD)
├── custom-theme/
│   └── manfreetech/                 # Custom theme (empty or for future use)
├── docker-compose.yml               # Docker stack (Moodle + MariaDB + Jobe)
├── down.ps1/.sh                     # Stop/backup scripts
├── gitignore.txt
├── import/
│   └── import_sample_exam_quiz.xml  # Example Moodle XML quiz
├── moodle_data/
│   ├── plugins/
│   │   └── qtype_coderunner.zip     # CodeRunner plugin (zip)
│   └── question/type/qtype_drawio/  # Draw.io plugin (source)
├── plugins/
│   ├── qtype_coderunner.zip         # CodeRunner plugin (zip)
│   └── qtype_drawio/                # Draw.io plugin (source)
├── question_set/
│   └── sample_c_qstn.xml            # Sample C question set
├── README.md
├── README_Lockdown.md
├── Restoring/                       # (custom folder, usage TBD)
├── Setting/                         # (custom folder, usage TBD)
├── setup-scripts/
│   ├── custom-theme/
│   │   └── manfreetech/
│   │       ├── lang/en/             # (empty)
│   │       ├── layout/
│   │       ├── pix/
│   │       └── style/
│   └── setup-scripts_install-plugins.sh
├── themes/
│   └── manfree/
│       ├── config.php
│       ├── custom.scss
│       ├── default.php
│       ├── frontpage.php
│       ├── lang/en/theme_manfree.php
│       ├── lib.php
│       ├── login.php
│       ├── logo.png
│       ├── settings.php
│       ├── theme_manfree.php
│       └── version.php
├── Trying/                          # (custom folder, usage TBD)
├── up.ps1/.sh                       # Start/restore scripts
├── Validating/                      # (custom folder, usage TBD)
```

---

## 🌐 LAN-Based Exam Instructions

1. Instructor launches the server via Docker.
2. Connect all student devices to same Wi-Fi/hotspot.
3. Students open browser: `http://<instructor-ip>:8080`
   * Get IP with: `wsl hostname -I` or `ipconfig`
4. Students log in and take the exam.
5. Answers stored centrally for grading.

> 💡 No internet required after initial setup. Moodle + DB runs entirely offline.

---

## 🛠️ Docker Services Used

| Service | Role                         | Port |
| ------- | ---------------------------- | ---- |
| Moodle  | LMS & exam UI (Bitnami)      | 8080 |
| MariaDB | Moodle DB backend            | 3306 |
| Jobe    | Auto-grade code (CodeRunner) | 4000 |

---

## ✅ Features

* ✅ Moodle 4 (via Bitnami)
* ✅ CodeRunner (auto-grade C, C++, Python, etc.)
* ✅ Draw.io plugin (diagram answers)
* ✅ LAN access for all students
* ✅ Dockerized: easy to deploy, backup, restore
* ✅ Runs on Linux, Windows (WSL), or Raspberry Pi

---

## 💡 Plugin Support


### CodeRunner
* Place `qtype_coderunner.zip` inside either `plugins/` or `moodle_data/plugins/`.
* Restart containers after adding.
* Finish install in Moodle GUI.

### Draw.io Plugin
* Place the `qtype_drawio` folder inside either `plugins/` or `moodle_data/question/type/`.
* May require manual setup.
* See plugin docs for question creation and auto-grading.

---

## 🔒 Lockdown/SEB Support

To enable lockdown exams, install the Safe Exam Browser (SEB) plugin in Moodle:

- Admin → Plugins → Install plugins → Search "Safe Exam Browser"
- Configure exam to require SEB access keys.
- See [SEB documentation](https://safeexambrowser.org/) for details.

---

* Place `qtype_coderunner.zip` inside `plugins/`
* Restart containers
* Finish install in Moodle GUI

### Draw.io Plugin

* Place folder inside `plugins/qtype_drawio/`
* May require manual setup
* See plugin docs for question creation and auto-grading

---


## 🧠 Best Practices

* Use **bulk user import** for students with roll numbers.
* Restrict quizzes with timing and attempt limits.
* Use **Safe Exam Browser** for lockdown mode.

---


## 💾 Backup & Restore

### 🌍 Distributed Workflow

**For Multi-Location Training Institutes:**

```bash
# Company Location (Daily)
./down.sh              # Auto-backup + stop
git add backup/
git commit -m "Daily backup $(date +%Y-%m-%d)"
git push origin main

# Remote Location (As needed)
git pull origin main    # Get latest backups
./up.sh                # Auto-restore + start
```

### Automation Scripts (Cross-Platform)

This project includes automation scripts for backup and restore, available for both Linux/macOS and Windows:

#### For Linux/macOS:
Use the provided shell scripts:
```bash
./up.sh            # Restore data and start containers
./down.sh          # Backup data and stop containers
./auto-backup.sh   # Manual backup (verifies backup completeness)
./auto-restore.sh  # Manual restore
```
**Important:** After cloning or copying the project, set executable permissions for these scripts:
```bash
chmod +x up.sh down.sh auto-backup.sh auto-restore.sh
```
You only need to do this once per new system or after copying the files.

#### For Windows (PowerShell):
Use the PowerShell scripts:
```powershell
.\up.ps1           # Restore data and start containers
.\down.ps1         # Backup data and stop containers
.\auto-backup.ps1
.\auto-restore.ps1
```
Run these from a PowerShell terminal in your project folder.
**Note:** If you see an error about script execution policy, these scripts now automatically set the policy for the session. No manual change is needed.

---

#### Backup & Restore Best Practices

- Always run backup/restore scripts from your project folder.
- The backup script now checks for `config.php` in the backup to ensure a complete backup. If missing, you will see a warning.
- When restoring on a new PC, create fresh Docker volumes before restoring.
- After restore, verify that all core Moodle files (including `config.php`) are present in the volume.
- Keep custom plugins/themes in your repo for easy re-deployment.

To backup volumes manually (works on both platforms if Docker is installed):

```bash
docker run --rm -v offline-exam-system_moodle_data:/data -v $(pwd)/backup:/backup alpine tar czf /backup/moodle_data.tar.gz -C /data .
```

Repeat for:

* `offline-exam-system_moodle_data`
* `offline-exam-system_mariadb_data`

To restore:

* Use `docker volume create` and `tar xzf` into the new volume

---

## 🧑‍🏫 Instructor Workflow

1. Add questions (MCQ, code, essay, draw.io)
2. Create timed quizzes
3. Share access with students
4. Review answers and grade
5. Export reports

---

## 🧑‍🎓 Student Workflow

1. Connect to LAN Wi-Fi
2. Open browser: `http://<instructor-ip>:8080`
3. Log in and take assigned quiz
4. Submit answers
5. Get results after evaluation

---

## 🐞 Troubleshooting

* **No access to `localhost:8080`?**
  * Try `http://<your LAN IP>:8080`
  * Use `wsl hostname -I` or `ipconfig`

* **Moodle restarting constantly?**
  * Delete `moodle_data` volume and re-run setup

* **Plugins not showing?**
  * Make sure ZIP files are inside `plugins/`
  * Restart Moodle container after adding

* **Docker: invalid reference format?**
  * This is now fixed in the PowerShell scripts. If you see this error, ensure you are using the latest scripts from this repo.

---

## 📚 Resources

* [Moodle Docs](https://docs.moodle.org/)
* [CodeRunner Plugin](https://github.com/trampgeek/moodle-qtype_coderunner)
* [Jobe Backend](https://github.com/trampgeek/jobe)
* [Draw.io Question Type](https://github.com/BradenM/moodle-qtype_drawio)
* [Safe Exam Browser](https://safeexambrowser.org/)

---

## 🙋 Need Help?

Open an issue or drop a message.

> Built for institutes who need **offline, fast, scalable exam platforms** with auto-grading. No cloud. No fees. Just control.
