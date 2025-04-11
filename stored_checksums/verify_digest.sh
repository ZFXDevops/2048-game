#!/bin/bash

set -e

IMAGE_NAME="zavifx/2048-custom-image"
TAG="latest"
STORED_DIGEST_FILE="stored_checksums/image.digest"

echo "🔍 Fetching current digest from Docker Hub..."

LIVE_DIGEST=$(docker pull ${IMAGE_NAME}:${TAG} | grep "Digest:" | awk '{print $2}')

echo "📥 Live Digest: $LIVE_DIGEST"

STORED_DIGEST=$(cat "$STORED_DIGEST_FILE" | grep -o 'sha256:[a-f0-9]\{64\}')

echo "📁 Stored Digest: $STORED_DIGEST"

if [[ "$LIVE_DIGEST" == "$STORED_DIGEST" ]]; then
  echo "✅ Digest match confirmed. Safe to deploy."
else
  echo "❌ Digest mismatch detected!"
  exit 1
fi

