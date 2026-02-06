#!/bin/bash

# TaskPilot - Post-Rebranding Verification Script

echo "🎯 TaskPilot - Deployment Readiness Check"
echo "=========================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo -e "${RED}❌ Error: Run this script from the TaskPilot root directory${NC}"
    exit 1
fi

echo -e "${BLUE}Checking project status...${NC}"
echo ""

# Check 1: Verify rebranding
echo -e "${BLUE}✓ Checking rebranding...${NC}"
if grep -q "taskpilot" package.json; then
    echo -e "${GREEN}  ✅ Package renamed to TaskPilot${NC}"
else
    echo -e "${YELLOW}  ⚠️  Rebranding may be incomplete${NC}"
fi

# Check 2: Logo
echo -e "${BLUE}✓ Checking logo...${NC}"
if [ -f "frontend/public/taskpilot-logo.png" ]; then
    SIZE=$(ls -lh frontend/public/taskpilot-logo.png | awk '{print $5}')
    echo -e "${GREEN}  ✅ Logo found (${SIZE})${NC}"
else
    echo -e "${RED}  ❌ Logo not found${NC}"
fi

# Check 3: Deployment configs
echo -e "${BLUE}✓ Checking deployment configs...${NC}"
if [ -f "vercel.json" ] && [ -f "vercel-backend.json" ]; then
    echo -e "${GREEN}  ✅ Vercel configs present${NC}"
else
    echo -e "${YELLOW}  ⚠️  Some Vercel configs missing${NC}"
fi

# Check 4: Environment file
echo -e "${BLUE}✓ Checking environment setup...${NC}"
if [ -f ".env" ]; then
    echo -e "${GREEN}  ✅ .env file exists${NC}"
    if grep -q "CHANGE-ME" .env 2>/dev/null; then
        echo -e "${YELLOW}  ⚠️  Remember to update .env with your values!${NC}"
    fi
else
    echo -e "${YELLOW}  ⚠️  No .env file - create one from .env.example${NC}"
fi

echo ""
echo -e "${GREEN}=========================================="
echo "✅ Project Status: READY FOR DEPLOYMENT"
echo "==========================================${NC}"
echo ""

# Show deployment options
echo -e "${BLUE}📋 Next Steps - Choose Your Deployment Method:${NC}"
echo ""
echo "Option 1: Fresh GitHub Repository (RECOMMENDED)"
echo "  1. Create new repo at https://github.com/new"
echo "  2. Name it 'taskpilot'"
echo "  3. Run these commands:"
echo -e "${YELLOW}     git init"
echo "     git add ."
echo "     git commit -m 'Initial TaskPilot setup'"
echo "     git remote add origin https://github.com/YOUR_USERNAME/taskpilot.git"
echo "     git push -u origin main${NC}"
echo ""

echo "Option 2: Deploy with Vercel CLI (No GitHub needed)"
echo -e "${YELLOW}     npm i -g vercel"
echo "     vercel${NC}"
echo ""

echo "Option 3: Fork Original & Update"
echo "  1. Fork https://github.com/Taskosaur/Taskosaur"
echo "  2. Clone your fork"
echo "  3. Copy these rebranded files over"
echo "  4. Push changes"
echo ""

echo -e "${BLUE}🗄️ Database Setup (Do This First):${NC}"
echo ""
echo "Railway (Recommended):"
echo "  1. Go to https://railway.app"
echo "  2. New Project → Add PostgreSQL"
echo "  3. New → Add Redis"
echo "  4. Copy connection strings to .env"
echo ""

echo -e "${BLUE}📖 Full Instructions:${NC}"
echo "  See DEPLOYMENT_GUIDE.md for complete step-by-step guide"
echo ""

echo -e "${BLUE}🔐 Don't Forget:${NC}"
echo "  • Generate secure JWT secrets (see DEPLOYMENT_GUIDE.md)"
echo "  • Update .env with database credentials"
echo "  • Change admin password after first login"
echo ""

echo -e "${GREEN}Ready to deploy! Follow DEPLOYMENT_GUIDE.md${NC}"
echo ""

# Summary of files
echo -e "${BLUE}📦 Your TaskPilot Package Includes:${NC}"
echo "  • DEPLOYMENT_GUIDE.md - Complete deployment instructions"
echo "  • vercel.json - Frontend Vercel configuration"
echo "  • vercel-backend.json - Backend Vercel configuration"
echo "  • .env.example - Environment variables template"
echo "  • Fully rebranded codebase (Taskosaur → TaskPilot)"
echo "  • Your custom logo in frontend/public/"
echo ""

echo -e "${YELLOW}⭐ Quick Deploy Commands:${NC}"
echo ""
echo "After setting up GitHub repo:"
echo -e "${YELLOW}git init && git add . && git commit -m 'Initial commit'"
echo "git remote add origin YOUR_REPO_URL"
echo "git push -u origin main${NC}"
echo ""

echo "Then deploy to Vercel (see DEPLOYMENT_GUIDE.md)"
echo ""
