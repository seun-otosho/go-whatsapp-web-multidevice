# 🚀 **Render Deployment Guide - GoWA WhatsApp**

## ✅ **Why Render?**
- ✅ **Go 1.24+ support** out of the box
- ✅ **750 hours/month free** (always on!)
- ✅ **WebSocket support** (perfect for WhatsApp)
- ✅ **One-click GitHub deployment**
- ✅ **Simple environment variable management**

---

## 📋 **Pre-Deployment Checklist**

### **1. Update Your Fork (Required)**
```bash
# Pull all my fixes and deployment files
git remote add upstream https://github.com/aldinokemal/go-whatsapp-web-multidevice.git
git fetch upstream
git merge upstream/main
git push origin main
```

**OR manually update from my repo:**
- Get these files from my repo: `railway.json`, `start.sh`, `Procfile`, `Dockerfile`
- Get all docs: `DATABASE_MIGRATION.md`, `DOCKER_BUILD_FIX.md`, etc.

### **2. Verify Your Fork Has:**
- ✅ `start.sh` (build script)
- ✅ `railway.json` (config)
- ✅ Updated `src/go.mod` (v5.2.1 with Go 1.23)
- ✅ Fixed `src/usecase/send.go` (no fasthttp)

---

## 🚀 **Deploy to Render (Step-by-Step)**

### **Step 1: Create Render Account**
1. Go to https://render.com
2. Click **"Get Started for Free"**
3. Sign up with **GitHub** (recommended)
4. Authorize Render to access your repos

### **Step 2: Create New Web Service**
1. In Render Dashboard, click **"New +"**
2. Select **"Web Service"**
3. Choose **"Build and deploy from a Git repository"**

### **Step 3: Connect Your Repository**
1. Find your repo: `seun-otosho/go-whatsapp-web-multidevice`
2. Click **"Connect"**

### **Step 4: Configure Build Settings**

**Fill in these fields EXACTLY:**

#### **Basic Settings:**
- **Name:** `gowa-whatsapp` (or your choice)
- **Region:** Choose closest to you
- **Branch:** `main`
- **Root Directory:** (leave empty)

#### **Runtime:**
- **Runtime:** `Go`

#### **Build Command:**
```bash
cd src && go build -o whatsapp
```

#### **Start Command:**
```bash
./whatsapp rest
```

#### **Plan:**
- **Free Tier** (750 hours/month)

### **Step 5: Add Environment Variables**

**Go to "Environment" tab and add these:**

**Click "Add Environment Variable" for each:**

#### **Essential Variables:**
```
Key: APP_PORT
Value: 10000

Key: APP_OS
Value: Render-WhatsApp

Key: APP_DEBUG
Value: false

Key: DB_URI
Value: file:storages/whatsapp.db?_foreign_keys=on

Key: WHATSAPP_ACCOUNT_VALIDATION
Value: false
```

#### **Recommended Variables:**
```
Key: APP_BASIC_AUTH
Value: admin:YourStrongPassword123

Key: WHATSAPP_AUTO_MARK_READ
Value: true

Key: WHATSAPP_WEBHOOK_SECRET
Value: yourSecretKey123
```

**⚠️ IMPORTANT:** Change the default values above with your own secure passwords!

### **Step 6: Deploy**
1. Click **"Create Web Service"**
2. Render will automatically:
   - Clone your repo
   - Run build command
   - Start your application
   - Give you a URL

### **Step 7: Monitor Build**
Watch the build logs. You should see:
```
--> Cloning repo...
--> Running build command: cd src && go build -o whatsapp
go: downloading go.mau.fi/whatsmeow v0.0.0-20250221160813-35b965ceadf1
[... dependency downloads ...]
--> Build complete!
--> Starting application
[INFO] Server started on port 10000
```

---

## 🎉 **After Successful Deployment**

### **1. Get Your URL**
Render will give you a URL like:
- `https://gowa-whatsapp.onrender.com`

### **2. Access GoWA Interface**
- **Homepage:** `https://your-app.onrender.com`
- **Login Page:** `https://your-app.onrender.com/app/login`

### **3. Connect WhatsApp**
1. Open the login page
2. Scan QR code with WhatsApp mobile app
3. You're connected! 🎉

---

## 🔧 **Environment Variables (Full List)**

### **Minimal Setup (Required):**
```bash
APP_PORT=10000
APP_OS=Render-WhatsApp
APP_DEBUG=false
DB_URI=file:storages/whatsapp.db?_foreign_keys=on
WHATSAPP_ACCOUNT_VALIDATION=false
```

### **Recommended Production Setup:**
```bash
# Basic
APP_PORT=10000
APP_OS=Render-WhatsApp
APP_DEBUG=false
DB_URI=file:storages/whatsapp.db?_foreign_keys=on
WHATSAPP_ACCOUNT_VALIDATION=false

# Security
APP_BASIC_AUTH=admin:YourSecurePassword123
WHATSAPP_AUTO_MARK_READ=true
WHATSAPP_WEBHOOK_SECRET=yourSecretKey

# Optional Features
WHATSAPP_CHAT_STORAGE=true
APP_BASE_PATH=/
```

