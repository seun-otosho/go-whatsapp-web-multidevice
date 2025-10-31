# 🚨 Railway Build Fix

## Issue
```
Script start.sh not found
✖ Railpack could not determine how to build the app.
```

## ✅ Solution Applied

I've added these files to fix the Railway build:

### 1. **start.sh**
```bash
#!/bin/sh
cd src
go build -o whatsapp
./whatsapp rest
```
- Railway will execute this script to build and run
- Builds the Go app, then starts it in REST mode

### 2. **Procfile**
```
web: cd src && go build -o whatsapp && ./whatsapp rest
```
- Alternative to start.sh (Heroku-style)
- Railway will use this if start.sh fails

### 3. **railway.json** (Updated)
```json
{
  "build": {
    "builder": "NIXPACKS",
    "buildCommand": "cd src && go build -o whatsapp"
  },
  "deploy": {
    "startCommand": "cd src && ./whatsapp rest"
  }
}
```
- Explicit build and start commands
- Tells Railway exactly what to do

---

## 🔄 **Update Your Fork (Required)**

### **Option 1: Pull from Upstream (Easiest)**
```bash
# In your local fork:
git remote add upstream https://github.com/aldinokemal/go-whatsapp-web-multidevice.git
git fetch upstream
git merge upstream/main
git push origin main
```

### **Option 2: Manual Update**
Download these files from my repo to yours:
- ✅ `start.sh`
- ✅ `Procfile`
- ✅ `railway.json` (updated version)

---

## 🚀 **Redeploy to Railway**

After updating your fork:

1. **Go to Railway Dashboard**
2. **Find your project**
3. **Click "Deployments" tab**
4. **Click "Redeploy"** (or just push to GitHub - Railway auto-deploys!)

Railway will now:
- ✅ Detect start.sh script
- ✅ Build the Go app
- ✅ Run it successfully
- ✅ Give you a working URL!

---

## 📊 **What to Expect**

### **Success Logs Should Show:**
```
--> Start.sh detected
--> Building application
go: downloading go.mau.fi/whatsmeow v0.0.0-20251024191251-088fa33fb87f
go: downloading github.com/gofiber/fiber/v2 v2.52.9
[... more downloads ...]
--> Build complete!
--> Starting application
[INFO] Server started on port 3000
```

### **After Success:**
- Get your URL from Railway **Domains** tab
- Visit: `https://your-app.railway.app`
- Go to: `https://your-app.railway.app/app/login`
- Scan QR code with WhatsApp
- **Done! 🎉**

---

## 🆘 **Still Having Issues?**

### **If start.sh doesn't work:**
1. Go to Railway Dashboard → Your Project → Settings
2. Find **"Build"** section
3. Set **"Build Command"**: `cd src && go build -o whatsapp`
4. Set **"Start Command"**: `cd src && ./whatsapp rest`
5. Redeploy

### **Check These:**
- ✅ `APP_PORT=3000` set in Railway variables
- ✅ Environment variables are correct
- ✅ GitHub repo is up to date with fixes

---

## 🎯 **Quick Summary**

The fix adds **start.sh** script that Railway can execute. This solves the "could not determine how to build" error.

**Next step: Update your fork and redeploy!**
