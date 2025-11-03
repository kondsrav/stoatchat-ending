#!/bin/bash

# Stoat Chat Rebuild and Restart Script
echo "🔄 Rebuilding and restarting Stoat Chat services..."

# Stop existing services
echo "⏹️ Stopping existing services..."
docker-compose -f docker-compose.unified.yml down

# Remove old images (optional - uncomment if you want to force rebuild)
# echo "🗑️ Removing old images..."
# docker rmi kondsrav/stoat-frontend-prod:latest kondsrav/stoat-api-production:latest

# Build new frontend image
echo "🏗️ Building frontend..."
cd frontend/frontend-stoat-new
docker build -f Dockerfile.prod -t kondsrav/stoat-frontend-prod:latest .
cd ../..

# Build new backend image  
echo "🏗️ Building backend..."
cd backend/stoat-backend-new
docker build -f Dockerfile.api.prod -t kondsrav/stoat-api-production:latest .
cd ../..

# Start all services
echo "🚀 Starting all services..."
docker-compose -f docker-compose.unified.yml up -d

# Show status
echo "📊 Service status:"
docker-compose -f docker-compose.unified.yml ps

echo "✅ Rebuild complete!"
echo "🌐 Frontend available at: http://localhost:3000"
echo "🌐 With Caddy proxy at: http://localhost (if domain configured)"
echo "📋 View logs with: docker-compose -f docker-compose.unified.yml logs -f"