---

## 📡 **API Usage Examples**

After deployment, your API is available at: `https://your-app.onrender.com`

### **Send Text Message:**
```bash
curl -X POST https://your-app.onrender.com/send/message \
  -H "Content-Type: application/json" \
  -d '{"chat_id":"1234567890@c.us","message":"Hello from Render!"}'
```

### **Send Image:**
```bash
curl -X POST https://your-app.onrender.com/send/image \
  -F "chat_id=1234567890@c.us" \
  -F "caption=Check this out!" \
  -F "image=@/path/to/image.jpg"
```

### **Get User Info:**
```bash
curl https://your-app.onrender.com/user/info
```

---

## 🔍 **Troubleshooting**

### **Build Fails - "Go version error"**
**Solution:**
1. Go to Render Dashboard → Your Service → Settings
2. Find **"Runtime"** section
3. Ensure **"Go Version"** is set to **"1.24"** (or latest)
4. Redeploy

### **Build Fails - "go: command not found"**
**Solution:**
1. Check Build Command is exactly: `cd src && go build -o whatsapp`
2. Ensure repository has `src/go.mod` file
3. Verify repository is set to Go

### **App Starts but Port Error**
**Solution:**
- Ensure `APP_PORT=10000` (Render's default port)
- Or set to `$PORT` (Render automatically provides this)

### **Can't Access URL**
**Solution:**
1. Check "Events" tab in Render dashboard
2. Ensure build succeeded (green checkmark)
3. Check environment variables are set
4. Try accessing from different browser/device

### **WhatsApp Won't Connect**
**Solution:**
1. Verify QR code scan is correct
2. Check if app is running (no errors in logs)
3. Ensure `WHATSAPP_ACCOUNT_VALIDATION=false`
4. Check Render logs for any error messages

---

## 💾 **Database Persistence**

### **SQLite (Default - Recommended)**
- Render provides persistent disk storage
- Files stored in `storages/` directory
- WhatsApp session persists across deployments
- **No extra setup needed!**

### **PostgreSQL (Optional)**
If you want PostgreSQL instead:
1. In Render Dashboard → **"New +"** → **"Database"** → **"PostgreSQL"**
2. Render creates database and sets `DATABASE_URL` env var
3. Update your service env var:
   ```
   DB_URI=${DATABASE_URL}
   ```
4. Redeploy

---

## 🔄 **Updates & Redeployment**

### **Update Your App:**
```bash
# Make changes to your fork
git add .
git commit -m "Your changes"
git push origin main
```

Render **automatically redeploys** when you push to main!

### **Manual Redeploy:**
1. Go to Render Dashboard → Your Service
2. Click **"Manual Deploy"** → **"Deploy latest commit"**

---

## 📊 **Monitoring & Logs**

### **View Logs:**
- Render Dashboard → Your Service → **"Logs"** tab
- Shows real-time application logs
- Shows build logs during deployment

### **Health Checks:**
- **URL:** `https://your-app.onrender.com/health` (if implemented)
- Check Render's **"Events"** tab for deployment history

---

## 💡 **Pro Tips**

### **1. Custom Domain (Optional)**
1. Go to Service Settings → **"Domains"**
2. Add your custom domain
3. Get free SSL certificate automatically

### **2. Scale Up (When Needed)**
- **Free Tier:** 750 hours/month (always on!)
- **Starter:** $7/month (always on, more resources)
- **Standard:** $25/month (more resources, multiple instances)

### **3. Backups**
- Download `storages/` folder regularly
- Contains WhatsApp session and chat data
- Can backup via Render's file browser or API

### **4. Environment Variables Management**
- Store sensitive data in env vars
- Never commit passwords to Git
- Use Render's encrypted storage

---

## ✅ **Success Checklist**

You'll know it's working when:
- [ ] Build completes successfully (green checkmark)
- [ ] Logs show: `"Server started on port 10000"`
- [ ] URL loads GoWA interface
- [ ] QR code appears at `/app/login`
- [ ] WhatsApp scan succeeds
- [ ] Can send a test message

---

## 🎯 **Next Steps**

1. **Deploy to Render** (follow steps above)
2. **Test basic functions:**
   - Send text message
   - Send image
   - Check user info
3. **Set up webhooks** (optional)
4. **Enable Basic Auth** (recommended)
5. **Customize as needed**

---

## 📞 **Support Resources**

- **Render Docs:** https://render.com/docs
- **GoWA GitHub:** https://github.com/aldinokemal/go-whatsapp-web-multidevice
- **Render Community:** https://render.com/community
- **GoWA Documentation:** Check `DATABASE_MIGRATION.md` in repo

---

## 🚀 **You're All Set!**

**Render + GoWA = Perfect combination!**

**Deploy now and enjoy your WhatsApp API! 📱✨**
