#!/bin/bash

set -e

APP_NAME=$1
RESOURCE_GROUP=$2
ZIP_PATH="functionapp.zip"
API_PATH="./api"

echo "📦 Zipping contents of $API_PATH into $ZIP_PATH ..."
cd "$API_PATH"
zip -r "../$ZIP_PATH" . > /dev/null
cd ..

echo "🚀 Deploying $ZIP_PATH to Function App: $APP_NAME in RG: $RESOURCE_GROUP ..."
az functionapp deployment source config-zip \
  --resource-group "$RESOURCE_GROUP" \
  --name "$APP_NAME" \
  --src "$ZIP_PATH"

echo "✅ Deployment complete."