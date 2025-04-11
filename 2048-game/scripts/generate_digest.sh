#!/bin/bash
# scripts/generate_digest.sh

set -e

IMAGE_NAME="zavifx/2048-custom-image:latest"

# Build the image
docker build -t $IMAGE_NAME .

# Get image digest
DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' $IMAGE_NAME)

# Extract only the digest hash (after the @)
CHECKSUM=$(echo "$DIGEST" | cut -d'@' -f2)

# Store checksum
mkdir -p stored_checksums
echo "$CHECKSUM" > stored_checksums/image_checksum.txt

echo "✅ Image built and digest stored: $CHECKSUM"
