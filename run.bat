@echo off
setlocal
cd /d "%~dp0"

echo ========================================
echo        StyleAI Recommendation System
echo ========================================
echo.

where python >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH.
    echo Install Python 3.10+ from python.org and enable "Add Python to PATH".
    pause
    exit /b 1
)

if not exist "venv\Scripts\python.exe" (
    echo Creating virtual environment...
    python -m venv venv
    if errorlevel 1 (
        echo ERROR: Could not create virtual environment.
        pause
        exit /b 1
    )
)

echo Installing/checking required packages...
"venv\Scripts\python.exe" -m pip install -r "backend\requirements.txt"
if errorlevel 1 (
    echo.
    echo ERROR: Package installation failed. Check your internet connection.
    pause
    exit /b 1
)

echo.
echo Starting StyleAI server...
start "StyleAI Server - keep this window open" cmd /k "cd /d "%~dp0" && venv\Scripts\python.exe backend\app.py"

echo Waiting for the server to start...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ok=$false; for($i=0;$i -lt 30;$i++){try{$r=Invoke-WebRequest -UseBasicParsing -Uri 'http://127.0.0.1:5000/api/health' -TimeoutSec 1;if($r.StatusCode -eq 200){$ok=$true;break}}catch{};Start-Sleep -Seconds 1}; if($ok){Start-Process 'http://127.0.0.1:5000/'}else{Write-Host 'ERROR: StyleAI server did not start within 30 seconds.' -ForegroundColor Red; Write-Host 'Check the StyleAI Server window for the error.' -ForegroundColor Yellow}"

echo.
echo If the browser did not open, manually visit:
echo http://127.0.0.1:5000/
echo.
endlocal
