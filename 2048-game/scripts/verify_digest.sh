#!/bin/bash

set -e

IMAGE_NAME="zavifx/2048-custom-image"
TAG="latest"
STORED_DIGEST_FILE="stored_checksums/image.digest"

echo "🔍 Fetching current digest from Docker Hub..."

# Pull image and extract live digest using Docker CLI
LIVE_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' ${IMAGE_NAME}:${TAG} | grep -o 'sha256:[a-f0-9]\{64\}')

if [[ -z "$LIVE_DIGEST" ]]; then
  echo "❌ Failed to fetch live digest!"
  exit 1
fi

echo "📥 Live Digest: $LIVE_DIGEST"

# Check if stored digest file exists
if [[ ! -f "$STORED_DIGEST_FILE" ]]; then
  echo "❌ Stored digest file not found: $STORED_DIGEST_FILE"
  exit 1
fi

# Read stored digest (just the SHA portion)
STORED_DIGEST=$(cat "$STORED_DIGEST_FILE" | grep -o 'sha256:[a-f0-9]\{64\}')

if [[ -z "$STORED_DIGEST" ]]; then
  echo "❌ Failed to extract digest from $STORED_DIGEST_FILE"
  exit 1
fi

echo "📁 Stored Digest: $STORED_DIGEST"

# Compare digests
if [[ "$LIVE_DIGEST" == "$STORED_DIGEST" ]]; then
  echo "✅ Digest match confirmed. Safe to deploy."
else
  echo "❌ Digest mismatch detected!"
  echo "Live Digest   : $LIVE_DIGEST"
  echo "Stored Digest : $STORED_DIGEST"
  exit 1
fi
