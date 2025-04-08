#!/bin/bash
set -e

IMAGE_NAME="zavifx/2048-custom-image:latest"
CHECKSUM_FILE="checksums/docker_image_checksum.txt"

# Get the image digest (requires the image to be pushed to registry)
docker push $IMAGE_NAME > /tmp/docker_push.log

# Extract digest (from push output or using docker inspect)
DIGEST=$(grep "digest:" /tmp/docker_push.log | awk '{print $2}')
echo "$DIGEST" > "$CHECKSUM_FILE"

echo "✅ Docker image digest saved: $DIGEST"
