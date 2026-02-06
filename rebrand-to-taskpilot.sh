#!/bin/bash

# TaskPilot Rebranding Script
# This script renames all occurrences of Taskosaur to TaskPilot

echo "🚀 Starting TaskPilot Rebranding Process..."
echo "=========================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Backup original files
echo -e "${BLUE}📦 Creating backup...${NC}"
BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to backup and replace in file
replace_in_file() {
    local file=$1
    if [ -f "$file" ]; then
        # Create backup
        cp "$file" "$BACKUP_DIR/$(basename $file).bak"
        
        # Perform replacements
        sed -i.tmp 's/Taskosaur/TaskPilot/g' "$file"
        sed -i.tmp 's/taskosaur/taskpilot/g' "$file"
        sed -i.tmp 's/TASKOSAUR/TASKPILOT/g' "$file"
        
        # Remove temporary file
        rm -f "$file.tmp"
        
        echo -e "${GREEN}✅ Updated: $file${NC}"
    fi
}

# Update package.json files
echo -e "${BLUE}📝 Updating package.json files...${NC}"
replace_in_file "package.json"
replace_in_file "frontend/package.json"
replace_in_file "backend/package.json"

# Update README
echo -e "${BLUE}📝 Updating README.md...${NC}"
replace_in_file "README.md"

# Update frontend files
echo -e "${BLUE}📝 Updating frontend files...${NC}"

# Update Next.js config
replace_in_file "frontend/next.config.js"
replace_in_file "frontend/next.config.mjs"

# Update metadata and titles
replace_in_file "frontend/src/app/layout.tsx"
replace_in_file "frontend/src/app/page.tsx"

# Find and update all TypeScript/JavaScript files in frontend
find frontend/src -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" \) | while read file; do
    replace_in_file "$file"
done

# Update backend files
echo -e "${BLUE}📝 Updating backend files...${NC}"

# Find and update all TypeScript files in backend
find backend/src -type f \( -name "*.ts" -o -name "*.js" \) | while read file; do
    replace_in_file "$file"
done

# Update environment example
echo -e "${BLUE}📝 Updating environment files...${NC}"
replace_in_file ".env.example"

# Update Docker files
echo -e "${BLUE}📝 Updating Docker files...${NC}"
replace_in_file "docker-compose.yml"
replace_in_file "docker-compose.dev.yml"
replace_in_file "docker-compose.prod.yml"
replace_in_file "Dockerfile.dev"
replace_in_file "Dockerfile.prod"

# Update documentation files
echo -e "${BLUE}📝 Updating documentation files...${NC}"
replace_in_file "CONTRIBUTING.md"
replace_in_file "CODE_OF_CONDUCT.md"
replace_in_file "DOCKER_DEV_SETUP.md"

# Rename logo files
echo -e "${BLUE}🎨 Preparing logo files...${NC}"
if [ -f "frontend/public/taskosaur-logo.svg" ]; then
    mv "frontend/public/taskosaur-logo.svg" "frontend/public/taskpilot-logo.svg"
    echo -e "${GREEN}✅ Renamed logo SVG${NC}"
fi

if [ -f "frontend/public/taskosaur-logo.png" ]; then
    mv "frontend/public/taskosaur-logo.png" "frontend/public/taskpilot-logo.png"
    echo -e "${GREEN}✅ Renamed logo PNG${NC}"
fi

# Create placeholder for new logo if it doesn't exist
if [ ! -f "frontend/public/taskpilot-logo.png" ]; then
    echo -e "${YELLOW}⚠️  Please add your logo at: frontend/public/taskpilot-logo.png${NC}"
fi

# Update HTML files
echo -e "${BLUE}📝 Updating HTML files...${NC}"
find . -type f -name "*.html" | while read file; do
    replace_in_file "$file"
done

# Update CSS files
echo -e "${BLUE}📝 Updating CSS files...${NC}"
find . -type f -name "*.css" | while read file; do
    replace_in_file "$file"
done

# Update database schema if it contains Taskosaur
echo -e "${BLUE}📝 Updating Prisma schema...${NC}"
if [ -f "backend/prisma/schema.prisma" ]; then
    replace_in_file "backend/prisma/schema.prisma"
fi

# Update any seed files
echo -e "${BLUE}📝 Updating seed files...${NC}"
find backend/prisma -type f -name "*.ts" -o -name "*.js" | while read file; do
    replace_in_file "$file"
done

# Summary
echo ""
echo -e "${GREEN}=========================================="
echo -e "✅ Rebranding Complete!"
echo -e "==========================================${NC}"
echo ""
echo -e "${BLUE}📋 Summary:${NC}"
echo -e "  • All 'Taskosaur' references → 'TaskPilot'"
echo -e "  • All 'taskosaur' references → 'taskpilot'"
echo -e "  • Backup created in: ${YELLOW}$BACKUP_DIR${NC}"
echo ""
echo -e "${BLUE}📝 Next Steps:${NC}"
echo "  1. Add your logo: frontend/public/taskpilot-logo.png"
echo "  2. Review changes: git diff"
echo "  3. Test locally: npm install && npm run dev"
echo "  4. Commit changes: git add . && git commit -m 'Rebrand to TaskPilot'"
echo "  5. Push to GitHub: git push origin main"
echo ""
echo -e "${YELLOW}⚠️  Important:${NC}"
echo "  • Review the changes before committing"
echo "  • Update your database name if needed"
echo "  • Generate new JWT secrets for production"
echo ""
echo -e "${GREEN}Ready to deploy to Vercel!${NC}"
echo ""
