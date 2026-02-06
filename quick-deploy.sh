#!/bin/bash

# TaskPilot Quick Deployment Script
# Run this after forking and cloning the repository

echo "🎯 TaskPilot Quick Deployment Setup"
echo "===================================="
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: Run this script from the root of the taskpilot directory"
    exit 1
fi

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Step 1: Run rebranding
echo -e "${BLUE}Step 1/5: Running rebranding script...${NC}"
if [ -f "rebrand-to-taskpilot.sh" ]; then
    chmod +x rebrand-to-taskpilot.sh
    ./rebrand-to-taskpilot.sh
else
    echo -e "${RED}❌ Error: rebrand-to-taskpilot.sh not found${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Step 2/5: Installing dependencies...${NC}"
npm install

echo ""
echo -e "${BLUE}Step 3/5: Setting up environment file...${NC}"
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo -e "${YELLOW}⚠️  Created .env file - please update with your values!${NC}"
else
    echo -e "${GREEN}✅ .env file already exists${NC}"
fi

echo ""
echo -e "${BLUE}Step 4/5: Generating secure secrets...${NC}"
echo ""
echo "Copy these values to your .env file:"
echo "-----------------------------------"
echo -e "${YELLOW}JWT_SECRET=$(openssl rand -base64 32)${NC}"
echo -e "${YELLOW}JWT_REFRESH_SECRET=$(openssl rand -base64 32)${NC}"
echo -e "${YELLOW}ENCRYPTION_KEY=$(openssl rand -hex 32)${NC}"
echo "-----------------------------------"
echo ""

echo -e "${BLUE}Step 5/5: Adding logo...${NC}"
if [ -f "WhatsApp_Image_2026-02-06_at_2_23_47_PM.png" ]; then
    cp WhatsApp_Image_2026-02-06_at_2_23_47_PM.png frontend/public/taskpilot-logo.png
    echo -e "${GREEN}✅ Logo added successfully${NC}"
else
    echo -e "${YELLOW}⚠️  Please manually copy your logo to: frontend/public/taskpilot-logo.png${NC}"
fi

echo ""
echo -e "${GREEN}=========================================="
echo -e "✅ Setup Complete!"
echo -e "==========================================${NC}"
echo ""
echo -e "${BLUE}📋 Next Steps:${NC}"
echo ""
echo "1️⃣  Update your .env file with:"
echo "   • Database credentials (PostgreSQL)"
echo "   • Redis credentials"
echo "   • The secure secrets printed above"
echo ""
echo "2️⃣  Test locally:"
echo "   npm run dev"
echo ""
echo "3️⃣  Review changes:"
echo "   git diff"
echo ""
echo "4️⃣  Commit to GitHub:"
echo "   git add ."
echo "   git commit -m 'Setup TaskPilot with custom branding'"
echo "   git push origin main"
echo ""
echo "5️⃣  Deploy to Vercel:"
echo "   • Go to https://vercel.com"
echo "   • Import your GitHub repository"
echo "   • Follow the deployment guide"
echo ""
echo -e "${YELLOW}📖 See TASKPILOT_DEPLOYMENT_GUIDE.md for detailed instructions${NC}"
echo ""
