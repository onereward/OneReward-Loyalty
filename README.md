# OneReward - Complete Vercel Deployment Guide

## Architecture
- **Frontend**: React + Vite → GitHub → Vercel
- **Backend**: Node.js (Port 3000) + Python QR Service (Port 5001) → Local + Cloudflare Tunnel
- **Database**: MongoDB (Local)

## 🚀 Quick Deployment

### Step 1: Deploy to Vercel (One-Time Setup)
```bash
# Run this script to prepare for Vercel:
deploy-to-vercel.bat
```

### Step 2: Setup Vercel Project
1. **Go to Vercel Dashboard**: https://vercel.com/dashboard
2. **Click "New Project"**
3. **Import from GitHub**: Select your repository
4. **Configure Project**:
   - **Framework Preset**: Vite
   - **Root Directory**: `Frontend`
   - **Build Command**: `npm run build` (auto-detected)
   - **Output Directory**: `dist` (auto-detected)
   - **Install Command**: `npm install` (auto-detected)

5. **Add Environment Variables**:
   - `VITE_API_URL` = `http://localhost:3000`
   - `VITE_QR_SERVICE_URL` = `http://localhost:5001`

6. **Click "Deploy"**

### Step 3: Install Cloudflared
Download from: https://github.com/cloudflare/cloudflared/releases

### 2. Daily Workflow

#### Start Backend Services:
```bash
# Run this script:
start-backend.bat
```

#### Start Cloudflare Tunnels (manually):
```bash
# Terminal 1: Main API Service
cloudflared tunnel --url http://localhost:3000

# Terminal 2: QR Service  
cloudflared tunnel --url http://localhost:5001
```

#### Update Frontend and Deploy:
```bash
# Copy both tunnel URLs and run:
update-and-deploy.bat
```

## Files to Update

**Only one file needs updating**: `Frontend/.env`

```env
# Main API URL (Node.js service - Port 3000)
VITE_API_URL=https://abc123.trycloudflare.com

# QR Service URL (Python service - Port 5001)
VITE_QR_SERVICE_URL=https://def456.trycloudflare.com
```

## Workflow Process

1. **Start Backend**: Run `start-backend.bat`
2. **Start Tunnels**: 
   - `cloudflared tunnel --url http://localhost:3000` (API)
   - `cloudflared tunnel --url http://localhost:5001` (QR Service)
3. **Copy URLs**: Copy both tunnel URLs from terminals
4. **Update & Deploy**: Run `update-and-deploy.bat` and enter both URLs
5. **Auto Deploy**: Vercel automatically deploys the updated frontend

## When You Restart Computer

1. Run `start-backend.bat`
2. Start both Cloudflare tunnels (new URLs each time)
3. Run `update-and-deploy.bat` with new tunnel URLs
4. Vercel redeploys automatically

## Troubleshooting Common Vercel Errors

### **Build/Deployment Errors:**

1. **DEPLOYMENT_NOT_FOUND (404)**
   ```bash
   # Check if repository is properly connected
   # Verify root directory is set to "Frontend"
   ```

2. **Build Command Failed**
   ```bash
   # Check Vercel build logs
   # Verify package.json scripts in Frontend folder
   # Ensure all dependencies are listed
   ```

3. **Environment Variables Not Working**
   ```bash
   # In Vercel dashboard:
   # 1. Go to Project Settings
   # 2. Environment Variables
   # 3. Add: VITE_API_URL and VITE_QR_SERVICE_URL
   # 4. Redeploy
   ```

### **Runtime Errors:**

1. **CORS Errors in Browser**
   ```bash
   # Check if tunnel URLs are accessible
   # Verify backend CORS settings allow your Vercel domain
   ```

2. **API Connection Failed**
   ```bash
   # Test tunnel URLs directly in browser
   # Check if backend services are running
   # Verify .env file has correct URLs
   ```

### **Quick Fixes:**

1. **Force Redeploy:**
   ```bash
   # Make a small change and push
   git commit --allow-empty -m "Force redeploy"
   git push
   ```

2. **Clear Vercel Cache:**
   - Go to Vercel dashboard
   - Project Settings → Functions
   - Clear cache and redeploy

3. **Check Logs:**
   - Vercel dashboard → Deployments
   - Click on failed deployment
   - Check build logs and runtime logs

That's it! Simple and straightforward.
