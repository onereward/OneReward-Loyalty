@echo off
echo ========================================
echo    Complete Vercel Deployment Setup
echo ========================================
echo.

echo [1/5] Cleaning up old configurations...
if exist "Frontend\vercel.json" del "Frontend\vercel.json"

echo [2/5] Adding all files to git...
git add .

echo [3/5] Committing Vercel-ready configuration...
git commit -m "Fix Vercel deployment configuration - remove secret references"

echo [4/5] Pushing to GitHub...
git push

echo [5/5] Deployment complete!
echo.
echo ========================================
echo   ✅ Ready for Vercel Deployment!
echo ========================================
echo.
echo Next Steps:
echo 1. Go to Vercel Dashboard: https://vercel.com/dashboard
echo 2. Import your GitHub repository
echo 3. Set Root Directory to: Frontend
echo 4. Add Environment Variables:
echo    - VITE_API_URL = http://localhost:3000
echo    - VITE_QR_SERVICE_URL = http://localhost:5001
echo 5. Deploy!
echo.
echo After deployment, use update-and-deploy.bat to set real tunnel URLs
echo.
pause
