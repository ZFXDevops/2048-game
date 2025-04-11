#!/bin/bash

set -e

IMAGE="zavifx/2048-custom-image"
TAG="latest"
CHECKSUM_FILE="stored_checksums/image-digest.txt"

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "❌ Digest file not found!"
    exit 1
fi

expected_digest=$(cat "$CHECKSUM_FILE")
current_digest=$(docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE:$TAG")

echo "🧾 Stored:  $expected_digest"
echo "📦 Current: $current_digest"

if [ "$expected_digest" != "$current_digest" ]; then
    echo "❌ Digest mismatch! Aborting deployment."
    exit 1
fi

echo "✅ Digest verification passed."
