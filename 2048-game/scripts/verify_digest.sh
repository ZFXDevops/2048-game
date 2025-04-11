#!/bin/bash
set -e

IMAGE="zavifx/2048-custom-image"
TAG="latest"
DIGEST_FILE="stored_checksums/image.digest"

echo "🔍 Fetching current digest from Docker Hub..."
CURRENT_DIGEST=$(docker pull $IMAGE:$TAG | grep "Digest:" | awk '{print $2}')

if [ ! -f "$DIGEST_FILE" ]; then
    echo "❌ Error: Digest file '$DIGEST_FILE' not found!"
    exit 1
fi

echo "📦 Stored digest:"
cat "$DIGEST_FILE"

STORED_DIGEST=$(cat "$DIGEST_FILE")

if [ "$CURRENT_DIGEST" != "$STORED_DIGEST" ]; then
    echo "❌ Digest mismatch!"
    echo "Expected: $STORED_DIGEST"
    echo "Actual:   $CURRENT_DIGEST"
    exit 1
else
    echo "✅ Digest verified: $CURRENT_DIGEST matches the stored checksum."
fi
