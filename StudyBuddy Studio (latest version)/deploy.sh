#!/bin/bash

# StudyBuddy Deployment Script
# Usage: ./deploy.sh [local|production]

set -e

echo "🚀 StudyBuddy Deployment Script"
echo "================================"

# Default to local deployment
ENVIRONMENT="${1:-local}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please edit .env file with your actual configuration before proceeding!"

    if [ "$ENVIRONMENT" = "production" ]; then
        echo "🔧 For production deployment, make sure to:"
        echo "   - Set DOMAIN to your actual domain"
        echo "   - Set ACME_EMAIL for SSL certificates"
        echo "   - Set a secure NEO4J_PASSWORD"
        echo "   - Uncomment SSL configuration in docker-compose.yml"
        read -p "Press Enter when you've configured .env file..."
    fi
fi

# Create required directories
echo "📁 Creating required directories..."
mkdir -p data uploads letsencrypt

# Set proper permissions for letsencrypt directory
chmod 600 letsencrypt 2>/dev/null || true

echo "🔨 Building and starting services..."

case "$ENVIRONMENT" in
    "local")
        echo "🏠 Deploying for local development..."
        docker compose up --build -d
        ;;
    "production")
        echo "🌐 Deploying for production..."
        # For production, we might want to use a separate compose file
        docker compose -f docker-compose.yml up --build -d
        ;;
    *)
        echo "❌ Invalid environment. Use 'local' or 'production'"
        exit 1
        ;;
esac

echo ""
echo "✅ Deployment completed!"
echo ""
echo "📊 Service Status:"
docker compose ps

echo ""
echo "🌐 Access URLs:"
if [ "$ENVIRONMENT" = "local" ]; then
    echo "   StudyBuddy App: http://localhost"
    echo "   Traefik Dashboard: http://localhost:8080"
    echo "   Neo4j Browser: http://neo4j.localhost"
else
    DOMAIN=$(grep DOMAIN .env | cut -d '=' -f2)
    echo "   StudyBuddy App: https://$DOMAIN"
    echo "   Traefik Dashboard: http://traefik.$DOMAIN"
    echo "   Neo4j Browser: http://neo4j.$DOMAIN"
fi

echo ""
echo "📝 Useful commands:"
echo "   View logs: docker compose logs -f"
echo "   Stop services: docker compose down"
echo "   Update app: docker compose up --build -d studybuddy"
echo ""