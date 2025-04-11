#!/bin/bash
set -e

IMAGE="zavifx/2048-custom-image"
TAG="latest"
DIGEST_FILE="stored_checksums/image.digest"

echo "🔐 Logging in to Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "🔨 Building Docker image..."
docker build -t $IMAGE:$TAG .

echo "📤 Pushing image to Docker Hub..."
docker push $IMAGE:$TAG

echo "🔍 Extracting RepoDigest..."
DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' $IMAGE:$TAG)

echo "💾 Saving digest to $DIGEST_FILE..."
mkdir -p stored_checksums
echo "$DIGEST" > "$DIGEST_FILE"

echo "✅ Digest saved: $DIGEST"
