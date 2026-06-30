#!/bin/bash
set -e
echo "🚀 RizenOS Deployment"
ENV="${1:-dev}"
echo "📦 Environment: $ENV"
echo "🔨 Building web..."
flutter clean && flutter pub get
flutter build web --release --web-renderer canvaskit
if [ $? -eq 0 ]; then echo "✅ Build successful"; else echo "❌ Build failed"; exit 1; fi
echo "📤 Deploying..."
if [[ "$ENV" == "prod" ]]; then firebase deploy --only hosting --project=rizenos-prod;
else firebase deploy --only hosting; fi
echo "🌐 Visit: https://rizenos.app"
echo "✅ Done!"
