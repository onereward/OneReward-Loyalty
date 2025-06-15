@echo off
echo ========================================
echo    Update Both Service URLs and Deploy
echo ========================================
echo.

echo Please enter your Cloudflare tunnel URLs:
echo.

echo [1/2] Main API Service (Node.js - Port 3000):
echo (Example: https://abc123.trycloudflare.com)
set /p "API_URL=API URL: "

echo.
echo [2/2] QR Service (Python - Port 5001):
echo (Example: https://def456.trycloudflare.com)
set /p "QR_URL=QR Service URL: "

if "%API_URL%"=="" (
    echo ❌ No API URL provided!
    pause
    exit
)

if "%QR_URL%"=="" (
    echo ❌ No QR Service URL provided!
    pause
    exit
)

echo.
echo Updating Frontend/.env file...

:: Update the .env file with both URLs
echo # Main API URL (Node.js service - Port 3000) > "Frontend\.env"
echo VITE_API_URL=%API_URL% >> "Frontend\.env"
echo. >> "Frontend\.env"
echo # QR Service URL (Python service - Port 5001) >> "Frontend\.env"
echo VITE_QR_SERVICE_URL=%QR_URL% >> "Frontend\.env"

echo ✓ Updated .env file with:
echo   - API URL: %API_URL%
echo   - QR Service URL: %QR_URL%
echo.

echo Pushing to GitHub...
git add Frontend/.env
git commit -m "Update service URLs: API=%API_URL%, QR=%QR_URL%"
git push

echo.
echo ========================================
echo   ✅ Deployed Successfully!
echo ========================================
echo.
echo Frontend will redeploy on Vercel with new service URLs
echo Check your Vercel dashboard for deployment status
echo.
pause
