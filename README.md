# 📝 Offline Exam System

**Advanced Moodle-based, LAN-ready, Dockerized exam platform. 100% Offline.**

---

## 🚀 Quick Start

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
├── docker-compose.yml               # Docker stack (Moodle + MariaDB + Jobe)
├── moodle_data/                     # Moodle persistent files
├── mariadb_data/                    # MariaDB database storage
├── plugins/                         # Moodle plugins (ZIPs or folders)
│   ├── qtype_coderunner.zip
│   └── qtype_drawio/
├── import/
│   └── sample_exam_quiz.xml         # Example Moodle XML quiz
├── setup-scripts/
│   └── install-plugins.sh           # Optional helper script
├── .gitignore
└── README.md
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

### Automation Scripts

This project includes automation scripts for backup and restore:

- `up.sh`: Restores data from backup and starts containers
- `down.sh`: Backs up data and stops containers
- `auto-backup.sh`: Manual backup
- `auto-restore.sh`: Manual restore

**Important:** After cloning or copying the project, set executable permissions for these scripts:

```bash
chmod +x up.sh down.sh auto-backup.sh auto-restore.sh
```

You only need to do this once per new system or after copying the files.

To backup volumes manually:

```bash
docker run --rm -v offline-exam-system_moodle_data:/data -v $(pwd):/backup alpine tar czf /backup/moodle_data.tar.gz -C /data .
```

Repeat for:

* `offline-exam-system_moodle_data_data`
* `offline-exam-system_mariadb_data`

To restore:

* Use `docker volume create` and `tar xzf` into the new volume

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

  * Delete `moodle_data_data` volume and re-run setup

* **Plugins not showing?**

  * Make sure ZIP files are inside `plugins/`
  * Restart Moodle container after adding

---

## 📚 Resources

* [Moodle Docs](https://docs.moodle.org/)
* [CodeRunner Plugin](https://github.com/trampgeek/moodle-qtype_coderunner)
* [Jobe Backend](https://github.com/trampgeek/jobe)
* [Draw.io Question Type](https://github.com/BradenM/moodle-qtype_drawio)

---

## 🙋 Need Help?

Open an issue or drop a message.

> Built for institutes who need **offline, fast, scalable exam platforms** with auto-grading. No cloud. No fees. Just control.
