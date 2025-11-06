@echo off
REM =============================
REM Start Vue server
REM =============================
cd frontend
start powershell -NoExit -Command "npm run dev -- --port 5175"

echo Both servers started.

REM =============================
REM Start Laravel backend (auto close CMD)
REM =============================
cd ..\backend
start /B cmd /C "php artisan serve --host=127.0.0.1 --port=8000"

echo Backend server started (CMD window closed automatically).


pause
