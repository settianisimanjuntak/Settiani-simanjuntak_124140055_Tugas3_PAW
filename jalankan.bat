@echo off
REM Klik dua kali file ini untuk menjalankan aplikasi (butuh Node.js terpasang)
where npm >nul 2>nul
if errorlevel 1 (
  echo Node.js belum terpasang. Pasang versi LTS dari https://nodejs.org lalu jalankan file ini lagi.
  pause
  exit /b
)
if not exist node_modules call npm install
start "" http://localhost:5173
call npm run dev
pause
