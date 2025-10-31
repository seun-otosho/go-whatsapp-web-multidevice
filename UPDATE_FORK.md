# 🔄 **Update Your Fork - Commands**

## Quick Commands (Copy & Paste)

Run these commands in your **local fork repository** directory:

```bash
# 1. Add upstream remote (if not already added)
git remote add upstream https://github.com/aldinokemal/go-whatsapp-web-multidevice.git

# 2. Fetch latest changes
git fetch upstream

# 3. Merge upstream into your main branch
git checkout main
git merge upstream/main

# 4. Push to your GitHub fork
git push origin main
```

## What You're Getting

After running these commands, your fork will have:

### ✅ **Deployment Files:**
- `railway.json` - Build configuration for Railway/Render
- `start.sh` - Build script
- `Procfile` - Alternative build config
- `Dockerfile` - Docker configuration
- `FORK_UPDATE_COMMANDS.sh` - This update script

### ✅ **Documentation:**
- `RENDER_DEPLOYMENT.md` - Complete Render deployment guide (362 lines!)
- `DATABASE_MIGRATION.md` - Full deployment documentation
- `DOCKER_BUILD_FIX.md` - Docker troubleshooting
- `RAILWAY_DEPLOYMENT_FINAL.md` - Railway instructions
- `GOLANG_VERSION_ISSUE.md` - Go version compatibility guide
- `UPDATE_FORK.md` - This file

### ✅ **Code Fixes:**
- Updated `src/go.mod` - Downgraded to v5.2.1 (Go 1.23 compatible)
- Updated `src/go.sum` - Updated checksums
- Fixed `src/usecase/send.go` - Replaced fasthttp with stdlib
- Added `saveMultipartFile` helper function

### ✅ **Environment Variables:**
- `.railway.env.example` - Template with all env vars

## Verification

After updating, verify you have these files:

```bash
# Check for deployment files
ls -la | grep -E "(railway|start.sh|Procfile|Dockerfile)"

# Check for documentation
ls -la | grep -E "(DEPLOYMENT|FIX|ISSUE|UPDATE)"

# Check go.mod version
grep "^go " src/go.mod
# Should show: go 1.23

# Check for fasthttp removal
grep "fasthttp" src/usecase/send.go
# Should return nothing (replaced with stdlib)
```

## Next Steps

After your fork is updated:

1. **Deploy to Render** (recommended)
   - See `RENDER_DEPLOYMENT.md` for complete instructions
   - Or follow the quick summary below

2. **Environment Variables**
   - Copy from `.railway.env.example`
   - Add them in Render dashboard

## Quick Render Deployment

After fork is updated:

1. Go to https://render.com
2. "New +" → "Web Service"
3. Connect your fork: `seun-otosho/go-whatsapp-web-multidevice`
4. Configure:
   - Runtime: `Go`
   - Build Command: `cd src && go build -o whatsapp`
   - Start Command: `./whatsapp rest`
5. Add env vars:
   ```
   APP_PORT=10000
   APP_OS=Render-WhatsApp
   DB_URI=file:storages/whatsapp.db?_foreign_keys=on
   ```
6. Deploy!

## Troubleshooting

### "remote upstream already exists"
```bash
# Skip the git remote add step
git fetch upstream
git merge upstream/main
git push origin main
```

### Merge conflicts
```bash
# If you have local changes that conflict
git status
# Resolve conflicts in affected files
git add .
git commit -m "Resolve merge conflicts"
git push origin main
```

### Permission denied (GitHub)
```bash
# You may need to authenticate
# Use GitHub CLI or personal access token
# See: https://docs.github.com/en/authentication
```

## Got Questions?

Check these documentation files:
- `RENDER_DEPLOYMENT.md` - Complete Render guide
- `GOLANG_VERSION_ISSUE.md` - Why we downgraded to v5.2.1
- `DOCKER_BUILD_FIX.md` - Docker troubleshooting

---

## 🎯 **Summary**

```bash
git remote add upstream https://github.com/aldinokemal/go-whatsapp-web-multidevice.git
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

**That's it! Your fork is ready for deployment! 🚀**
