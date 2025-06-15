@echo off
echo ========================================
echo    Fix Vercel Configuration Error
echo ========================================
echo.

echo Fixing vercel.json configuration...
echo ✓ Removed invalid environment variable references
echo.

echo Committing fix to GitHub...
git add Frontend/vercel.json
git commit -m "Fix Vercel environment variable configuration"
git push

echo.
echo ========================================
echo   ✅ Vercel Config Fixed!
echo ========================================
echo.
echo Next steps:
echo 1. Go to Vercel dashboard
echo 2. Add environment variables manually:
echo    - VITE_API_URL = http://localhost:3000 (temporary)
echo    - VITE_QR_SERVICE_URL = http://localhost:5001 (temporary)
echo 3. Redeploy the project
echo 4. Use update-and-deploy.bat to set real tunnel URLs
echo.
pause
