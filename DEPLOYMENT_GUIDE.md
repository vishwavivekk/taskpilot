# 🚀 TaskPilot - Complete Setup & Deployment Guide

## ✅ What's Already Done

Your TaskPilot project is **ready to deploy**! Here's what has been completed:

- ✅ **All files rebranded** from Taskosaur → TaskPilot
- ✅ **Your custom logo** added to `frontend/public/taskpilot-logo.png`
- ✅ **Package names updated** to @taskpilot/platform
- ✅ **All references renamed** in code, docs, and configs
- ✅ **Deployment configs ready** (vercel.json files included)
- ✅ **Project structure intact** - everything works!

## 📁 Your TaskPilot Directory

```
Taskosaur-main/  (rename this to 'taskpilot' or any name you like)
├── frontend/           - Next.js application
├── backend/            - NestJS API
├── .env.example        - Environment template
├── vercel.json         - Frontend Vercel config
├── vercel-backend.json - Backend Vercel config
├── package.json        - Root configuration
└── ... (all other files)
```

---

## 🎯 Quick Deployment (3 Options)

### **Option 1: Fresh GitHub Repository (RECOMMENDED)**

This creates a completely new project under your GitHub account.

#### Step 1: Create New GitHub Repository

1. Go to https://github.com/new
2. Repository name: **taskpilot** (or any name you like)
3. Description: "TaskPilot - AI-Powered Project Management"
4. Make it **Private** or **Public** (your choice)
5. **DO NOT** initialize with README (we have our own)
6. Click **Create repository**

#### Step 2: Push Your Code

```bash
# Navigate to your project
cd /path/to/Taskosaur-main

# Initialize git (if not already)
git init

# Add all files
git add .

# Commit
git commit -m "Initial TaskPilot setup with custom branding"

# Add your new GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/taskpilot.git

# Push to GitHub
git push -u origin main
```

If you get an error about branch name, try:
```bash
git branch -M main
git push -u origin main
```

---

### **Option 2: Fork Original Taskosaur**

If you want to maintain connection to original project (for updates).

1. Fork https://github.com/Taskosaur/Taskosaur
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Taskosaur.git taskpilot
   ```
3. Copy your rebranded files over
4. Push changes

---

### **Option 3: Deploy Directly (No GitHub)**

Use Vercel CLI to deploy without GitHub.

```bash
npm i -g vercel
cd Taskosaur-main
vercel
```

---

## 🗄️ Database Setup (Free Options)

### **Railway (RECOMMENDED - Easiest)**

**Why Railway?** PostgreSQL + Redis in ONE place, free tier, easy setup.

1. Go to https://railway.app
2. Sign up with GitHub
3. Click **New Project**
4. Click **Provision PostgreSQL**
5. Click **New** → **Provision Redis**
6. Click on PostgreSQL → **Connect** tab → Copy `DATABASE_URL`
7. Click on Redis → **Connect** tab → Copy connection details

**Your connection strings will look like:**
```
DATABASE_URL=postgresql://user:pass@region.railway.app:1234/railway
REDIS_HOST=region.railway.app
REDIS_PORT=6379
REDIS_PASSWORD=your-redis-password
```

---

### **Alternative: Supabase + Upstash**

**PostgreSQL - Supabase:**
1. Go to https://supabase.com
2. New Project
3. Settings → Database → Connection String
4. Copy **Connection Pooling** string (faster)

**Redis - Upstash:**
1. Go to https://upstash.com
2. Create Database
3. Copy connection details

---

## 🔐 Environment Variables

### Step 1: Create .env File

```bash
cd Taskosaur-main
cp .env.example .env
```

### Step 2: Generate Secure Secrets

**On Mac/Linux:**
```bash
# Generate JWT_SECRET
openssl rand -base64 32

# Generate JWT_REFRESH_SECRET
openssl rand -base64 32

# Generate ENCRYPTION_KEY
openssl rand -hex 32
```

**On Windows:**
```powershell
# Use PowerShell
[Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 }))
```

Or use online generator (ONLY for development):
https://generate-secret.vercel.app/32

### Step 3: Update .env File

Edit `.env` with your values:

```env
# Database (from Railway/Supabase)
DATABASE_URL="postgresql://user:pass@host:port/database?sslmode=require"

