@echo off
REM =============================
REM Start Vue server
REM =============================
cd frontend
start powershell -NoExit -Command "npm run dev -- --port 5175"

echo Both servers started.

REM =============================
REM Define Laravel backend port
REM =============================
set LARAVEL_PORT=8000

REM =============================
REM Stop Laravel server if running
REM =============================
for /f "tokens=5" %%a in ('netstat -aon ^| find ":%LARAVEL_PORT%" ^| find "LISTENING"') do (
    echo Stopping Laravel backend (PID %%a)...
    taskkill /PID %%a /F >nul 2>&1
)

echo Laravel backend stopped.

REM =============================
REM Start Laravel backend again (auto-close CMD)
REM =============================
cd ..\backend
start /B cmd /C "php artisan serve --host=127.0.0.1 --port %LARAVEL_PORT%"

echo Laravel backend restarted.
pause
