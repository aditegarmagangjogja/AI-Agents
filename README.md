# Hermes + 9Router + Obsidian Ecosystem Distribution Package

Paket distribusi portabel untuk mereplikasi ekosistem kerja lokal secara identik di laptop lain (Windows/Mac) maupun di VPS (Linux).

---

## 📦 Isi Paket

1. **`hermes/`**:
   - `SOUL.template.md`: System instructions lengkap (Superadmin, Agency Orchestrator, Zero-Vulnerability, Human-in-the-loop strict approvals, sandboxing boundaries).
   - `config.template.yaml`: Konfigurasi Hermes yang mengarah ke gateway lokal `http://localhost:20128/v1`.
   - `plugins/agency-agents-router`: Katalog dan router 270+ Agency Agents bawaan.
   - `memories/`: Persistent memory template untuk token optimization, standard user boundaries, dan preferensi arsitektur.
2. **`9router/`**:
   - Panduan mapping alias model `hermes-default` & `hermes-code`.
3. **`vault-template/`**:
   - Template folder Obsidian (`00-System`, `01-Projects`, `02-Learning`, `03-Knowledge`) beserta konfigurasi `.obsidian/` dan template `_Tracker.md`.
4. **`setup.ps1` & `setup.sh`**:
   - Auto-setup script 1-klik untuk Windows & Linux.

---

## 🚀 Panduan Penggunaan

### A. Di Laptop Teman (Windows)
1. Ekstrak folder ini ke lokasi pilihan (misal: `D:\hermes-ecosystem` atau `C:\hermes-ecosystem`).
2. Buka PowerShell di dalam folder tersebut dan jalankan:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   .\setup.ps1
   ```
   *Script akan otomatis mendeteksi path lokal, membuat folder `workspace` & `vault`, lalu menyalin semua aturan & plugin ke `%LOCALAPPDATA%\hermes`.*
3. Setup **9Router**:
   - Jalankan `9router start`.
   - Di antarmuka 9Router, buat alias model:
     - `hermes-default` $\rightarrow$ arahkan ke model reasoning/chat pilihan.
     - `hermes-code` $\rightarrow$ arahkan ke model coding pilihan.
4. Buka aplikasi **Obsidian** di laptop:
   - Pilih *Open folder as vault* $\rightarrow$ arahkan ke folder `vault` di direktori ini.
5. Jalankan Hermes:
   ```bash
   hermes
   ```

---

### B. Di VPS (Linux / Ubuntu / Debian)
1. Clone atau copy folder ini ke VPS (misal: `/opt/hermes-ecosystem`).
2. Jalankan script setup:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
3. Setup **9Router**:
   - Jalankan 9Router di background (misal dengan `pm2` atau `systemd`):
     ```bash
     pm2 start 9router -- start
     ```
   - Pastikan model alias `hermes-default` dan `hermes-code` sudah diatur.
4. Jalankan Hermes:
   ```bash
   hermes
   ```
   *Catatan di VPS:* Tidak perlu install aplikasi Obsidian GUI. Hermes langsung menuliskan dokumen catatan Markdown ke folder `./vault/`. Anda bisa menyinkronkannya ke lokal dengan Git.

---

## 🔒 Keamanan & Batasan Sandbox
- Agen terkunci di dalam folder `./workspace` (untuk kode) dan `./vault` (untuk catatan).
- Akses root drive sistem, folder personal (`C:\Users\`, `/home/`), atau scan rekursif otomatis dilarang.
- Instalasi package eksternal (`npm install`, `pip install`, dll) wajib meminta persetujuan manusia terlebih dahulu.
