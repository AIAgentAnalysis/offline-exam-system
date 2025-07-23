# Offline Exam System

**Advanced Moodle-based, LAN-ready, Dockerized exam platform.**

---

## 🚀 Quick Start

1. **Clone/Download Repo**

   ```bash
   git clone https://github.com/AIAgentAnalysis/offline-exam-system.git
   cd offline-exam-system
   ```

2. **Start All Services**

   ```bash
   docker-compose up -d
   ```

3. **Install Plugins**

   - Run setup script:
     ```bash
     bash setup-scripts/install-plugins.sh
     docker restart <moodle_container_name>
     ```
   - Or manually use Moodle GUI for ZIP and place custom Draw.io plugin.

4. **Login to Moodle**

   - URL: `http://localhost:8080`
   - Username: `admin`
   - Password: `admin123`

5. **Import Sample Quiz**

   - Go to: Course > Quiz > Import
   - Select `import/sample_exam_quiz.xml`

---

## 🗂️ Folder Structure

```plaintext
offline-exam-system/
├── docker-compose.yml
├── moodle_data/
├── mariadb_data/
├── plugins/
│   ├── qtype_coderunner.zip
│   └── qtype_drawio/
├── import/
│   └── sample_exam_quiz.xml
├── setup-scripts/
│   └── install-plugins.sh
├── .gitignore
└── README.md
```

---

## 🧑‍💻 LAN Exam Workflow

1. Connect all student devices to your Wi-Fi/hotspot.
2. Students access server IP (e.g. `192.168.1.100:8080`) in browser.
3. Take exam; answers saved centrally.
4. Grade via Moodle’s interface; export results.

---

## ⚡ Advanced Features

- **Lockdown browser:**  
  See `README_Lockdown.md` for Safe Exam Browser setup instructions.
- **Auto-grading Draw.io diagrams:**  
  See plugin docs in `plugins/qtype_drawio/`.
- **Roll number login:**  
  Extend using Moodle’s user profile fields and bulk import.
- **Backup exams:**  
  Snapshot `moodle_data/` and `mariadb_data/` for full backups.

---

## 🛠️ Troubleshooting

- If plugins aren’t detected, ensure correct paths and restart Moodle container.
- For LAN access, verify firewall/router settings.
- For auto-grading, refer to plugin code and documentation.

---

## 🙋 Need Help?

Open an issue or contact the repo maintainer.