# Redis (from Railway/Upstash)
REDIS_HOST=your-redis-host.railway.app
REDIS_PORT=6379
REDIS_PASSWORD=your-redis-password

# Security (generated above)
JWT_SECRET="paste-first-generated-secret-here"
JWT_REFRESH_SECRET="paste-second-generated-secret-here"
ENCRYPTION_KEY="paste-hex-key-here"

# Application
NODE_ENV=production

# URLs (update after Vercel deployment)
FRONTEND_URL="https://taskpilot.vercel.app"
CORS_ORIGIN="https://taskpilot.vercel.app"

# For frontend
NEXT_PUBLIC_API_BASE_URL="https://taskpilot-api.vercel.app/api"
```

---

## 🚀 Deploy to Vercel

### **Deploy Backend (API)**

1. Go to https://vercel.com/new
2. Click **Import Git Repository**
3. Select your **taskpilot** repository
4. Configure project:
   - **Project Name**: taskpilot-api
   - **Framework Preset**: Other
   - **Root Directory**: `backend`
   - **Build Command**: 
     ```
     npm install && npx prisma generate && npm run build
     ```
   - **Output Directory**: `dist`
   - **Install Command**: `npm install`

5. **Environment Variables** - Add ALL of these:
   ```
   DATABASE_URL=your-database-url
   REDIS_HOST=your-redis-host
   REDIS_PORT=6379
   REDIS_PASSWORD=your-redis-password
   JWT_SECRET=your-jwt-secret
   JWT_REFRESH_SECRET=your-refresh-secret
   ENCRYPTION_KEY=your-encryption-key
   NODE_ENV=production
   FRONTEND_URL=https://taskpilot.vercel.app
   CORS_ORIGIN=https://taskpilot.vercel.app
   SMTP_HOST=smtp.gmail.com
   SMTP_PORT=587
   SMTP_USER=your-email@gmail.com
   SMTP_PASS=your-app-password
   SMTP_FROM=noreply@taskpilot.com
   EMAIL_DOMAIN=taskpilot.com
   ```

6. Click **Deploy**

7. **Copy your backend URL** (e.g., `https://taskpilot-api.vercel.app`)

---

### **Run Database Migrations**

After backend deploys successfully:

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Navigate to backend
cd backend

# Link to your Vercel project
vercel link
# Select: your-username → taskpilot-api → yes

# Pull environment variables
vercel env pull .env.production

# Run migrations
npx prisma migrate deploy

# Seed database with admin user
npx prisma db seed
```

**Default Admin Credentials:**
- Email: `admin@taskpilot.com`
- Password: `admin123`
- **Change these immediately after first login!**

---

### **Deploy Frontend**

1. Go to https://vercel.com/new
2. Import **same repository** again
3. Configure project:
   - **Project Name**: taskpilot
   - **Framework Preset**: Next.js
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `.next`
   - **Install Command**: `npm install`

4. **Environment Variables** - Add this:
   ```
   NEXT_PUBLIC_API_BASE_URL=https://taskpilot-api.vercel.app/api
   ```
   (Use YOUR actual backend URL from previous step)

5. Click **Deploy**

6. **Copy your frontend URL** (e.g., `https://taskpilot.vercel.app`)

---

### **Update Backend URLs**

Now update the backend environment variables with your real frontend URL:

1. Go to backend project on Vercel
2. Settings → Environment Variables
3. Edit these variables:
   - `FRONTEND_URL` → `https://taskpilot.vercel.app`
   - `CORS_ORIGIN` → `https://taskpilot.vercel.app`
4. Go to **Deployments** tab
5. Click **•••** on latest deployment → **Redeploy**

---

## ✅ Test Your Deployment

1. Visit your frontend URL: `https://taskpilot.vercel.app`
2. Click **Sign Up** or **Login**
3. Use admin credentials:
   - Email: `admin@taskpilot.com`
   - Password: `admin123`
