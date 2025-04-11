#!/bin/bash
set -e

echo "🔍 Fetching current digest from Docker Hub..."
digest=$(docker pull zavifx/2048-custom-image:latest --quiet | grep sha256)

echo ""
echo "📦 Stored digest:"
stored_digest=$(cat stored_checksums/image.digest)
echo "$stored_digest"

# Extract the actual sha256 value only (strip repo name if present)
stored_sha=$(echo "$stored_digest" | awk -F'@' '{print $2}')
actual_sha=$(echo "$digest" | grep -o 'sha256:[a-f0-9]\+')

echo "Expected: $stored_sha"
echo "Actual:   $actual_sha"

if [ "$stored_sha" == "$actual_sha" ]; then
  echo "✅ Digest match confirmed."
else
  echo "❌ Digest mismatch!"
  exit 1
fi
