#!/bin/bash

echo "🔍 Fetching current digest from Docker Hub..."
actual_digest=$(docker inspect --format='{{index .RepoDigests 0}}' zavifx/2048-custom-image:latest | cut -d'@' -f2)

echo "📦 Stored digest:"
stored_digest=$(cat stored_checksums/image.digest)
echo "$stored_digest"

# Extract only the SHA part from stored digest (strip repo name)
stored_digest_sha=$(echo "$stored_digest" | cut -d'@' -f2)

echo "🔍 Comparing digests..."
echo "Expected: $stored_digest_sha"
echo "Actual:   $actual_digest"

if [[ "$stored_digest_sha" == "$actual_digest" ]]; then
    echo "✅ Digest match. Proceeding with deployment."
else
    echo "❌ Digest mismatch!"
    echo "Expected: $stored_digest_sha"
    echo "Actual:   $actual_digest"
    exit 1
fi
