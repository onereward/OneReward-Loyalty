@echo off
echo ========================================
echo    OneReward Backend Services
echo ========================================
echo.

:: Start MongoDB (if not running)
echo [1/3] Checking MongoDB...
tasklist /FI "IMAGENAME eq mongod.exe" 2>NUL | find /I /N "mongod.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo ✓ MongoDB is running
) else (
    echo Starting MongoDB...
    net start MongoDB
)

:: Start Node.js API Server (Port 3000)
echo.
echo [2/3] Starting Node.js API Server (Port 3000)...
cd /d "%~dp0Backend"
start "OneReward-API" cmd /k "echo OneReward Node.js API Server && node server.js"

:: Start Python QR Service (Port 5001)
echo.
echo [3/3] Starting Python QR Service (Port 5001)...
start "OneReward-QR" cmd /k "echo OneReward Python QR Service && python app.py"

echo.
echo ========================================
echo   ✅ Backend Services Started!
echo ========================================
echo.
echo Services Running:
echo ✓ MongoDB (Port 27017)
echo ✓ Node.js API (Port 3000)
echo ✓ Python QR Service (Port 5001)
echo.
echo 📋 Next Steps:
echo 1. Start Cloudflare tunnel for API: cloudflared tunnel --url http://localhost:3000
echo 2. Start Cloudflare tunnel for QR: cloudflared tunnel --url http://localhost:5001
echo 3. Copy both tunnel URLs
echo 4. Run update-and-deploy.bat and enter both URLs
echo 5. Vercel will auto-deploy with new URLs
echo.
pause
