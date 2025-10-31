# Railway Deployment Guide

## Quick Start Deployment Checklist

### ✅ Pre-Deployment (Done)
- [x] Forked repository to: `https://github.com/seun-otosho/go-whatsapp-web-multidevice.git`
- [x] Created Railway account
- [x] Config files prepared (railway.json)

---

## 🚀 Deployment Steps

### Step 1: Create New Railway Project
1. Go to https://railway.app/dashboard
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose: `seun-otosho/go-whatsapp-web-multidevice`
5. Railway auto-detects Go and builds

### Step 2: Configure Environment Variables
Go to your project → Variables tab → Add these:

#### **Essential Variables:**
```
APP_PORT=3000
APP_OS=Railway-WhatsApp
APP_DEBUG=false
DB_URI=file:storages/whatsapp.db?_foreign_keys=on
WHATSAPP_ACCOUNT_VALIDATION=false
```

#### **Optional (Advanced Features):**
```
APP_BASIC_AUTH=admin:yourStrongPassword
WHATSAPP_AUTO_MARK_READ=true
WHATSAPP_WEBHOOK_SECRET=yourWebhookSecret
APP_BASE_PATH=/
```

### Step 3: Verify Deployment
- Wait for build to complete (2-5 minutes)
- Go to **"Domains"** tab
- Click your app URL (e.g., `https://your-app.railway.app`)
- You should see the GoWA login page

### Step 4: Connect WhatsApp
1. Visit: `https://your-app.railway.app/app/login`
2. Scan QR code with your WhatsApp mobile app
3. You're connected! 🎉

---

## 📊 Database Options

### SQLite (Default - Recommended)
**No additional setup!**
- Uses local file storage
- Stored in `/app/storages/whatsapp.db`
- Perfect for single-user WhatsApp instances
- Free with Railway's persistent disk

### PostgreSQL (Optional - For Multi-User)
**If you need PostgreSQL:**
1. In Railway dashboard, click **"New"** → **"Database"** → **"Add PostgreSQL"**
2. Railway creates DB and sets `DATABASE_URL` env var
3. Update `DB_URI` to: `${{Postgres.DATABASE_URL}}`

---

## 🔧 Troubleshooting

### Build Fails?
**Issue**: Go version error
**Solution**: Railway auto-installs latest Go. If issues occur:
```bash
# Add to railway.json build section
"phases": {
  "setup": {
    "nixpacksMeta": {
      "go": {
        "version": "1.23"
      }
    }
  }
}
```

### App Crashes on Start?
**Issue**: Missing environment variables
**Solution**: Ensure `APP_PORT=3000` is set

### WhatsApp Disconnects?
**Issue**: App sleeps
**Solution**: Railway's free tier doesn't sleep apps with traffic

---

## 🎯 Next Steps After Deployment

1. **Test Basic Functions:**
   - Send a text message
   - Send an image
   - Check group list

2. **Set up Webhooks (Optional):**
   - Create webhook endpoint
   - Set `WHATSAPP_WEBHOOK` env var

3. **Enable Basic Auth:**
   - Set `APP_BASIC_AUTH=username:password`
   - Protects your API from unauthorized access

4. **Monitor Usage:**
   - Railway dashboard shows CPU/memory
   - Check logs for any errors

---

## 📱 API Usage Examples

After deployment, your API is available at:
`https://your-app.railway.app`

**Example - Send Text Message:**
```bash
curl -X POST https://your-app.railway.app/send/message \
  -H "Content-Type: application/json" \
  -d '{"chat_id":"1234567890@c.us","message":"Hello from Railway!"}'
```

**Example - Send Image:**
```bash
curl -X POST https://your-app.railway.app/send/image \
  -F "chat_id=1234567890@c.us" \
  -F "caption=Check this out!" \
  -F "image=@/path/to/image.jpg"
```

---

## 🆘 Need Help?

### Check Logs:
Railway Dashboard → Your Project → Deploy → View Logs

### Common Issues:
- **Port error**: Ensure `APP_PORT=3000`
- **Build timeout**: Check build logs in Railway
- **WhatsApp not connecting**: Verify QR code scan

### Support:
- Railway Docs: https://docs.railway.app
- GoWA Issues: https://github.com/aldinokemal/go-whatsapp-web-multidevice/issues

---

## 💡 Pro Tips

1. **Custom Domain:**
   - Add your own domain in Railway Domains tab
   - Get free SSL certificate automatically

2. **Scale Up:**
   - Railway free tier: $5 credit/month
   - Upgrade anytime for more resources

3. **Backups:**
   - Download `storages/` folder regularly
   - Contains WhatsApp session data

4. **Security:**
   - Enable Basic Auth in production
   - Use strong webhook secrets
   - Don't expose sensitive env vars

---

## ✅ Success Indicators

You'll know it's working when:
- [x] Railway shows "Active" status
- [x] App URL loads the GoWA interface
- [x] QR code appears for login
- [x] WhatsApp connects successfully
- [x] Can send a test message

**You're all set! Happy WhatsApping! 📱✨**
