#!/bin/bash
set -e

IMAGE_NAME=$1
TAG=$2
CHECKSUM_FILE="stored_checksums/image-checksum.txt"

echo "[INFO] Saving Docker image $IMAGE_NAME:$TAG to tar..."
docker save ${IMAGE_NAME}:${TAG} -o temp_image.tar

echo "[INFO] Generating SHA-256 checksum..."
sha256sum temp_image.tar | awk '{print $1}' > "$CHECKSUM_FILE"

rm temp_image.tar
echo "[INFO] ✅ Checksum stored in $CHECKSUM_FILE"
