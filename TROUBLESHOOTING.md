# OneReward Deployment Troubleshooting Guide

## **Common Vercel Deployment Issues**

### **1. Build Failures**

#### **Error: "Build Command Failed"**
```bash
# Solution 1: Check build logs in Vercel dashboard
# Go to: Vercel Dashboard → Your Project → Deployments → Click failed deployment

# Solution 2: Verify package.json in Frontend folder
cd Frontend
npm install
npm run build  # Test locally

# Solution 3: Check if all dependencies are installed
npm ci  # Clean install
```

#### **Error: "DEPLOYMENT_NOT_FOUND (404)"**
```bash
# Solution: Verify Vercel project settings
# 1. Root Directory should be: Frontend
# 2. Build Command should be: npm run build
# 3. Output Directory should be: dist
# 4. Install Command should be: npm install
```

### **2. Environment Variable Issues**

#### **Error: "API calls returning 404/500"**
```bash
# Solution: Check environment variables in Vercel
# 1. Go to Vercel Dashboard → Project Settings → Environment Variables
# 2. Verify these exist:
#    - VITE_API_URL = https://your-api-tunnel.trycloudflare.com
#    - VITE_QR_SERVICE_URL = https://your-qr-tunnel.trycloudflare.com
# 3. Click "Redeploy" after adding/updating
```

#### **Error: "Environment variables not loading"**
```bash
# Solution: Check variable names
# Must start with VITE_ for Vite to include them
# Correct: VITE_API_URL
# Wrong: API_URL
```

### **3. CORS and Connection Errors**

#### **Error: "CORS policy blocked"**
```bash
# Solution 1: Check backend CORS settings
# In Backend/server.js, verify:
app.use(cors({
  origin: ['https://your-vercel-app.vercel.app', 'http://localhost:8080'],
  credentials: true
}));

# Solution 2: Test tunnel URLs directly
# Open browser and visit:
# https://your-api-tunnel.trycloudflare.com/api/test
# https://your-qr-tunnel.trycloudflare.com/
```

#### **Error: "Failed to fetch" or "Network Error"**
```bash
# Solution: Verify tunnel accessibility
# 1. Test tunnel URLs in browser
# 2. Check if backend services are running
# 3. Verify tunnel hasn't expired (restart if needed)
```

### **4. Git and GitHub Issues**

#### **Error: "Git push failed"**
```bash
# Solution 1: Check git configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Solution 2: Check remote repository
git remote -v
# Should show: origin https://github.com/USERNAME/REPO.git

# Solution 3: Re-add remote if missing
git remote add origin https://github.com/USERNAME/REPO.git
```

#### **Error: "Authentication failed"**
```bash
# Solution: Use GitHub token or SSH
# Option 1: Use personal access token
# Go to GitHub → Settings → Developer settings → Personal access tokens

# Option 2: Use GitHub CLI
gh auth login
```

### **5. Backend Service Issues**

#### **Error: "MongoDB connection failed"**
```bash
# Solution: Start MongoDB service
net start MongoDB

# Or check if MongoDB is running
tasklist | findstr mongod
```

#### **Error: "Node.js server won't start"**
```bash
# Solution: Check port availability
netstat -ano | findstr :3000

# Kill process if port is busy
taskkill /PID <process_id> /F

# Check Node.js version
node --version  # Should be v18+
```

#### **Error: "Python QR service failed"**
```bash
# Solution: Check Python and dependencies
python --version  # Should be 3.8+

cd Backend
pip install -r requirements.txt

# Test QR service manually
python app.py
```

### **6. Cloudflare Tunnel Issues**

#### **Error: "Tunnel URL not accessible"**
```bash
# Solution 1: Wait for tunnel to initialize
# Tunnels can take 30-60 seconds to become accessible

# Solution 2: Restart tunnel
# Ctrl+C to stop, then restart:
cloudflared tunnel --url http://localhost:3000

# Solution 3: Check if cloudflared is updated
cloudflared update
```

#### **Error: "Tunnel expired or changed"**
```bash
# Solution: Update URLs and redeploy
# 1. Get new tunnel URLs
# 2. Run: update-and-deploy.bat
# 3. Enter new URLs when prompted
```

## **Step-by-Step Debugging Process**

### **When Deployment Fails:**

1. **Check Vercel Build Logs:**
   ```bash
   # Go to Vercel Dashboard
   # Click on failed deployment
   # Read build logs for specific errors
   ```

2. **Test Locally:**
   ```bash
   cd Frontend
   npm install
   npm run build
   # If this fails, fix the build issue first
   ```

3. **Verify Environment Variables:**
   ```bash
   # Check .env file
   cat Frontend/.env
   
   # Check Vercel dashboard environment variables
   # Make sure they match
   ```

4. **Test Backend Services:**
   ```bash
   # Test API service
   curl http://localhost:3000/api/test
   
   # Test QR service
   curl http://localhost:5001/
   ```

5. **Test Tunnel URLs:**
   ```bash
   # Open in browser:
   # https://your-api-tunnel.trycloudflare.com/api/test
   # https://your-qr-tunnel.trycloudflare.com/
   ```

### **When App Loads but APIs Don't Work:**

1. **Check Browser Console:**
   ```bash
   # Press F12 in browser
   # Look for CORS or network errors
   # Check if API calls are going to correct URLs
   ```

2. **Verify API Configuration:**
   ```bash
   # Check Frontend/src/config/api.ts
   # Verify getApiUrl function routes correctly
   ```

3. **Test API Endpoints:**
   ```bash
   # Test in browser or Postman:
   # GET https://your-api-tunnel.trycloudflare.com/api/restaurants
   # POST https://your-qr-tunnel.trycloudflare.com/generate_qr
   ```

## **Emergency Recovery Steps**

### **If Everything Breaks:**

1. **Reset Environment:**
   ```bash
   # 1. Stop all services
   # 2. Restart backend services
   start-backend.bat
   
   # 3. Get fresh tunnel URLs
   cloudflared tunnel --url http://localhost:3000
   cloudflared tunnel --url http://localhost:5001
   
   # 4. Update and redeploy
   update-and-deploy.bat
   ```

2. **Force Clean Deployment:**
   ```bash
   # Make empty commit to trigger redeploy
   git commit --allow-empty -m "Force redeploy"
   git push
   ```

3. **Contact Support:**
   - For Vercel issues: https://vercel.com/help
   - For Cloudflare issues: Check tunnel logs
   - For GitHub issues: Check repository settings

## **Prevention Tips**

1. **Always test locally before deploying**
2. **Keep tunnel URLs updated in .env**
3. **Monitor Vercel deployment status**
4. **Check backend service health regularly**
5. **Keep dependencies updated**

Remember: Most issues are related to environment variables or tunnel URL changes!