4. **Change password immediately!**
5. Create a test project
6. Create a test task
7. Try uploading an attachment

**Everything working?** 🎉 Congratulations!

---

## 🐛 Common Issues & Solutions

### Issue: Build Fails

**Check:**
- Node.js version in Vercel (should be 22.x)
- All dependencies in package.json
- Build command is correct

**Fix:**
```bash
# In your project
npm install
npm run build  # Test locally first
```

---

### Issue: Database Connection Failed

**Check:**
- DATABASE_URL is correct
- Includes `?sslmode=require` at the end
- Database is running and accessible

**Fix:**
```env
# Correct format:
DATABASE_URL="postgresql://user:pass@host:5432/db?sslmode=require"
```

---

### Issue: Frontend Can't Connect to Backend

**Check:**
- CORS_ORIGIN matches frontend URL EXACTLY
- NEXT_PUBLIC_API_BASE_URL has `/api` at the end
- Both are using HTTPS (not HTTP)

**Fix:**
```env
# Backend .env:
CORS_ORIGIN="https://taskpilot.vercel.app"  # NO trailing slash

# Frontend .env:
NEXT_PUBLIC_API_BASE_URL="https://taskpilot-api.vercel.app/api"  # HAS /api
```

---

### Issue: Login Not Working

**Check:**
- JWT secrets are set
- Migrations ran successfully
- Database was seeded

**Fix:**
```bash
cd backend
vercel env pull .env.production
npx prisma migrate deploy
npx prisma db seed
```

---

## 🎨 Customize Further

### Change Logo
1. Replace `frontend/public/taskpilot-logo.png`
2. Git commit and push
3. Vercel auto-deploys

### Change Colors
Edit `frontend/src/styles/globals.css`

### Add Custom Domain
1. Vercel Dashboard → Your Project → Settings → Domains
2. Add domain → Update DNS records
3. Wait for SSL certificate

---

## 📊 Project Structure

```
taskpilot/
├── backend/                 # NestJS API (Port 3000)
│   ├── src/                # Source code
│   ├── prisma/             # Database schema & migrations
│   └── package.json
├── frontend/               # Next.js App (Port 3001)
│   ├── src/
│   │   ├── app/           # Pages (App Router)
│   │   ├── components/    # React components
│   │   └── styles/        # CSS styles
│   ├── public/            # Static files (logo here!)
│   └── package.json
├── .env                    # Your environment variables
├── .env.example           # Template
├── vercel.json            # Frontend Vercel config
├── vercel-backend.json    # Backend Vercel config
└── package.json           # Root workspace config
```

---

## 🔑 Important Security Notes

1. **Never commit .env to Git!** (It's in .gitignore)
2. **Change admin password immediately** after first login
3. **Use strong JWT secrets** (generate new ones for production)
4. **Enable 2FA** for your Vercel account
5. **Regular backups** of your database

---

## 📞 Need Help?

1. Check deployment logs in Vercel dashboard
2. Check browser console (F12) for frontend errors
3. Review environment variables (most common issue)
4. Ensure migrations ran successfully

---

## 🎉 Success Checklist

- [ ] Code pushed to GitHub
- [ ] Database created (Railway/Supabase)
- [ ] Redis created (Railway/Upstash)
- [ ] Backend deployed to Vercel
- [ ] Database migrations completed
- [ ] Frontend deployed to Vercel
- [ ] Can access frontend URL
- [ ] Can login with admin credentials
- [ ] Can create projects and tasks
- [ ] Logo displays correctly
- [ ] All branding shows "TaskPilot"

---

## 🚀 Your TaskPilot URLs

After deployment, save these:

- **Frontend**: https://taskpilot.vercel.app
- **Backend API**: https://taskpilot-api.vercel.app
- **API Docs**: https://taskpilot-api.vercel.app/api/docs
- **Admin Email**: admin@taskpilot.com
- **Admin Password**: admin123 (CHANGE THIS!)

---

**Congratulations on deploying TaskPilot!** 🎉

Start managing your projects with AI-powered task execution!
