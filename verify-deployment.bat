@echo off
echo ========================================
echo    Vercel Deployment Verification
echo ========================================
echo.

echo Checking file structure...
echo.

echo ✓ Root vercel.json:
if exist "vercel.json" (
    echo   Found: vercel.json
) else (
    echo   ❌ Missing: vercel.json
)

echo.
echo ✓ Frontend configuration:
if exist "Frontend\package.json" (
    echo   Found: Frontend/package.json
) else (
    echo   ❌ Missing: Frontend/package.json
)

if exist "Frontend\vite.config.ts" (
    echo   Found: Frontend/vite.config.ts
) else (
    echo   ❌ Missing: Frontend/vite.config.ts
)

if exist "Frontend\.env" (
    echo   Found: Frontend/.env
) else (
    echo   ❌ Missing: Frontend/.env
)

if exist "Frontend\.env.production" (
    echo   Found: Frontend/.env.production
) else (
    echo   ❌ Missing: Frontend/.env.production
)

echo.
echo ✓ API configuration:
if exist "Frontend\src\config\api.ts" (
    echo   Found: Frontend/src/config/api.ts
) else (
    echo   ❌ Missing: Frontend/src/config/api.ts
)

echo.
echo ✓ Environment variables in .env:
if exist "Frontend\.env" (
    type "Frontend\.env"
) else (
    echo   No .env file found
)

echo.
echo ========================================
echo   Verification Complete!
echo ========================================
echo.
echo If all files are found, you're ready to deploy to Vercel!
echo Run: deploy-to-vercel.bat
echo.
pause
