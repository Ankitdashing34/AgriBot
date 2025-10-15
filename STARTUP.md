# Startup guide — Agri Chatbot (backend + frontend)

This document shows quick steps and convenient PowerShell scripts to start the backend (Flask) and the frontend (Flutter web in Chrome).

IMPORTANT: This project uses environment variables for secrets. Do not commit your `.env` file with API keys to version control.

Files added
- `scripts/run_backend.ps1` — sets up Python dependencies and launches `backend/app.py` in a new PowerShell window.
- `scripts/run_frontend_chrome.ps1` — launches the Flutter app in Chrome in a new PowerShell window.
- `scripts/run_all.ps1` — launches both backend and frontend (backend first, then frontend) in separate windows.

Prerequisites
- Python 3.10+ installed and on PATH.
- Flutter SDK installed and on PATH (for running the frontend). Follow https://flutter.dev/docs/get-started/install if needed.
- (Optional) A local MySQL/MariaDB instance if you want the DB persistence used in `backend/app.py`. The backend will continue to run without a DB but will skip DB writes.
- A valid API key for the AI provider used by the backend (set in `backend/.env` as `CEREBRAS_API_KEY`).

Quick start (recommended)
1. Open PowerShell (you may need to run as Administrator the first time if you change Execution Policy).
2. From the repository root run the combined script:

```powershell
# if your system blocks script execution you can bypass for this run:
powershell -ExecutionPolicy Bypass -File .\scripts\run_all.ps1
```

3. Two new PowerShell windows will open:
   - One will run the backend and will show Flask logs (listening on 0.0.0.0:5000 by default).
   - The other will run `flutter run -d chrome` and open Chrome to the app.

Manual steps (if you prefer to run by hand)

Backend
```powershell
cd .\backend
# optional: create a virtual environment
python -m venv .venv
# install deps (using system pip if venv activation is blocked)
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
# ensure .env is configured (CEREBRAS_API_KEY, DB_* variables)
python app.py
```

Frontend (Flutter web in Chrome)
```powershell
cd .\frontend\agri_chatbot_app
flutter pub get
flutter run -d chrome
```

Verifying
- Backend health: open http://127.0.0.1:5000/health or run:

```powershell
Invoke-RestMethod -Uri http://127.0.0.1:5000/health
```

- Frontend: Chrome should open automatically to the running app. If it doesn't, check the terminal logs started by the frontend script.

Troubleshooting
- PowerShell execution policy blocks scripts: run with `-ExecutionPolicy Bypass` as shown above, or temporarily change ExecutionPolicy for the process:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
```

- Python `flask`/packages not found: make sure you installed the requirements. If venv activation is blocked, the startup script installs packages using `python -m pip` so it should still work.

- CORS / backend unreachable: the frontend expects the backend at `http://localhost:5000` (see `lib/main.dart`). Ensure the backend is running and accessible on that port.

Security note
- The `.env` file contains your `CEREBRAS_API_KEY` and DB credentials. Keep it out of version control. For production, do not run Flask's development server; instead use a production WSGI server and secure the keys.

If you want, I can:
- Run `.	emplates\run_all.ps1` for you now, or
- Adjust the scripts to use different browsers or desktop targets (Windows) instead of Chrome.

