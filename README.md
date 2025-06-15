# OneReward - Simple Deployment Workflow

## Architecture
- **Frontend**: React + Vite → GitHub → Vercel
- **Backend**: Node.js (Port 3000) + Python QR Service (Port 5001) → Local + Cloudflare Tunnel
- **Database**: MongoDB (Local)

## Setup Steps

### 1. Initial Setup
1. Push your code to GitHub
2. Connect GitHub repository to Vercel
3. Install Cloudflared: https://github.com/cloudflare/cloudflared/releases

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

That's it! Simple and straightforward.
