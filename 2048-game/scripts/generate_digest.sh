#!/bin/bash

set -e

IMAGE="zavifx/2048-custom-image"
TAG="latest"

echo "🔨 Building Docker image..."
docker build -t "$IMAGE:$TAG" .

echo "📦 Inspecting digest..."
digest=$(docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE:$TAG")

if [ -z "$digest" ]; then
    echo "❌ Failed to retrieve image digest!"
    exit 1
fi

echo "✅ Digest: $digest"

echo "💾 Saving digest to stored_checksums/image-digest.txt"
echo "$digest" > stored_checksums/image-digest.txt
