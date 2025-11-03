# Stoat Chat Rebuild and Restart Script (Windows PowerShell)
Write-Host "🔄 Rebuilding and restarting Stoat Chat services..." -ForegroundColor Green

# Stop existing services
Write-Host "⏹️ Stopping existing services..." -ForegroundColor Yellow
docker-compose -f docker-compose.unified.yml down

# Remove old images (optional - uncomment if you want to force rebuild)
# Write-Host "🗑️ Removing old images..." -ForegroundColor Yellow
# docker rmi kondsrav/stoat-frontend-prod:latest kondsrav/stoat-api-production:latest

# Build new frontend image
Write-Host "🏗️ Building frontend..." -ForegroundColor Cyan
Set-Location "frontend\frontend-stoat-new"
docker build -f Dockerfile.prod -t kondsrav/stoat-frontend-prod:latest .
Set-Location "..\..\"

# Build new backend image  
Write-Host "🏗️ Building backend..." -ForegroundColor Cyan
Set-Location "backend\stoat-backend-new"
docker build -f Dockerfile.api.prod -t kondsrav/stoat-api-production:latest .
Set-Location "..\..\"

# Start all services
Write-Host "🚀 Starting all services..." -ForegroundColor Green
docker-compose -f docker-compose.unified.yml up -d

# Show status
Write-Host "📊 Service status:" -ForegroundColor Magenta
docker-compose -f docker-compose.unified.yml ps

Write-Host "✅ Rebuild complete!" -ForegroundColor Green
Write-Host "🌐 Frontend available at: http://localhost:3000" -ForegroundColor Cyan
Write-Host "🌐 With Caddy proxy at: http://localhost (if domain configured)" -ForegroundColor Cyan
Write-Host "📋 View logs with: docker-compose -f docker-compose.unified.yml logs -f" -ForegroundColor Yellow
