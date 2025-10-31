#!/bin/bash

# =============================================
# Update Your Fork with Latest Changes
# =============================================

echo "🔄 Updating your fork with latest changes..."

# Step 1: Add upstream remote (if not already added)
echo ""
echo "Step 1: Adding upstream remote..."
git remote add upstream https://github.com/aldinokemal/go-whatsapp-web-multidevice.git

# Step 2: Fetch latest from upstream
echo ""
echo "Step 2: Fetching latest changes from upstream..."
git fetch upstream

# Step 3: Merge upstream changes into your main branch
echo ""
echo "Step 3: Merging upstream changes into your main branch..."
git checkout main
git merge upstream/main

# Step 4: Push changes to your fork on GitHub
echo ""
echo "Step 4: Pushing changes to your fork on GitHub..."
git push origin main

echo ""
echo "✅ Done! Your fork is now updated with all the latest changes!"
echo ""
echo "📦 Changes include:"
echo "  - Railway/Render deployment configuration"
echo "  - Go version compatibility fixes (v5.2.1)"
echo "  - Fasthttp replacement with stdlib"
echo "  - Complete deployment guides"
echo "  - Environment variable templates"
echo "  - Troubleshooting documentation"
echo ""
echo "🚀 You can now deploy to Render!"
echo "   See RENDER_DEPLOYMENT.md for instructions"
